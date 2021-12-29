<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form action="<%=request.getContextPath()%>/updategoodsqnaanswer" method="post">
	<input type="hidden" id="gdsqna_num" name="gdsqna_num" value="${answer.gdsqna_num}">
	<table border="1" id="goodsQnaAnswer${answer.gdsqna_num}">
		<caption>답변 수정</caption>
		<tr>
			<th width="100">답변 제목</th>
			<td><input type="text" id="gdsqna_title" name="gdsqna_title" size="100" value="${answer.gdsqna_title }"></td>
		</tr>
		<tr>
			<th width="100">답변 내용</th>
			<td><textarea id="gdsqna_content" name="gdsqna_content" cols="102" rows="10">${answer.gdsqna_content }</textarea></td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input type="submit" value="수정">
			</td>
		</tr>
	</table>
</form>