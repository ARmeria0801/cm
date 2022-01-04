<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
function updategoodsqnaanswer(gdsqna_num) {
		 $.ajax({
		    url : '/updategoodsqnaanswerform', // 요청 할 주소
		   // async: true, // false 일 경우 동기 요청으로 변경
		    type : 'post', // GET, PUT
		    dataType : 'text',
		    data : {
		    	"gdsqna_num" : gdsqna_num,
		    },
		    success : function(data) {
		    	 /*var tr = $(this).parent().parent();
		    	 tr.html(data);*/
		    	$("#goodsQnaAnswer"+gdsqna_num).html(data);
		    	$("#goodsQnaAnswer"+gdsqna_num).removeClass('hide').addClass('show');  
		    }, // 요청 완료 시
		    error :function(xhr,status,error){
						console.log("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);
						alert(xhr.status);
			}
		});
}
</script>

<!-- 문의글 -->
	<table id="questionTable" border="1" style="margin:0 auto;">
		<caption>문의</caption>
		<tr>
			<th width="100">상품 정보</th>
			<td style="border-right: none;" width="100">
				<img src="<%=request.getContextPath() %>/resources/images/thumbnailimage/${goodsquestion.gds_thumbnail}" height="100" width="100" />
			</td>
			<td style="border-left: none; white-space:nowrap; overflow: hidden;" width="200">
				${goodsquestion.gds_name}
				<br><br>
				<div style="text-align: right"> <a href="goodsupdate?&gds_num=${goodsquestion.gds_num}">상품 수정하기</a></div>
			</td>
			<td>
				<fmt:formatDate value="${goodsquestion.gdsqna_date}" pattern="yyyy-MM-dd HH:mm:ss"/> 
			</td>
		</tr>
		<tr>
			<th width="100">문의 제목</th>
			<td colspan="3">${goodsquestion.gdsqna_title}</td>
		</tr>
		<tr>
			<th width="100">문의 내용</th>
			<td colspan="3">
				<c:if test="${goodsquestion.fname ne null}">
					<img src="<%=request.getContextPath() %>/resources/upload/goodsqna/${goodsquestion.fname}"/> <br><br>
				</c:if>
				<pre style="border: none; background: none;">${goodsquestion.gdsqna_content}</pre>
			</td>
		</tr>
	</table>

	<c:choose>
<%-- 답변이 있을 경우 --%>
		<c:when test="${answer == 1 }">
		<div id="goodsQnaAnswer${goodsanswer.gdsqna_num}" >
			<table border="1" style="margin:0 auto;">
					<caption>답변</caption>
					<tr>
						<th width="100">답변 제목</th>
						<td>${goodsanswer.gdsqna_title}</td>
						<th width="100">답변 등록일</th>
						<td><fmt:formatDate value="${goodsanswer.gdsqna_date}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<th>문의내용</th>
						<td colspan="3"><pre style="border: none; background: none;">${goodsanswer.gdsqna_content}</pre></td>
					</tr>
					<tr>
						<td colspan="4" align="center">
							<input type="button" onclick="updategoodsqnaanswer(${goodsanswer.gdsqna_num})" value="수정">
							<input type="button" onclick="location='deletegoodsqnaanswer?gdsqna_num=${goodsanswer.gdsqna_num}'" value="삭제">
						</td>
					</tr>
				</table>
			</div>
		</c:when>
<%-- 답변이 없을 경우 --%>
		<c:when test="${answer == 0 }">
			<form action="goodsqnaanswer" method="post">
			<input type="hidden" id="gdsqna_num" name="gdsqna_num" value="${goodsquestion.gdsqna_num}">
				<table border="1" style="margin:0 auto;">
					<caption>답변 등록</caption>
					<tr>
						<th width="100">답변 제목</th>
						<td><input type="text" id="gdsqna_title" name="gdsqna_title" size="100"></td>
					</tr>
					<tr>
						<th width="100">문의내용</th>
						<td><textarea id="gdsqna_content" name="gdsqna_content" cols="102" rows="10"></textarea></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="답변 등록">
						</td>
					</tr>
				</table>
			
			</form>
		</c:when>
	</c:choose>
	