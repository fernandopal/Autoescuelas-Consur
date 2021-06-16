<%--
  Created by IntelliJ IDEA.
  User: fpalm
  Date: 27/03/2021
  Time: 18:45
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>${labels.get('ADMIN', pageContext.request)} - ${labels.get('BRAND_NAME', pageContext.request)}</title>

        <!-- Custom fonts for this template-->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Titillium+Web&family=Single+Day&family=Stick&display=swap">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">

    </head>

    <body class="container py-5 darken">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb rounded">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">${labels.get('ADMIN', pageContext.request)}</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?view=tests">${labels.get('TESTS', pageContext.request)}</a></li>
                <li class="breadcrumb-item active" aria-current="page">${labels.get('ADD_NEW', pageContext.request)}</li>
            </ol>
        </nav>

        <form class="fullpage-form rounded" action="${pageContext.request.contextPath}/app/a/add/test" method="post">
            <div class="mb-3">
                <label for="nombre" class="form-label">${labels.get('NAME', pageContext.request)}</label>
                <input type="text" class="form-control" id="nombre" name="nombre" maxlength="40">
            </div>
            <div class="mb-3">
                <label for="tema" class="form-label">${labels.get('THEME', pageContext.request)}</label>
                <c:choose>
                    <c:when test="${cn.tests.allTemas.size() <= 0}">
                        <select class="form-select" aria-label="${labels.get('THEME_OF_TEST', pageContext.request)}" id="tema" name="tema" disabled>
                            <option selected>${labels.get('NO_THEMES_TO_SHOW', pageContext.request)}</option>
                        </select>
                    </c:when>
                    <c:otherwise>
                        <select class="form-select" aria-label="${labels.get('THEME_OF_TEST', pageContext.request)}" id="tema" name="tema">
                            <c:forEach var="tema" items="${cn.tests.allTemas}">
                                <option>${tema}</option>
                            </c:forEach>
                        </select>
                    </c:otherwise>
                </c:choose>
            </div>

            <div id="preguntas-test" class="rounded">
                <span class="text-danger">${labels.get('ADD_QUESTIONS_HELP', pageContext.request)}</span>
                <div class="mb-3">
                    <button class="btn btn-sm mt-1 mb-3" id="add" type="button">
                        <i class="fas fa-plus-square"></i> ${labels.get('ADD_QUESTION', pageContext.request)}
                    </button>
                </div>

                <ol id="list" class="list-group"></ol>

            </div>
            <button type="submit" class="btn btn-primary">${labels.get('SAVE', pageContext.request)}</button>
        </form>

        <!-- Bootstrap core JavaScript-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/typed.js/2.0.11/typed.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
        <script>
            $(function() {
                let add = $('#add');
                let listContainer = $('#list');

                let count = 1;

                add.on('click', function(event) {
                    event.preventDefault();

                    if(count <= 10) {
                        listContainer.append(
                            '<label for="pregunta" class="form-label">${labels.get('QUESTION', pageContext.request)} '+count+'</label>' +
                            '<div class="mb-3">' +
                            '<input class="form-control" type="text" placeholder="pregunta" name="p'+count+'" required>' +
                            '<input class="form-control mt-1" type="text" placeholder="${labels.get('QUESTION_CATEGORY', pageContext.request)}" name="p'+count+'c" required>' +
                            '<input class="form-control mt-1" type="text" placeholder="${labels.get('CORRECT_ANSWER', pageContext.request)}" name="p'+count+'r1" required>' +
                            '<input class="form-control mt-1" type="text" placeholder="${labels.get('WRONG_ANSWER', pageContext.request)}" name="p'+count+'r2" required>' +
                            '<input class="form-control mt-1" type="text" placeholder="${labels.get('WRONG_ANSWER', pageContext.request)}" name="p'+count+'r3" required>' +
                            '<input class="form-control mt-1" type="text" placeholder="${labels.get('WRONG_ANSWER', pageContext.request)}" name="p'+count+'r4" required>' +
                            '</div>'
                        );

                        count++;

                    }

                });

            });
        </script>
    </body>
</html>