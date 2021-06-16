<%--
  Created by IntelliJ IDEA.
  User: fpalm
  Date: 27/03/2021
  Time: 18:45
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="es.fernandopal.autoescuela.entities.Rango" %>
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?view=usuarios">${labels.get('USERS', pageContext.request)}</a></li>
                <li class="breadcrumb-item active" aria-current="page">${labels.get('ADD_NEW', pageContext.request)}</li>
            </ol>
        </nav>

        <form class="fullpage-form rounded" action="${pageContext.request.contextPath}/app/a/add/usuario" method="post">
            <div class="mb-3">
                <label for="dni" class="form-label">${labels.get('UPP_DNI', pageContext.request)}</label>
                <input type="text" class="form-control" id="dni" name="dni" maxlength="9" pattern="^[0-9]{8,8}[A-Za-z]$">
            </div>
            <div class="mb-3 row g-3">
                <div class="col">
                    <label for="nombre" class="form-label">${labels.get('NAME', pageContext.request)}</label>
                    <input type="text" class="form-control" id="nombre" name="nombre">
                </div>
                <div class="col">
                    <label for="apellidos" class="form-label">${labels.get('SURNAME', pageContext.request)}</label>
                    <input type="text" class="form-control" id="apellidos" name="apellidos">
                </div>
            </div>
            <div class="mb-3">
                <label for="tlf" class="form-label">${labels.get('PHONE_NUMBER', pageContext.request)}</label>
                <input type="tel" class="form-control" id="tlf" name="tlf">
            </div>
            <div class="mb-3">
                <label for="rango" class="form-label">${labels.get('THEME', pageContext.request)}</label>
                <select class="form-select" aria-label="${labels.get('USER_RANK', pageContext.request)}" id="rango" name="rango">
                    <c:set var="rangos" value="<%=Rango.values()%>"/>
                    <c:forEach var="rango" items="${rangos}">
                        <option>${rango.name()}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">${labels.get('SAVE', pageContext.request)}</button>
        </form>

        <!-- Bootstrap core JavaScript-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/typed.js/2.0.11/typed.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>

    </body>
</html>