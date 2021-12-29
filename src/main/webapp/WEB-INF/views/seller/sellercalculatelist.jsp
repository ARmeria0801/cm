<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정산리스트</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/seller/sellercalculatelist.css'/>">
<script src="<%=request.getContextPath()%>/resources/js/sellerjs/sellercalculatelistjs.js"></script>

<style type="text/css">
 	 table {width:900px;}  

/*     .calculdetail {display:none;}  

    .calculList td {cursor:pointer;}   */

    .show {display:table-row;}  
</style>
</head>
<body>
<%@ include file="../layout/sellerheader.jsp" %>
<%@ include file="../layout/sellerSidebar.jsp" %>
	<div class="main">
	 <h1>정산리스트</h1>
		<table id="caltable" border="1">
			<tr>
				<th>정산번호</th>
				<th>주문번호</th>
				<th>판매금액</th>
				<th>PG수수료</th>
				<th>플랫폼수수료</th>
				<th>정산금액</th>
				<th>정산 신청일</th>
				<th>정산일</th>
				<th>상태</th>
				<th>비고</th>
			</tr>
			<c:set var="num" value="${listcount-(page-1)*10}" />
			<c:forEach var="clist" items="${calculatelist}">
			
				<tr class="calculList">
					<td>
						<input type="hidden" id="clcln_num" name ="clcln_num" value="${clist.clcln_num}">
						<input type="hidden" id="sel_num" name ="sel_num" value="${clist.sel_num}">
						<input type="hidden" id="gds_num" name ="gds_num" value="${clist.gds_num}">
						<!-- 번호 출력 부분 -->
						<c:out value="${num}" />
					</td>
					<c:set var="num" value="${num-1}" />
					<td>${clist.ord_num }</td>
					<td><fmt:formatNumber value="${clist.ord_totalprice }"
							pattern="#,###원" /></td>
					<td><fmt:formatNumber value="${clist.ord_totalprice*0.037}"
							pattern="#,###원" /></td>
					<td><fmt:formatNumber value="${clist.ord_totalprice*0.01}"
							pattern="#,###원" /></td>
					<td><fmt:formatNumber value="${clist.clcln_amount}"
							pattern="#,###원" /></td>
					<td><fmt:formatDate value="${clist.clcln_appdate }"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><c:if test="${clist.clcln_comdate == null}">
						-
					</c:if> <fmt:formatDate value="${clist.clcln_comdate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${clist.clcln_status}</td>
					<td>
					<button type="button" onclick="showcalculdetail(${clist.clcln_num})">상세페이지 보기</button>
					</td>
				</tr>
				<tr>
					<td colspan="10" >
						<div id="calculdetail${clist.clcln_num}" class="hide"></div>
					</td>
				</tr>

			</c:forEach>
		</table>
		<br>
		<div id="bbslist_paging">
			<c:if test="${page <=1 }">
				[이전]&nbsp;
			</c:if>

			<c:if test="${page > 1 }">
				<a href="sellercalculatelist?page=${page-1}">[이전]</a>&nbsp;
			</c:if>

			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a == page }">
					[${a}]
				</c:if>
				<c:if test="${a != page }">
					<a href="sellercalculatelist?page=${a}">[${a}]</a>&nbsp;
				</c:if>
			</c:forEach>

			<c:if test="${page >= maxpage }">
				[다음] 
			</c:if>
			<c:if test="${page < maxpage }">
				<a href="sellercalculatelist?page=${page+1}">[다음]</a>
			</c:if>
		</div>

	</div>

</body>
</html>