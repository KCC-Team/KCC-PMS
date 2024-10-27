package com.kcc.pms.domain.system.service;

import com.kcc.pms.domain.system.mapper.SystemMapper;
import com.kcc.pms.domain.system.model.dto.SystemPageDto;
import com.kcc.pms.domain.system.model.dto.SystemResponseDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class SystemServiceImpl implements SystemService{

    private final SystemMapper mapper;

    @Override
    public List<SystemResponseDTO> getSystemsByProjectNo(Long projectNo) {
        return buildTree(mapper.getSystemsByProjectNo(projectNo));
    }

    @Override
    public List<SystemPageDto> getParentSystems(int page, int size, Long prjNo) {
        int startRow = (page - 1) * size;
        int endRow = page * size;
        return mapper.getParentSystems(startRow, endRow, prjNo);
    }


    private List<SystemResponseDTO> buildTree(List<SystemResponseDTO> systems){
        Map<Integer, SystemResponseDTO> systemMap = new HashMap<>();
        List<SystemResponseDTO> rootSystems = new ArrayList<>();

        for (SystemResponseDTO system : systems) {
            systemMap.put(system.getSystemNo(), system);
        }

        for (SystemResponseDTO system : systems) {
            if (system.getParentSystemNo() == null) {
                // 상위 시스템이 없으면 루트 시스템
                rootSystems.add(system);
            } else {
                // 상위 시스템이 있으면 해당 시스템의 subMenu에 추가
                SystemResponseDTO parentSystem = systemMap.get(system.getParentSystemNo());
                if (parentSystem != null) {
                    parentSystem.getSubSystems().add(system);
                }
            }
        }

        return rootSystems; // 최상위 시스템만 반환
    }
}
