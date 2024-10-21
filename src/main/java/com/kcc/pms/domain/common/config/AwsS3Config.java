package com.kcc.pms.domain.common.config;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RequiredArgsConstructor
public class AwsS3Config {
    private final EnvVariableProperties properties;

    @Bean
    public AmazonS3Client amazonS3Client() {
        BasicAWSCredentials credentials = new BasicAWSCredentials(properties.getAccessKey(), properties.getSecretKey());

        return (AmazonS3Client) AmazonS3ClientBuilder
                .standard()
                .withRegion(properties.getRegion())
                .withCredentials(new AWSStaticCredentialsProvider(credentials))
                .build();
    }
}