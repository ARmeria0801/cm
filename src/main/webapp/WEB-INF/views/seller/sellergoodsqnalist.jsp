<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<style type="text/css">
.goodsQnaList {
	margin-left: 300px; /* Same width as the sidebar + left position in px */
	margin-right: 300px; 
	margin-top: 10px; 
	font-size: 14px; /* Increased text to enable scrolling */
	padding: 0px 10px;
}
.goodsQnaList caption{
	color : black;
  	font-size: 25px; /* Increased text to enable scrolling */
}

#goodsQnaTable th{
	text-align : center;
	background: #a0a0a0;
}

#goodsQnaTable td{
	padding-left: 5px;
	padding-right: 5px;
}

tr.notcheck {
	background : #e9ecef;
}
.goodsQnaListName{
	text-overflow:ellipsis; 
	overflow:hidden; 
	white-space:nowrap;
} 

table {width:900px;}  

.hide {display:none;}

.show {display:table-row;}  


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	
	
</script>
</head>
<body>
<%@ include file="../layout/sellerSidebar.jsp" %>
<div class="goodsQnaList">
	<table border="1" id="goodsQnaTable" style="table-layout:fixed" width="800">
		<caption>문의 내역</caption>
		<tr>
			<th width="5%">번호</th>
			<th width="20%">상품명</th>
			<th width="25%">문의제목</th>
			<th width="20%">문의날짜</th>
			<th width="20%">상태</th>
			<th width="10%">액션</th>
		</tr>
		<c:set var="num" value="${listcount-(page-1)*10}"/> 
		<c:forEach var="sellergoodsQnaList" items="${sellergoodsQnaList}">
			<tr <c:if test="${sellergoodsQnaList.gdsqna_check == 0 }"> class="notcheck"</c:if> height=30px>
				<td style="text-align: center;"><!-- 번호 출력 부분 -->
					<input type="hidden" id="gdsqna_num" name="gdsqna_num" value="${sellergoodsQnaList.gdsqna_num}">
					<c:out value="${num}"/>			
					<c:set var="num" value="${num-1}"/>	 
				</td>
				<td class="goodsQnaListName" title="${sellergoodsQnaList.gds_name}"><nobr>${sellergoodsQnaList.gds_name}</nobr></td>
				<td>${sellergoodsQnaList.gdsqna_title}</td>
				<td>
					<fmt:formatDate value="${sellergoodsQnaList.gdsqna_date}" pattern="yyyy-MM-dd HH:mm:ss"/> 
				</td>
				<td style="text-align: center;">
					<c:choose>
						<c:when test="${sellergoodsQnaList.gdsqna_answer == 0}">
							미답변
						</c:when>
						<c:when test="${sellergoodsQnaList.gdsqna_answer == 1}">
							답변완료
						</c:when>
					</c:choose>
				</td>
				<td style="text-align: center;">
					<script type="text/javascript">
						function showquestiondetail(gdsqna_num) {
							if($("#questiondetail"+gdsqna_num).hasClass('hide')) {
								 $.ajax({
								    url : '/showgoodsQnadetail', // 요청 할 주소
								    type : 'post', // GET, PUT
								    dataType : 'text',
								    data : {
								    	"gdsqna_num" : gdsqna_num,
								    },
								    success : function(data) {
								    	 /*var tr = $(this).parent().parent();
								    	 tr.html(data);*/
								    	$("#questiondetail"+gdsqna_num).html(data);
								    	$("#questiondetail"+gdsqna_num).removeClass('hide').addClass('show');  
								    }, // 요청 완료 시
								    error :function(xhr,status,error){
												console.log("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);
												alert(xhr.status);
									}
								});
							}else if($("#questiondetail"+gdsqna_num).hasClass('show')) {
								$("#questiondetail"+gdsqna_num).empty();
								$("#questiondetail"+gdsqna_num).removeClass('show').addClass('hide');  
								
						}
					}
					</script>
					<button id="detailbtn" type="button" onclick="showquestiondetail(${sellergoodsQnaList.gdsqna_num})">상세보기</button>
				</td>
			</tr>
			<tr>
				<td colspan="6">
					<div id="questiondetail${sellergoodsQnaList.gdsqna_num}" class="hide"></div>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>


</body>
</html>