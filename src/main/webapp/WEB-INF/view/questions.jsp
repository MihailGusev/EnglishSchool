<%--
  Created by IntelliJ IDEA.
  User: Mihail
  Date: 20.11.2019
  Time: 18:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <script src="https://kit.fontawesome.com/55ce58b0c0.js" crossorigin="anonymous"></script>

    <script type="text/javascript">
        function getTextFromTextBox(id) {
            return document.getElementById(id).value;
        }
    </script>

    <script type="text/javascript">
        function checkForMistakes(input, answer, id, event) {

            if (event.keyCode != 13 && event !== 13)
                return;
            $("#success-fail-alert" + id).removeClass('d-none');

            let i_old = document.getElementById("success-fail-icon" + id);
            let i_new = document.createElement('i');
            i_new.id = "success-fail-icon" + id;

            // const contractions = [
            //     ['aren\'t', 'are not'],
            //     ['i\'m', 'i am'],
            //     ['that\'s', 'that is'],
            //     ['can\'t', 'can not'],
            //     ['didn\'t', 'did not'],
            //     ['don\'t', 'do not'],
            //     ['he\'ll', 'he will'],
            //     ['i\'ve', 'i have'],
            //     ['isn\'t', 'is not'],
            //     ['let\'s', 'let us'],
            //     ['she\'ll', 'she will'],
            //     ['there\'s', 'there is'],
            //     ['we\'re', 'we are'],
            //     ['what\'s', 'what is'],
            //     ['you\'ll', 'you will'],
            // ];
            // var questionContractions=[];
            // var answerVariations=[];
            // answerVariations.push(answer.toLowerCase());
            // for (var i=0;i<contractions.length;i++){
            //     for (var j=0;j<contractions[i].length;j++) {
            //         var index=0;
            //         while (true){
            //
            //             index=answer.indexOf(contractions[i][j],index);
            //                 break;
            //             index=
            //         }
            //     }
            // }


            if (input === answer) {
                document.getElementById(id).setAttribute("disabled","true");
                document.getElementById("button-addon2"+id).setAttribute("disabled","true");
                i_new.className = "fas fa-check-circle";
                $("#success-fail-alert" + id)
                    .addClass('alert-success')
                    .removeClass('alert-danger');
                addAnsweredQuestion(id);
            } else {
                i_new.className = "fas fa-times-circle";
                $("#success-fail-alert" + id)
                    .addClass('alert-danger')
                    .removeClass('alert-success');
            }
            i_old.parentNode.replaceChild(i_new, i_old);
        }
    </script>

    <script>
        function addAnsweredQuestion(id) {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "./addAnsweredQuestion?id=" + id, false);
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            xhr.send();
        }
    </script>

    <script type="text/javascript">
        function deleteQuestion(questionId) {
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "./deleteQuestion?questionId=" + questionId, false);
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            xhr.send();
            location.reload();
        }
    </script>

    <script type="text/javascript">
        function editQuestion(questionId) {
            const xhr = new XMLHttpRequest();
            const english = document.getElementById("english-field" + questionId).value;
            const russian = document.getElementById("russian-field" + questionId).value;
            xhr.open("POST", "./editQuestion?questionId=" + questionId
                + "&english=" + english + "&russian=" + russian, false);
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            xhr.send();
            document.getElementById("td-english" + questionId).innerText = english;
            document.getElementById("td-russian" + questionId).innerText = russian;
        }
    </script>

    <script type="text/javascript">
        function addQuestion() {
            const xhr = new XMLHttpRequest();
            const english = document.getElementById("english-field-add").value;
            const russian = document.getElementById("russian-field-add").value;
            xhr.open("POST", "./addQuestion?workshopId=" + ${workshop.id}
                +"&english=" + english + "&russian=" + russian, false);
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

    <title>Список вопросов</title>
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

<div class="jumbotron">
    <h2 class="display-6">Практикум №${workshop.id}</h2>
    <p>${workshop.explanations}</p>
</div>
<br>

<table class="table">
    <thead class="thead-dark">
    <tr>
        <th scope="col" style="width: 5%">#</th>
        <th scope="col">Предложение</th>

        <security:authorize access="hasAnyRole('STUDENT','MODERATOR')">
            <th scope="col">Ваш ответ</th>
            <th scope="col" style="width: 7%">Результат</th>
        </security:authorize>

        <security:authorize access="hasAnyRole('TEACHER','ADMIN')">
            <th scope="col">Перевод</th>
        </security:authorize>

        <security:authorize access="hasAnyRole('MODERATOR','TEACHER','ADMIN')">
            <th scope="col" style="width: 10%">Действия</th>
        </security:authorize>
    </tr>

    </thead>


    <tbody>
    <c:forEach var="question" items="${workshop.questions}" varStatus="vs">
        <tr>
            <th scope="row">${vs.count}</th>
            <td id="td-russian${question.id}">${question.russian}</td>
            <security:authorize access="hasAnyRole('STUDENT','MODERATOR')">

                <td>
                    <form action="${pageContext.request.contextPath}/questions" method="post">
                        <div class="input-group mb-3">
                            <input id="${question.id}" type="text" class="form-control" placeholder="Ответ"
                            <c:if test="${answeredQuestionsIds.contains(question.id)}">
                                   value="${question.english}" disabled
                            </c:if>
                                   aria-describedby="button-addon2"
                                   onkeyup="checkForMistakes(getTextFromTextBox(${question.id}),'${question.english}',${question.id},event)">

                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary" type="button" id="button-addon2${question.id}"
                                        onclick="checkForMistakes(getTextFromTextBox(${question.id}),'${question.english}',${question.id},13)"
                                        <c:if test="${answeredQuestionsIds.contains(question.id)}">
                                            disabled
                                        </c:if>>
                                    Проверить
                                </button>
                            </div>
                        </div>
                    </form>
                </td>

                <td>
                    <div id="success-fail-alert${question.id}" role="alert"
                            <c:choose>
                                <c:when test="${answeredQuestionsIds.contains(question.id)}">
                                    class="alert alert-success"
                                </c:when>
                                <c:otherwise>
                                    class="alert d-none"
                                </c:otherwise>
                            </c:choose>>
                        <i id="success-fail-icon${question.id}" class="fas fa-check-circle"></i>
                    </div>
                </td>
            </security:authorize>

            <security:authorize access="hasAnyRole('TEACHER','ADMIN')">
                <td id="td-english${question.id}">${question.english}</td>
            </security:authorize>

            <security:authorize access="hasAnyRole('MODERATOR','TEACHER','ADMIN')">
                <td>

                    <div class="btn-group" role="group" aria-label="Basic example">
                        <button type="button" class="btn btn-warning" data-toggle="modal"
                                data-target="#editQuestionModal${question.id}">Редактировать
                        </button>
                        <button type="button" class="btn btn-danger" data-toggle="modal"
                                data-target="#deleteQuestionModal${question.id}">Удалить
                        </button>
                    </div>

                    <div class="modal fade" id="editQuestionModal${question.id}" tabindex="-1" role="dialog"
                         aria-labelledby="editQuestionModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editQuestionModalLabel">Редактирование вопроса №${vs.count}</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form>
                                        <div class="form-group">
                                            <label for="russian-field${question.id}"
                                                   class="col-form-label">Русский:</label>
                                            <input type="text" class="form-control" id="russian-field${question.id}"
                                                   value="${question.russian}"/>
                                        </div>
                                        <div class="form-group">
                                            <label for="english-field${question.id}"
                                                   class="col-form-label">Английский:</label>
                                            <input type="text" class="form-control" id="english-field${question.id}"
                                                   value="${question.english}"/>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
                                    <button type="button" class="btn btn-warning" data-dismiss="modal"
                                            onclick="editQuestion(${question.id})">Сохранить изменения
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="deleteQuestionModal${question.id}" tabindex="-1" role="dialog"
                         aria-labelledby="deleteQuestionModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Удалить вопрос №${vs.count}?</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form>
                                        <div class="form-group">
                                            <label class="col-form-label">Английский: ${question.english}</label>
                                            <br>
                                            <label class="col-form-label">Русский: ${question.russian}</label>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Нет
                                    </button>
                                    <button type="button" class="btn btn-danger"
                                            onclick="deleteQuestion(${question.id})">Да
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

<security:authorize access="hasAnyRole('MODERATOR','TEACHER','ADMIN')">
    <button type="button" class="btn btn-success" data-toggle="modal"
            data-target="#addQuestionModal">Добавить вопрос
    </button>

    <div class="modal fade" id="addQuestionModal" tabindex="-1" role="dialog"
         aria-labelledby="addQuestionModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addQuestionModalLabel">Добавление нового вопроса в практикум
                        №${workshop.id}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="russian-field-add" class="col-form-label">Русский:</label>
                            <input type="text" class="form-control" id="russian-field-add"/>
                        </div>
                        <div class="form-group">
                            <label for="english-field-add" class="col-form-label">Английский:</label>
                            <input type="text" class="form-control" id="english-field-add"/>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Отмена</button>
                    <button type="button" class="btn btn-warning" data-dismiss="modal" onclick="addQuestion()">Сохранить
                        изменения
                    </button>
                </div>
            </div>
        </div>
    </div>
</security:authorize>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
</body>
</html>


