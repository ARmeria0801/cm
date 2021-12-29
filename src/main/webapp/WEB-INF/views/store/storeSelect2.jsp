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
								</div>
							</div>
						</div>
						<div id="cartPut">
							<div class="cart_option cartList cart_type2">
								<div class="inner_option">
									<strong class="tit_cart">${select.gds_name}</strong>
									<div class="in_option">
										<div class="list_goods">
											<div class="box_select">
												<strong class="name">상품 선택</strong>
												<div class="inner_select">
													<a href="#none" class="txt_select open">상품 선택</a>
													<ul class="select_item">
														<li class="fst">
															<a href="#none" class="sold_out">
																<span class="item_name">
																	<span>(품절)</span>
																	[아웃팅] 일반트리
																</span>
																<span class="price">
																	<span class="dc_price">43900원</span>
																</span>
															</a>
														</li>
														<li class>
															<a href="#none" class="sold_out">
																<span class="item_name">
																	<span>(품절)</span>
																	[아웃팅] 미니트리
																</span>
																<span class="price">
																	<span class="dc_price">19900원</span>
																</span>
															</a>
														</li>
														<li class>
															<a href="#none" class>
																<span class="item_name">
																	[아웃팅] 하프벽트리
																</span>
																<span class="price">
																	<span class="dc_price">19900원</span>
																</span>
															</a>
														</li>
													</ul>
												</div>
											</div>
											<ul class="list">
												<li class="off sold_out">
													<span class="btn_position on">
														<button type="button" class="btn_del">
															<span class="txt">삭제하기</span>
														</button>
													</span>
													<span class="name">
														<span>(품절)</span>
														[아웃팅] 일반트리
													</span>
													<div class="option">
														<span class="price">
															<span class="dc_price">43900원</span>
														</span>
													</div>
												</li>
												<li class="off sold_out">
													<span class="btn_position on">
														<button type="button" class="btn_del">
															<span class="txt">삭제하기</span>
														</button>
													</span>
													<span class="name">
														<span>(품절)</span>
														[아웃팅] 미니트리
													</span>
													<div class="option">
														<span class="price">
															<span class="dc_price">19900원</span>
														</span>
													</div>
												</li>
												<li class="on">
													<span class="btn_position on">
														<button type="button" class="btn_del">
															<span class="txt">삭제하기</span>
														</button>
													</span>
													<span class="name">
														<!-- <span>(품절)</span> -->
														[아웃팅] 하프벽트리
													</span>
													<div class="option">
														<span class="count">
															<button type="button" class="btn down on">수량내리기</button>
															<input type="number" readonly="readonly" onfocus="this.blur()" class="inp">
															<button type="button" class="btn up on">수량올리기</button>
														</span>
														<span class="price">
															<span class="dc_price">19900원</span>
														</span>
													</div>
												</li>
											</ul>
										</div>
										<div class="total">
											<div class="price">
												<strong class="tit">총 상품금액 :</strong>
												<span class="sum">
													<span class="num">19900</span>
													<span class="won">원</span>
												</span>
											</div>
										</div>
									</div>
									<div class="group_btn off">
										<div class="view_function">
											<button type="button" class="btn btn_alarm on">재입고 알림</button>
										</div>
										<span class="btn_type1">
											<button type="button" class="txt_type">장바구니 담기</button>
										</span>
									</div>
								</div>
							</div>
						</div>
						<div class="layout-wrapper goods-view-area">
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>