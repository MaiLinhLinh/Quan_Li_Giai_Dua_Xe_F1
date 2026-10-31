<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="f1.util.HtmlUtil" %>
<%
    String loginError = (String) session.getAttribute("loginError");
    session.removeAttribute("loginError");
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Quản lý giải đua F1</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        .login-shell { background: radial-gradient(circle at top, #1e293b 0, #0f172a 42%, #020617 100%); }
    </style>
</head>
<body class="login-shell min-h-screen text-slate-900 flex items-center justify-center px-4 py-10">
    <div class="w-full max-w-md bg-white border border-slate-300 rounded-2xl shadow-2xl overflow-hidden">
        <div class="h-1.5 bg-red-600"></div>
        <div class="p-6 space-y-5">
            <div class="text-center border-b border-slate-200 pb-4">
                <div class="inline-flex items-center justify-center w-11 h-11 rounded-full bg-red-600 text-white font-black text-lg mb-2 shadow">
                    F1
                </div>
                <h3 class="text-base font-bold text-slate-900">ĐĂNG NHẬP HỆ THỐNG</h3>
                <p class="text-xs text-slate-500 mt-0.5">Hệ thống quản lí giải đua xe công thức F1</p>
            </div>

            <% if (loginError != null) { %>
                <div class="rounded-lg border border-red-300 bg-red-50 px-4 py-3 text-sm text-red-800">
                    <%= HtmlUtil.escape(loginError) %>
                </div>
            <% } %>

            <form action="<%= ctx %>/doDangNhap.jsp" method="post" class="space-y-4" autocomplete="on">
                <div>
                    <label for="tenDangNhap" class="block text-xs font-semibold text-slate-700 mb-1">Tên đăng nhập</label>
                    <input id="tenDangNhap" name="tenDangNhap" type="text" required autofocus
                           class="w-full px-3.5 py-2 border border-slate-300 rounded-lg text-sm text-slate-900 placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-red-500"
                           placeholder="Nhập tên đăng nhập">
                </div>
                <div>
                    <label for="matKhau" class="block text-xs font-semibold text-slate-700 mb-1">Mật khẩu</label>
                    <input id="matKhau" name="matKhau" type="password" required
                           class="w-full px-3.5 py-2 border border-slate-300 rounded-lg text-sm text-slate-900 placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-red-500"
                           placeholder="Nhập mật khẩu">
                </div>
                <div class="pt-1">
                    <button type="submit"
                            class="w-full py-2.5 px-4 bg-red-600 hover:bg-red-700 text-white font-semibold text-sm rounded-lg shadow transition">
                        Đăng nhập
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
