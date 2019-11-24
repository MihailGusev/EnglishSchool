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
            i_new.className = "fas fa-check-circle";
            if (input === answer) {
                i_new.className = "fas fa-check-circle";
                $("#success-fail-alert" + id)
                    .addClass('alert-success')
                    .removeClass('alert-danger');
                searchViaAjax(id);
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
        function searchViaAjax(id) {
            var csrfHeaderName = "X-CSRF-TOKEN";
            var csrfTokenValue;

            var metaTags = document.getElementsByTagName('meta');
            for(var i = 0; i < metaTags.length; i++) {
                var metaTagName = metaTags[i].getAttribute("name");
                if(metaTagName === "_csrf_header")
                    csrfHeaderName = metaTags[i].getAttribute("content");
                if(metaTagName === "_csrf")
                    csrfTokenValue = metaTags[i].getAttribute("content");
            }

            var xhr = new XMLHttpRequest();
            xhr.open("POST", "./addAnsweredQuestion?id=" + id, false);
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
            xhr.send();
            //
            //
            //
            // $.ajax({
            //
            //     type : "POST",
            //     url : "./addAnsweredQuestion",
            //     data : {id:id},
            //     timeout : 100000,
            //     beforeSend:function(xhr){xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);},
            //     success : function(id) {
            //         alert("success");
            //         console.log("SUCCESS: ", id);
            //         display(id);
            //         alert(response);
            //     },
            //     error : function(e) {
            //         alert("error");
            //         console.log("ERROR: ", e);
            //         display(e);
            //     },
            //     done : function(e) {
            //         alert("done");
            //         console.log("DONE");
            //     }
            // });
        }
    </script>

    <title>Список вопросов</title>
</head>
<body>
<%--<button onclick="searchViaAjax(1)">Ajax</button>--%>
<p>
    Пользователь: <security:authentication property="principal.username"/>
    <form:form action="${pageContext.request.contextPath}/logout"
               method="POST">
        <input type="submit" value="Выход" class="btn btn-primary"/>
    </form:form>
    Роль(и): <security:authentication property="principal.authorities"/>
    <br><br>
    Имя: ${user.firstName}, Фамилия: ${user.lastName}
</p>

<h3>Практикум №${workshop.id}</h3>
<h4>Пояснения:</h4>
${workshop.explanations}
<br>
<br>

<form action="${pageContext.request.contextPath}/questions" method="get">
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
                <th scope="col">Действия</th>
            </security:authorize>
        </tr>

        </thead>


        <tbody>
        <c:forEach var="question" items="${workshop.questions}" varStatus="vs">
            <tr>
                <th scope="row">${vs.count}</th>
                <td>${question.russian}</td>
                <security:authorize access="hasAnyRole('STUDENT','MODERATOR')">

                    <td>
                        <form action="${pageContext.request.contextPath}/questions" method="post">
                            <div class="input-group mb-3">
                                <input id="${question.id}" type="text" class="form-control" placeholder="Ответ"
                                <c:if test="${answeredQuestionsIds.contains(question.id)}">
                                       value="${question.english}"
                                </c:if>
                                       aria-describedby="button-addon2"
                                       onkeyup="checkForMistakes(getTextFromTextBox(${question.id}),'${question.english}',${question.id},event)">

                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="button" id="button-addon2"
                                            onclick="checkForMistakes(getTextFromTextBox(${question.id}),'${question.english}',${question.id},13)">
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
                    <td>
                            ${question.russian}
                    </td>
                </security:authorize>

                <security:authorize access="hasAnyRole('MODERATOR','TEACHER','ADMIN')">
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

<security:authorize access="hasAnyRole('MODERATOR','TEACHER','ADMIN')">
    <input type="button" class="btn btn-success" value="Добавить вопрос">
</security:authorize>

<%--<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"--%>
<%--        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"--%>
<%--        crossorigin="anonymous"></script>--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
</body>
</html>


