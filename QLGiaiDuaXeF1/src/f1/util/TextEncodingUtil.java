package f1.util;

import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

/**
 * Tạm thời phục hồi văn bản UTF-8 từng bị đọc bằng bảng mã Windows-1252.
 * Dữ liệu nhập mới không đi qua hàm này vì không chứa các ký tự lỗi đặc trưng.
 */
public final class TextEncodingUtil {
    private static final Charset WINDOWS_1252 = Charset.forName("windows-1252");

    private TextEncodingUtil() {
    }

    public static String repairMojibake(String value) {
        if (value == null || !looksLikeMojibake(value)) {
            return value;
        }
        try {
            String repaired = new String(value.getBytes(WINDOWS_1252), StandardCharsets.UTF_8);
            return repaired.indexOf('\uFFFD') >= 0 ? value : repaired;
        } catch (RuntimeException ignored) {
            return value;
        }
    }

    private static boolean looksLikeMojibake(String value) {
        return value.contains("Ã") || value.contains("Â") || value.contains("Ä") || value.contains("á»");
    }
}
