<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib  prefix="spring" uri="http://www.springframework.org/tags" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/footer.css'/>"></head>
<body>
	<footer>
		<div class="inner_footer">
			<div class="footer_cc">
				<h2 class="tit_cc">고객 센터</h2>
			<br>
				<div class="cc_view cc_tel">
					<div
						class="tit">1111-1111</div>
					<div class="list">
						<p>365일 운영<br>
						고객센터 운영시간 오전 7시~ 오후7시</p>
					</div>
				</div>
				<br><br>
				<div class="cc_view cc_faq">
					<a href="#"
						class="tit">FAQ</a>
					<div class="list">
						<p>자주 묻는 질문<br> 여기서 확인</p>
					</div>
				</div>
				<br><br>
				<div class="cc_view cc_qna">
					<a href="#"
						class="tit">문의하기</a>
					<div class="list">
						<p>24시간 접수 가능<br>
						고객센터 운영시간에 순차적으로 답변해드리겠습니다.</p>
					</div>
				</div>
				<br><br><br><br>
				
			</div>
			<div class="company">
				<br>
				법인명 (상호): 주식회사 중앙마켓 <span class="bar">I</span> 사업자등록번호: 111-11-11111
				<a href="#" target="_blank" class="link">사업자정보 확인</a> <br /> 통신판매업 : 제
				2021-서울강남-11111 호 <span class="bar">I</span> 개인정보보호책임자 : 스노든 <br />
				주소 : 서울시 도산대로 16길 20, 이래빌딩 B1 ~ 4F <span class="bar">I</span> 대표이사 :
				홍길동 <br /> 제휴문의 : <a href="#" class="link">business@email.com</a>
				<br /> 채용문의 : <a href="#" class="link">recruit@email.com</a>
				<br /> 팩스: 111 - 111 - 1111 <span class="bar"></span> <br />이메일 : <a
					href="#" class="link">help@email.com</a>
				<em class="copy"><br>© Cmarket CORP. ALL RIGHTS RESERVED</em>
				<ul class="list_sns">
					<li><a href="#"
						class="link_sns" target="_blank"><img
							src="https://res.kurly.com/pc/ico/1810/ico_instagram.png"
							alt="마켓컬리 인스타그램 바로가기" /></a></li>
					<li><a href="#"
						class="link_sns" target="_blank"><img
							src="https://res.kurly.com/pc/ico/1810/ico_fb.png"
							alt="마켓컬리 페이스북 바로가기" /></a></li>
					<li><a href="#"
						class="link_sns" target="_blank"><img
							src="https://res.kurly.com/pc/ico/1810/ico_blog.png"
							alt="마켓컬리 네이버블로그 바로가기" /></a></li>
					<li><a href="#"
						class="link_sns" target="_blank"><img
							src="https://res.kurly.com/pc/ico/1810/ico_naverpost.png"
							alt="마켓컬리 네이버포스트바로가기" /></a></li>
					<li><a
						href="#"
						class="link_sns lst" target="_blank"><img
							src="https://res.kurly.com/pc/ico/1810/ico_youtube.png"
							alt="마켓컬리 유튜브 바로가기" /></a></li>
				</ul>
			</div>
		</div>
	</footer>

<button onclick="topFunction()" id="mytopBtn" title="Go to top">Top</button>

<script>
//Get the button
var mybutton = document.getElementById("mytopBtn");

// When the user scrolls down 20px from the top of the document, show the button
window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
    mybutton.style.display = "block";
  } else {
    mybutton.style.display = "none";
  }
}

// When the user clicks on the button, scroll to the top of the document
function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}
</script>


</body>
</html>