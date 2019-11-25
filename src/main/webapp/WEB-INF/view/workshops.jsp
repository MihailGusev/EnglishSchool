<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <title>Практика</title>
</head>

<body>

<!-- display user name and role -->
<%--<p>--%>
<%--    Пользователь: <security:authentication property="principal.username"/>--%>
<%--    <form:form action="${pageContext.request.contextPath}/logout"--%>
<%--               method="POST">--%>
<%--        <input type="submit" value="Выход" class="btn btn-primary"/>--%>
<%--    </form:form>--%>
<%--    Роль(и): <security:authentication property="principal.authorities"/>--%>
<%--    <br><br>--%>
<%--    Имя: ${user.firstName}, Фамилия: ${user.lastName}--%>
<%--</p>--%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="./">Главная</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <security:authentication property="principal.username"/>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <div class="dropdown-item">Роль(и): <security:authentication property="principal.authorities"/></div>
                    <div class="dropdown-item">Имя: ${user.firstName}, Фамилия: ${user.lastName}</div>
                    <div class="dropdown-divider"></div>
                    <div class="dropdown-item">
                        <input type="button" value="Выход" class="btn btn-primary" onclick="logout()"/>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</nav>

<hr>

<h3>Список практикумов</h3>

<form action="${pageContext.request.contextPath}/questions" method="get">
    <table class="table">
        <thead class="thead-dark">
        <tr>
            <th scope="col" style="width: 5%">#</th>
            <th scope="col" style="text-align: center">Пояснения</th>
            <th scope="col" style="width: 10%" nowrap="true">Список вопросов</th>
            <security:authorize access="hasAnyRole('TEACHER','ADMIN')">
                <th scope="col" style="width: 10%">Действия</th>
            </security:authorize>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="workshop" items="${workshops}" varStatus="vs">
            <tr>
                <th>${vs.count}</th>
                <td>
                    <button class="btn btn-info" type="button" data-toggle="collapse" data-target="#collapseExplanations" aria-expanded="false" aria-controls="collapseExplanations" style="width: 100%">
                        Читать
                    </button>
                    <div class="collapse" id="collapseExplanations">
                        <div class="card card-body">
                                ${workshop.explanations}
                        </div>
                    </div>
                </td>
                <td nowrap="true">
                    <button type="submit"
                            name="workshopIdGet"
                            value="${workshop.id}"
                            class="btn btn-info">
                        Список <span class="badge badge-light">${workshop.questions.size()}</span>
                    </button>
                </td>
                <security:authorize access="hasAnyRole('TEACHER','ADMIN')">
                    <td>
                        <div class="btn-group" role="group" aria-label="Basic example">
                            <button type="submit"
                                    name="workshopIdEdit"
                                    value="${workshop.id}"
                                    class="btn btn-warning">Редактировать
                            </button>
                            <button type="submit"
                                    name="workshopIdDelete"
                                    value="${workshop.id}"
                                    class="btn btn-danger">Удалить
                            </button>
                        </div>
                    </td>
                </security:authorize>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</form>

<security:authorize access="hasAnyRole('TEACHER','ADMIN')">
    <input type="button" class="btn btn-success" value="Добавить практикум">
</security:authorize>

<%--<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>

</html>









