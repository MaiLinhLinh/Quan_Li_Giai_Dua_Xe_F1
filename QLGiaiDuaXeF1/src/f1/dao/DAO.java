package f1.dao;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DAO {

    private static final Properties PROPS = new Properties();

    static {
        // Đọc cấu hình SQL Server một lần khi lớp DAO được nạp.
        try (InputStream in = DAO.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in == null) {
                throw new IllegalStateException("Không tìm thấy db.properties trong classpath (WEB-INF/classes).");
            }
            PROPS.load(new InputStreamReader(in, StandardCharsets.UTF_8));
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (Exception e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    protected Connection getConnection() throws SQLException {
        // Mỗi thao tác DAO lấy một kết nối riêng; DAO con tự đóng bằng try-with-resources.
        return DriverManager.getConnection(
                PROPS.getProperty("db.url"),
                PROPS.getProperty("db.username"),
                PROPS.getProperty("db.password"));
    }
}
