<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>로그인 폼</title>
<script>
	function check(){
		if($.trim($("#mem_id").val())==""){
			alert("아이디를 입력해주세요.");
			$("#mem_id").val("").focus();
			return false;
		}
		if($.trim($("#mem_pass").val())==""){
			alert("비밀번호를 입력해주세요.");
			$("#mem_pass").val("").focus();
			return false;
		}
	}
</script>


</head>

<body>
<%@ include file="../layout/header.jsp" %>
<div class="container">
<div class="col-lg-4"></div>
<div class="col-lg-4">
  <div align="center"><h2>로그인</h2></div>
  <form method="post" action="/login_ok" onsubmit="return check()">
   <table class="table table-bordered table-hover" align="center" >
    <div class="form-group">
      <input type="text" class="form-control" id="mem_id" name="mem_id" placeholder="아이디" maxlength="20">
    </div>
    <div class="form-group">
      <input type="password" class="form-control" id="mem_pass" name="mem_pass" placeholder="비밀번호" maxlength="20">
    </div>
    	<div class="form-group">
      	<a href="member_idFind" > 아이디 찾기</a> | <a href="member_passFind">비밀번호 찾기</a>
    	</div>
      <div class="form-group">
    <input type="submit" class="btn btn-default form-control" style="background: #6e58fe; color:white; border: none" value="로그인">
      </div>
      <div class="form-group">
    <input type="button" class="btn btn-default form-control"
onClick="location.href='<%=request.getContextPath() %>/member_join'" style="background: #6e58fe; color:white; border: none" value="회원가입">
	  </div>

 	</table>
  </form>
  </div>
  <div class="col-lg-4"></div>
</div> 
	
<%@ include file="../layout/footer.jsp" %>
</body>
</html>