<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- 다음 우편주소api -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	//우편번호, 주소 Daum API
	function openDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
				document.getElementById('deladd_post').value = data.zonecode;
				document.getElementById('deladd_add1').value = data.address;
			}
		}).open();
	}
</script>
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
		var mem_id=$('#mem_id').val();

		if($('#mem_id').val()==''){ 
		$('#id_check').text('아이디를 입력하세요.');
		$('#id_check').css('color', 'red');
		
		}
		else if(idJ.test($('#mem_id').val())!=true){
		$('#id_check').text('4~12자의 영문, 숫자만 사용 가능합니다.');
		$('#id_check').css('color', 'red');
		}
		else if($('#mem_id').val() != '' ){ 
			
		 $.ajax({
			async : true,
			type : 'POST',
			data : {
				"mem_id" : mem_id,//mem_id라는 이름으로 mem_id라는 데이터를 @WebServlet("/idsearch.do")에 보내겠다
			},
			url : '/idCheck',
/* 			dateType: 'json',
			contentType: "application/json; charset=UTF-8", */
			success : function(data){ 
				if(data == 1 ){ 
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
			error:function(e){
				console.log("실패");
			}
	
		  }); //ajax///
		}//else if
	});//blur

	var inval_Arr = new Array(7).fill(false)
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
		}else {
			inval_Arr[5] = true;
		}
		//이용약관 동의 모두체크
		if (!$("input:checked[id='agreeAll']").is(":checked")){
			inval_Arr[6] = false;
			alert("모든 약관에 동의 해주세요.");
			$("#agreeAll").focus();
			return false;
		}else{
			inval_Arr[6] = true;
		}
		
		//전체 유효성 검사
		var validAll = true;
		for(var i = 0; i < inval_Arr.length; i++){
			if(inval_Arr[i] == false){
			   validAll = false;
			   }
			}
		if(validAll == true){ // 유효성 모두 통과
			alert('Cmarket 가족이 되어주셔 감사합니다.');
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
	//이메일 양식 확인
	$("#mem_email").blur(function() {
		if (mailJ.test($(this).val())) {
			$("#email_check").text('');
		} else {
			$('#email_check').text('이메일 양식을 확인해주세요.');
			$('#email_check').css('color', 'red');
		}
	});//핸드폰번호 입력
	$("#mem_phone").blur(function(){
		if (phoneJ.test($(this).val())) {
			console.log(phoneJ.test($(this).val()));
			$("#phone_check").text('');
		}else {
			$("#phone_check").text('핸드폰번호를 제대로 입력해주세요. ');
			$('#phone_check').css('color', 'red');
		}
	});
	
	//이용약관 동의
	$("#agreeAll").click(function() {
		if($("#agreeAll").is(":checked")) $("input[name=agree]").prop("checked", true);
		else $("input[name=agree]").prop("checked", false);
		
	});
		

	$("input[name=agree]").click(function() {
		var total = $("input[name=agree]").length;
		var checked = $("input[name=agree]:checked").length;

		if(total != checked) $("#agreeAll").prop("checked", false);
		else $("#agreeAll").prop("checked", true); 
	});
	
});
	</script>
</head>

<body>
<%@ include file="../layout/header.jsp" %>
	<article class="container">
		<div class="page-header">
			<div class="col-md-6 col-md-offset-3">
				<div align=center>
					<h2>회원가입</h2>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-md-offset-3">
			<form action="/join_ok" method="post" role="form" id="usercheck"
				name="member">
				<label for="mem_id">아이디</label>
				<div class="form-group">
					<input type="text" class="form-control" id="mem_id" name="mem_id" placeholder="ID">
					<div class="check_font" id="id_check"></div>
				</div>
				<div class="form-group">
					<label for="mem_pass">비밀번호&nbsp; </label> <input type="password" 
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
					<label for="mem_name">이름</label> <input type="text"
						class="form-control" id="mem_name" name="mem_name"
						placeholder="Name">
					<div class="check_font" id="name_check"></div>
				</div>
				<div class="form-group">
					<label for="mem_email">이메일 주소</label> <input
						type="email" class="form-control" id="mem_email" name="mem_email"
						placeholder="E-mail (Ex.cmarket@naver.com)">
					<div class="check_font" id="email_check"></div>
				</div>
				<div class="form-group">
					<label for="mem_phone">휴대폰 번호</label> <input
						type="tel" class="form-control" id="mem_phone" name="mem_phone"
						placeholder="Phone Number ('-'없이 번호만 입력해주세요)">
					<div class="check_font" id="phone_check"></div>
				</div>

				<div class="form-group">
					<input class="form-control" style="width: 40%; display: inline;"
						placeholder="우편번호" name="deladd_post" id="deladd_post" type="text">
					<button type="button" class="btn btn-default"
						onclick="openDaumPostcode()">
						<i class="fa fa-search"></i> 우편번호 찾기
					</button>
				</div>
				<div class="form-group">
					<input class="form-control" style="top: 5px;" placeholder="도로명 주소"
						name="deladd_add1" id="deladd_add1" type="text" />
				</div>
				<div class="form-group">
					<input class="form-control" placeholder="상세주소" name="deladd_add2"
						id="deladd_add2" type="text" />
				</div>
				
				<label>이용약관 동의</label><br>
				 <input type="checkbox" name="agreeAll" value="agreeAll" id="agreeAll">
				  <span>모두 동의합니다</span><br>
				 <input type="checkbox" name="agree">
				  <span>이용약관 동의&nbsp;<strong>(필수)</strong></span>
				  <button type="button" class="btn btn-link" style="text-align :right; text-decoration :none; color:black;"
				   data-toggle="modal" data-target="#myModal1">약관보기 ></button><br>
				 <input type="checkbox" name="agree">
				  <span>개인정보 수집 및 이용 동의&nbsp;<strong>(필수)</strong></span>
				 <button type="button" class="btn btn-link" style="text-align :right; text-decoration :none; color:black;"
				   data-toggle="modal" data-target="#myModal2">약관보기 ></button><br>
				 <input type="checkbox" name="agree">
				  <span>만 14세 이상입니다.&nbsp;<strong>(필수)</strong></span><br><br>
				
					<div class="form-group text-center">
					<button type="submit" class="btn btn-primary form-control" style="background: #6e58fe; color:white; border: none">회원가입</button>
				</div>
				
<!--------------------------------------약관 모달 창 개길어------------------------------------------------------------------------------------------>
				<!-- 이용약관 동의 -->
  <div class="modal fade" id="myModal1" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">이용약관 동의(필수)</h4>
        </div>
        <div class="modal-body">
          <p>제 1 장 총칙</p>
			<p>제 1 조 (목적)
<p>본 약관은 Cmarket이 운영하는 웹 사이트 (http://Cmarket.com)의 제반 서비스의 이용조건 및 절차에 관한 사항 및 기타 필요한 사항을 규정함을 목적으로 한다.</p>

<p>제 2 조 (용어의 정의)
<p>본 약관에서 사용하는 용어는 다음과 같이 정의한다.
<p>①회원 : 기본 회원 정보를 입력하였고, 회사와 서비스 이용계약을 체결하여 아이디를 부여받은 개인
<p>②아이디(ID) : 회원식별과 회원의 서비스 이용을 위해 회원이 선정하고 회사가 승인하는 문자와 숫자의 조합
<p>③비밀번호(Password) : 회원이 통신상의 자신의 비밀을 보호하기 위해 선정한 문자와 숫자의 조합
<p>④해지 : 회사 또는 회원에 의한 이용계약의 종료</p>

<p>제 3 조 (약관의 공시 및 효력과 변경)
<p>①본 약관은 회원가입 화면에 게시하여 공시하며 회사는 사정변경 및 영업상 중요한 사유가 있을 경우 약관을 변경할 수 있으며 변경된 약관은 공지사항을 통해 공시한다
<p>②본 약관 및 차후 회사사정에 따라 변경된 약관은 이용자에게 공시함으로써 효력을 발생한다.

<p>제 4 조 (약관 외 준칙)
<p>본 약관에 명시되지 않은 사항이 전기통신기본법, 전기통신사업법, 정보통신촉진법, ‘전자상거래등에서의 소비자 보호에 관한 법률’, ‘약관의 규제에관한법률’, ‘전자거래기본법’, ‘전자서명법’, ‘정보통신망 이용촉진등에 관한 법률’, ‘소비자보호법’ 등 기타 관계 법령에 규정되어 있을 경우에는 그 규정을 따르도록 한다.


<p>제 2 장 이용계약

<p>제 5 조 (이용신청)
<p>①이용신청자가 회원가입 안내에서 본 약관과 개인정보보호정책에 동의하고 등록절차(회사의 소정 양식의 가입 신청서 작성)를 거쳐 '확인' 버튼을 누르면 이용신청을 할 수 있다.
<p>②이용신청자는 반드시 실명과 실제 정보를 사용해야 하며 1개의 생년월일에 대하여 1건의 이용신청을 할 수 있다.
<p>③실명이나 실제 정보를 입력하지 않은 이용자는 법적인 보호를 받을 수 없으며, 서비스 이용에 제한을 받을 수 있다.

<p>제 6 조 (이용신청의 승낙)
①회사는 제5조에 따른 이용신청자에 대하여 제2항 및 제3항의 경우를 예외로 하여 서비스 이용을 승낙한다.
②회사는 아래 사항에 해당하는 경우에 그 제한사유가 해소될 때까지 승낙을 유보할 수 있다.
  가. 서비스 관련 설비에 여유가 없는 경우
  나. 기술상 지장이 있는 경우
  다. 기타 회사 사정상 필요하다고 인정되는 경우
③회사는 아래 사항에 해당하는 경우에 승낙을 하지 않을 수 있다.
  가. 다른 사람의 명의를 사용하여 신청한 경우
  나. 이용자 정보를 허위로 기재하여 신청한 경우
  다. 사회의 안녕질서 또는 미풍양속을 저해할 목적으로 신청한 경우
  라. 기타 회사가 정한 이용신청 요건이 미비한 경우


<p>제 3 장 계약 당사자의 의무

<p>제 7 조 (회사의 의무)
<p>①회사는 사이트를 안정적이고 지속적으로 운영할 의무가 있다.
<p>②회사는 이용자로부터 제기되는 의견이나 불만이 정당하다고 인정될 경우에는 즉시 처리해야 한다. 단, 즉시 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 공지사항 또는 전자우편을 통해 통보해야 한다.
<p>③제1항의 경우 수사상의 목적으로 관계기관 및 정보통신윤리위원회의 요청이 있거나 영장 제시가 있는 경우, 기타 관계 법령에 의한 경우는 예외로 한다.

<p>제 8 조 (이용자의 의무)
<p>①이용자는 본 약관 및 회사의 공지사항, 사이트 이용안내 등을 숙지하고 준수해야 하며 기타 회사의 업무에 방해되는 행위를 해서는 안된다.
<p>②이용자는 회사의 사전 승인 없이 본 사이트를 이용해 어떠한 영리행위도 할 수 없다.
<p>③이용자는 본 사이트를 통해 얻는 정보를 회사의 사전 승낙 없이 복사, 복제, 변경, 번역, 출판, 방송 및 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없다.

<p>제 4 장 서비스의 제공 및 이용

<p>제 9 조 (서비스 이용)
<p>①이용자는 본 약관의 규정된 사항을 준수해 사이트를 이용한다.
<p>②본 약관에 명시되지 않은 서비스 이용에 관한 사항은 회사가 정해 '공지사항'에 게시하거나 또는 별도로 공지하는 내용에 따른다.

<p>제 10 조 (정보의 제공)
<p>회사는 회원이 서비스 이용 중 필요하다고 인정되는 다양한 정보에 대하여 전자메일이나 서신우편 등의 방법으로 회원에게 정보를 제공할 수 있다.

<p>제 11 조 (광고게재)
<p>①회사는 서비스의 운용과 관련하여 서비스 화면, 홈페이지, 전자우편 등에 광고 등을 게재할 수 있다.
<p>②회사는 사이트에 게재되어 있는 광고주의 판촉활동에 회원이 참여하거나 교신 또는 거래의 결과로서 발생하는 모든 손실 또는 손해에 대해 책임을 지지 않는다.

<p>제 12 조 (서비스 이용의 제한)
<p>본 사이트 이용 및 행위가 다음 각 항에 해당하는 경우 회사는 해당 이용자의 이용을 제한할 수 있다.
<p>①공공질서 및 미풍양속, 기타 사회질서를 해하는 경우
<p>②범죄행위를 목적으로 하거나 기타 범죄행위와 관련된다고 객관적으로 인정되는 경우
<p>③타인의 명예를 손상시키거나 타인의 서비스 이용을 현저히 저해하는 경우
<p>④타인의 의사에 반하는 내용이나 광고성 정보 등을 지속적으로 전송하는 경우
<p>⑤해킹 및 컴퓨터 바이러스 유포 등으로 서비스의 건전한 운영을 저해하는 경우
<p>⑥다른 이용자 또는 제3자의 지적재산권을 침해하거나 지적재산권자가 지적 재산권의 침해를 주장할 수 있다고 판단되는 경우
<p>⑦타인의 아이디 및 비밀번호를 도용한 경우
<p>⑧기타 관계 법령에 위배되는 경우 및 회사가 이용자로서 부적당하다고 판단한 경우

<p>제 13 조 (서비스 제공의 중지)
<p>회사는 다음 각 호에 해당하는 경우 서비스의 전부 또는 일부의 제공을 중지할 수 있다.
<p>①전기통신사업법 상에 규정된 기간통신 사업자 또는 인터넷 망 사업자가 서비스를 중지했을 경우
<p>②정전으로 서비스 제공이 불가능할 경우
<p>③설비의 이전, 보수 또는 공사로 인해 부득이한 경우
<p>④서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 어려운 경우
<p>⑤전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우
<p>제 14 조 (게시물 관리)
<p>회사는 건전한 통신문화 정착과 효율적인 사이트 운영을 위하여 이용자가 게시하거나 제공하는 자료가 제12조에 해당한다고 판단되는 경우에 임의로 삭제, 자료이동, 등록거부를 할 수 있다.
<p>제 15 조 (서비스 이용 책임)
<p>이용자는 회사에서 권한 있는 사원이 서명한 명시적인 서면에 구체적으로 허용한 경우를 제외하고는 서비스를 이용하여 불법상품을 판매하는 영업활동을 할 수 없으며 특히 해킹, 돈벌기 광고, 음란 사이트를 통한 상업행위, 상용 S/W 불법제공 등을 할 수 없다. 이를 어기고 발생한 영업활동의 결과 및 손실, 관계기관에 의한 구속 등 법적 조치 등에 관해서는 회사가 책임을 지지 않는다.
<p>제 5 장 (재화의 주문 및 결제 관련) 
<p>제16조 (결제방법)
‘회원’은 ‘회사’에서 판매하는 재화에 대하여 ‘선불카드, 직불카드, 신용카드 등의 각종 카드 결제 수단’을 이용하여 결제할 수 있다. 이때 ‘회사’는 이용자의 지급방법에 대하여 재화외 어떠한 명목의 수수료를 추가 징수하지 않는다.
<p>① ‘회사’는 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 한다. 주문확인에 대한 내용은 해당게시판에서 확인 할 수 있다.
<p>② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 ‘회사’는 배송전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리한다. 다만 이미 대금을 지불한 경우에는 제18조의 ‘반품규정’을 따른다.
<p>제17조 (배송정책)
<p>① ‘회사’는 이용자와 재화의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 결재를 실시한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취한다. 
<p>②‘회사’는 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 제품을 구매하는 웹 페이지 하단에 명시한다. 만약 ‘회사’가 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상한다. 하지만 ‘회사’의 고의과실이 없음을 입증한 경우에는 그러하지 아니한다.
<p>18조 (취소 및 반품 환불 규정)
<p>‘회사’는 이용자가 구매 신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 한다.
<p>① 재화가 발송 되기전 이용자가 결제를 취소할 경우 ‘회사’는 해당 주문건을 취소 처리하고 카드결제 승인을 취소한다.
<p>② 재화가 발송 된 이후 결제 취소는 불가하다. 단, ‘회사’의 부주의 ‘배송’상의 문제로 인한 재화의 파손, 변질의 경우 ‘회사’는 이용자에게 구매 금액의 반품 및 환불 조취 및 교환 조취를 취한다.


<p>제 6 장 기타

<p>제 19 조 (면책 및 손해배상)
<p>①천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 회사의 서비스 제공 책임이 면제된다.
<p>②회사는 이용자간 또는 이용자와 제3자간의 상호거래 관계에서 발생되는 결과에 대하여 어떠한 책임도 부담하지 않는다.
<p>③회사는 이용자가 게시판에 게재한 정보, 자료, 내용 등에 관하여 사실의 정확성, 신뢰도 등에 어떠한 책임도 부담하지 않으며 이용자는 본인의 책임 아래 본 사이트를 이용해야 한다.
<p>④이용자가 게시 또는 전송한 자료 등에 관하여 손해가 발생하거나 자료의 취사선택, 기타 무료로 제공되는 서비스 이용과 관련해 어떠한 불이익이 발생하더라도 이에 대한 모든 책임은 이용자에게 있다.
<p>⑤아이디와 비밀번호의 관리 및 이용자의 부주의로 인하여 발생되는 손해 또는 제3자에 의한 부정사용 등에 대한 책임은 이용자에게 있다.
<p>⑥이용자가 본 약관의 규정을 위반함으로써 회사에 손해가 발생하는 경우 이 약관을 위반한 이용자는 회사에 발생한 모든 손해를 배상해야 하며 동 손해로부터 회사를 면책시켜야 한다.

<p>제 20 조 (개인신용정보 제공 및 활용에 대한 동의서)
회사가 회원 가입과 관련해 취득한 개인 신용 정보는 신용정보의 이용 및 보호에 관한 법률 제23조의 규정에 따라 타인에게 제공 및 활용 시 이용자의 동의를 얻어야 한다. 이용자의 동의는 회사가 회원으로 가입한 이용자의  신용정보를 신용정보기관, 신용정보업자 및 기타 이용자 등에게 제공해 이용자의 신용을 판단하기 위한 자료로서 활용하거나 공공기관에서 정책자료로 활용하는데 동의하는 것으로 간주한다.

<p>제 21 조 (분쟁의 해결)
<p>①회사와 이용자는 본 사이트 이용과 관련해 발생한 분쟁을 원만하게 해결하기 위하여 필요한 모든 노력을 해야 한다.
<p>②제1항의 규정에도 불구하고 동 분쟁으로 인하여 소송이 제기될 경우 동 소송은 회사의 본사 소재지를 관할하는 법원의 관할로 본다.

<p><부칙>
본 약관은 2021년 12월 6일부터 적용한다.
</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
        </div>
      </div>
      
    </div>
  </div>
				
	<!-- 개인정보 수집 이용동의 -->
  <div class="modal fade" id="myModal2" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">개인정보 수집 및 이용 동의(필수)</h4>
        </div>
        <div class="modal-body">
        <p> [Cmarket] ('http://www.Cmarket.com'이하 'Cmarket')은(는) 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.
<p>제1조(개인정보의 처리목적)
<p>< Cmarket >(이)가 개인정보 보호법 제32조에 따라 등록․공개하는 개인정보파일의 처리목적은 다음과 같습니다.
<p>제2조(개인정보처리 위탁)
<p>② < Cmarket >은(는) 위탁계약 체결시 「개인정보 보호법」 제26조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적․관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리․감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.
<p>③ 위탁업무의 내용이나 수탁자가 변경될 경우에는 지체없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.
<p>제3조(정보주체와 법정대리인의 권리·의무 및 그 행사방법)
<p>① 정보주체는 Cmarket에 대해 언제든지 개인정보 열람·정정·삭제·처리정지 요구 등의 권리를 행사할 수 있습니다.
<p>② 제1항에 따른 권리 행사는Cmarket에 대해 「개인정보 보호법」 시행령 제41조제1항에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 Cmarket은(는) 이에 대해 지체 없이 조치하겠습니다.
<p>③ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다.이 경우 “개인정보 처리 방법에 관한 고시(제2020-7호)” 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.
<p>④ 개인정보 열람 및 처리정지 요구는 「개인정보 보호법」 제35조 제4항, 제37조 제2항에 의하여 정보주체의 권리가 제한 될 수 있습니다.
<p>⑤ 개인정보의 정정 및 삭제 요구는 다른 법령에서 그 개인정보가 수집 대상으로 명시되어 있는 경우에는 그 삭제를 요구할 수 없습니다.
<p>⑥ Cmarket은(는) 정보주체 권리에 따른 열람의 요구, 정정·삭제의 요구, 처리정지의 요구 시 열람 등 요구를 한 자가 본인이거나 정당한 대리인인지를 확인합니다.
<p>제4조(처리하는 개인정보의 항목 작성)
<p>제5조(개인정보의 파기)
<p>① < Cmarket > 은(는) 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개인정보를 파기합니다.
<p>② 정보주체로부터 동의받은 개인정보 보유기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존하여야 하는 경우에는, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다.
<p>1. 법령 근거 :
<p>2. 보존하는 개인정보 항목 : 계좌정보, 거래날짜
<p>③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.
<p>1. 파기절차
<p>[ Cmarket ] 은(는) 파기 사유가 발생한 개인정보를 선정하고, < Cmarket > 의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다.
<p>2. 파기방법
<p>전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.
<p>종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다
<p>제6조(개인정보의 안전성 확보 조치)
<p>[ Cmarket ]은(는) 개인정보의 안전성 확보를 위해 다음과 같은 조치를 취하고 있습니다.
<p>1. 정기적인 자체 감사 실시
<p>개인정보 취급 관련 안정성 확보를 위해 정기적(분기 1회)으로 자체 감사를 실시하고 있습니다.
<p>2. 해킹 등에 대비한 기술적 대책
<p><Cmarket>('Cmarket')은 해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안프로그램을 설치하고 주기적인 갱신·점검을 하며 외부로부터 접근이 통제된 구역에 시스템을 설치하고 기술적/물리적으로 감시 및 차단하고 있습니다.
<p>3. 개인정보의 암호화
<p>이용자의 개인정보는 비밀번호는 암호화 되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.
<p>4. 접속기록의 보관 및 위변조 방지
<p>개인정보처리시스템에 접속한 기록을 최소 1년 이상 보관, 관리하고 있으며,다만, 5만명 이상의 정보주체에 관하여 개인정보를 추가하거나, 고유식별정보 또는 민감정보를 처리하는 경우에는 2년이상 보관, 관리하고 있습니다.
<p>또한, 접속기록이 위변조 및 도난, 분실되지 않도록 보안기능을 사용하고 있습니다.
<p>5. 개인정보에 대한 접근 제한
<p>개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.
<p>6. 문서보안을 위한 잠금장치 사용
<p>개인정보가 포함된 서류, 보조저장매체 등을 잠금장치가 있는 안전한 장소에 보관하고 있습니다.
<p>7. 비인가자에 대한 출입 통제
<p>개인정보를 보관하고 있는 물리적 보관 장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다.
<p>제7조(개인정보 자동 수집 장치의 설치•운영 및 거부에 관한 사항)
<p>① Cmarket 은(는) 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠키(cookie)’를 사용합니다.
<p>② 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다.
<p>가. 쿠키의 사용 목적 : 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다.
<p>나. 쿠키의 설치•운영 및 거부 : 웹브라우저 상단의 도구>인터넷 옵션>개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다.
<p>다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.
<p>② 정보주체께서는 Cmarket 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. Cmarket 은(는) 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.
<p>제9조(개인정보 열람청구)
<p>정보주체는 ｢개인정보 보호법｣ 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다.
<p>[ Cmarket ]은(는) 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.
<p>정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.
<p>1. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr)
<p>2. 개인정보침해신고센터 : (국번없이) 118 (privacy.kisa.or.kr)
<p>3. 대검찰청 : (국번없이) 1301 (www.spo.go.kr)
<p>4. 경찰청 : (국번없이) 182 (ecrm.cyber.go.kr)
<p>「개인정보보호법」제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대 하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.
<p>※ 행정심판에 대해 자세한 사항은 중앙행정심판위원회(www.simpan.go.kr) 홈페이지를 참고하시기 바랍니다.
<p>① 이 개인정보처리방침은 2021년 12월 12부터 적용됩니다.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
        </div>
      </div>
      
    </div>
  </div>			
			</form>
		</div>
	</article>

<%@ include file="../layout/footer.jsp" %>
</body>
</html>