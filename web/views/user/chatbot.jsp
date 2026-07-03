<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- View: Giao dien chatbot AI tu van sach tu du lieu kho. --%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Tư vấn sách</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/user-bookstore.css">
</head>
<body class="bookstore-user-page">
<nav class="navbar navbar-dark bg-dark sticky-top shadow-sm bookstore-navbar">
    <div class="container">
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home"><i class="bi bi-book-half"></i> FPT BOOK</a>
        <a class="btn btn-outline-light btn-sm rounded-pill px-3" href="${pageContext.request.contextPath}/home"><i class="bi bi-house me-1"></i>Về trang chủ</a>
    </div>
</nav>

<div class="container bookstore-page-shell mt-4 mt-md-5 pb-4">
    <div class="hero-card bookstore-hero mb-4">
        <div class="card-body p-4 p-md-5">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-3">
                <div>
                    <div class="text-uppercase small fw-semibold mb-2" style="letter-spacing:0.08em; opacity: 0.8;">AI book concierge</div>
                    <h3 class="mb-2">Chatbot tư vấn sách</h3>
                    <p class="mb-0 text-muted">Nhập mô tả nhu cầu đọc, AI sẽ chọn sách phù hợp và hiển thị ngay để bạn xem chi tiết hoặc mua luôn.</p>
                </div>
                <div class="d-inline-flex align-items-center gap-2 px-3 py-2 rounded-pill" style="background: rgba(255,255,255,0.10);">
                    <i class="bi bi-stars"></i>
                    <span class="small fw-semibold">Gợi ý theo nhu cầu, không bịa sách ngoài kho</span>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm p-4 border-0 rounded-4 bookstore-history-card">
        <form method="post" action="${pageContext.request.contextPath}/chatbot">
            <div class="mb-3">
                <label for="query" class="form-label">Bạn đang muốn tìm sách như thế nào?</label>
                <textarea class="form-control" id="query" name="query" rows="4" placeholder="Ví dụ: Tôi cần sách Java cho người mới bắt đầu, có bài tập thực hành.">${query}</textarea>
            </div>
            <button class="btn btn-primary rounded-pill px-4" type="submit"><i class="bi bi-robot me-1"></i> Nhờ AI gợi ý</button>
        </form>

        <c:if test="${not empty error}">
            <div class="alert alert-danger mt-4">${error}</div>
        </c:if>

        <c:if test="${not empty answer}">
            <div class="card mt-4 border-success result-card bookstore-result-card">
                <div class="card-header bg-success text-white">Kết quả tư vấn</div>
                <div class="card-body">
                    <div class="mb-0"><c:out value="${answer}" /></div>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty recommendedBooks}">
            <div class="d-flex justify-content-between align-items-center mt-4 mb-3">
                <h5 class="mb-0">Sách AI đề xuất</h5>
                <span class="text-muted small">Bạn có thể xem chi tiết hoặc thêm vào giỏ hàng</span>
            </div>

            <div class="row g-3">
                <c:forEach items="${recommendedBooks}" var="b">
                    <div class="col-6 col-lg-4">
                        <div class="book-card bookstore-card text-center">
                            <a href="${pageContext.request.contextPath}/detail?id=${b.id}">
                                <img src="${b.image}" class="book-img bookstore-book-img" alt="${b.title}">
                            </a>

                            <div class="book-title bookstore-book-title--chatbot mb-2">${b.title}</div>
                            <div class="book-price mb-2">
                                <fmt:formatNumber value="${b.price}" pattern="#,##0" /> VND
                            </div>
                            <div class="book-stock bookstore-book-stock mb-3">Trên kệ: <strong>${b.stock}</strong></div>

                            <div class="d-flex justify-content-center gap-2">
                                <a href="${pageContext.request.contextPath}/detail?id=${b.id}" class="btn btn-outline-secondary btn-sm">Xem chi tiết</a>
                                <c:choose>
                                    <c:when test="${b.stock gt 0}">
                                        <a href="${pageContext.request.contextPath}/add-to-cart?id=${b.id}" class="btn btn-primary btn-sm">Thêm vào giỏ hàng</a>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-danger btn-sm" disabled>Hết hàng</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
