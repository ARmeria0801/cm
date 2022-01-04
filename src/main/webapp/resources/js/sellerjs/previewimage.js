	function readImage(input) {
	    // input 태그에 이미지를 업로드 한 경우
	    if(input.files && input.files[0]) {
		        // FileReader 생성
		        const reader = new FileReader();
		        // 이미지가 로드가 된 경우
		        reader.onload = function(e){
		            const previewImage = document.getElementById("dummy-image");
		            previewImage.src = e.target.result;
		        }
		        // reader가 업로드된 이미지의 경로를 읽는다.
		        reader.readAsDataURL(input.files[0])
		    }
		}
		// input 태그에 change 이벤트 설정
		const inputImage = document.getElementById("gds_thumbnail1");
		inputImage.addEventListener("change", function(e){
		    readImage(e.target);
		});
	
	