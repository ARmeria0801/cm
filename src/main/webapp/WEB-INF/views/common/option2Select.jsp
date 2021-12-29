<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<dl class="list" style="overflow: visible;">
	<dt class="tit">${list[0].opt_2ndname}</dt>
	<dd class="">
		<div class="select select2">
			<label class="text text2">선택</label>
			<ul class="option-list">
				<c:forEach	items="${list}" var="opt">
					<li class="option option2" data-optnum="${opt.opt_num}">${opt.opt_2ndval}</li>
				</c:forEach>
			</ul>
		</div>
	</dd>
</dl>
<script type="text/javascript">
	// active가 추가되었을 경우에만 option-list가 보이도록
	// active 클래스 추가/제거 이벤트 함수
	$('.select2').click(function () {
		$(this).toggleClass("active");
	});
	
	// option 태그 클릭 시, 선택한 값으로 변경 이벤트 함수
	$('.option2').click(function () {
		$(".text2").html($(this).html());
		
		opt_num = $(this).attr('data-optnum');
		//alert(opt_num);
		$('.numCount').val(1);
		
		var price = ${gds_price};
		price = addComma(price);
		$('.totalPrice').text(price);
	});
</script>

