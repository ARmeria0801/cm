<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CM StoreSelect</title>
<c:import url="../template/boot.jsp" />
<link href="${pageContext.request.contextPath}/resources/css/reset.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/store/storeSelect.css" rel="stylesheet"></head>
<body>
	<div id="wrap">
		<div id="container">
			<div id="header"></div>
			<div id="main">
				<div id="content" style="opacity: 1;">
					<div class="section_view">
						<div id="shareLayer">
							<div class="layer_share">
								<div class="inner_layersns">
									<h3 class="screen_out">SNS 공유하기</h3>
									<ul class="list_share">
										<li>
											<a class="btn btn_fb">
												<img alt="페이스북" src="${pageContext.request.contextPath}/resources/images/storeSelect/ico_facebook.webp">
												<span class="txt">공유하기</span>
											</a>
										</li>
										<li>
											<a class="btn btn_tw">
												<img alt="트위터" src="${pageContext.request.contextPath}/resources/images/storeSelect/ico_twitter.webp">
												<span class="txt">트윗하기</span>
											</a>
										</li>
										<li class="btn_url">
											<input type="text" class="inp" value readonly="readonly">
											<a class="btn_copy off" href="#none">
												URL 복사
												<img alt="" src="">
											</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<div id="sectionView">
							<div class="inner_view">
								<div class="thumb" style="background: url('../resources/images/goodsimage/${select.gds_thumbnail}') center center no-repeat;"></div>
								<p class="goods_name">
									<span class="btn_share">
										<button id="btnShare">공유하기</button>
									</span>
									<strong class="name">${select.gds_name}</strong>
									<!-- <span class="short_desc">솔솔 풍기는 와인의 향</span> -->
								</p>
								<p class="goods_price">
									<span class="position">
										<span class="dc">
											<span class="dc_price">
												<fmt:formatNumber value="${select.gds_price}" pattern="###,###,###" />
												<span class="won">원</span>
											</span>
										</span>
									</span>
								</p>
								<div class="goods_info">
									<dl class="list fst">
										<dt class="tit">판매단위</dt>
										<dd class="desc">1개</dd>
									</dl>
									<dl class="list">
										<dt class="tit">판매자</dt>
										<dd class="desc">${select.gds_seller}</dd>
									</dl>
									<dl class="list">
										<dt class="tit">택배사</dt>
										<dd class="desc">CJ 대한통운</dd>
									</dl>
								<c:if test="${select.optionVO[0].opt_1stval ne null}">
									<dl class="list fst">
										<dt class="tit">${select.optionVO[0].opt_1stname}</dt>
										<dd class="">
											<div class="select select1">
												<label class="text text1">선택</label>
												<input type="hidden" class="opt_num" value>
												<ul class="option-list" style="z-index: 10;">
													<c:forEach items="${select.optionVO}" var="opt">
														<li class="option option1" id="${opt.opt_2ndval}">${opt.opt_1stval}</li>
													</c:forEach>
												</ul>
											</div>
										</dd>
									</dl>
								</c:if>
									<div class="opt2select"></div>
									<script type="text/javascript">
										// active가 추가되었을 경우에만 option-list가 보이도록
										// active 클래스 추가/제거 이벤트 함수
										$('.select1').click(function () {
											$(this).toggleClass("active");
										});
										
										// option 태그 클릭 시, 선택한 값으로 변경 이벤트 함수
										$('.option1').click(function () {
											var opt_1stval = $(this).text();
											//alert(opt_1stval);
											var gds_num = ${select.gds_num};
											//alert(gds_num);
											
											$(".text1").html($(this).html());
											
											var opt_2ndval = $(this).attr('id');
											//alert('"'+opt_2ndval+'"');
											
											if (opt_2ndval) {
												//option1 선택시, option2 불러오기
												$.ajax({
													url: "option2Select",
													type: "GET",
													async: false,
													data: {
														gds_num : gds_num,
														opt_1stval : opt_1stval
													},
													success: function(data) {
														//alert(data);
														$('.opt2select').html(data);
													},
													error: function(){
														alert("에러");
													}
												});
											}
										});
									</script>
								</div>
							</div>
						<div class="quantity">
							<a href="javascript:void(0)" class="aMinus"><img alt="수량감소" src="../resources/images/storeSelect/btn_quantity_minus.jpg"></a>
							<input type="text" class="numCount" value="1" readonly="readonly" name="camount">
							<a href="javascript:void(0)" class="aPlus"><img alt="수량증가" src="../resources/images/storeSelect/btn_quantity_plus.jpg"></a>
						</div>
							
						<div class="total">
							<strong>총 상품 금액</strong>
							<em>
								<span class="totalPrice">
									<fmt:formatNumber value="${select.gds_price}" pattern="###,###,###" />
								</span>
								원
							</em>
						</div>
							
						<script type="text/javascript">
						if($('.numCount').val() == ""){
							$('.numCount').val(1);
						}
						
						//,찍어주는 정규식 함수
						function addComma(price) {
						  var regexp = /\B(?=(\d{3})+(?!\d))/g;
						  return price.toString().replace(regexp, ',');
						}
						
						//수량 감소
						$('.aMinus').click(function() {
							var num = $('.numCount').val();
							var minusNum = num - 1;
							var price = ${select.gds_price};
							
							if(minusNum <= 0){
								$('.numCount').val(1);
							}else {
								$('.numCount').val(minusNum);
								price = ${select.gds_price} * minusNum;
							}
							
							price = addComma(price);
							$('.totalPrice').text(price);
						});
						
						//수량 증가
						$('.aPlus').click(function() {
							var num = $('.numCount').val();
							num++;
							$('.numCount').val(num);
							
							var price = ${select.gds_price} * num;
							price = addComma(price);
							$('.totalPrice').text(price);
						});
							
						</script>
<!-- ------------------------------------------ -->							
						<div class="btn_wrap">
							<a href="./storeList?store_package=" class="btn_list">상품 리스트</a>
							<a href="#" class="btn_cart">장바구니</a>
							<!-- <a class="btn_buy">구매하기</a> -->
							<button type="button" class="btn_buy">구매하기</button>
						</div>
						</div>
					</div>
					<div class="layout-wrapper goods-view-area">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>