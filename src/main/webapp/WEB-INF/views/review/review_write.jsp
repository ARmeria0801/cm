<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 쓰기</title>
<link rel="stylesheet" href="<c:url value='/resources/css/review/review_write.css'/>">
</head>
<body>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/mypage.jsp" %>
<div id="writeform">
		<h2>후기작성</h2><br>
	<form method="post" action="/review_ok" enctype="multipart/form-data">
	<input type="hidden" id="gds_name" name ="gds_name" value="${gds_name}">
	<input type="hidden" id="ord_gdsnum" name ="ord_gdsnum" value="${ord_gdsnum}">
	<input type="hidden" id="ord_num" name ="ord_num" value="${ord_num}">
		<table border="1" id="customers">
			<tr>
				<th>작성자</th>
				<td>
				${mem_id}
				</td>
			</tr>
			<tr>
				<th>후기</th>
				<td>				
				<textarea name="rev_content" id="rev_content" rows="8" cols="50" class="input_box"></textarea>
				</td>
			</tr>
			<tr>
				<th>후기사진</th>
				<td>	
				<input type="file" class="form-control" id="rev_filename1" name="rev_filename1">
				</td>
			</tr>
		</table>
		<br>
    <button type="submit">등록</button>
    <button type="reset"  onclick="history.go(-1)">취소</button>
	</form>
</div>
<%@ include file="../layout/footer.jsp" %>	
</body>
</html>