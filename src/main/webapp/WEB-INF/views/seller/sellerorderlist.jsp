<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/seller/sellerorderlist.css'/>">
</head>
<body>
<%@ include file="../layout/sellerheader.jsp" %>
<%@ include file="../layout/sellerSidebar.jsp" %>
<div class="main">
	<h1>판매자 주문내역</h1>
	<table border="1" id="customers">
		<tr>
			<th>주문번호</th>
			<th colspan="2">상품이름</th>
			<th>옵션</th>
			<th>수량</th>
			<th>주문자(이름)</th>
			<th>배송비</th>
			<th>주문금액</th>
			<th>상태</th>
		</tr>
		<!-- 화면 출력 번호  변수 정의 -->		
		<c:set var="num" value="${listcount-(page-1)*10}"/> 	
		
		<c:forEach var="order" items="${orderlist}" >
			<tr>
				<td>
					<!-- 번호 출력 부분 -->	
 					<c:out value="${num}"/>			
					<c:set var="num" value="${num-1}"/>	 
				</td>
				<td style="border-right: none;">
					<img src="<%=request.getContextPath() %>/resources/images/thumbnailimage/${order.gds_thumbnail}" height="100" width="100" />
				</td>
				<td style="border-left: none;">
					<a href="sellerorderdetail?ord_num=${order.ord_num}&page=${page}">${order.gds_name}<br><br></a>
					<button type="button" onclick="location.href='goodsupdate?&gds_num=${order.ord_gdsnum}'">상품 수정하기</button>
				</td>
				<td>
					<c:choose>	
						<c:when test="${order.opt_2ndval != null}"> <!-- 옵션이 2종류이면 -->
							${order.opt_1stname} : ${order.opt_1stval}	<br>
							${order.opt_2ndname} : ${order.opt_2ndval}
						</c:when>
						<c:when test="${order.opt_1stval != null}">	 <!-- 옵션이 1 종류이면 -->
							${order.opt_1stname} : ${order.opt_1stval}
						</c:when>
						<c:otherwise>								 <!-- 옵션이 없으면 -->
							-
						</c:otherwise>
					</c:choose>
				</td>
				<td>${order.ol_count}</td>
				<td>${order.mem_id}</td>
				<td><fmt:formatNumber value="${order.deltem_delfee}" pattern="#,###원" /></td>
				<td><fmt:formatNumber value="${order.gds_price}" pattern="#,###원" /></td>
				<td>${order.ord_status} <br>
					<c:choose>
						<c:when test="${order.ord_delnum eq null }">	<!-- 배송준비중 이면 -->
							<input type="button" value="송장번호 입력">
						</c:when>
						<c:when test="${order.ord_delnum ne null }">	<!-- 배송중 이라면 -->
							${order.ord_delnum}
						</c:when>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>