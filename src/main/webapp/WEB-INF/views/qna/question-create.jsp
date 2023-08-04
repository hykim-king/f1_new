<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로드스캐너</title>
</head>
<body>
    <form>
        <div>
            <label for="category">카테고리:</label>
            <select id="category" name="category">
                <option value="30" selected>답변 대기</option>
                <option value="20">답변 완료</option>
                <option value="10">공지</option>
            </select>
        </div>
        <div>
            <label for="id">작성자:</label>
            <input type="text" id="id">
        </div>
        <div>
            <label for="title">제목:</label>
            <input type="text" id="title">
        </div>
        <div>
            <label for="idx">첨부파일:</label>
            <input type="text" id="idx">
        </div>
        <div>
            <label for="content">내용:</label>
            <textarea id="content" placeholder="내용을 입력하세요"></textarea>
        </div>
        <a href="/qna" role="button">취소</a>
        <button type="submit" id="btn-create" value="저장">등록</button>
    </form>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="/resources/js/qna.js"></script>
</body>
</html>
