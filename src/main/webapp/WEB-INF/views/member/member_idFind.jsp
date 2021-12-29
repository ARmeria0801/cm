<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <script>
	function check(){
		if($.trim($("#mem_name").val())==""){
			alert("이름을 확인해주세요.");
			$("#mem_name").val("").focus();
			return false;
		}
		if($.trim($("#mem_phone").val())==""){
			alert("핸드폰번호를 확인해주세요.");
			$("#mem_phone").val("").focus();
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
  <div align="center"><h2>아이디 찾기</h2></div><br>

  
  <form method="post" action="/id_find" onSubmit="return check()">
   <table class="table table-bordered table-hover" align="center" >
    <div class="form-group">
    <label for="mem_name">이름</label>
      <input type="text" class="form-control" id="mem_name" name="mem_name" placeholder="이름을 입력해주세요" maxlength="20">
    </div>
    <div class="form-group">
    <label for="mem_phone">핸드폰번호</label>
      <input type="text" class="form-control" id="mem_phone" name="mem_phone" placeholder="핸드폰번호를 입력해주세요 (' - ' 제외)" maxlength="20">
    </div>
    <div class="form-group">
    <input type="submit" class="btn btn-default form-control" value="확인">
      </div>
   
   <!-- The Modal -->
   <div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">ID찾기</h4>
        <button type="submit" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      <h5>회원님의 아이디는${mem_id}</h5>
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
  </div>
  <div class="col-lg-4"></div>
</div> 
	
<%@ include file="../layout/footer.jsp" %>
</body>
</html>