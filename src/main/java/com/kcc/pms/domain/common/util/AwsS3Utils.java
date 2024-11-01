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
        return properties.getS3().getFakeUrl()  + fileName + "." + ext;
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

    public S3ObjectInputStream downloadFile(String filePath) throws MalformedURLException, UnsupportedEncodingException {
        URL url = new URL(filePath);
        String path = url.getPath();
        String key = path;
        String bucketName = properties.getS3().getBucket();

        if (path.startsWith("/" + bucketName + "/")) {
            key = path.substring(bucketName.length() + 2);
        } else if (path.startsWith("/")) {
            key = path.substring(1);
        }

        S3Object s3Object = amazonS3.getObject(new GetObjectRequest(bucketName, key));
        return s3Object.getObjectContent();
    }

    public String generatePresignedUrl(String s3Key) {
        // 유효 기간 설정 (예: 1시간)
        Date expiration = new Date();
        long expTimeMillis = expiration.getTime();
        expTimeMillis += 1000 * 60 * 60; // 1시간 후 만료
        expiration.setTime(expTimeMillis);

        GeneratePresignedUrlRequest generatePresignedUrlRequest =
                new GeneratePresignedUrlRequest(properties.getS3().getBucket(), s3Key)
                        .withMethod(HttpMethod.GET)
                        .withExpiration(expiration);

        URL url = amazonS3.generatePresignedUrl(generatePresignedUrlRequest);
        return url.toString();
    }
}