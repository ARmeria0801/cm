<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>판매자 메인페이지</title>
<style>

.main {
	margin-left: 300px; /* Same width as the sidebar + left position in px */
	margin-right: 300px; 
	margin-top: 90px; 
	font-size: 18px; /* Increased text to enable scrolling */
	padding: 0px 10px;
	display: grid;
	grid-template-rows: repeat(2, 300px);
	grid-template-columns: repeat(2, 1fr);
	row-gap: 10px; /* row의 간격을 10px로 */
	column-gap: 20px; /* column의 간격을 20px로 */
	
}

.mainOrderTable th{
	text-align : center;
	background : #e9ecef;
}

.mainOrdername{
	text-overflow:ellipsis; 
	overflow:hidden; 
	white-space:nowrap;
}

td{
	font-size: 12px; /* Increased text to enable scrolling */
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


</head>


<body>
<%@ include file="../layout/sellerheader.jsp" %>
<%@ include file="../layout/sellerSidebar.jsp" %>

<div class="main">
	<div class="lefttop">
		<table border="1" style="table-layout:fixed" width="600" class="mainOrderTable">
			<thead><h2>최근 주문 현황</h2></thead>
			<tr>
				<th width="50%">상품명</th>
				<th width="10%">수량</th>
				<th width="20%">금액</th>
				<th width="20%">날짜</th>
			</tr>
			<c:forEach var="mainOrderList" items="${mainOrderList}">
			<tr>
				<td class="mainOrdername" title="${mainOrderList.gds_name }"><nobr>${mainOrderList.gds_name }</nobr></td>
				<td>${mainOrderList.ol_count }</td>
				<td><fmt:formatNumber value="${mainOrderList.ord_totalprice }" pattern="#,###원"/> </td>
				<td><fmt:formatDate value="${mainOrderList.ord_date}" pattern="yyyy-MM-dd"/></td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div class="righttop">
		<table border="1" style="table-layout:fixed" width="600" class="mainOrderTable">
			<thead><h2>판매자 공지</h2></thead>
			<tr>
				<th width="50%">상품명</th>
				<th width="10%">수량</th>
				<th width="20%">금액</th>
				<th width="20%">날짜</th>
			</tr>
			<%-- <c:forEach var="mainOrderList" items="${mainOrderList}">
			<tr>
				<td class="mainOrdername" title="${mainOrderList.gds_name }"><nobr>${mainOrderList.gds_name }</nobr></td>
				<td>${mainOrderList.ord_gdscount }</td>
				<td>${mainOrderList.ord_totalprice }</td>
				<td></td>
			</tr>
			</c:forEach> --%>
		</table>
	</div>
	
	<div class="lefttop">
		<table border="1" style="table-layout:fixed" width="600" class="mainOrderTable">
		<thead><h2>최근 문의</h2></thead>
			<tr>
				<th width="40%">상품명</th>
				<th width="20%">제목</th>
				<th width="20%">날짜</th>
				<th width="20%">상태</th>
			</tr>
			<c:forEach var="mainGoodsQnaList" items="${mainGoodsQnaList}">
			<tr>
				<td class="mainOrdername" title="${mainGoodsQnaList.gds_name }"><nobr>${mainGoodsQnaList.gds_name }</nobr></td>
				<td class="mainOrdername" title="${mainGoodsQnaList.gdsqna_title}"><nobr>${mainGoodsQnaList.gdsqna_title}</nobr></td>
				<td><fmt:formatDate value="${mainGoodsQnaList.gdsqna_date}" pattern="yyyy-MM-dd"/></td>
				<td>
					<c:choose>
						<c:when test="${mainGoodsQnaList.gdsqna_answer == 0}">
							미답변
						</c:when>
						<c:when test="${mainGoodsQnaList.gdsqna_answer == 1}">
							답변완료
						</c:when>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<div class="lefttop">
		<table border="1" style="table-layout:fixed" width="600" class="mainOrderTable">
		<thead><h2>최근 후기</h2></thead>
			<tr>
				<th width="40%">상품명</th>
				<th width="20%">옵션</th>
				<th width="20%">후기내용</th>
				<th width="20%">날짜</th>
			</tr>
			<c:forEach var="mainReviewList" items="${mainReviewList}">
			<tr>
				<td class="mainOrdername" title="${mainReviewList.gds_name }"><nobr>${mainReviewList.gds_name }</nobr></td>
				<td>
					<c:choose>
						<c:when test="${mainReviewList.opt_2ndval != null}">
							${mainReviewList.opt_1stname} : ${mainReviewList.opt_1stval}	<br>
							${mainReviewList.opt_2ndname} : ${mainReviewList.opt_2ndval}
						</c:when>
						<c:when test="${mainReviewList.opt_1stval != null}">
							${mainReviewList.opt_1stname} : ${mainReviewList.opt_1stval}
						</c:when>
						<c:otherwise>
							-
						</c:otherwise>
					</c:choose>
				</td>
				<td>${mainReviewList.rev_content }</td>
				<td><fmt:formatDate value="${mainReviewList.rev_date}" pattern="yyyy-MM-dd"/></td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>  

</body>
</html>
