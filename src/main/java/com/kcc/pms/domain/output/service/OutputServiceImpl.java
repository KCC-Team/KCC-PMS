package com.kcc.pms.domain.output.service;

import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;
import com.kcc.pms.domain.output.mapper.OutputMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class OutputServiceImpl implements OutputService {
    private final OutputMapper outputMapper;

    @Override
    public List<FileStructResponseDto> findList(Long prjNo, String option) {
        List<FileStructResponseDto> list = outputMapper.findList(prjNo, option);
        return buildTree(list);
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
}
