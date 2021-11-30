<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
	
	
	$(document).ready(function() {
		//주소 뭐꼬
		var address = $('#deladd_add1');
		//모든 공백 체크 정규식
		var empJ = /\s/g;
		//아이디 정규식
		var idJ = /^[a-z0-9][a-z0-9_\-]{4,12}$/;
		// 비밀번호 정규식
		var pwJ = /^[A-Za-z0-9]{4,12}$/;
		// 이름 정규식
		var nameJ = /^[가-힣]{2,6}$/;
		// 이메일 검사 정규식
		var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		// 휴대폰 번호 정규식
		var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;


		
	//아이디 중복확인
	$("#mem_id").blur(function() {
		if($('#mem_id').val()==''){ 
		$('#id_check').text('아이디를 입력하세요.');
		$('#id_check').css('color', 'red');
		
		} else if(idJ.test($('#mem_id').val())!=true){
		$('#id_check').text('4~12자의 영문, 숫자만 사용 가능합니다.');
		$('#id_check').css('color', 'red');
		}else if($('#mem_id').val()!=''){
			
		var mem_id=$('#mem_id').val();
		 $.ajax({
			async : true,
			type : 'POST',
			data : mem_id,//mem_id라는 이름으로 mem_id라는 데이터를 @WebServlet("/idsearch.do")에 보내겠다
			url : 'member/member_idCheck',
/* 			dateType: 'json',
			contentType: "application/json; charset=UTF-8", */
			success : function(data){ 
			
		if(result == 1 ){ 
		  $('#id_check').text('중복된 아이디 입니다.');
		  	$('#id_check').css('color', 'red');
		  	$("#usercheck").attr("disabled", true);
		}else{
			if(idJ.test(mem_id)){
			$('#id_check').text('사용가능한 아이디 입니다.');
			$('#id_check').css('color', 'blue');
			$("#usercheck").attr("disabled", false);
		 }
		 else if(mem_id==''){
			$('#id_check').text('아이디를 입력해주세요.');
				$('#id_check').css('color', 'red');
				$("#usercheck").attr("disabled", true);
			}
		 else{
			$('#id_check').text("아이디는 소문자와 숫자 4~12자리만 가능합니다.");
			$('#id_check').css('color', 'red');
			$("#usercheck").attr("disabled", true);
			} 
		}
	},
		  }); //ajax///
		}//else if
	
});//blur
	
	var inval_Arr = new Array(6).fill(false)
		//id 정규식
	$('form').on('submit',function(){
		if (idJ.test($('#mem_id').val())) {
			inval_Arr[0] = true;
		} else {
			inval_Arr[0] = false;
			alert('아이디를 확인하세요.');
			$("#mem_id").focus();			
			return false;
		}
		// 비밀번호가 같은 경우 && 비밀번호 정규식
		if (($('#mem_pass').val() == ($('#mem_pass2').val()))
				&& pwJ.test($('#mem_pass').val())) {
			inval_Arr[1] = true;
		} else {
			inval_Arr[1] = false;
			alert('비밀번호를 확인하세요.');
			$("#mem_pass").focus();
			return false;
		}
		// 이름 정규식
		if (nameJ.test($('#mem_name').val())) {
			inval_Arr[2] = true;
		} else {
			inval_Arr[2] = false;
			alert('이름을 확인하세요.');
			$("#mem_name").focus();
			return false;
		} 
		// 이메일 정규식
		if (mailJ.test($('#mem_email').val())){
			console.log(mailJ.test($('#mem_email').val()));
			inval_Arr[3] = true;
		} else { inval_Arr[3] = false;
		alert('이메일을 확인하세요.');
		$("#mem_email").focus();
		return false;
		}
		// 휴대폰번호 정규
		if (phoneJ.test($('#mem_phone').val())) {
			console.log(phoneJ.test($('#mem_phone').val()));
			inval_Arr[4] = true;
		} else {
			inval_Arr[4] = false;
			alert('휴대폰 번호를 확인하세요.');
			$("#mem_phone").focus();
			return false;
		}
		//주소확인
		if(address.val() == ''){
			inval_Arr[5] = false;
			alert('[우편번호 찾기버튼]을 눌러 주소를 확인하세요.');
			$("#deladd_add1").focus();
			return false;
		}else inval_Arr[5] = true;
		
		//전체 유효성 검사
		var validAll = true;
		for(var i = 0; i < inval_Arr.length; i++){
			if(inval_Arr[i] == false){
			   validAll = false;
			   }
			}
		if(validAll == true){ // 유효성 모두 통과
			alert('정보수정이 완료되었습니다.');
		} else{
			alert('정보를 다시 확인하세요.')
			}
		});
	
	$('#mem_id').blur(function() {
		if (idJ.test($('#mem_id').val())) { 
			console.log('true');
			$('#id_check').text('');
		} else { console.log('false');
		$('#id_check').text('4~12자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.');
		$('#id_check').css('color', 'red');
		}
	});
	
	$('#mem_pass').blur(function() {
		if (pwJ.test($('#mem_pass').val())) {
			console.log('true');
			$('#pw_check').text('');
		} else {
			console.log('false');
			$('#pw_check').text('4~12자의 숫자 , 문자로만 사용 가능합니다.');
			$('#pw_check').css('color', 'red');
			}
		});
	//1~2 패스워드 일치 확인
	$('#mem_pass2').blur(function() {
		if ($('#mem_pass').val() != $(this).val()) {
			$('#pw2_check').text('비밀번호가 일치하지 않습니다.');
			$('#pw2_check').css('color', 'red');
		} else {
			$('#pw2_check').text('');
		}
	});
	//이름에 특수문자 들어가지 않도록 설정
	$("#mem_name").blur(function() {
		if (nameJ.test($(this).val())) {
			console.log(nameJ.test($(this).val()));
			$("#name_check").text('');
		} else {
			$('#name_check').text('한글 2~6자 이내로 입력하세요. (특수기호, 공백 사용 불가)');
			$('#name_check').css('color', 'red');
		}
	});
	$("#mem_email").blur(function() {
		if (mailJ.test($(this).val())) {
			$("#email_check").text('');
		} else {
			$('#email_check').text('이메일 양식을 확인해주세요.  (Ex.cmarket@naver.com)');
			$('#email_check').css('color', 'red');
		}
	});
	$("#mem_phone").blur(function(){
		if (phoneJ.test($(this).val())) {
			console.log(phoneJ.test($(this).val()));
			$("#phone_check").text('');
		}else {
			$("#phone_check").text('핸드폰번호를 제대로 입력해주세요. ');
			$('#phone_check').css('color', 'red');
		}
	});
});

	</script>
</head>

<body>

	<article class="container">
		<div class="page-header">
			<div class="col-md-6 col-md-offset-3">
				<div align=center>
					<h2>회원정보 수정</h2>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-md-offset-3">
			<form action="/update_ok" method="post" role="form" id="usercheck"
				name="member">
				<label for="mem_id">아이디</label>
				<div class="form-group">
					<input type="text" class="form-control" id="mem_id" name="mem_id" 
						   value="${upmv.mem_id}" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="mem_pass">비밀번호</label> <input type="password"
						class="form-control" id="mem_pass" name="mem_pass"
						placeholder="PASSWORD">
					<div class="check_font" id="pw_check"></div>
				</div>
				<div class="form-group">
					<label for="mem_pass2">비밀번호 확인</label> <input type="password"
						class="form-control" id="mem_pass2" name="mem_pass2"
						placeholder="Confirm Password">
					<div class="check_font" id="pw2_check"></div>
				</div>
				<div class="form-group">
					<label for="mem_name">이름</label>
					<input type="text" class="form-control" id="mem_name" name="mem_name"
						placeholder="Name" value="${upmv.mem_name}">
					<div class="check_font" id="name_check"></div>
				</div>
				<div class="form-group">
					<label for="mem_email">이메일 주소</label> <input
						type="email" class="form-control" id="mem_email" name="mem_email"
						placeholder="E-mail" value="${upmv.mem_email}">
					<div class="check_font" id="email_check"></div>
				</div>
				<div class="form-group">
					<label for="mem_phone">휴대폰 번호('-'없이 번호만 입력해주세요)</label> <input
						type="tel" class="form-control" id="mem_phone" name="mem_phone"
						placeholder="Phone Number" value="${upmv.mem_phone}">
					<div class="check_font" id="phone_check"></div>
				</div>
				<div class="form-group text-center">
					<button type="submit" class="btn btn-primary">정보수정</button>
				</div>
			</form>
		</div>
	</article>


</body>
</html>