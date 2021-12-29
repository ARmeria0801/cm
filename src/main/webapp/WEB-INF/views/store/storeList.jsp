<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CM StoreList</title>
<c:import url="../template/boot.jsp" />
<link href="${pageContext.request.contextPath}/resources/css/reset.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/store/storeList.css" rel="stylesheet">
</head>
<body>
	<div id="wrap">
		<div id="container">
			<c:import url="../layout/header.jsp" />
			<div id="main">
				<div id="content">
					<div class="page_article">
						<!-- 카테고리 목록 -->
						<div id="lnbMenu" class="lnb_menu">
							<div class="inner_lnb">
								<h3 class="tit">채소</h3>
								<ul class="list on">
									<li data-start="124" data-end="188">
										<a class="on">전체보기</a>
									</li>
									<li data-start="316" data-end="368">
										<a class>친환경</a>
									</li>
									<li data-start="435" data-end="548">
										<a class>고구마·감자·당근</a>
									</li>
									<li data-start="603" data-end="728">
										<a class>시금치·쌈채소·나물</a>
									</li>
									<li data-start="748" data-end="908">
										<a class>브로콜리·파프리카·양배추</a>
									</li>
								</ul>
							</div>
						</div>
						
						<!-- 상품 리스트 -->
						<div id="goodsList" class="page_section section_goodslist">
							<div class="list_ability">
								<div class="sort_menu">
									<div>
										<p class="count">
											<span class="inner_count"> 총 467개 </span>
										</p>
										<div class="select_type">
											<a class="name_select">추천순</a>
											<ul class="list">
												<li class>
													<a class="on">추천순</a>
													<div class="recommend">
														<div id="layerRecommend" class="layer_recommend">
															<p class="desc">
																"검색어 적합성과 소비자 인기도(판매량, 판매금액,"
																<br>
																" 조회수 등)를 종합적으로 고려한 순서입니다."
															</p>
														</div>
													</div>
												</li>
												<li class>
													<a class>신상품순</a>
												</li>
												<li class>
													<a class>판매량순</a>
												</li>
												<li class>
													<a class>혜택순</a>
												</li>
												<li class>
													<a class>낮은 가격순</a>
												</li>
												<li class>
													<a class>높은 가격순</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="list_goods">
								<div class="inner_listgoods">
									<ul class="list">
									<c:forEach items="${lists}" var="list">
										<li>
											<div class="item">
												<div class="thumb">
													<a href="./storeSelect?gds_num=${list.gds_num}&curPage=${pager.curPage}" class="img" style="background: url('../resources/images/goodsimage/${list.gds_thumbnail}') center center no-repeat;"></a>
													<div class="exp_area">
														<div class="util_bx">
															<a class="btn_category_product_cart">
																<span class="blind">장바구니</span>
															</a>
															<a class="btn_category_product_buy" id="btn_buy${list.gds_num}">
																<span class="blind">바로구매</span>
															</a>
															<a class="btn_category_product_heart">
																<span class="blind">찜하기</span>
															</a>
														</div>	
													</div>
												</div>
												<a class="info">
													<span class="name">${list.gds_name}</span>
													<span class="cost">
														<span class="price">
															<fmt:formatNumber value="${list.gds_price}" pattern="###,###,###" />원
														</span>
													</span>
													<!-- <span class="desc">상추와 깻잎을 한번에!</span> -->
													<span class="tag"></span>
												</a>	
											</div>
										</li>
									</c:forEach>	
									</ul>
								</div>
							</div>
							<div class="layout-pagination">
								<div class="pagediv">
									<a href="./storeList?curPage=1" class="layout-pagination-button layout-pagination-first-page">맨 처음 페이지로 가기</a>
									<a href="./storeList?curPage=${pager.curPage-1}" class="layout-pagination-button layout-pagination-prev-page">이전 페이지로 가기</a>
									
									<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
										<span>
											<c:if test="${pager.curPage == i}">
												<strong class="layout-pagination-button layout-pagination-number active">${i}</strong>
											</c:if>
											<c:if test="${pager.curPage != i}">
												<a href="./storeList?curPage=${i}" class="layout-pagination-button layout-pagination-number">${i}</a>
											</c:if>
										</span>
									</c:forEach>
									<a href="./storeList?curPage=${pager.curPage+1}" class="layout-pagination-button layout-pagination-next-page">다음 페이지로 가기</a>
									<a href="./storeList?curPage=${pager.totalPage}" class="layout-pagination-button layout-pagination-last-page">맨 끝 페이지로 가기</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>