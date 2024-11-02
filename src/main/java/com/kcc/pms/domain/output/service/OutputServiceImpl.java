package com.kcc.pms.domain.output.service;

import com.kcc.pms.domain.common.service.CommonService;
import com.kcc.pms.domain.output.domain.dto.DeleteOutputResponseDto;
import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;
import com.kcc.pms.domain.output.domain.dto.OutputResponseDto;
import com.kcc.pms.domain.output.mapper.OutputMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OutputServiceImpl implements OutputService {
    private final CommonService commonService;
    private final OutputMapper outputMapper;

    @Override
    public List<FileStructResponseDto> findList(Long projectNo, String option) {
        List<FileStructResponseDto> list = outputMapper.findList(projectNo, option);
        return buildTree(list);
    }

    @Transactional
    @Override
    public void insertOutput(Long projectNo, String memberName, String title, List<FileStructResponseDto> res, List<MultipartFile> files) {
        Long outputNo = updateOutput(projectNo, res, null, commonService.fileUpload(files, memberName, projectNo, null));
        outputMapper.updateOutputInfo(title, outputNo);
    }

    @Override
    public void insertOutputFiles(Long projectNo, String memberName, Long outputNo, List<MultipartFile> files) {
        commonService.fileUploadToOutput(files, memberName, projectNo, outputNo);
    }

    @Transactional
    @Override
    public Long updateOutput(Long projectNo, List<FileStructResponseDto> structResponse, String option, Long fileMasterNo) {
        Long savedOutputNo = null;

        List<FileStructResponseDto> flattenTree = flattenTree(structResponse);
        List<FileStructResponseDto> currentList = outputMapper.findList(projectNo, option);
        Map<Long, FileStructResponseDto> currentMap = currentList.stream()
                .collect(Collectors.toMap(FileStructResponseDto::getId, Function.identity()));

        Map<Long, FileStructResponseDto> modifiedMap = flattenTree.stream()
                .collect(Collectors.toMap(FileStructResponseDto::getId, Function.identity()));

        // 노드 추가 및 수정 처리
        for (FileStructResponseDto modifiedNode : flattenTree) {
            if (modifiedNode.getParentId() == null) {
                continue;
            }

            FileStructResponseDto currentNode = currentMap.get(modifiedNode.getId());
            if (currentNode == null) {
                modifiedNode.setProjectNo(projectNo);
                int isPassed = outputMapper.insertOutput(modifiedNode, fileMasterNo);
                if (isPassed != 1) {
                    throw new RuntimeException("Failed to insert output");
                }
                savedOutputNo = modifiedNode.getId();
            } else if (!currentNode.equals(modifiedNode)) {
                int isPassed = outputMapper.updateOutput(modifiedNode);
                if (isPassed != 1) {
                    throw new RuntimeException("Failed to update output");
                }
            }
        }

        return savedOutputNo;
    }

    @Override
    public void updateOutputInfo(String title, Long outputNo) {
        outputMapper.updateOutputInfo(title, outputNo);
    }

    @Override
    public void deleteOutput(Long outputNo) {
        outputMapper.deleteOutput(outputNo);
    }

    @Override
    public OutputResponseDto findOutput(Long projectNo, Long outputNo) {
        OutputResponseDto outputNotFound = outputMapper.findOutput(projectNo, outputNo).orElseThrow(() -> new RuntimeException("Output not found"));
        return outputNotFound;
    }

    @Override
    public List<DeleteOutputResponseDto> findDeleteOutputs(Long outputNo) {
        return outputMapper.findDeleteOutputs(outputNo);
    }

    @Transactional
    @Override
    public void deleteOutputFiles(String memberName, List<Long> deleteOutputs) {
        for (Long deleteOutput : deleteOutputs) {
            commonService.deleteFileDetail(memberName, deleteOutput);
        }
    }

    private List<FileStructResponseDto> buildTree(List<FileStructResponseDto> nodeList) {
        Map<Long, FileStructResponseDto> nodeMap = new HashMap<>();

        nodeList.forEach(node -> {
            nodeMap.put(node.getId(), node);
        });

        List<FileStructResponseDto> rootNodes = new ArrayList<>();
        for (FileStructResponseDto node : nodeMap.values()) {
            Long parentId = node.getParentId();
            if (parentId == null) {
                rootNodes.add(node);
            } else {
                FileStructResponseDto parent = nodeMap.get(parentId);
                if (parent != null) {
                    parent.getChildren().add(node);
                }
            }
        }

        return rootNodes;
    }

    private List<FileStructResponseDto> flattenTree(List<FileStructResponseDto> tree) {
        List<FileStructResponseDto> flatList = new ArrayList<>();
        for (FileStructResponseDto node : tree) {
            flatList.add(node);
            if (node.getChildren() != null && !node.getChildren().isEmpty()) {
                flatList.addAll(flattenTree(node.getChildren()));
            }
        }
        return flatList;
    }
}
