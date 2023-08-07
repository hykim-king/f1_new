const main = {
    init: function () {
        const _this = this;
        $('#btn-save').on('click', function (e) {
            e.preventDefault();
            _this.save();
        });

        $('#btn-update').on('click', function () {
            _this.update();
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
            window.location.href = "/qna";
        }).fail(function (error) {
            console.error(error);
            alert(JSON.stringify(error));
        });
    }
};

main.init();