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
      	<a href="" > 아이디 찾기</a>
    	</div>
      <div class="form-group">
    <input type="submit" class="btn btn-default form-control" value="확인">
      </div>
      <div class="form-group">
    <input type="reset" class="btn btn-default form-control"
onClick="location.href=''" value="취소">
	  </div>
	    <button type="button" class="btn btn-primary form-control" data-toggle="modal" data-target="#myModal">비밀번호 확인</button>
   
   <!-- The Modal -->
   <div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">비밀번호 찾기</h4>
        <button type="submit" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      <h5>회원님 ${pwdok}</h5>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>

 	</table>
  </form>
   <h2 class="pwd_title2">비번찾기 결과</h2>
    <table id="pwd_t2">
     <tr>
      <th>검색한 비번:</th>
      <td>${pwdok}</td>
     </tr>
    </table>
    <div id="pwd_close2">
    <input type="button" value="닫기" class="input_button"
    onclick="self.close();" />
    <!-- close()메서드로 공지창을 닫는다. self.close()는 자바스크립트이다. -->
    </div>
  </div>
  <div class="col-lg-4"></div>
</div> 
	

</body>
</html>