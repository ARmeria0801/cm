<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재확인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
	
function check(){
	if($.trim($("#mem_pass").val()) ==""){
		alert("비밀번호를 확인해주세요.");
		$("#mem_pass").val("").focus();
		return false;
	}
}	
	</script>
</head>

<body>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/mypage.jsp" %>
	<article class="container">
		<div class="page-header">
			<div class="col-md-6 col-md-offset-3">
				<div align=center>
					<h2>비밀번호 재확인</h2>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-md-offset-3">
			<form action="/recheck_ok" method="post" role="form" id="usercheck"
				name="member" onsubmit="return check()">
				<label for="mem_id">아이디</label>
				<div class="form-group">
					<input type="text" class="form-control" id="mem_id" name="mem_id" 
						   value="${prmv.mem_id}" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="mem_pass">비밀번호</label> <input type="password"
						class="form-control" id="mem_pass" name="mem_pass"
						placeholder="PASSWORD">
				</div>
				<div class="form-group text-center">
					<button type="submit" class="btn btn-primary" style="background: #6e58fe; color:white; border: none"
					onClick="passReCheck?mem_id=${prmv.mem_id}">확인</button>
				</div>
			</form>
		</div>
	</article>

<%@ include file="../layout/footer.jsp" %>
</body>
</html>