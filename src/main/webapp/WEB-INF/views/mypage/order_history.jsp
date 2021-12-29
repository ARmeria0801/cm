<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/mypage/order_history.css'/>">
</head>
<body>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/mypage.jsp" %>
<div class="main">
<h1>구매내역</h1>
<div id="count">구매내역 : ${listcount }건</div>
	<table border="1" id="customers">
		<tr style="text-align: center;">
			<th>주문번호</th>
			<th>썸네일, 상품이름</th>
			<th>옵션</th>
			<th>수량</th>
			<th>배송비</th>
			<th>요청사항</th>
			<th>총 결제금액</th>
			<th>후기</th>
		</tr>
		<!-- 화면 출력 번호  변수 정의 -->		
		<c:set var="num" value="${listcount-(page-1)*10}"/> 	
		
		<c:choose>
		<c:when test="${!empty historylist}">
		<c:forEach var="his" items="${historylist}">
			<tr>
				<td>${his.ord_num}</td>
				<td>
					<img src="<%=request.getContextPath() %>/resources/image/thumbnailimage/${his.gds_thumbnail}" height="100" width="100" />
						<a>${his.gds_name}<br></a>
				</td>
				<td>
					<c:choose>
	                  <c:when test="${his.opt_2ndval != null}">
	                     ${his.opt_1stname} : ${his.opt_1stval}   <br>
	                     ${his.opt_2ndname} : ${his.opt_2ndval}
	                  </c:when>
	                  <c:when test="${his.opt_1stval != null}">
	                     ${his.opt_1stname} : ${his.opt_1stval}
	                  </c:when>
	                  <c:otherwise>
	                     -
	                  </c:otherwise>
	               </c:choose>
				</td>
				<td>${his.ord_gdscount}</td>
				<td><fmt:formatNumber value="${his.ord_delfee}" pattern="#,###원" /></td>
				<td>${his.ord_request}</td>
				<td><fmt:formatNumber value="${his.ord_totalprice}" pattern="#,###원" /></td>
				<td>
				<button type="button" onclick="location.href='#'">취소</button>
				<button type="button" onclick="location.href='#'">환불</button>
				<button type="button" onclick="location.href='#'">교환</button>
				<button type="button" onclick="location.href='review_write?ord_gdsnum=${his.ord_gdsnum}&ord_num=${his.ord_num}'">후기</button>
				</td>
			</tr>
			</c:forEach>
		</c:when>
		<c:otherwise>
		<tr>
		 <td colspan="8">구매한 물품이 없습니다.</td>
		</tr>
		</c:otherwise>
		</c:choose>
		
	</table>
	<div id="bbslist_paging">
			<c:if test="${page <=1 }">
				[이전]&nbsp;
			</c:if>

			<c:if test="${page > 1 }">
				<a href="order_history?page=${page-1}">[이전]</a>&nbsp;
			</c:if>

			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a == page }">
					[${a}]
				</c:if>
				<c:if test="${a != page }">
					<a href="order_history?page=${a}">[${a}]</a>&nbsp;
				</c:if>
			</c:forEach>

			<c:if test="${page >= maxpage }">
				[다음] 
			</c:if>
			<c:if test="${page < maxpage }">
				<a href="order_history?page=${page+1}">[다음]</a>
			</c:if>
		</div>

	</div>

<%@ include file="../layout/footer.jsp" %>
</body>
</html>