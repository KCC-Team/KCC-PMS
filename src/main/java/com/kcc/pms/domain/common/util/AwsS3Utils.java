package com.kcc.pms.domain.common.util;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.kcc.pms.domain.common.config.EnvVariableProperties;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class AwsS3Utils {
    private final AmazonS3 amazonS3;
    private final EnvVariableProperties properties;

    public String saveFile(MultipartFile multipartFile, String fileName) throws IOException {
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(multipartFile.getSize());
        metadata.setContentType(multipartFile.getContentType());
        String ext = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".") + 1);

        amazonS3.putObject(properties.getS3().getBucket() + "/kcc_pms", fileName + "." + ext, multipartFile.getInputStream(), metadata);
        return amazonS3.getUrl(properties.getS3().getBucket() + "/kcc_pms", fileName + "." + ext).toString();
    }
}