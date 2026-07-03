<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- View: Trang lich su cac don hang da dat cua user dang nhap. --%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử mua hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/user-bookstore.css">
</head>
<body class="bookstore-user-page">

<nav class="navbar navbar-dark bg-dark mb-4 mb-md-5 shadow-sm sticky-top bookstore-navbar">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home"><i class="bi bi-arrow-left"></i> Quay lại cửa hàng</a>
    </div>
</nav>

<div class="container bookstore-history-shell pb-4">
    <div class="page-title bookstore-page-title mb-4">
        <div class="d-flex align-items-center gap-2">
            <i class="bi bi-clock-history fs-4"></i>
            <div>
                <h2 class="fw-bold mb-1">Lịch sử đơn hàng</h2>
                <div class="small text-white-50">Xem nhanh trạng thái, tổng thanh toán và thao tác trên từng đơn.</div>
            </div>
        </div>
    </div>

    <div class="card p-4 bg-white bookstore-history-card">
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th class="ps-3">Mã đơn</th>
                        <th>Ngày đặt hàng</th>
                        <th>Tổng thanh toán</th>
                        <th>Trạng thái</th>
                        <th class="text-center">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${history}" var="o">
                        <tr>
                            <td class="ps-3 fw-bold">#ORD-${o.id}</td>
                            <td>
                                <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td class="text-danger fw-bold">
                                <fmt:formatNumber value="${o.totalPrice}" type="number"/> VND
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${o.status == 'Chờ xác nhận'}">
                                        <span class="status-badge bookstore-status-badge" style="background:#fff3cd;color:#856404;border:1px solid #ffc107">
                                            <i class="bi bi-clock"></i> Chờ xác nhận
                                        </span>
                                    </c:when>
                                    <c:when test="${o.status == 'Đang giao'}">
                                        <span class="status-badge bookstore-status-badge" style="background:#cfe2ff;color:#084298;border:1px solid #0d6efd">
                                            <i class="bi bi-truck"></i> Đang giao
                                        </span>
                                    </c:when>
                                    <c:when test="${o.status == 'Hoàn thành'}">
                                        <span class="status-badge bookstore-status-badge" style="background:#d1e7dd;color:#0a3622;border:1px solid #198754">
                                            <i class="bi bi-check-circle-fill"></i> Hoàn thành
                                        </span>
                                    </c:when>
                                    <c:when test="${o.status == 'Đã hủy'}">
                                        <span class="status-badge bookstore-status-badge" style="background:#f8d7da;color:#842029;border:1px solid #dc3545">
                                            <i class="bi bi-x-circle-fill"></i> Đã hủy
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge bookstore-status-badge bg-secondary text-white">${o.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/order-detail?oid=${o.id}"
                                   class="btn btn-primary btn-sm rounded-pill px-3 me-1">
                                    <i class="bi bi-eye"></i> Chi tiết
                                </a>
                                <c:if test="${o.status == 'Chờ xác nhận'}">
                                    <a href="${pageContext.request.contextPath}/delete-order?oid=${o.id}"
                                       class="btn btn-danger btn-sm rounded-pill px-3"
                                       onclick="return confirm('Hủy đơn hàng #ORD-${o.id}?')">
                                        <i class="bi bi-trash"></i> Hủy đơn
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty history}">
                        <tr>
                            <td colspan="5" class="text-center py-5 text-muted">
                                Bạn chưa có đơn hàng nào. <a href="${pageContext.request.contextPath}/home">Mua sắm ngay</a>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
