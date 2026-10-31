cd D:\PTTK\Code\QLGiaiDuaXeF1

.\build.ps1

.\deploy.ps1 -TomcatHome "C:\Tools\apache-tomcat-9.0.123"
Sau đó bật Tomcat nếu nó chưa chạy:
$tomcatHome = "C:\Tools\apache-tomcat-9.0.123"
$env:CATALINA_HOME = $tomcatHome
$env:CATALINA_BASE = $tomcatHome
& "$tomcatHome\bin\startup.bat"
Mở web:
http://localhost:8080/QLGiaiDuaXeF1/gdDangNhap.jsp
Nếu không sửa code mà Tomcat đang chạy, chỉ cần mở lại link web; không cần build/deploy.
Khi không chạy web nữa, tắt Tomcat:
$tomcatHome = "C:\Tools\apache-tomcat-9.0.123"
$env:CATALINA_HOME = $tomcatHome
$env:CATALINA_BASE = $tomcatHome
& "$tomcatHome\bin\shutdown.bat"
SQL Server không cần tắt mỗi lần đóng web; cứ để chạy cũng được.


Không sửa code nhưng Tomcat đã tắt thì chỉ cần bật Tomcat, không cần build.ps1 hay deploy.ps1:
$tomcatHome = "C:\Tools\apache-tomcat-9.0.123"
$env:CATALINA_HOME = $tomcatHome
$env:CATALINA_BASE = $tomcatHome
& "$tomcatHome\bin\startup.bat"
Rồi mở:
http://localhost:8080/QLGiaiDuaXeF1/gdDangNhap.jsp
Tóm lại:
Không sửa code + Tomcat đang chạy → chỉ mở link web.
Không sửa code + Tomcat đã tắt → startup.bat.
Có sửa code → build.ps1 → deploy.ps1 → startup.bat nếu Tomcat đang tắt.