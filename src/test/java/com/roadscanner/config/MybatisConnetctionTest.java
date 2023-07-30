package com.roadscanner.config;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

import javax.sql.DataSource;

import java.sql.Connection;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

@SpringJUnitConfig(classes = {DatabaseConfig.class, MyBatisConfig.class})
class MybatisConnectionTest {

    @Autowired
    private DataSource dataSource;

    @DisplayName("마이바티스 연결 테스트")
    @Test
    void testConnection() {
        try (Connection connection = dataSource.getConnection()) {
            Assertions.assertNotNull(connection);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}