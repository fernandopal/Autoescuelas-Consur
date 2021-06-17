<%--
  Created by IntelliJ IDEA.
  User: fpalm
  Date: 21/04/2021
  Time: 14:19
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?view=ofertas">${labels.get('OFFERS', pageContext.request)}</a></li>
                <li class="breadcrumb-item active" aria-current="page">${labels.get('ADD_NEW', pageContext.request)}</li>
            </ol>
        </nav>

        <form class="fullpage-form rounded" action="${pageContext.request.contextPath}/app/a/add/oferta" method="post">
            <div class="mb-3 row g-3">
                <div class="col-lg-11 col-sm-12">
                    <label for="nombre" class="form-label">${labels.get('NAME', pageContext.request)}</label>
                    <input type="text" class="form-control" id="nombre" name="nombre">
                </div>
                <div class="col-lg-1 col-sm-12">
                    <label for="precio" class="form-label">${labels.get('PRICE', pageContext.request)}</label>
                    <input type="number" class="form-control" id="precio" name="precio">
                </div>
            </div>
            <div class="mb-3">
                <label for="tipo" class="form-label">${labels.get('TYPE', pageContext.request)}</label>
                <select class="form-select" aria-label="${labels.get('OFFER_TYPE', pageContext.request)}" id="tipo" name="tipo">
                    <c:forEach var="tipo" items="${cn.ofertas.allTypes}">
                        <option>${tipo}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label for="desc" class="form-label">${labels.get('DESCRIPTION', pageContext.request)}</label>
                <textarea class="form-control" id="desc" name="desc" rows="3" maxlength="200" aria-describedby="descHelp"></textarea>
                <div id="descHelp" class="form-text">
                    ${labels.get('DESC_CHARS_LEFT_TEXT', pageContext.request).replace('{used_chars}', '<span id="charLimit"></span>').replace('{max_chars}', '<span id="showMax"></span>')}
                </div>
            </div>
            <button type="submit" class="btn btn-primary">${labels.get('SAVE', pageContext.request)}</button>
        </form>

        <!-- Bootstrap core JavaScript-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/typed.js/2.0.11/typed.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
        <script>
            $().ready(function () {
                let charLimit = document.getElementById('charLimit');
                let showMax = document.getElementById('showMax');
                let textarea = document.getElementById('desc');
                let maxChars = 200;

                showMax.innerHTML = maxChars.toString();
                charLimit.innerHTML = maxChars.toString();
                charLimit.style.color = '#198754';

                textarea.addEventListener('input', function() {
                    let txtLength = textarea.value.length;

                    if (txtLength > 150) {
                        charLimit.style.color = '#dc3545'

                    } else if (txtLength > 100 && txtLength < 150) {
                        charLimit.style.color = '#ffc107'

                    } else if (txtLength > 150) {
                        charLimit.style.color = '#198754';

                    }

                    if (txtLength > 200) {
                        textarea.value = textarea.value.substring(0, maxChars);

                    } else {
                        charLimit.innerHTML = (maxChars - txtLength).toString();

                    }

                }, false);

            });
        </script>
    </body>
</html>