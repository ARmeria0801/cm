<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 보기</title>
<link rel="stylesheet" href="<c:url value='/resources/css/review/review_cont.css'/>">
<script>
//리뷰 삭제 확인
function del(page, rev_num) {
   var chk = confirm("정말 삭제하시겠습니까?");
   if (chk) {
      location.href='review_delete?page='+page+'&rev_num='+review.rev_num;
   }
}   
</script>
</head>
<body>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/mypage.jsp" %>
	<div id="boardcont_wrap">
		<h2 class="boardcont_title">게시물 내용보기</h2>
		 <input type="hidden" name="rev_num" value="${review.rev_num}" />
  <input type="hidden" name="page" value="${page}" />
		<table border="1" id="boardcont_t">
			<tr>
				<th>글내용</th>
			</tr>
			<tr>
				<td>
<%-- 					<c:if test="${empty rev_filename}">
       				${rcont.rev_content}
       				</c:if>
       				<c:if test="${!empty rev_filename}">
					<img src="<%=request.getContextPath() %>/resources/images/sellerimage/${rev_filename}" height="100" width="100" />
					${rcont.rev_content}
					</c:if> --%>
					${review.rev_content}
					 <%-- <pre>${bcont.board_content}</pre> --%>
					 </td>
			</tr>
		</table>
		<br>
		 <button type="button" onclick="location='review_update?rev_num=${review.rev_num}&page=${page}'">수정</button>
		 <button type="button" onclick="del(${page},${review.rev_num})">삭제</button>
		 <button type="button" onclick="location='review_list?page=${page}'">목록</button>
	</div>
	 <%@ include file="../layout/footer.jsp" %>
</body>
</html>