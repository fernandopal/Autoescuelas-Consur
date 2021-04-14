<%--
  Created by IntelliJ IDEA.
  User: fpalm
  Date: 01/04/2021
  Time: 17:23
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="iso-8859-1" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Admin - Consur Autoescuelas</title>

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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Admin</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?view=tests">Tests</a></li>
                <li class="breadcrumb-item active" aria-current="page">Editar</li>
            </ol>
        </nav>

        <c:set var="test" value="${cn.tests.findTest(param.id)}" />

        <form class="fullpage-form rounded" action="${pageContext.request.contextPath}/app/a/edit/test" method="post" id="form">
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" maxlength="40" value="${test.nombre}">
            </div>
            <div class="mb-3">
                <label for="tema" class="form-label">Tema</label>
                <c:choose>
                    <c:when test="${cn.tests.allTemas.size() <= 0}">
                        <select class="form-select" aria-label="Tema al que pertenece el test" id="tema" name="tema" disabled>
                            <option selected>Aún no se ha añadido ningún tema</option>
                        </select>
                    </c:when>
                    <c:otherwise>
                        <select class="form-select" aria-label="Tema al que pertenece el test" id="tema" name="tema">
                            <c:forEach var="tema" items="${cn.tests.allTemas}">
                                <option ${test.tema == tema ? 'selected' : ''}>${tema}</option>
                            </c:forEach>
                        </select>
                    </c:otherwise>
                </c:choose>
            </div>

            <div id="preguntas-test" class="rounded">
                <span class="text-danger">Introduce las preguntas que tendrá el test (máximo 10)</span>
                <div class="mb-3">
                    <button class="btn btn-sm mt-1 mb-3" id="add" type="button">
                        <i class="fas fa-plus-square"></i> Añadir pregunta
                    </button>
                </div>

                <ol id="list" class="list-group"></ol>

            </div>
            <button type="submit" class="btn btn-primary" id="send">Guardar</button>
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
                            '<label for="pregunta" class="form-label">Pregunta '+count+'</label>' +
                            '<div class="mb-3">' +
                            '<input class="form-control" type="text" placeholder="pregunta" name="p'+count+'">' +
                            '<input class="form-control mt-1" type="text" placeholder="Respuesta 1 (correcta)" name="p'+count+'r1">' +
                            '<input class="form-control mt-1" type="text" placeholder="Respuesta 2" name="p'+count+'r2">' +
                            '<input class="form-control mt-1" type="text" placeholder="Respuesta 3" name="p'+count+'r3">' +
                            '<input class="form-control mt-1" type="text" placeholder="Respuesta 4" name="p'+count+'r4">' +
                            '</div>'
                        );

                        count++;

                    }

                });

            });
        </script>

    </body>
</html>