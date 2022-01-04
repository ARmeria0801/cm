<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/seller/sellergoodsqnalist.css'/>">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/sellerjs/sellercalculatelistjs.js"></script>
</head>
<body>
<%@ include file="../layout/sellerheader.jsp" %>
<%@ include file="../layout/sellerSidebar.jsp" %>
<div class="goodsQnaList">
	<table border="1" id="goodsQnaTable" style="table-layout:fixed" width="700">
		<caption>문의 내역</caption>
		<tr>
			<th width="5%">번호</th>
			<th width="20%">상품명</th>
			<th width="25%">문의제목</th>
			<th width="20%">문의날짜</th>
			<th width="20%">상태</th>
			<th width="20%">액션</th>
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
				<td colspan="6" >
					<div id="questiondetail${sellergoodsQnaList.gdsqna_num}" class="hide"> </div>
				</td>
			
			</tr>
		</c:forEach>
	</table>
</div>


</body>
</html>