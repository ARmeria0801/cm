<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <script>
	function check(){
		if($.trim($("#mem_id").val())==""){
			alert("아이디를 확인해주세요.");
			$("#mem_id").val("").focus();
			return false;
		}
		if($.trim($("#mem_email").val())==""){
			alert("이메일을 확인해주세요.");
			$("#mem_email").val("").focus();
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
  <div align="center"><h2>비밀번호 찾기</h2></div><br>

  
  <form method="post" action="/pass_find" onsubmit="return check()">
   <table class="table table-bordered table-hover" align="center" >
    <div class="form-group">
    <label for="mem_id">아이디</label>
      <input type="text" class="form-control" id="mem_id" name="mem_id" placeholder="아이디를 입력해주세요" maxlength="20">
    </div>
    <div class="form-group">
    <label for="mem_email">이메일</label>
      <input type="email" class="form-control" id="mem_email" name="mem_email" placeholder="이메일을 입력해주세요" maxlength="20">
    </div>
    <div class="form-group" style="text-align:right">
      	<a href="member_idFind" > 아이디 찾기</a>
    	</div>
      <div class="form-group">
    <input type="submit" class="btn btn-default form-control" value="확인">
      </div>
      <div class="form-group">
    <input type="reset" class="btn btn-default form-control"
onClick="location.href=''" value="취소">
	  </div>

 	</table>
  </form>
    <table id="pwd_t2">
     <tr>
      <th>${pwdok}</th>
      <td></td>
     </tr>
    </table>
  </div>
  <div class="col-lg-4"></div>
</div> 
	
<%@ include file="../layout/footer.jsp" %>
</body>
</html>