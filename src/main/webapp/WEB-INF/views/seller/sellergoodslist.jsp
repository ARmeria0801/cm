<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품목록</title>
<link rel="stylesheet" href="<c:url value='/resources/css/seller/sellergoodslist.css'/>">
<script src="<%=request.getContextPath()%>/resources/js/sellerjs/sellergoodslistjs.js"></script>
</head>
<body>
<%@ include file="../layout/sellerheader.jsp" %>
<%@ include file="../layout/sellerSidebar.jsp" %>
	<div class="main">
		<h1 class="goodslist_title">상품목록</h1>
	<div id="goodslist_div">
		<div id="goodslist_c">총 판매상품 : ${listcount}개</div>

		<table id="goodslist_t" border="1">
			<tr>
				<th height="26">
					<div align="center">번호</div>
				</th>
				<th>
					<div align="center">상품명</div>
				</th>
				<th >
					<div align="center">가격</div>
				</th>
				<th>
					<div align="center">재고</div>
				</th>
				<th>
					<div align="center">등록일</div>
				</th>
				<th>
					<div align="center">조회수 / 판매수</div>
				</th>
				<th>
					<div align="center">상태</div>
				</th>
				<th>
					<div align="center">액션</div>
				</th>
			</tr>
			
			<!-- 화면 출력 번호  변수 정의 -->		
			<c:set var="num" value="${listcount-(page-1)*10}"/> 	
			
			<!-- 반복문 시작 -->
			<c:forEach var="sgl" items="${sellergoodslist}">
			<tr>
				<td>
					<!-- 번호 출력 부분 -->	
 					<c:out value="${num}"/>			
					<c:set var="num" value="${num-1}"/>	 
				</td>
				<td>
					<div>
						<!-- 썸네일 출력 부분 -->
						<img src="<%=request.getContextPath() %>/resources/images/thumbnailimage/${sgl.gds_thumbnail}" height="100" width="100" />	
						<!-- 제목 출력 부분 -->	
						<a href="goodsupdate?page=${page}&gds_num=${sgl.gds_num}">
							${sgl.gds_name}
						</a>
					</div>
				</td>
				<td >
					<div><fmt:formatNumber value="${sgl.gds_price}" pattern="#,###원" /></div>
				</td>
				<td>
					<div><fmt:formatNumber value="${sgl.gds_count}" pattern="#,###개" /></div>
				</td>
				<td>
					<div><fmt:formatDate value="${sgl.gds_date}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
				</td>
				<td>
					<div><fmt:formatNumber value="${sgl.gds_readcount}" pattern="#,###" /> / <fmt:formatNumber value="${sgl.gds_sellcount}" pattern="#,###" /></div>
				</td>
				<td>
					<c:if test="${sgl.gds_viewyn eq 'y' || sgl.gds_viewyn eq 'Y'}">
						<div align = "center">판매중</div>
						<button type="button" onclick="location='goodshide?page=${page}&gds_num=${sgl.gds_num}'">판매중지</button>
					</c:if>
					<c:if test="${sgl.gds_viewyn eq 'n' || sgl.gds_viewyn eq 'N'}">
						<div align = "center">판매 중지</div>
						<button type="button" onclick="location='goodsview?page=${page}&gds_num=${sgl.gds_num}'">판매중으로 전환</button>
					</c:if>
				</td>
				<td>
						<button type="button" onclick="location='goodsdetail?page=${page}&gds_num=${sgl.gds_num}'">구매자 페이지에서 보기</button><br><br>
						<button type="button" onclick="del(${page},${sgl.gds_num})">삭제</button>
				</td>
			</tr>
			</c:forEach>
		</table>
		<div id="bbslist_paging">			
			<c:if test="${page <=1 }">
				[이전]&nbsp;
			</c:if>
			
			<c:if test="${page > 1 }">
				<a href="sellergoodslist?page=${page-1}">[이전]</a>&nbsp;
			</c:if>			

			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a == page }">
					[${a}]
				</c:if>
				<c:if test="${a != page }">
					<a href="sellergoodslist?page=${a}">[${a}]</a>&nbsp;
				</c:if>
			</c:forEach>			
			
			<c:if test="${page >= maxpage }">
				[다음] 
			</c:if>
			<c:if test="${page < maxpage }">
				<a href="sellergoodslist?page=${page+1}">[다음]</a>
			</c:if>			
		</div>

	</div>
	</div>
</body>
</html>