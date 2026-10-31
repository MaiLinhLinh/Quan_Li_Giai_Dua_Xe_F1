package f1.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public final class DateUtil {
    private DateUtil() {
    }

    private static final DateTimeFormatter DINH_DANG_NGAY = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public static String format(LocalDate date) {
        if (date == null) {
            return "";
        }
        return date.format(DINH_DANG_NGAY);
    }

    public static LocalDate parse(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        return LocalDate.parse(value.trim());
    }
}
