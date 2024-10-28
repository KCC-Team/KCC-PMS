package com.kcc.pms.domain.common.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kcc.pms.domain.output.domain.dto.FileStructResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.List;

@Component
@RequiredArgsConstructor
public class JsonParser {

    public List<FileStructResponseDto> parseJson(String json) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(json, objectMapper.getTypeFactory().constructCollectionType(List.class, FileStructResponseDto.class));
    }
}
