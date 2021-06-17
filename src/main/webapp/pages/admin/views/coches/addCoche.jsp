<%--
  Created by IntelliJ IDEA.
  User: fpalm
  Date: 17/06/2021
  Time: 00:23
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?view=tests">${labels.get('CARS', pageContext.request)}</a></li>
                <li class="breadcrumb-item active" aria-current="page">${labels.get('ADD_NEW', pageContext.request)}</li>
            </ol>
        </nav>

        <form class="fullpage-form rounded" action="${pageContext.request.contextPath}/app/a/add/coche" method="post">
            <div class="mb-3">
                <label for="matricula" class="form-label">${labels.get('CAR_LICENSE_PLATE', pageContext.request)}</label>
                <input type="text" class="form-control" id="matricula" name="matricula" placeholder="1234-ABC" pattern="^[0-9]{1,4}-[BCDFGHJKLMNPRSTVWXYZ]{3}">
            </div>
            <div class="mb-3">
                <label for="fecha-itv" class="form-label">${labels.get('LATEST_ITV', pageContext.request)}</label>
                <input type="date" class="form-control" id="fecha-itv" name="fecha-itv" min="1900-01-01">
            </div>
            <div class="mb-3">
                <label for="fecha-reg" class="form-label">${labels.get('REGISTER', pageContext.request)}</label>
                <input type="date" class="form-control" id="fecha-reg" name="fecha-reg" min="1900-01-01">
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