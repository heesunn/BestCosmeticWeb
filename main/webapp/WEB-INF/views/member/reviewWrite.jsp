<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link href="/assets/css/star.css" rel="stylesheet"/>		
    <!-- firebase sdk -->
    <script src="https://www.gstatic.com/firebasejs/6.0.2/firebase.js"></script>
    <script src="/script.js">
    	//api key 소스보기로 볼 수 없도록 js파일로 옮겨둠
    </script> 
    <script type="text/javascript">
    	// 대표사진 스토리지Url 만들어서 value 넣기
	 	function getRealPath(obj){  
			document.getElementById('BCR_PHOTO').value = 
				'https://firebasestorage.googleapis.com/v0/b/bestcosmetic-624a1.appspot.com/o/review%2F' 
				+ $(obj).val().split('/').pop().split('\\').pop() 
				+ '?alt=media';
		}
	</script>   
    <script>    
    	function form_check(){       //firebase에 이미지 저장       	
        	// 리뷰사진 업로드
    		// get dom in variables
        	var hiddenBtn = document.getElementsByClassName('hidden-upload-btn')[0];       	
        	// get file
            var file = hiddenBtn.files[0];
            // change file name so cannot overwrite
            var name = file.name.split('.').shift() + '.' + file.name.split('.').pop();
            var type = file.type.split('/')[0];
            var path = type + '/' + name;
            // now upload
            var storageRef = firebase.storage().ref(path);
            var uploadTask = storageRef.put(file);
                        
            submit_ajax();            
        }

        function submit_ajax() {     //BC_REVIEW oracle DB에 저장
            var queryString=$("#AddForm").serialize();
            $.ajax({
            	url: '/member/upReview',  
                type: 'POST',
                data: queryString,
                dataType: 'text',
                success: function(json) {  
                	window.location.replace("/guest/goods/detailPage?BCG_KEY=${BCG_KEY}");           		               	           	
                }
            });
        }
    </script>
	<style type="text/css">
		#AddForm fieldset{
		    display: inline-block;
		    direction: rtl;
		    border:0;
		}
		#AddForm fieldset legend{
		    text-align: right;
		}
		#AddForm input[type=radio]{
		    display: none;
		}
		#AddForm label{
		    font-size: 3em;
		    color: transparent;
		    text-shadow: 0 0 0 #f0f0f0;
		}
		#AddForm label:hover{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
		}
		#AddForm label:hover ~ label{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
		}
		#AddForm input[type=radio]:checked ~ label{
		    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
		}
		#BCR_CONTENT {
		    width: 100%;
		    height: 150px;
		    padding: 10px;
		    box-sizing: border-box;
		    border: solid 1.5px #D3D3D3;
		    border-radius: 5px;
		    font-size: 16px;
		    resize: none;
		}
	</style>
</head>
<body>
	
    <h1>리뷰등록</h1>
    <form id="AddForm" method="post">
		<div>
	        <img src="${BCG_IMG}" width="100" height="100"> ${BCG_NAME}<br/>  		
		</div>
		<fieldset>
			<span class="text-bold">별점을 선택해주세요</span>
			<!-- 라디오 선택 안하면 0점인거 체크해야함 -->
			<input type="radio" name="BCR_SCORE" value="5" id="rate1"><label
				for="rate1">★</label>
			<input type="radio" name="BCR_SCORE" value="4" id="rate2"><label
				for="rate2">★</label>
			<input type="radio" name="BCR_SCORE" value="3" id="rate3"><label
				for="rate3">★</label>
			<input type="radio" name="BCR_SCORE" value="2" id="rate4"><label
				for="rate4">★</label>
			<input type="radio" name="BCR_SCORE" value="1" id="rate5"><label
				for="rate5">★</label>
		</fieldset>
		<div>
			리뷰 사진을 등록해주세요<br/>      	
			<input type="file" class="hidden-upload-btn" onchange="javascript:getRealPath(this);">
	    	<input type="hidden" id="BCR_PHOTO" name="BCR_PHOTO"><br/>      			         	                          
			<textarea class="col-auto form-control" type="text" id="BCR_CONTENT" name="BCR_CONTENT"
					  placeholder="리뷰 내용을 입력해주세요"></textarea>
			<input type="hidden" id="BCG_KEY" name="BCG_KEY" value="${BCG_KEY}">   
       		<input type="hidden" id="BCG_NAME" name="BCG_NAME" value="${BCG_NAME}">           
       		<input type="hidden" id="BCM_NUM" name="BCM_NUM" value="${BCM_NUM}">           
       		<input type="hidden" id="BCM_NAME" name="BCM_NAME" value="${BCM_NAME}">           
       		<input type="button" value="등록" onclick="form_check()">
		</div>
    </form>
</body>
</html>
