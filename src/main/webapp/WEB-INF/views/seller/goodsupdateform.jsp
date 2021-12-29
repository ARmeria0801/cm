<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<!-- SmartEditor 텍스트 편집기 -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<!-- 우편번호 API, 배송템플릿 유효성검사 -->
<script src="<%=request.getContextPath()%>/resources/js/sellerjs/sellerdeliverytemplate.js"></script>
<!-- Ajax 및 상품수정 유효성검사 -->
<script src="<%=request.getContextPath()%>/resources/js/sellerjs/goodsupdateform.js"></script>
<!-- 옵션 유효성검사 -->
<script src="<%=request.getContextPath()%>/resources/js/sellerjs/insertOption.js"></script>

<link rel="stylesheet" href="<c:url value='/resources/css/seller/goodsuploadform.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/seller/sellergoodsupload.css'/>">

</head>
<body>
<%@ include file="../layout/sellerheader.jsp" %>
<%@ include file="../layout/sellerSidebar2.jsp" %>
	<div id="goodsuploadform">
		<form method="post" action="<%=request.getContextPath()%>/goodsupdate" enctype="multipart/form-data" onsubmit="return goodsupload_check()">
			<input type="hidden" name="gds_num" value="${goods.gds_num}" />
 			<input type="hidden" name="page" value="${page}" />
			<input type="hidden" name="oldgds_thumbnail" value="<%=request.getContextPath()%>/resources/images/thumbnailimage/${goods.gds_thumbnail}">
			<table border="1" width="1200">
				<tr>
					<th width="100" style="text-align:center;">카테고리</th>
					<td class="content">
						<span id="lcate">
							<select id="lcate_code" name="lcate_code" onchange="mcateload()">
									<option value=0>대분류 선택</option>
								<c:forEach var="lcate" items="${lcatelist}">
									<option value="${lcate.lcate_code}" 
									<c:if test="${lcate.lcate_code == goods.lcate_code}"> 
										selected="selected"</c:if>
									>${lcate.lcate_name}</option>
								</c:forEach>
							</select>
						</span>
						<span id="mcate">
						<select id="mcate_code" name="mcate_code" onchange="scateload()">
								<option value=0>중분류 선택</option>
							<c:forEach var="mcate" items="${mcatelist}">
								<option value="${mcate.mcate_code}"
								<c:if test="${mcate.mcate_code == goods.mcate_code}"> 
										selected="selected"</c:if>>${mcate.mcate_name}</option>
							</c:forEach>
						</select>
						</span>
						<span id="scate">
							<select id="scate_code" name="scate_code">
									<option value=-1>소분류 선택</option>
								<c:forEach var="scate" items="${scatelist}">
									<option value="${scate.scate_code}"
									<c:if test="${scate.scate_code == goods.scate_code}"> 
										selected="selected"</c:if>>${scate.scate_name}</option>
								</c:forEach>
									<option value=0 
									<c:if test="${goods.scate_code == 0}"> 
										selected="selected"</c:if>>소분류 없음</option>
							</select>						
						</span>
					</td>
				</tr>
				<tr>
					<th style="text-align:center;">상품 판매자</th>
					<td class="content">${goods.gds_seller}</td>
				</tr>
				<tr>
					<th style="text-align:center;">상품명</th>
					<td class="content"><input type="text" id="gds_name" name="gds_name" size="100" value="${goods.gds_name}"></td>
				</tr>
				<tr>
					<th style="text-align:center;">대표이미지</th>
					<td class="content">
						 <img style="width: 400px;" id="preview-image" src="<%=request.getContextPath() %>/resources/images/thumbnailimage/${goods.gds_thumbnail}">
					     <input style="display: block;" type="file" id="gds_thumbnail1" name="gds_thumbnail1">
					</td>
				</tr>
				<tr>
					<th style="text-align:center;">단위 가격</th>
					<td class="content"><input type="text" id="gds_price" name="gds_price" value="${goods.gds_price}"></td>
				</tr>
				<tr>
					<th style="text-align:center;">상세설명</th>
					<td width=900 class="content"><textarea id="gds_detail" name="gds_detail"
							rows="100" cols="150">${goods.gds_detail}</textarea></td>
				</tr>
				<tr>
					<th style="text-align:center;">옵션</th>
					<td class="content">
						<div id="pre_set">
							<input type="text" name="option1name" id="option1name" placeholder="옵션명" size=7 value="${optionlist[0].opt_1stname}">  : 
							<input type="text" name="option1val" id="option1val" style="width:300px" placeholder="쉼표(,)로 구분해주세요. ex)red,blue,..."><br>
							<input type="text" name="option2name" id="option2name" placeholder="옵션명" size=7 value="${optionlist[0].opt_2ndname}">  : 
							<input type="text" name="option2val" id="option2val" style="width:300px" placeholder="쉼표(,)로 구분해주세요. ex)L,XL,..."><br>
							<input type="button" value="추가 " onclick="add_item()">
						</div>
					<div id="field">
						<c:set var="sum" value="0" />
						<c:if test="${optionlist[0].opt_1stval != null }">
							<c:choose>
								<c:when test="${optionlist[0].opt_2ndval != null}">
									<!-- 옵션값을 2개다 입력한 경우 -->
									<table border="1">
										<tr>
											<th style="text-align:center;">${optionlist[0].opt_1stname} - ${optionlist[0].opt_2ndname}</th>
											<th style="text-align:center;">재고</th>
										</tr>
										<c:forEach var="optionlist" items="${optionlist}">
											<tr>
												<td>
													<input type="hidden" id="edit_opt_num" name="edit_opt_num" value="${optionlist.opt_num }">
													<input type="text" id="edit_opt_1stval" name="edit_opt_1stval" value="${optionlist.opt_1stval} - ${optionlist.opt_2ndval}" readonly>
												</td>
												<td>
													<input type="text" id="edit_opt_count" name="edit_opt_count" value="${optionlist.opt_count}">
												</td>
												<c:set var="sum" value="${sum+optionlist.opt_count}"/>
											</tr>
										</c:forEach>
										<tr>
											<td><input type="button" onclick="updateOption()" value="확인"></td>
										</tr>
									</table>
									
								</c:when>
								<c:otherwise>
								<!-- 옵션값을 1개만 입력한 경우 -->
									<table border="1">
										<tr>
											<th style="text-align:center;">${optionlist[0].opt_1stname}</th>
											<th style="text-align:center;">재고</th>
										</tr>
										<c:forEach var="optionlist" items="${optionlist}">
											<tr>
												<td>
													<input type="hidden" id="edit_opt_num" name="edit_opt_num" value="${optionlist.opt_num }">
													<input type="text" id="edit_opt_1stval" name="edit_opt_1stval" value="${optionlist.opt_1stval}" readonly>
												</td>
												<td>
													<input type="text" id="edit_opt_count" name="edit_opt_count" value="${optionlist.opt_count}">
												</td>
												<c:set var="sum" value="${sum+optionlist.opt_count}"/>
											</tr>
										</c:forEach>
										<tr>
											<td><input type="button" onclick="updateOption()" value="확인"></td>
										</tr>
									</table>
								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${optionlist[0].opt_1stval == null}">
							<input type="hidden" id="opt_num" name="opt_num" value="${optionlist[0].opt_num }">
							<c:set var="sum" value="${optionlist[0].opt_count}"/>
						</c:if>
					</div>
				<tr>
					<th style="text-align:center;">재고</th>
					<td class="content"><input type="text" id="opt_count" name="opt_count" value="${sum}"></td>
				</tr>
				<tr>
					<th style="text-align:center;">배송 정보</th>
					<td class="content">
						<select id="deltem_num" name="deltem_num" onchange="deltemLoad()">
								<option value="-1">배송 템플릿</option>
								<c:forEach var="dtlist" items="${deltemlist}">
								<option value="${dtlist.deltem_num}" <c:if test="${dtlist.deltem_num == goods.deltem_num}"> selected="selected"</c:if>>
									${dtlist.deltem_name}</option>
								</c:forEach>
								<option value="0">새로입력</option>
						</select>
						<div id="deltemdiv">
							<c:if test="${gettemplate != null}">
								<table>
									<tr>
										<th style="text-align:center;">배송 탬플릿 명</th>
										<td><input type="text" id="deltem_name" name="deltem_name" value="${gettemplate.deltem_name}" disabled="disabled"></td>
									</tr>
									<tr>
										<th style="text-align:center;">배송사 선택</th>
										<td>
											<input type="hidden" id="del_code" name="del_code" value="${gettemplate.del_code}" disabled="disabled">
											<input type="text" id="del_name" name="del_name" value="${gettemplate.del_name}" disabled="disabled">
										</td>
									</tr>
									<tr>
										<th style="text-align:center;">배송비</th>
										<td><input type="text" name="deltem_delfee" id="deltem_delfee" value="${gettemplate.deltem_delfee}" disabled="disabled"></td>
									</tr>
									<tr>
										<th style="text-align:center;">무료배송 기준금액</th>
										<td><input type="text" name="deltem_freedel" id="deltem_freedel" value="${gettemplate.deltem_freedel}" disabled="disabled"></td>
									</tr>
									<tr>
										<th style="text-align:center;">반품 배송비</th>
										<td><input type="text" name="deltem_redelfee" id="deltem_redelfee" value="${gettemplate.deltem_redelfee}" disabled="disabled"></td>
									</tr>
									<tr>
										<th style="text-align:center;">교환 배송비</th>
										<td><input type="text" name="deltem_exdelfee" id="deltem_exdelfee" value="${gettemplate.deltem_exdelfee}" disabled="disabled"></td>
									</tr>
									<tr>
										<th style="text-align:center;">반품/교환 배송지 <br>우편번호</th>
										<td><input name="deltem_repost" id="deltem_repost" size="5"
											class="input_box" readonly onclick="post_search()"  value="${gettemplate.deltem_repost}" disabled="disabled"/> 
										</td>
									</tr>
									<tr>
										<th style="text-align:center;">주소</th>
										<td><input name="deltem_readd1" id="deltem_readd1" size="50"
											class="input_box" readonly onclick="post_search()" value="${gettemplate.deltem_readd1}" disabled="disabled"/></td>
									</tr>
						
									<tr>
										<th style="text-align:center;">나머지 주소</th>
										<td><input name="deltem_readd2" id="deltem_readd2" size="37"
											class="input_box" value="${gettemplate.deltem_readd2}" disabled="disabled"/></td>
									</tr>
								</table>
							</c:if>
						</div>
					</td>
				</tr>
				<tr>
					<th style="text-align:center;">교환 환불 기준</th>
					<td class="content"><textarea id="gds_ears" name="gds_ears" rows="20" cols="150">${goods.gds_ears}</textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center" class="content">
					<input type="submit" id="updatebutton" name="updatebutton" value="수정 하기"></td>
				</tr>

			</table>
		</form>
	
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
			$("#updatebutton").click(
					function() {
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