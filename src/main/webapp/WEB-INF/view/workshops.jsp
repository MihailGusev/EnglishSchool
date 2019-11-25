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

    <script type="text/javascript">
        function deleteWorkshop(workshopId) {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "./deleteWorkshop?workshopId=" + workshopId, false);
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            xhr.send();
            location.reload();
        }
    </script>

    <script type="text/javascript">
        function editWorkshop(workshopId) {
            const xhr = new XMLHttpRequest();
            const explanations = document.getElementById("explanations" + workshopId).value;
            xhr.open("POST", "./editWorkshop?workshopId=" + workshopId
                + "&explanations=" + explanations, false);
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            xhr.send();
            document.getElementById("card" + workshopId).innerText = explanations;
        }
    </script>

    <script type="text/javascript">
        function addWorkshop() {
            const xhr = new XMLHttpRequest();
            const explanations = document.getElementById("explanations-add").value;
            xhr.open("POST", "./addWorkshop?explanations=" + explanations, false);
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            xhr.send();
            location.reload();
        }
    </script>

    <script type="text/javascript">
        function logout() {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "./logout", false);
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            xhr.send();
            location.href = "./login"
        }
    </script>


    <title>Практика</title>
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
                    <div class="dropdown-item">Роль(и): <security:authentication
                            property="principal.authorities"/></div>
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
            <th scope="col" style="text-align: center">Объяснения</th>
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
                    <button class="btn btn-info" type="button" data-toggle="collapse"
                            data-target="#collapseExplanations${workshop.id}" aria-expanded="false"
                            aria-controls="collapseExplanations" style="width: 100%">
                        Читать
                    </button>
                    <div class="collapse" id="collapseExplanations${workshop.id}">
                        <div class="card card-body" id="card${workshop.id}">
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
                            <button type="button" class="btn btn-warning" data-toggle="modal"
                                    data-target="#editWorkshopModal${workshop.id}">Редактировать
                            </button>
                            <button type="button" class="btn btn-danger" data-toggle="modal"
                                    data-target="#deleteWorkshopModal${workshop.id}">Удалить
                            </button>
                        </div>

                        <div class="modal fade bd-example-modal-lg" id="editWorkshopModal${workshop.id}" tabindex="-1" role="dialog"
                             aria-labelledby="editWorkshopModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg modal-dialog-scrollable" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editWorkshopModalLabel">Редактирование практикума
                                            №${vs.count}</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <label for="explanations${workshop.id}"
                                               class="col-form-label">Объяснения:</label>
                                        <textarea class="form-control" style="height: 200px"
                                                  id="explanations${workshop.id}">${workshop.explanations}</textarea>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена
                                        </button>
                                        <button type="button" class="btn btn-warning" data-dismiss="modal"
                                                onclick="editWorkshop(${workshop.id})">Сохранить изменения
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade" id="deleteWorkshopModal${workshop.id}" tabindex="-1" role="dialog"
                             aria-labelledby="deleteWorkshopModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="deleteWorkshopModalLabel">Удалить практикум №${vs.count}?</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form>
                                            <div class="form-group">
                                                <label class="col-form-label">Объяснения: ${workshop.explanations}</label>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Нет
                                        </button>
                                        <button type="button" class="btn btn-danger"
                                                onclick="deleteWorkshop(${workshop.id})">Да
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </security:authorize>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</form>

<security:authorize access="hasAnyRole('TEACHER','ADMIN')">
    <button type="button" class="btn btn-success" data-toggle="modal"
            data-target="#addWorkshopModal">Добавить практикум
    </button>

    <div class="modal fade" id="addWorkshopModal" tabindex="-1" role="dialog"
         aria-labelledby="addWorkshopModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addWorkshopModalLabel">Добавление нового практикума</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <label for="explanations-add"
                           class="col-form-label">Объяснения:</label>
                    <textarea class="form-control" style="height: 200px"
                              id="explanations-add"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-warning" data-dismiss="modal" onclick="addWorkshop()">Сохранить
                        изменения
                    </button>
                </div>
            </div>
        </div>
    </div>
</security:authorize>

<%--<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
</body>

</html>









