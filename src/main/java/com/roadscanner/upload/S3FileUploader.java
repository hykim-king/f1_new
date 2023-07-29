package com.roadscanner.upload;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.util.Properties;

import org.apache.ibatis.io.Resources;

public class S3FileUploader {

    public static void uploadFile(File fileToUpload, String fileKey) throws IOException {
    	System.out.println("┌────────────────────┐");
    	System.out.println("│UploadFile to Bucket│");
    	System.out.println("└────────────────────┘");
    	
    	String accessKey;
    	String secretKey;
    	String region;
    	String bucketName;
    	
        String resource = "config/upload.properties";
        Properties properties = new Properties();
        Reader reader = Resources.getResourceAsReader(resource);
        properties.load(reader);
        
        // AWS 자격 증명 설정
        accessKey = properties.getProperty("cloud.aws.credentials.accessKey");
        secretKey = properties.getProperty("cloud.aws.credentials.secretKey");
        region = properties.getProperty("cloud.aws.region.static");
        
        // S3 버킷 설정
        bucketName = properties.getProperty("cloud.aws.s3.bucket");
    	
        S3Client s3Client = S3Client.builder()
                .region(Region.of(region))
                .credentialsProvider(StaticCredentialsProvider.create(
                        AwsBasicCredentials.create(accessKey, secretKey)
                ))
                .build();

        try {
        	PutObjectRequest request = PutObjectRequest.builder()
                                   .bucket(bucketName)
                                   .key(fileKey)
                                   .build();

        	s3Client.putObject(request, fileToUpload.toPath());
        	System.out.println("**********************");
        	System.out.println("*File upload Success!*");
        	System.out.println("**********************");
        } catch (S3Exception e) {
        	System.err.println("Error: " + e.getMessage());
        	throw e; // 업로드 실패 시 예외를 발생시킵니다. 이후 컨트롤러에서 예외 처리 가능
        } finally {
        	s3Client.close(); // 클라이언트 리소스 정리
        }
    }

}
