package com.kcc.pms.domain.common.util;

import com.amazonaws.HttpMethod;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.*;
import com.kcc.pms.domain.common.config.EnvVariableProperties;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.List;

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
        return properties.getS3().getUrl()  + fileName + "." + ext;
    }

    public void deleteImage(String filePath) {
        DeleteObjectRequest deleteObjectRequest;
        deleteObjectRequest = new DeleteObjectRequest(properties.getS3().getBucket(), filePath);
        amazonS3.deleteObject(deleteObjectRequest);
    }

    public void deleteImages(List<String> files){
        if (files != null) {
            for (String file : files) {
                deleteImage(file);
            }
        }
    }

    public S3ObjectInputStream downloadFile(String filePath) {
        String bucketName = properties.getS3().getBucket();
        String objectKey = filePath.substring(filePath.indexOf("/", 8) + 1); // "8"은 "https://" 이후 첫 '/' 위치를 건너뛰기 위함입니다.

        GetObjectRequest getObjectRequest = new GetObjectRequest(bucketName, objectKey);
        S3Object s3Object = amazonS3.getObject(getObjectRequest);

        return s3Object.getObjectContent();
    }

}
