<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="f1.model.BanToChuc, f1.util.HtmlUtil, f1.util.TextEncodingUtil" %>
<%@ include file="/WEB-INF/jspf/auth.jspf" %>
<%
    BanToChuc btc = (BanToChuc) session.getAttribute("banToChuc");
    request.setAttribute("pageTitle", "Trang chính Ban tổ chức");

    String hoTen = TextEncodingUtil.repairMojibake(btc.getHoTen());
    hoTen = hoTen == null ? "" : hoTen.trim();
    String viTriCongViec = TextEncodingUtil.repairMojibake(btc.getViTriCongViec());
    String[] tuCach = hoTen.split("\\s+");
    String kyTu = tuCach.length > 0 ? tuCach[0].substring(0, 1) : "";
    if (tuCach.length > 1) {
        kyTu += tuCach[tuCach.length - 1].substring(0, 1);
    }
    kyTu = kyTu.toUpperCase();
%>
<%@ include file="/WEB-INF/jspf/header.jspf" %>

<section class="mb-7">
    <p class="page-kicker">Trang chính Ban tổ chức</p>
    <h1 class="mt-1 text-2xl font-extrabold tracking-tight text-slate-900">Điều hành giải đua F1</h1>
    <p class="mt-2 text-sm text-slate-500">Chọn chức năng quản lý phù hợp với công việc của bạn.</p>
</section>

<div class="grid gap-6 lg:grid-cols-3">
    <div class="rounded-2xl border border-slate-200 bg-slate-50 p-5 shadow-sm flex flex-col justify-between">
        <div>
            <h4 class="text-xs font-bold uppercase tracking-wider text-slate-500 border-b border-slate-200 pb-2.5 mb-4">
                Thông tin nhân viên
            </h4>
            <div class="flex items-center gap-3 mb-4">
                <div class="w-11 h-11 rounded-full bg-red-600 text-white font-bold flex items-center justify-center text-sm shadow">
                    <%= HtmlUtil.escape(kyTu) %>
                </div>
                <div>
                    <div class="text-sm font-bold text-slate-900"><%= HtmlUtil.escape(hoTen) %></div>
                    <div class="text-xs text-red-600 font-semibold"><%= HtmlUtil.escape(viTriCongViec) %></div>
                </div>
            </div>
            <div class="space-y-2 text-xs text-slate-700 bg-white p-3.5 rounded-lg border border-slate-200">
                <div class="flex justify-between">
                    <span class="text-slate-500">Họ tên:</span>
                    <span class="font-semibold text-slate-900"><%= HtmlUtil.escape(hoTen) %></span>
                </div>
                <div class="flex justify-between">
                    <span class="text-slate-500">Vị trí:</span>
                    <span class="font-semibold text-slate-900"><%= HtmlUtil.escape(viTriCongViec) %></span>
                </div>
            </div>
        </div>
    </div>

    <div class="lg:col-span-2 bg-white border border-slate-200 rounded-2xl p-5 shadow-sm">
        <h4 class="text-xs font-bold text-slate-500 uppercase tracking-wider border-b border-slate-200 pb-2.5 mb-4">
            Menu chức năng
        </h4>
        <div class="space-y-3">
            <a href="<%= ctx %>/gdTimTayDua.jsp"
               class="action-control block w-full px-4 py-3 text-center text-sm shadow-sm">
                Quản lý thông tin tay đua
            </a>
            <a href="<%= ctx %>/gdTimMuaGiai.jsp"
               class="action-control block w-full px-4 py-3 text-center text-sm shadow-sm">
                Đăng kí tay đua vào chặng đua
            </a>
            <button type="button" disabled title="Thuộc module tiếp theo, chưa triển khai trong module M1"
                    class="w-full py-3 px-4 rounded-lg bg-slate-200 text-slate-500 font-semibold text-sm cursor-not-allowed text-center">
                Xem bảng xếp hạng tay đua
            </button>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
