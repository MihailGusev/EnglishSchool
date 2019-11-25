<%--
  Created by IntelliJ IDEA.
  User: Mihail
  Date: 25.11.2019
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>


    <script type="text/javascript">
        function logout() {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "./logout", false);
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            xhr.send();
            location.href = "./login"
        }
    </script>

    <title>Преподавательская</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="./">Главная</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                    <security:authentication property="principal.username"/>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <div class="dropdown-item">Роль(и):
                        <security:authentication property="principal.authorities"/>
                    </div>
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

<h3>Новые заявки на доступ:</h3>

<table class="table">
    <thead class="thead-dark">
    <tr>
        <th scope="col" style="width: 5%">#</th>
        <th scope="col" nowrap="true">Email</th>
        <th scope="col" nowrap="true">Имя</th>
        <th scope="col" nowrap="true">Фамилия</th>
        <th scope="col" style="width: 10%">Действия</th>
    </tr>
    </thead>

    <tbody>
    <c:forEach var="student" items="${newStudents}" varStatus="vs">
        <tr>
            <th>${vs.count}</th>
            <td>${student.username}</td>
            <td>${student.firstName}</td>
            <td>${student.lastName}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
