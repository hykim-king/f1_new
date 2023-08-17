const main = {
    init: function () {
        const _this = this;
        $('#btn-save').on('click', function (e) {
            e.preventDefault();
            _this.save_upload();
        });

        $('#btn-update').on('click', function (e) {
        	const thisName = document.getElementById('thisName').value;
        	const fileName = document.getElementById('fileName');
            e.preventDefault();
            if (fileName.value == thisName.substr(18)) {
            	_this.update();
            } else {
            	_this.update_upload();
            }
        });

        $('#btn-delete').on('click', function () {
            if (confirm('정말 삭제하시겠습니까?')) {
                _this.delete();
            }
        });
        
        $('#cancelButton').on('click', function () {
        	const thisFile = document.getElementById('thisFile');
        	const uploadLabel = document.getElementById('uploadLabel');
        	
        	thisFile.style.display = 'none';
        	uploadLabel.style.display = 'block';
        	
        });
        
        $('#fileUpload').on('click', function (e) {
        	const fileUpload = document.getElementById('fileUpload');
        	fileUpload.value = '';
        });
        
        $('#fileUpload').on('change', function (e) {
        	_this.displaySelectedFile(e);
        });
        
    },
    
    displaySelectedFile : function (event) {
    	const cancelButton = document.getElementById('cancelButton');
    	const fileUpload = document.getElementById('fileUpload');
    	const uploadLabel = document.getElementById('uploadLabel');
    	const selectedName = fileUpload.files[0].name;
    	const thisFile = document.getElementById('thisFile');
    	const fileName = document.getElementById('fileName');
    	
    	const file = event.target.files[0];
    	if (file) {
    		// 파일 크기 체크 (5MB)
    		const maxSize = 5 * 1024 * 1024;
    		if (file.size > maxSize) {
    			alert('최대 5MB인 이미지만 선택 가능합니다.');
    			fileUpload.value = '';
    			return;
    		}
    		// 허용된 이미지 확장자 체크
    		const allowedExtensions = ['jpg', 'jpeg', 'png', 'bmp', 'tiff', 'webp', 'ico', 'svg'];
    		const fileExtension = file.name.split('.').pop().toLowerCase();
    		if (!allowedExtensions.includes(fileExtension)) {
    			alert('이미지 파일이 아닙니다.');
    			fileUpload.value = '';
    			return;
    		}
    		
    		const reader = new FileReader();
    		reader.readAsDataURL(file);                 // 파일을 base64로 읽기(파일명)
    		reader.onload = function() {
    			//console.log("name: "+selectedName);
    			uploadLabel.style.display = 'none';     // 파일선택 버튼 숨기기
    			cancelButton.style.display = 'block';   // 취소버튼 보이기
    			fileName.value = selectedName;
    			thisFile.style.display = 'block';
    		};
    	}
    },
    
    save_upload : function () {
    	let formData = new FormData(); // FormData 생성
    	formData.append("fileUpload", $("#fileUpload")[0].files[0]); // 파일 파트 추가
    	formData.append("idx", 1);
    	formData.append("id", $("#id").val());
    	formData.append("category", 40);
    	formData.append("name", "testname");
    	formData.append("url", "testurl");
    	formData.append("fileSize", 0);
    	formData.append("checked", 0);
    	formData.append("u1", 0);
    	formData.append("u2", 0);
    	
    	// 파일 저장
    	$.ajax({
    		type: "POST",
    		url: "/qna/fileUploaded",
    		processData: false,
    		contentType: false,
    		data: formData,
    		success: function (data) {
    			//console.log(data);
    			$("#idx").val(parseInt(data, 10));
                // 파일 업로드 성공 후에 save 함수 호출
    			main.save();
    		},
    		error: function (data) {
    			console.log(data);
    			console.error("파일 업로드 오류");
    			return;
    		},
    	});
    	
    },
    
    update_upload : function () {
    	//console.log("update_upload");
    	const thisName = document.getElementById('thisName');
    	//console.log(thisName.value);
    	$.ajax({
    		type: "GET",
    		url: "/qna/fileDelete",
    		asyn: "true",
    		dataType: "html",
    		data: {
    			name: thisName.value
    		},
    		success: function(data) { //통신 성공
    			//console.log("fileDelete success");
//    			let parsedJson = JSON.parse(data);
//    			if ("1" == parsedJson.msgId) {
//    				console.log(parsedJson.msgContents);
//    			} else {
//    				console.error(parsedJson.msgContents);
//    			}
    		},
    		error: function(data) { //실패시 처리
    			console.log(data);
    			console.error("기존파일 삭제 오류");
    		}
    	});
    	
    	let formData = new FormData(); // FormData 생성
    	formData.append("fileUpload", $("#fileUpload")[0].files[0]); // 파일 파트 추가
    	formData.append("idx", 1);
    	formData.append("id", $("#id").val());
    	formData.append("category", 40);
    	formData.append("name", "testname");
    	formData.append("url", "testurl");
    	formData.append("fileSize", 0);
    	formData.append("checked", 0);
    	formData.append("u1", 0);
    	formData.append("u2", 0);
    	
    	// 새로운 파일 저장
    	$.ajax({
    		type: "POST",
    		url: "/qna/fileUploaded",
    		processData: false,
    		contentType: false,
    		data: formData,
    		success: function (data) {
    			//console.log("fileUploaded success");
    			$("#idx").val(parseInt(data, 10));
                // 파일 업로드 성공 후에 update 함수 호출
    			main.update();
    		},
    		error: function (data) {
    			console.log(data);
    			console.error("파일 업로드 오류");
    		},
    	});
    	
    },

    save : function () {
        const data = {
            category: $('#category').val(),
            id: $('#id').val(),
            idx: $('#idx').val(),
            title: $('#title').val(),
            content: $('#content').val(),
        };

        $.ajax({
            type: 'POST',
            url: '/api/qna/save',
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(data)
        }).done(function () {
            alert('글이 등록되었습니다.');
            window.location.href = '/qna';
        }).fail(function (error) {
            alert("등록 실패했습니다.");
            console.error(error);
            // alert(JSON.stringify(error));
        });
    },

    update : function () {
        const data = {
            category: $('#category').val(),
            title: $('#title').val(),
            idx: $('#idx').val(),
            content: $('#content').val(),
        };

        const no = $('#no').val();

        $.ajax({
            type: 'PUT',
            url: '/api/qna/' + no,
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(data)
        }).done(function () {
            alert("글이 수정되었습니다.");
            window.location.href = '/qna/' + no; // 수정된 페이지로 리다이렉트
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    },

    delete: function () {
        const no = $('#no').val();

        $.ajax({
            type: 'DELETE',
            url: '/api/qna/' + no,
        }).done(function () {
            alert('글이 삭제되었습니다.');
            window.location.href = '/qna';
        }).fail(function (error) {
            alert('글 삭제 실패했습니다.');
            console.error(error);
        });
    }
};

main.init();


const answer = {

    init: function() {
        const _this = this;
        $('#btn-answer-save').on('click', function(e) {
            e.preventDefault();
            _this.save();
        });
    },

    save: function() {
        const no = $('#no').val();

        // 사용자가 입력한 답변 내용
        const answerData = {
            no: no,
            id: $('#id').val(),
            content: $('#answer-content').val()
        };

        // 답변 등록 Ajax 요청
        $.ajax({
            type: 'POST',
            url: '/api/qna/' + no + '/saveAnswer', // 답변 등록 API 엔드포인트
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(answerData),
        }).done(function() {
            alert('답변이 등록되었습니다.');
            // 답변 등록 후, 답변 목록을 다시 불러와서 화면 갱신
            window.location.href = '/qna/' + no;
        }).fail(function(error) {
            alert('답변 등록에 실패했습니다.');
            console.error(error + answerData);
        });
    },

    load: function() {
            // Ajax 요청을 통해 댓글을 불러오고 HTML에서 댓글 섹션을 업데이트
            $.get('/api/qna/' + no + '/answer', function(data) {
                // 데이터를 처리하고 HTML에서 댓글 섹션을 업데이트
                $('#answer-section').html(data);
            });
    }
};

// 초기화 함수 호출
answer.init();
