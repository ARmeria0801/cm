// 중분류 불러오기  ajax
function mcateload() {
	if($("#lcate_code  option:selected").val() > 0){
		var lcate_code = $("#lcate_code  option:selected").val();
		 $.ajax({
	    	    url : '/mcateload', // 요청 할 주소
	    	    type : 'post', // GET, PUT
	    	    dataType : 'text',
	    	    data : {
	    	    	"lcate_code" : lcate_code,
	    	    },
	    	    success : function(data) {
	    	    	$('#mcate').html(data);
	    	    }, // 요청 완료 시
	    	    error :function(xhr,status,error){
						console.log("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);
						alert(xhr.status);
					}
	    	});
		 $('#scate').empty();
	}else {
		$('#mcate').empty();
		$('#scate').empty();
	}
}

//소분류 불러오기  ajax
function scateload() {
	if($("#mcate_code  option:selected").val() > 0){
		var mcate_code = $("#mcate_code  option:selected").val();
		 $.ajax({
	    	    url : '/scateload', // 요청 할 주소
	    	   // async: true, // false 일 경우 동기 요청으로 변경
	    	    type : 'post', // GET, PUT
	    	    dataType : 'text',
	    	    data : {
	    	    	"mcate_code" : mcate_code,
	    	    },
	    	    success : function(data) {
	    	    	$('#scate').html(data);
	    	    }, // 요청 완료 시
	    	    error :function(xhr,status,error){
						console.log("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);
						alert(xhr.status);
					}
	    	});
	}else {
		$('#scate').empty();
	}
}

// 옵션 Ajax
function add_item(){
	// 옵션을 입력하였을 경우
	 if($("#opt_1stname").val()!=""){
		 var option1name = $("#option1name").val();
         var option1val = $("#option1val").val();
         var option2name = $("#option2name").val();
         var option2val = $("#option2val").val();
         
         $.ajax({
       	    url : '/optioncom', // 요청 할 주소
       	    type : 'post', // GET, PUT
       	    dataType : 'text',
       	    data : {
       	    	"option1name" : option1name,
       	    	"option1val" : option1val,
       	    	"option2name" : option2name,
       	    	"option2val" : option2val,
       	    },
       	    success : function(data) {
       	    	$('#field').html(data);
       	    }, // 요청 완료 시
       	    error :function(xhr,status,error){
					console.log("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);
					alert(xhr.status);
				}
       	});
     // 옵션을 입력하지 않았을 경우
	 }else{
		 alert("옵션값을 입력해 주세요.");
		 return false;
	 }
}
// 배송템플릿 자동완성  ajax
function deltemLoad() {
	if($("#deltem_num  option:selected").val() >= 0){
		var deltem_num = $("#deltem_num  option:selected").val();
		 $.ajax({
	    	    url : '/deltemload', // 요청 할 주소
	    	   // async: true, // false 일 경우 동기 요청으로 변경
	    	    type : 'post', // GET, PUT
	    	    dataType : 'text',
	    	    data : {
	    	    	"deltem_num" : deltem_num,
	    	    },
	    	    success : function(data) {
	    	    	$('#deltemdiv').html(data);
	    	    }, // 요청 완료 시
	    	    error :function(xhr,status,error){
						console.log("code:"+xhr.status+"\n"+"message:"+xhr.responseText+"\n"+"error:"+error);
						alert(xhr.status);
					}
	    	});
	}else {
		$('#deltemdiv').empty();
	}
}


//배송템플릿 유효성검사
function goodsupload_check(){
	// 스마트 에디터 유효성검사
	var gds_detail = $("#gds_detail").val();
	
	if ($.trim($("#lcate_code").val()) == "") {
		alert("대분류를 선택해 주세요");
		$("#lcate_code").val("").focus();
		return false;
	}
	if ($.trim($("#mcate_code").val()) == "") {
		alert("중분류를 선택해 주세요");
		$("#mcate_code").val("").focus();
		return false;
	}

	if ($.trim($("#gds_name").val()) == "") {
		alert("상품명을 입력해 주세요");
		$("#gds_name").val("").focus();
		return false;
	}
	if ($.trim($("#gds_price").val()) == "") {
		alert("가격을 입력해 주세요");
		$("#gds_price").val("").focus();
		return false;
	}
	if (isNaN($("#gds_price").val())) {
		alert("가격은 숫자만 입력해 주세요");
		$("#gds_price").val("").focus();
		return false;
	}
	if (($("#gds_detail").val()) == "") {
		alert("상세정보를 입력해 주세요");
		$("#gds_detail").val("").focus();
		return false;
	}
	
	 if( gds_detail == ""  || gds_detail == null || gds_detail == '&nbsp;' || gds_detail == '<p>&nbsp;</p>')  {
         alert("내용을 입력하세요.");
         oEditors.getById["gds_detail"].exec("FOCUS"); //포커싱
         return;
    }
	if ($.trim($("#opt_count").val()) == "") {
		alert("수량을 입력해 주세요");
		$("#opt_count").val("").focus();
		return false;
	}
	if (isNaN($("#opt_count").val())) {
		alert("수량은 숫자만 입력해 주세요");
		$("#opt_count").val("").focus();
		return false;
	}
	if ($.trim($("#deltem_num").val()) < 0) {
		alert("배송정보를 입력해 주세요");
		return false;
	}
	if ($.trim($("#gds_ears").val()) == "") {
		alert("교환 환불 기준을 입력해 주세요");
		$("#gds_ears").val("").focus();
		return false;
	}
}