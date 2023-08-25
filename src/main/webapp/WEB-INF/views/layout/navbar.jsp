<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav id="font-id" class="navbar navbar-expand-md mb-4" style="background-color: white;">
    <div class="container-fluid">
        <a class="navbar-brand roadscanner" href="${CP}/main">RoadScanner</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <ul class="navbar-nav me-auto mb-md-0">
                <c:if test="${user ne null}">
                    <li class="nav-item">
                        <a class="nav-link" href="${CP}/main/preUpload">사진 업로드</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${CP}/qna">게시판</a>
                    </li>
                </c:if>
                <c:if test="${user.grade == 2}">
                    <li class="nav-item dropdown">
                        <input type="hidden" id="nekeyword" name="nekeyword" value ="${user.id}">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">관리자 기능</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${CP}/admin">List</a></li>
                            <li><a class="dropdown-item" href="${CP}/imgManagement">Image Management</a></li>
                            <li><a class="dropdown-item" href="${CP}/graph">graph</a></li>
                        </ul>
                    </li>
                </c:if>
            </ul>
            <form class="d-flex" role="search">
                <!-- 로그인 세션 X -->
                <c:if test="${user eq null}">
                    <button type="button" class="btn btn-sm btn-outline-secondary me-2" id="login" onclick="location.href='${CP}/login'" >Login</button>
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='${CP}/registerpage'" style="margin-right: 50px;">Sign-up</button>
                </c:if>
                <!-- 로그인 세션 O -->
                <c:if test="${user ne null}">
                    <button type="button" class="btn btn-sm btn-outline-secondary me-2" onclick="location.href='${CP}/mypage'">MyPage</button>
                    <button type="button" class="btn btn-sm btn-outline-secondary" onclick="location.href='${CP}/logout'" style="margin-right: 50px;">LogOut</button>
                </c:if>
            </form>
        </div>
    </div>
</nav>