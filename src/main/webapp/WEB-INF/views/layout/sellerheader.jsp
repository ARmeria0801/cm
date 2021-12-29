<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>CSS</title>
<meta charset="utf-8">
<link rel="stylesheet"
	href="<c:url value='/resources/css/seller/sellerheader.css'/>">	
</head>
<body>

	<header>
		  <div class="links">
         <c:if test="${member == null}"><a href="member_login" class="link_text">로그인</a></c:if>
         <c:if test="${member != null}">${member.mem_id}님 안녕하세요.</c:if>
         <c:if test="${member != null}"><a href="member_logout" class="link_text">로그아웃</a></c:if>
         <c:if test="${member != null}"><a href="order_history" class="link_text">마이페이지</a></c:if>
         <c:if test="${member == null}"><a href="member_join" class="link_text">회원가입</a></c:if>
        <a href="/" class="link_text">공지</a>
      </div>
    <a href="home"><img src="resources/image/logo3.png" class="img_logo"/></a><br><br>
	</header>
	

</body>
</html>
