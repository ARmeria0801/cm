<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
</head>
<body>
	<button onclick="requestPay()">결제하기</button>
	<script type="text/javascript">
		var IMP = window.IMP; // 생략 가능
		IMP.init("imp22110636"); // 예: imp00000000

		function requestPay() {
			// IMP.request_pay(param, callback) 결제창 호출
			IMP.request_pay({ // param
				pg : "html5_inicis", //PG사 선택
				pay_method : "card", //지불수단
				merchant_uid : "ORD20180131-0000012",//'merchant_' + new Date().getTime() //가맹점에서 구별할 수 있는 고유한 ID
				name : "주문명:결제테스트",//결제창에서 보여질 이름(상품명)
				amount : 100,//실제 결제 금액
				buyer_email : "gildong@gmail.com",
				buyer_name : "홍길동", //구매자 이름
				buyer_tel : "010-4242-4242", //구매자 연락처
				buyer_addr : "서울특별시 강남구 신사동", //구매자 주소지
				buyer_postcode : "01181" //구매자 우편번호
			}, function(rsp) { // callback
				console.log(rsp);
				if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
					//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
					/* jQuery.ajax({
						url : "{서버의 결제 정보를 받는 endpoint}", // 예: https://www.myservice.com/payments/complete
						method : "POST",
						dataType: 'json',
						data : {
							imp_uid : rsp.imp_uid,
							merchant_uid : rsp.merchant_uid
							//기타 필요한 데이터가 있으면 추가 전달
						}
					}).done(function(data) {
						//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
						// 가맹점 서버 결제 API 성공시 로직
						if ( everythings_fine ) {
			    			var msg = '결제가 완료되었습니다.';
			    			msg += '\n고유ID : ' + rsp.imp_uid;
			    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
			    			msg += '\결제 금액 : ' + rsp.paid_amount;
			    			msg += '카드 승인번호 : ' + rsp.apply_num;
			    			
			    			alert(msg);
			    		} else {
			    			//[3] 아직 제대로 결제가 되지 않았습니다.
			    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
			    		}
					}) */
				} else { //결제 실패시
					 var msg = '결제에 실패하였습니다.';
			         msg += '에러내용 : ' + rsp.error_msg;
					//alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
				}
				alert(msg);
			});
		}
	</script>
</body>
</html>