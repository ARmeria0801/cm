<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 리스트</title>
<style type="text/css">
#sellerreviewlist{
 	margin-left: 260px; /* Same width as the sidebar + left position in px */
    margin-right: 300px; /* Same width as the sidebar + left position in px */
}
th{
	background:#e9ecef;
	text-align:center;
	align-content: center;
}
caption {
	color: black;
}

.hide{
 display: none;

}


</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
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
function del(page, rev_num) {
	   var chk = confirm("정말 삭제하시겠습니까?");
	   if (chk) {
	      location.href='review_delete?page='+page+'&rev_num='+rev_num;
	   }
	}   
</script>

</head>
<body>
<div id="myreviewlist">
	<table border="1">
		<caption><h2>내 후기 목록</h2></caption>
		<!-- 화면 출력 번호  변수 정의 -->		
		<c:set var="num" value="${listcount-(page-1)*5}"/> 	
		<tr>
			<th style="text-align: center;">번호</th>
			<th style="text-align: center;" colspan="2">상품명</th>
			<th style="text-align: center;">옵션</th>
			<th style="text-align: center;" width="50">작성자</th>
			<th style="text-align: center;">작성일</th>
			<th style="text-align: center;">상세정보</th>
			<th style="text-align: center;">비고</th>
		</tr>
		<c:forEach var="myreviewlist" items="${myreviewlist}">
			<tr class="head">
				<td width="50" style="text-align: center;">
				 <!-- 번호 출력 부분 -->	
					<input type="hidden" id="rev_num" name="rev_num" value="${myreviewlist.rev_num}">
					<c:out value="${num}"/>			
					<c:set var="num" value="${num-1}"/>	 
				</td>
				<td style="border-right: none;">
					<img src="<%=request.getContextPath() %>/resources/images/thumbnailimage/${myreviewlist.gds_thumbnail}" height="100" width="100" />
				</td>
				<td style="border-left: none;">
					${myreviewlist.gds_name}
				</td>
				<td>
					<c:choose>
						<c:when test="${myreviewlist.opt_2ndval != null}">
							${myreviewlist.opt_1stname} : ${myreviewlist.opt_1stval}	<br>
							${myreviewlist.opt_2ndname} : ${myreviewlist.opt_2ndval}
						</c:when>
						<c:when test="${myreviewlist.opt_1stval != null}">
							${myreviewlist.opt_1stname} : ${myreviewlist.opt_1stval}
						</c:when>
						<c:otherwise>
							-
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					${myreviewlist.mem_id}
				</td>
				<td>
					${myreviewlist.rev_date}
				</td>
				<td>
				<input type="button" onclick="showreviewdetail(${myreviewlist.rev_num})" value="상세정보 보기"></td>
				<td>
				<input type="button" value="수정" class="input_button"
				onclick="location='review_update?rev_num=${myreviewlist.rev_num}&page=${page}'" />
				<input type="button" value="삭제" onclick="del(${page},${myreviewlist.rev_num})"/>
				</td>
			</tr>
			<tr>
				<td colspan="7">
					<div id="reviewdetail${myreviewlist.rev_num}" class="hide" style="height:150px"></div>
				</td>
			</tr>
		

		</c:forEach>
		</table>
		
		<div id="revlist_paging">
			<c:if test="${page <=1 }">
				[이전]&nbsp;
			</c:if>

			<c:if test="${page > 1 }">
				<a href="review_list?page=${page-1}">[이전]</a>&nbsp;
			</c:if>

			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a == page }">
					[${a}]
				</c:if>
				<c:if test="${a != page }">
					<a href="review_list?page=${a}">[${a}]</a>&nbsp;
				</c:if>
			</c:forEach>

			<c:if test="${page >= maxpage }">
				[다음] 
			</c:if>
			<c:if test="${page < maxpage }">
				<a href="review_list?page=${page+1}">[다음]</a>
			</c:if>
		</div>
</div>

</body>
</html>