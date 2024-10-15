package com.kcc.pms.domain.system.service;

import com.kcc.pms.domain.system.model.dto.SystemResponseDTO;

import java.util.List;

public interface SystemService {
    List<SystemResponseDTO> getSystemsByProjectNo(Long projectNo);
}
