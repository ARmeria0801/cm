<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 업로드</title>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- SmartEditor 텍스트 편집기 -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<!-- 우편번호 API, 배송템플릿 유효성검사 -->
<script src="<%=request.getContextPath()%>/resources/js/sellerjs/sellerdeliverytemplate.js"></script>
<!-- Ajax 및 상품업로드 유효성검사 -->
<script src="<%=request.getContextPath()%>/resources/js/sellerjs/goodsuploadform.js"></script>

<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="<c:url value='/resources/css/seller/goodsuploadform.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/seller/sellergoodsupload.css'/>">
</head>
<body>
<%@ include file="../layout/sellerheader.jsp" %>
<%@ include file="../layout/sellerSidebar.jsp" %>
	<div id="goodsuploadform">
		<form method="post" action="<%=request.getContextPath()%>/goodsupload" enctype="multipart/form-data" onsubmit="return goodsupload_check()">
			<table border="1" width="1200" class="goodsUploadForm">

				<tr>
					<th style="text-align:center;">카테고리</th>
					<td class="content">
						<span id="lcate">
							<select id="lcate_code" name="lcate_code" onchange="mcateload()">
									<option value=0>대분류 선택</option>
								<c:forEach var="lcate" items="${lcatelist}">
									<option value="${lcate.lcate_code}">${lcate.lcate_name}</option>
								</c:forEach>
							</select>
						</span>
						<span id="mcate">
						</span>
						<span id="scate">
						</span>
					</td>
				</tr>
				<tr>
					<th style="text-align:center;">상품 판매자</th>
					<td class="content">${seller.sel_name}</td>
				</tr>
				<tr>
					<th style="text-align:center;">상품명</th>
					<td class="content"><input type="text" id="gds_name" name="gds_name"></td>
				</tr>
				<tr>
					<th style="text-align:center;">대표이미지</th>
					<td class="content"> 
						 <img style="width: 400px;" id="dummy-image" src="<%=request.getContextPath()%>/resources/images/goodsupload/dummyImage500X500.png">
					     <input type="file" id="gds_thumbnail1" name="gds_thumbnail1">
					</td>
				</tr>
				
				<tr>
					<th style="text-align:center;">단위 가격</th>
					<td class="content"><input type="text" id="gds_price" name="gds_price"></td>
				</tr>
				<tr>
					<th style="text-align:center;">상세설명</th>
					<td width=900 class="content"><textarea id="gds_detail" name="gds_detail"
							rows="20" cols="150"></textarea></td>
				</tr>
				<tr>
					<th style="text-align:center;">옵션</th>
					<td class="content">
						<div id="pre_set">
							<input type="text" name="option1name" id="option1name" placeholder="옵션명" size=7 >  : 
							<input type="text" name="option1val" id="option1val" style="width:300px" placeholder="쉼표(,)로 구분해주세요. ex)red,blue,..."><br>
							<input type="text" name="option2name" id="option2name" placeholder="옵션명" size=7>  : 
							<input type="text" name="option2val" id="option2val" style="width:300px" placeholder="쉼표(,)로 구분해주세요. ex)L,XL,..."><br>
							<input type="button" value="추가 " onclick="add_item()">
						</div>
						
						
						<div id="field"></div>
					</td>
				</tr>
				<tr>
					<th style="text-align:center;">재고</th>
					<td class="content"><input type="text" id="opt_count" name="opt_count"></td>
				</tr>
				<tr>
					<th style="text-align:center;">배송 정보</th>
					<td class="content">
						<select id="deltem_num" name="deltem_num" onchange="deltemLoad()">
								<option value="-1">배송 템플릿</option>
							<c:forEach var="dtlist" items="${deltemlist}">
								<option value="${dtlist.deltem_num}">${dtlist.deltem_name}</option>
							</c:forEach>
								<option value="0">새로입력</option>
						</select>
						<div id="deltemdiv" name="deltemdiv">
						</div>
					
					</td>
				</tr>
				<tr>
					<th style="text-align:center;">교환 환불 기준</th>
					<td class="content"><textarea id="gds_ears" name="gds_ears" rows="10" cols="150"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center" class="content">
					<input type="submit" id="uploadbutton" name="uploadbutton" value="업로드 하기"></td>
				</tr>
			</table>
		</form>
		<br><br>

	</div>
	<!-- 스마트에디터    -->
	<script>
	$(function(){
	    //전역변수선언
	    var editor_object = [];
	     
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: editor_object,
	        elPlaceHolder: "gds_detail",
	        sSkinURI: "<%=request.getContextPath()%>/resources/smarteditor2/SmartEditor2Skin.html",
						htParams : {
							// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseToolbar : true,
							// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseVerticalResizer : false,
							// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
							bUseModeChanger : true,
							fCreator : "createSEditor2"
						}
					});

			//업로드버튼 클릭이벤트
			$("#uploadbutton").click(function() {
					//id가 gds_content인 textarea에 스마트 에디터의 내용을 전달
					editor_object.getById["gds_detail"].exec(
							"UPDATE_CONTENTS_FIELD", []);
					
					//폼 submit
					$("#form").submit();
			})
	})
	</script>
	<!-- 대표이미지 미리보기 -->
	<script src="<%=request.getContextPath()%>/resources/js/sellerjs/previewimage.js"></script>
	


</body>
</html>