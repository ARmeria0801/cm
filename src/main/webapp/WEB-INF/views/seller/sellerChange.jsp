<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 전환 페이지</title>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- 다음 우편주소api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	//우편번호, 주소 Daum API
	function openDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
				document.getElementById('sel_post').value = data.zonecode;
				document.getElementById('sel_add').value = data.address;
			}
		}).open();
	}
</script>
<script>
//유효성 검사 자리
	function check(){
		if($.trim($("#sel_bnum").val())==""){
			alert("사업자 등록번호를 입력해주세요.");
			$("#sel_bnum").val("").focus();
			return false;
		}
		if($.trim($("#sel_name").val())==""){
			alert("상호명을 입력해주세요.");
			$("#sel_name").val("").focus();
			return false;
		}
		if($.trim($("#sel_ceo").val())==""){
			alert("대표자명을 입력해주세요.");
			$("#sel_ceo").val("").focus();
			return false;
		}
		if($.trim($("#sel_mobnum").val()) == ""){
			alert("통신판매업번호를 입력해주세요.");
			$("#sel_mobnum").val("").focus();
			return false;
		}
		if($.trim($("#sel_post").val())==""){
			alert("[우편번호 찾기]버튼을 눌러 우편번호를 입력해주세요.");
			$("#sel_post").val("").focus();
			return false;
		}
		if($.trim($("#sel_add").val())==""){
			alert("사업장 주소를 상세히 입력해주세요.");
			$("#sel_add").val("").focus();
			return false;
		}
		if($.trim($("#sel_tel").val())==""){
			alert("사업장 번호를 입력해주세요.");
			$("#sel_tel").val("").focus();
			return false;
		}
		if($.trim($("#sel_bank").val())==""){
			alert("정산받을 은행명을 입력해주세요.");
			$("#sel_bank").val("").focus();
			return false;
		}
		if($.trim($("#sel_accholder").val())==""){
			alert("정산받을 계좌 예금주를 입력해주세요.");
			$("#sel_accholder").val("").focus();
			return false;
		}
		if($.trim($("#sel_acc").val())==""){
			alert("정산받을 계좌번호를 입력해주세요.");
			$("#sel_acc").val("").focus();
			return false;
		}
		if($.trim($("#seling_filename1").val())==""){
			alert("사업자등록증을 파일로 넣어주세요.");
			$("#seling_filename1").val("").focus();
			return false;
		}
	}
</script>
</head>

<body>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/mypage.jsp" %>
<div class="container">
<div class="col-lg-4"></div>
<div class="col-lg-4">
  <div align="center"><h2>사업자판매자 가입</h2></div><br>
  <form method="post" action="/sellerchange_ok" onsubmit="return check()" enctype="multipart/form-data">
   <table class="table table-bordered table-hover" align="center" >
    <div class="form-group">
      <label for="sel_bnum">사업자 등록번호</label>
      <input type="text" class="form-control" id="sel_bnum" name="sel_bnum" placeholder="사업자 등록번호(' - '없이 번호만 입력해주세요)" maxlength="20">
    </div>
    <div class="form-group">
    <label for="sel_name">상호명</label>
      <input type="text" class="form-control" id="sel_name" name="sel_name" placeholder="상호명" maxlength="20">
    </div>
    <div class="form-group">
    <label for="sel_ceo">대표자</label>
      <input type="text" class="form-control" id="sel_ceo" name="sel_ceo" placeholder="대표자이름" maxlength="20">
    </div>
    <div class="form-group">
    <label for="sel_mobnum">통신판매업번호</label>
      <input type="text" class="form-control" id="sel_mobnum" name="sel_mobnum" placeholder="통신판매업번호(' - '없이 입력해주세요)" >
    </div>
    
    <label for="sel_tel">사업장 주소</label>
    <div class="form-group">
	  <input class="form-control" style="width: 40%; display: inline;" placeholder="우편번호"
	  			 name="sel_post" id="sel_post" type="text">
	  			 
		<button type="button" class="btn btn-default" onclick="openDaumPostcode()">
				<i class="fa fa-search"></i> 우편번호 찾기
		</button>
	</div>
	<div class="form-group">
	  <input class="form-control" placeholder="사업장 상세주소" name="sel_add" id="sel_add" type="text"/>
	</div>
    
    <div class="form-group">
    <label for="sel_tel">사업장 연락처</label>
      <input type="text" class="form-control" id="sel_tel" name="sel_tel" placeholder="사업장 연락처(' - '없이 번호만 입력해주세요)" maxlength="20">
    </div>
    
    <div class="form-group" >
    <label for="sel_bank">은행</label>
      <input type="text" class="form-control" style="width: 30%; display:inline;" id="sel_bank" name="sel_bank" placeholder="은행명" maxlength="20">
      <label for="sel_acchloder">예금주</label>
      <input type="text" class="form-control" style="width: 40%; display:inline;" id="sel_accholder" name="sel_accholder" placeholder="정산계좌 예금주" maxlength="20">
    </div>
   <!--  <div class="form-group" style="float: right;">
    <label for="sel_acchloder">예금주</label>
      <input type="text" class="form-control" style="width: 40%; display: inline;" id="sel_accholder" name="sel_accholder" placeholder="정산계좌 예금주" maxlength="20">
    </div> -->
    <div class="form-group">
    <label for="sel_acc">계좌번호</label>
      <input type="text" class="form-control" id="sel_acc" name="sel_acc" placeholder="계좌번호(' - '없이 번호만 입력해주세요)" maxlength="20">
    </div>
    
    <div class="form-group">
    <label for="seling_filename1">파일첨부 [사업자 등록증]</label>
      <input type="file" class="form-control" id="seling_filename1" name="seling_filename1">
    </div>
    
      <div class="form-group">
    <input type="submit" class="btn btn-default form-control" style="background: #6e58fe; color:white; border: none" value="신청하기">
      </div>


 	</table>
  </form>
  </div>
  <div class="col-lg-4"></div>
</div> 
<%@ include file="../layout/footer.jsp" %>
</body>
</html>