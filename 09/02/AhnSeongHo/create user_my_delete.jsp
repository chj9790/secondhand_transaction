<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>

<style>
body {
    font-family: 'Segoe UI', sans-serif;
    background-color: #f4f7fb;
    margin: 0;
    padding: 0;
}

/* 메인 컨테이너 */
.delete-container {
    max-width: 1000px;
    margin: 40px auto;
    padding: 0 20px;
}

/* 카드 스타일 */
.delete-card {
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    padding: 30px;
    border: 1px solid #e0e0e0;
}

/* 타이틀 */
.delete-title {
    text-align: center;
    font-size: 28px;
    color: #dc2626;
    margin-bottom: 20px;
    font-weight: 600;
}

/* 회원 메뉴 네비게이션 */
.nav-links {
    text-align: center;
    margin-bottom: 30px;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    border: 1px solid #e0e0e0;
}

.nav-links a {
    color: #2b7cff;
    text-decoration: none;
    font-size: 15px;
    font-weight: 500;
    margin: 0 20px;
    padding: 8px 16px;
    border-radius: 6px;
    transition: all 0.2s ease;
}

.nav-links a:hover {
    background-color: #dceaff;
    text-decoration: none;
}

/* 경고 문구 */
.alert-warning {
    background: #fff3cd;
    color: #856404;
    border-radius: 8px;
    padding: 15px;
    font-size: 14px;
    line-height: 1.5;
    margin-bottom: 30px;
}

/* 버튼 그룹 */
.button-group {
    text-align: center;
}

.btn {
    padding: 12px 24px;
    border-radius: 6px;
    font-size: 15px;
    font-weight: 500;
    cursor: pointer;
    border: none;
    transition: all 0.25s ease;
}

.btn-danger {
    background-color: #dc2626;
    color: white;
}

.btn-danger:hover {
    background-color: #a71d2a;
}

.btn-secondary {
    background-color: #f8f9fa;
    color: #666;
    border: 1px solid #ddd;
    margin-left: 10px;
}

.btn-secondary:hover {
    background-color: #e9ecef;
    color: #495057;
}

.text-center {
    text-align: center;
}

/* 반응형 */
@media screen and (max-width: 768px) {
    .delete-container {
        margin: 20px auto;
        padding: 0 15px;
    }
    .nav-links a {
        display: block;
        margin: 8px 0;
    }
}
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp" />

<div class="delete-container">

    <!-- 회원 메뉴 네비게이션 -->
    <div class="nav-links">
        <a href="user_my_page.go">회원정보 수정</a>
        <a href="user_sales_product_list.go">판매글 목록</a>
        <a href="user_my_chat.go">메세지 목록</a>
        <a href="user_my_delete.go">회원 탈퇴</a>
    </div>

    <div class="delete-card">
        <h2 class="delete-title">회원 탈퇴</h2>

        <div class="alert-warning">
            <strong>주의!</strong> 회원 탈퇴 시, 계정과 관련된 모든 정보가 삭제되며 복구가 불가능합니다.<br>
            정말로 탈퇴하시겠습니까?
        </div>

        <form action="<c:url value='/user_my_delete_ok.go' />" method="post">
            <div class="button-group">
                <button type="submit" class="btn btn-danger">예, 탈퇴하겠습니다</button>
                <a href="<c:url value='/user_my_page.go' />" class="btn btn-secondary">취소</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>
</html>
