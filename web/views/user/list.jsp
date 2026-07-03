<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- View: Trang chu hien thi danh sach sach, bo loc danh muc va tim kiem. --%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>FPT - Book Store</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/user-bookstore.css">
    </head>
    <body class="bookstore-user-page">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top bookstore-navbar">
            <div class="container">
                <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/home">
                    <i class="bi bi-book-half"></i>
                    <span>FPT BOOK</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <form class="d-none d-md-flex ms-lg-4 mt-2 mt-lg-0 align-items-center" action="${pageContext.request.contextPath}/home" method="get">
                        <input class="form-control me-2 rounded-pill px-3" type="search" name="txtSearch" placeholder="Tìm tên sách..." value="${param.txtSearch}">
                        <div class="d-flex align-items-center me-2">
                            <div class="input-group input-group-sm me-1" style="min-width:110px;">
                                <span class="input-group-text">₫</span>
                                <input class="form-control price-input" type="text" id="priceMinDisplay" placeholder="Giá từ" value="${param.priceMin}" aria-label="Giá từ">
                                <input type="hidden" name="priceMin" id="priceMin" value="${param.priceMin}" />
                            </div>
                            <div class="input-group input-group-sm" style="min-width:110px;">
                                <span class="input-group-text">₫</span>
                                <input class="form-control price-input" type="text" id="priceMaxDisplay" placeholder="Giá đến" value="${param.priceMax}" aria-label="Giá đến">
                                <input type="hidden" name="priceMax" id="priceMax" value="${param.priceMax}" />
                            </div>
                        </div>
                        <div class="d-flex align-items-center">
                            <button class="btn btn-outline-light rounded-pill" type="submit">Tìm</button>
                        </div>
                    </form>

                    <form class="d-flex d-md-none w-100 align-items-center gap-2 mobile-search-bar" action="${pageContext.request.contextPath}/home" method="get">
                        <button class="btn btn-outline-secondary btn-sm rounded-pill" type="button" data-bs-toggle="collapse" data-bs-target="#categoryCollapse" aria-expanded="false" aria-controls="categoryCollapse" title="Danh mục">
                            <i class="bi bi-funnel"></i>
                        </button>
                        <input class="form-control rounded-pill px-3" type="search" name="txtSearch" placeholder="Tìm tên sách..." value="${param.txtSearch}" style="flex:1">
                        <a class="btn btn-outline-secondary btn-sm position-relative me-1 rounded-pill" href="${pageContext.request.contextPath}/cart">
                            <i class="bi bi-cart"></i>
                            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                ${sessionScope.cart != null ? sessionScope.cart.size() : 0}
                            </span>
                        </a>
                        <div class="dropdown">
                            <button class="btn btn-outline-secondary btn-sm dropdown-toggle rounded-pill" type="button" id="mobileUserMenu" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="mobileUserMenu">
                                <c:choose>
                                    <c:when test="${sessionScope.user == null}">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/chatbot">AI tư vấn sách</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><h6 class="dropdown-header">Chào, ${sessionScope.user.displayName}</h6></li>
                                        <c:if test="${sessionScope.user.role == 1}">
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">Trang Admin</a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.user.role != 1}">
                                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/history">Lịch sử mua hàng</a></li>
                                        </c:if>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/chatbot">AI tư vấn sách</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </form>
                    <c:if test="${not empty priceError}">
                        <div class="alert alert-danger mt-2 mb-0 py-2 px-3" role="alert" style="font-size: 0.9rem;">
                            ${priceError}
                        </div>
                    </c:if>

                    <ul class="navbar-nav ms-auto align-items-center">
                        <c:choose>
                            <c:when test="${sessionScope.user == null}">
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <span class="nav-link text-warning">Chào, <strong>${sessionScope.user.displayName}</strong></span>
                                </li>
                                <c:if test="${sessionScope.user.role == 1}">
                                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Trang Admin</a></li>
                                </c:if>
                                <c:if test="${sessionScope.user.role != 1}">
                                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/history">Lịch sử mua hàng</a></li>
                                </c:if>
                                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                            </c:otherwise>
                        </c:choose>

                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/chatbot">AI tư vấn sách</a></li>

                        <li class="nav-item ms-lg-3">
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-light position-relative btn-sm px-3 rounded-pill">
                                Giỏ hàng
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    ${sessionScope.cart != null ? sessionScope.cart.size() : 0}
                                </span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container bookstore-page-shell my-4 my-md-5">
            <c:if test="${not empty sessionScope.stockMessage}">
                <div class="alert alert-warning" role="alert">
                    ${sessionScope.stockMessage}
                </div>
                <c:set var="stockMessage" value="" scope="session" />
            </c:if>
            <div class="row">
                <c:set var="extraParams" value="" />
                <c:if test="${not empty param.txtSearch}">
                    <c:set var="extraParams" value="${extraParams}&amp;txtSearch=${param.txtSearch}" />
                </c:if>
                <c:if test="${not empty param.priceMin}">
                    <c:set var="extraParams" value="${extraParams}&amp;priceMin=${param.priceMin}" />
                </c:if>
                <c:if test="${not empty param.priceMax}">
                    <c:set var="extraParams" value="${extraParams}&amp;priceMax=${param.priceMax}" />
                </c:if>

                <div class="col-md-3 mb-4">
                    <div class="sidebar bookstore-sidebar mb-3 mb-md-0">
                        <div class="bookstore-chip"><i class="bi bi-funnel"></i> Danh mục</div>
                        <div class="d-flex align-items-center justify-content-between gap-2">
                            <button class="btn btn-outline-secondary btn-sm rounded-pill" type="button" data-bs-toggle="collapse" data-bs-target="#categoryCollapse" aria-expanded="false" aria-controls="categoryCollapse" title="Danh mục">
                                <i class="bi bi-list"></i>
                            </button>
                            <h5 class="mb-0 d-none d-md-block">SHOPPING OPTIONS</h5>
                        </div>
                        <div class="collapse mt-3" id="categoryCollapse">
                            <p class="small fw-bold text-muted mt-0 mb-2">Sản Phẩm</p>
                            <div class="category-list bookstore-category-list">
                                <a href="${pageContext.request.contextPath}/home?cid=0${extraParams}" class="category-link bookstore-category-link ${param.cid == '0' || param.cid == null ? 'text-danger fw-bold' : ''}">Tất cả sản phẩm</a>
                                <c:forEach items="${categories}" var="c">
                                    <a href="${pageContext.request.contextPath}/home?cid=${c.id}${extraParams}" class="category-link bookstore-category-link ${param.cid == c.id ? 'text-danger fw-bold' : ''}">
                                        ${c.name}
                                    </a>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-9">
                    <div class="hero-panel bookstore-hero mb-3 mb-md-4">
                        <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center gap-2">
                            <div>
                                <div class="bookstore-chip"><i class="bi bi-stars"></i> Bộ sưu tập nổi bật</div>
                                <h5 class="m-0 text-uppercase fw-bold">Danh sách sách</h5>
                                <div class="text-white-50 small mt-1 d-md-none">Chạm vào sách để xem chi tiết hoặc thêm vào giỏ.</div>
                            </div>
                            <div class="text-white-50 small">Hiển thị ${data.size()} kết quả</div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-3 mb-md-4 p-3 top-toolbar bookstore-toolbar">
                        <h5 class="m-0 text-uppercase fw-bold">Khám phá sách</h5>
                        <div class="text-muted small">Chọn nhanh sách phù hợp trên mobile</div>
                    </div>

                    <div class="row g-3 g-md-4">
                        <c:forEach items="${data}" var="b">
                            <div class="col-6 col-lg-4">
                                <div class="book-card bookstore-card text-center">
                                    <a href="${pageContext.request.contextPath}/detail?id=${b.id}">
                                        <img src="${b.image}" class="book-img bookstore-book-img" alt="${b.title}">
                                    </a>
                                    <div class="book-title bookstore-book-title">${b.title}</div>
                                    <div class="text-muted small mb-2" style="height: 25px; overflow: hidden;">
                                        ${b.author != null && !b.author.isEmpty() ? 'Tác giả: ' : ''}<strong>${b.author}</strong>
                                    </div>
                                    <div class="book-price bookstore-price"><fmt:formatNumber value="${b.price}" pattern="#,##0" /> ₫</div>
                                    <div class="mb-2">
                                        <small class="text-secondary">Trên kệ: <strong>${b.stock}</strong></small>
                                    </div>
                                    <c:choose>
                                        <c:when test="${b.stock gt 0}">
                                            <a href="${pageContext.request.contextPath}/add-to-cart?id=${b.id}" class="btn btn-add bookstore-btn-add">Add To Cart</a>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-danger bookstore-btn-add" disabled>Hết hàng</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${data.size() == 0}">
                            <div class="col-12 text-center mt-4 mt-md-5 empty-state bookstore-empty-state">
                                <img src="https://cdn-icons-png.flaticon.com/512/7486/7486744.png" width="96" class="mb-3 opacity-50">
                                <p class="text-muted mb-0">Không tìm thấy cuốn sách nào.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <footer class="bg-dark text-white py-4 mt-5">
            <div class="container text-center">
                <small>&copy; 2026 FPT Book Store - PRJ301 FPT University</small>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            (function(){
                const nf = new Intl.NumberFormat('vi-VN');
                function digitsOnly(s){ return s ? s.replace(/[^0-9]/g, '') : '' }
                function attach(displayId, hiddenId){
                    const display = document.getElementById(displayId);
                    const hidden = document.getElementById(hiddenId);
                    if(!display || !hidden) return;
                    if(hidden.value) display.value = nf.format(hidden.value);
                    display.addEventListener('input', function(){
                        const raw = digitsOnly(this.value);
                        this.value = raw ? nf.format(raw) : '';
                        hidden.value = raw;
                        this.setSelectionRange(this.value.length, this.value.length);
                    });
                    const form = display.form;
                    if(form) form.addEventListener('submit', function(){
                        hidden.value = digitsOnly(display.value);
                    });
                }
                attach('priceMinDisplay','priceMin');
                attach('priceMaxDisplay','priceMax');
            })();
        </script>
    </body>
</html>
