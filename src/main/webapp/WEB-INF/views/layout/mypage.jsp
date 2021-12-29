<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value='/resources/css/mypage.css'/>">
<title>메인페이지</title>
</head>
<body>
<div class="mypagesidenav">
  <h2>마이페이지</h2>
  <a href="#">취소 교환 반품 내역</a>
  <a href="passReCheck">개인 정보 수정</a>
  <a href="review_list">내 후기 목록</a>
  <c:choose>
  <c:when test="${member.mem_grade == 50}">
  <a href="sellergoodslist">판매자페이지</a>
  </c:when>
  <c:otherwise>
  <a href="sellerChange">판매자신청</a>
  </c:otherwise>
  </c:choose>
  <a href="#">문의QNA</a>
  <a href="member_delete">회원탈퇴</a>
</div>


</body>
</html>
