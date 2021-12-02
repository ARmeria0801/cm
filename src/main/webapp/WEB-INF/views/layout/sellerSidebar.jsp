<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>판매자 메인페이지</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/seller/sellerSidebar.css'/>">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>


<body>
<div class="mypagesidenav">
  	<h2>판매자 페이지</h2>
  	<div class="title">주문관리</div>
  	<div class="menu">
  		<a href="sellerorderlist">판매자 주문내역</a>
  	</div>
  	
  	<div class="title">상품관리</div>
 	<div class="menu">
	 	<a href="goodsuploadform">판매자 상품 업로드 폼</a>			
		<a href="sellergoodslist">판매자 상품 리스트</a>
	</div>	
	
	<div class="title">문의 / 후기관리</div>
	<div class="menu">
		<a href="sellergoodsqnalist">판매자 문의내역</a>
	</div>	
		
	<div class="title">배송관리</div>
  	<div class="menu">
  		<a href="sellerdeliverytemplate">판매자 배송 템플릿 작성</a>		
		<a href="sellerdeliverytemplatelist">판매자 배송템플릿 리스트</a>
  	</div>
  	
	<div class="title">정산관리</div>
	<div class="menu">
		<a href="sellercalculatelist">판매자 정산내역</a>
	</div>					
				
						
</div>

<div class="main">
</div>  
<script type="text/javascript">
$(".title").click(function() {
	   $(this).next(".menu").stop().slideToggle(300);
	  $(this).toggleClass('on').siblings().removeClass('on');
	  $(this).next(".menu").siblings(".menu").slideUp(300); // 1개씩 펼치기
	});
</script>

</body>
</html>