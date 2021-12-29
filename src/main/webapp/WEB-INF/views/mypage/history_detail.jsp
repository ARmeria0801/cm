<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문내역 상세페이지</title>
<style>
.title{
text-align: left;
background: #E2E2E2;
}
</style>
</head>
<body>

주문 상세페이지 입니다.
<div>
	<table border="1">
		<tr>
			<th class="title" colspan="2">주문 정보</th>	
		</tr>
		<tr>
			<th>주문번호</th>
			<td>${order.ord_num}</td>
		</tr>
		<tr>
			<th>구매자 id</th>
			<td>${member.mem_id}</td>
		</tr>
		<tr>
			<th class="title" colspan="2">상품 정보</th>	
		</tr>
		<tr>
			<th>상품번호</th>
			<td>${goods.gds_num}</td>
		</tr>
		<tr>
			<th>상품명</th>
			<td>${goods.gds_name}</td>
		</tr>
		<tr>
			<th>상품옵션</th>
			<td>
				<c:choose>
					<c:when test="${option.opt_2ndval != null}">
						${option.opt_1stname} : ${option.opt_1stval}	<br>
						${option.opt_2ndname} : ${option.opt_2ndval}
					</c:when>
					<c:when test="${option.opt_1stval != null}">
						${option.opt_1stname} : ${option.opt_1stval}
					</c:when>
					<c:otherwise>
						-
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th>상품 수량</th>
			<td>${order.ord_gdscount} 개</td>
		</tr>	
		<tr>
			<th class="title" colspan="2">배송 정보</th>	
		</tr>
		<tr>
			<th>송장번호</th>
			<td>
				<!-- 수정필요 -->
			</td>
		</tr>
		<tr>
			<th>배송사</th>
			<td>${deliverytemplate.del_name}</td>
		</tr>
		<tr>
			<th>배송지 우편번호</th>
			<td>${deliveryAddress.deladd_post}</td>
		</tr>
		<tr>
			<th>배송지 주소</th>
			<td>${deliveryAddress.deladd_add1}</td>
		</tr>
		<tr>
			<th>배송지 상세주소</th>
			<td>${deliveryAddress.deladd_add2}</td>
		</tr>
		<tr>
			<th class="title" colspan="2">결제 정보</th>	
		</tr>
		<tr>
			<td colspan="2" style="text-align: center;">
			<input type="button" value="목록으로" onclick="location.href='order_history?page${page}'">
			</td>
		</tr>
	</table>
</div>

</body>
</html>