package com.roadscanner.service.upload;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.apache.ibatis.io.Resources;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.roadscanner.cmn.PcwkLogger;
import com.roadscanner.dao.upload.FileUploadDao;
import com.roadscanner.domain.upload.FileUploadVO;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;

@Service
public class FileUploadServiceImpl implements PcwkLogger, FileUploadService {
	
	@Autowired
	FileUploadDao dao;
	
	@Autowired
	FileUploadVO uploadVO;

	@Override
	public List<FileUploadVO> quarterlyFeedback(FileUploadVO inVO) throws SQLException {
		
		return dao.quarterlyFeedback(inVO);
	}

	@Override
	public FileUploadVO totalFeedback(FileUploadVO inVO) throws SQLException {
		
		return dao.totalFeedback(inVO);
	}

	@Override
	public List<FileUploadVO> doRetrieve(FileUploadVO inVO) throws SQLException {
		
		return dao.doRetrieve(inVO);
	}

	@Override
	public FileUploadVO doSelectOne(FileUploadVO inVO) throws SQLException {
		
		return dao.doSelectOne(inVO);
	}

	@Override
	public int doUpdate(FileUploadVO inVO) throws SQLException {
		
		return dao.doUpdate(inVO);
	}

	@Override
	public int doDelete(FileUploadVO inVO) throws SQLException {
		
		return dao.doDelete(inVO);
	}

	@Override
	public int doSave(MultipartFile file, FileUploadVO inVO) throws SQLException, IOException {
        uploadVO = uploadFileToS3(file, inVO);
        
		return dao.doSave(uploadVO);
	}
	
	private FileUploadVO uploadFileToS3(MultipartFile file, FileUploadVO uploadVO) throws IOException {
    	LOG.debug("┌────────────────────┐");
    	LOG.debug("│UploadFile to Bucket│");
    	LOG.debug("└────────────────────┘");
		
        String resource = "config/upload.properties";
        Properties properties = new Properties();
        Reader reader = Resources.getResourceAsReader(resource);
        properties.load(reader);
        
        // AWS 자격 증명 설정
        String accessKey = properties.getProperty("cloud.aws.credentials.accessKey");
        String secretKey = properties.getProperty("cloud.aws.credentials.secretKey");
        String region = properties.getProperty("cloud.aws.region.static");
        
        // S3 버킷 설정
        String bucketName = properties.getProperty("cloud.aws.s3.bucket");
		
        // 파일 이름 형식(yyyyMMddHH24MISS_원본파일명), 등록일, url, 파일 크기 설정
		Date currentDate = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		
		String datestr  = dateFormat.format(currentDate);
		String fileName = datestr+"_"+file.getOriginalFilename();
		String url      = "https://"+bucketName+".S3."+region+".amazonaws.com/"+fileName;
		int    fileSize = (int) (file.getSize() / 1024);
		
        File convertedFile = new File(file.getOriginalFilename());
        try (FileOutputStream fos = new FileOutputStream(convertedFile)) {
            fos.write(file.getBytes());
        }
		
        S3Client s3Client = S3Client.builder()
                .region(Region.of(region))
                .credentialsProvider(StaticCredentialsProvider.create(
                        AwsBasicCredentials.create(accessKey, secretKey)
                ))
                .build();

        try {
        	PutObjectRequest request = PutObjectRequest.builder()
        	        .bucket(bucketName)
        	        .key(fileName)
        	        .build();

        	s3Client.putObject(request, convertedFile.toPath());
        	LOG.debug("**********************");
        	LOG.debug("*File upload Success!*");
        	LOG.debug("**********************");
        	
        	uploadVO.setUploadDate(datestr);
        	uploadVO.setName(fileName);
        	uploadVO.setUrl(url);
        	uploadVO.setFileSize(fileSize);
        	
        	String voString = uploadVO.toString();
    		LOG.debug("┌──────────┐");
    		LOG.debug("│uploadVO: "+voString);
    		LOG.debug("└──────────┘");
        	
        	return uploadVO;
        } catch (S3Exception e) {
        	System.err.println("Error: " + e.getMessage());
        	throw e;

        } finally {
        	// 클라이언트 리소스 정리
        	s3Client.close();
        }
	}

}
