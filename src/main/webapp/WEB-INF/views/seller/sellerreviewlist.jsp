<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/seller/sellerreviewlist.css'/>">
<script type="text/javascript">
function showreviewdetail(rev_num) {
	if($("#reviewdetail"+rev_num).hasClass('hide')) {
		 $.ajax({
	 	    url : '/showreviewdetail', // 요청 할 주소
	 	   // async: true, // false 일 경우 동기 요청으로 변경
	 	    type : 'post', // GET, PUT
	 	    dataType : 'text',
	 	    data : {
	 	    	"rev_num" : rev_num,
	 	    },
	 	    success : function(data) {
	 	    	 /*var tr = $(this).parent().parent();
	 	    	 tr.html(data);*/
	 	    	$("#reviewdetail"+rev_num).html(data);
	 	    	$("#reviewdetail"+rev_num).removeClass('hide').addClass('show');  
	 	    }, // 요청 완료 시
	 	    error :function(xhr,status,error){
						console.log("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);
						alert(xhr.status);
			}
	 	});
	}else if($("#reviewdetail"+rev_num).hasClass('show')) {
		$("#reviewdetail"+rev_num).empty();
		$("#reviewdetail"+rev_num).removeClass('show').addClass('hide');  
	}
}


</script>

</head>
<body>
<%@ include file="../layout/sellerheader.jsp" %>
<%@ include file="../layout/sellerSidebar.jsp" %>
<div class="main">
	<table border="1" id="sellerreviewTable">
		<h1>후기 목록</h1>
		<!-- 화면 출력 번호  변수 정의 -->		
		<c:set var="num" value="${listcount-(page-1)*10}"/> 	
		<tr>
			<th >번호</th>
			<th colspan="2">상품명</th>
			<th>옵션</th>
			<th width="80">작성자</th>
			<th>작성일</th>
			<th>비고</th>
		</tr>
		<c:forEach var="sellerReviewList" items="${sellerReviewList}">
			<tr class="head">
				<td width="50" style="text-align: center;"> <!-- 번호 출력 부분 -->	
					<input type="hidden" id="rev_num" name="rev_num" value="${sellerReviewList.rev_num}">
					<c:out value="${num}"/>			
					<c:set var="num" value="${num-1}"/>	 
				</td>
				<td style="border-right: none;">
					<img src="<%=request.getContextPath() %>/resources/images/thumbnailimage/${sellerReviewList.gds_thumbnail}" height="100" width="100" />
				</td>
				<td style="border-left: none;">
					<a href="showreviewdetail(${sellerReviewList.rev_num})">${sellerReviewList.gds_name}</a>
					<br><br>
					<div style="text-align: right"> <a href="goodsupdate?&gds_num=${sellerReviewList.gds_num}">상품 수정하기</a></div>
				</td>
				<td>
					<c:choose>
						<c:when test="${sellerReviewList.opt_2ndval != null}">
							${sellerReviewList.opt_1stname} : ${sellerReviewList.opt_1stval}	<br>
							${sellerReviewList.opt_2ndname} : ${sellerReviewList.opt_2ndval}
						</c:when>
						<c:when test="${sellerReviewList.opt_1stval != null}">
							${sellerReviewList.opt_1stname} : ${sellerReviewList.opt_1stval}
						</c:when>
						<c:otherwise>
							-
						</c:otherwise>
					</c:choose>
				</td>
				<td style="text-align: center;">
					${sellerReviewList.mem_id}
				</td>
				<td>
					${sellerReviewList.rev_date}
				</td>
				<td>
				<button type="button" onclick="showreviewdetail(${sellerReviewList.rev_num})">후기 상세 보기</button>
				</td>
			</tr>
			<tr>
				<td colspan="7">
					<div id="reviewdetail${sellerReviewList.rev_num}" class="hide"></div>
				</td>
			</tr>

		</c:forEach>
		</table>
		
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