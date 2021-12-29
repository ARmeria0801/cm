<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<link rel="stylesheet" href="<c:url value='/resources/css/home.css'/>">
</head>
<body>
<%@ include file="layout/header.jsp" %>    
<main>
<div class="main-container">
<h3>베스트 상품</h3>
<hr>
<section class="bestlist">
 <div class="bestlist_box">
 	<section class="best_content">
		<ul>
			<%-- <c:forEach items="${list}" var="list"> --%>
			<li>
				<div class="best_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="best_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="best_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="best_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="best_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="best_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="best_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="best_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="best_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="best_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="best_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="best_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="best_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="best_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="best_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="best_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="best_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="best_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
		 	<%-- </c:forEach> --%>
		</ul>
 	</section>
 </div>
</section>
<br><br><br><br><br><br><br><br><br><br>
<h3>신상품</h3>
<hr>
<section class="newlist">
 <div class="newlist_box">
 	<section class="new_content">
		<ul>
			<%-- <c:forEach items="${list}" var="list"> --%>
			<li>
				<div class="new_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="new_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="new_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="new_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="new_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="new_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="new_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="new_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="new_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="new_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="new_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="new_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="new_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="new_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="new_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="new_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
			<li>
				<div class="new_goods">
				<img src="resources/image/logo2.png"/>
				</div>
				<div class="new_goods_name">
					<a href="#">상품1</a>
				</div>
			</li>		
		 	<%-- </c:forEach> --%>
		</ul>
 	</section>
 </div>
</section>
</div>
</main>
<%@ include file="layout/footer.jsp" %>    
</body>
</html>
