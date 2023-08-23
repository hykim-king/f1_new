const main = {
    init: function () {
        const _this = this;
        $('#btn-save').on('click', function (e) {
            e.preventDefault();
            _this.save();
        });

        $('#btn-update').on('click', function (e) {
            e.preventDefault();
            _this.update();
        });

        $('#btn-delete').on('click', function () {
            if (confirm('정말 삭제하시겠습니까?')) {
                _this.delete();
            }
        });

        // 이미지 미리보기
        // $('#attachFile').on('change', function(e) {
        //     const file = e.target.files[0];
        //     const reader = new FileReader();
        //
        //     reader.onload = function(e) {
        //         $('#preview-image').attr('src', e.target.result); // src 속성 설정
        //         $('#preview-image').css('display', 'block'); // 미리보기 이미지 보이기
        //     };
        //
        //     reader.readAsDataURL(file);
        // });

        // 이미지 삭제
        $('#btn-remove-file').on('click', function(e) {
            e.preventDefault(); // 기본 동작을 막습니다.
            $('#attachFile').val(''); // 파일 입력 필드를 초기화합니다.
            // $('#preview-image').attr('src', ''); // 미리보기 이미지 URL 초기화
            // $('#preview-image').css('display', 'none'); // 미리보기 이미지 숨기기

            // Bootstrap의 파일 입력 초기화
            // $('.custom-file-label').text(''); // 파일 이름을 초기화
        });



        $('#btn-delete-selected').on('click', function () {
            // console.log('select button clicked');
            if (confirm('선택한 항목을 삭제하시겠습니까?')) {
                const checkedItems = $('.delete-checkbox:checked');
                    const totalItems = checkedItems.length;
                    let deletedItems = 0;


                checkedItems.each(function(index) {
                    const no = $(this).val();
                    _this.deleteItem(no, function() {
                        deletedItems++;
                        if (deletedItems === totalItems) {
                            alert('선택한 항목이 삭제되었습니다.');
                            window.location.reload();
                        }
                    });
                });
            }
        });

        $('#select-all').on('click', function() {
            // #select-all이 체크되면 모든 .delete-checkbox의 상태를 #select-all과 동일하게 설정
            $('.delete-checkbox').prop('checked', $(this).prop('checked'));
            showDeleteBtn();
        });

        $('.delete-checkbox').on('change', function() {
            showDeleteBtn();
        });

        // 페이지 로드시 체크박스 선택 상태에 따른 버튼 표시 상태 초기화
        showDeleteBtn();

    },

    save: function () {
        if (!validateForm()) return; // 검증 실패 시 함수 종료

        const data = new FormData();
        data.append('category', $('#category').val());
        data.append('id', $('#id').val());
        data.append('title', $('#title').val());
        data.append('content', $('#content').val());

        const file = $('#attachFile')[0].files[0];
        if (file) { // 파일이 존재하는 경우에만 추가
            data.append('attachFile', file);
        }
        
        $.ajax({
            type: 'POST',
            enctype: 'multipart/form-data', // 이 부분 추가
            url: '/api/qna/save',
            processData: false,
            contentType: false,
            data: data
        }).done(function () {
            alert('글이 등록되었습니다.');
            window.location.href = '/qna';
        }).fail(function (error) {
            const errors = error.responseJSON; // 서버에서 전달된 에러메시지
            alert("등록 실패했습니다.");
            // 제목 오류 메시지 처리

            if (errors.title) { // 'error'가 아닌 'errors'를 사용
                $('#title').addClass('field-error'); // input 필드에 클래스 추가
                $('#title-error').text(errors.title).addClass('field-error');
            }

            // 내용 오류 메시지 처리
            if (errors.content) {
                $('#content').addClass('field-error');
                $('#content-error').text(errors.content).addClass('field-error');
            }

            // 이미지 파일 오류 메시지 처리
            if (errors.attachFile) {
                $('#attachFile').addClass('field-error');
                $('#attachFile-error').text(errors.attachFile).addClass('field-error');
            }
        })
        console.error(error);
    },

    update : function () {

        if (!validateForm()) return; // 검증 실패 시 함수 종료

        const data = new FormData();
        data.append('no', $('#no').val());
        data.append('category', $('#category').val());
        data.append('id', $('#id').val());
        data.append('title', $('#title').val());
        data.append('content', $('#content').val());

        const file = $('#attachFile')[0].files[0];
        if (file) { // 파일이 존재하는 경우에만 추가
            data.append('attachFile', file);
        }

        const no = $('#no').val();

        $.ajax({
            type: 'POST',
            enctype:'multipart/form-data',
            url: '/api/qna/' + no,
            processData: false,
            contentType: false,
            data: data
        }).done(function () {
            alert("글이 수정되었습니다.");
            window.location.href = '/qna/' + no; // 수정된 페이지로 리다이렉트
        }).fail(function (error) {
            alert("수정 실패했습니다.");
            const responseJSON = JSON.parse(error.responseText);
            responseJSON.forEach(function (errorMessage) {
                alert(errorMessage);
            });
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
    },

    deleteItem: function (no, callback) {
        $.ajax({
            type: 'DELETE',
            url: '/api/qna/' + no,
        }).done(function () {
            if (callback) callback();
        }).fail(function (error) {
            alert('삭제에 실패했습니다.');
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

        $('#btn-answer-delete').on('click', function() {
            // console.log('click delete');
           if (confirm('정말 삭제하시겠습니까?')) {
               _this.delete();
           }
        });


        $('#btn-answer-update-form').on('click', function(e) {
            // console.log('click update-form');
            e.preventDefault();
            $('#answer-update-form').css('display', 'block');
            $('#answer-detail').css('display', 'none');
        });


        $('#btn-answer-updated').on('click', function(e) {
            // console.log('click update');
            e.preventDefault();
            _this.update();
        });

    },

    save : function() {
        const no = $('#no').val();

        // 사용자가 입력한 답변 내용
        const answerData = {
            no: no,
            id: $('#id').val(),
            content: $('#answer-content').val()
        };

        // 입력 내용 검사
        if (!answerData.content) {
            alert('답변 내용을 입력해주세요.');
            $('#answer-content').focus(); // 커서를 답변 내용 입력 필드로 이동
            return;
        }

        // 답변 등록 Ajax 요청
        $.ajax({
            type: 'POST',
            url: '/api/qna/' + no + '/answer', // 답변 등록 API 엔드포인트
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(answerData),
        }).done(function() {
            alert('답변이 등록되었습니다.');
            // 답변 등록 후, 답변을 다시 불러와서 화면 갱신
            window.location.href = '/qna/' + no;
        }).fail(function(error) {
            alert('답변 등록에 실패했습니다.');
            console.error(error + answerData);

            // .fail(function(jqXHR) {
            //     var response = JSON.parse(jqXHR.responseText);
            //     alert(response.message); // 서버에서 보낸 메시지를 표시
            // })
        });
    },


    delete : function(){
        const no = $('#no').val();

        $.ajax({
            type: 'DELETE',
            url: '/api/qna/' + no + '/answer',
        }).done(function () {
            alert('답변이 삭제되었습니다.');
            window.location.href = '/qna/' + no;
        }).fail(function (error) {
            alert('답변 삭제에 실패했습니다.');
            console.error(error);
        });
    },

    update : function () {
        const no = $('#no').val();

        const answerData = {
            content: $('#answer-update-content').val()
        };

        // 입력 내용 검사
        if (!answerData.content) {
            alert('답변 내용을 입력해주세요.');
            $('#answer-update-content').focus(); // 커서를 답변 내용 입력 필드로 이동
            return;
        }

        // 답변 등록 Ajax 요청
        $.ajax({
            type: 'PUT',
            url: '/api/qna/' + no + '/answer', // 답변 등록 API 엔드포인트
            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(answerData),
        }).done(function() {
            alert('답변이 수정되었습니다.');
            // 답변 수정 후, 답변을 다시 불러와서 화면 갱신
            window.location.href = '/qna/' + no;
        }).fail(function(error) {
            alert('답변 수정에 실패했습니다.');
            console.error(error + answerData);
        });
    }

};

// 초기화 함수 호출
// main.init();
answer.init();

function validateForm() {
    // 제목 길이 검증
    const title = $('#title').val();
    if (title.length > 15) {
        alert('제목은 15글자 이하여야 합니다.');
        $('#title').focus(); // 제목 입력 필드에 포커스
        return false;
    }

    // 제목과 내용이 비어있는지 검증
    const content = $('#content').val();
    if (!title) {
        alert('제목은 필수입니다.');
        $('#title').focus(); // 제목 입력 필드에 포커스
        return false;
    }

    if (!content) {
        alert('내용은 필수입니다.');
        $('#content').focus(); // 내용 입력 필드에 포커스
        return false;
    }

    // 이미지 파일 검증
    const file = $('#attachFile')[0].files[0];
    if (file) {
        if (!file.type.match('image.*')) {
            alert('유효한 이미지 파일만 업로드할 수 있습니다.');
            $('#attachFile').focus(); // 파일 입력 필드에 포커스
            return false;
        }

        // 파일 크기 검증 (5MB 이하)
        const fileSizeMB = file.size / (1024 * 1024);
        if (fileSizeMB > 5) {
            alert('파일 크기는 5MB 이하여야 합니다.');
            $('#attachFile').focus(); // 파일 입력 필드에 포커스
            return false;
        }
    }

    return true;
}

function showDeleteBtn() {
     if ($('.delete-checkbox:checked').length > 0) {
         $('#btn-delete-selected').show();
     } else {
         $('#btn-delete-selected').hide();
     }
 }
