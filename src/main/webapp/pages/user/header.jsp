<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>${labels.get('BRAND_NAME', pageContext.request)}</title>

        <meta name="description" content="Autoescuelas consur">
        <meta name="viewport" content="width=device-width">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/img/logo1.png" />

        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Titillium+Web&family=Single+Day&family=Stick&display=swap">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">

        <!-- JS that need to be laoded first -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    <body class="min-vh-100">
        <%-- ADMIN NAV --%>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand text-danger" href="${pageContext.request.contextPath}/home">
                    <img src="${pageContext.request.contextPath}/assets/img/logo1.png" alt="" height="50" class="d-inline-block align-middle">
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link ${(empty param.view || param.view == 'home') ? 'text-nav-link' : ''}" aria-current="page" href="${pageContext.request.contextPath}/home">${labels.get('HOME', pageContext.request)}</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${(param.view == 'contacto') ? 'text-nav-link' : ''}" aria-current="page" href="${pageContext.request.contextPath}/contacto">${labels.get('CONTACT', pageContext.request)}</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${(param.view == 'ofertas') ? 'text-nav-link' : ''}" aria-current="page" href="${pageContext.request.contextPath}/ofertas">${labels.get('OFFERS', pageContext.request)}</a>
                        </li>
                    </ul>

                    <ul class="navbar-nav px-3">
                        <li class="nav-item dropdown" id="sessionDropdown">
                            <c:choose>
                                <c:when test="${sessionScope.usuario != null && sessionScope.usuario.nombre != null}">
                                    <a class="dropdown-toggle text-danger fw-bold text-nav-link text-decoration-none" href="#" role="button" data-bs-toggle="dropdown">${sessionScope.usuario.nombre} ${sessionScope.usuario.apellidos} <span class="caret"></span></a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li><a class="dropdown-item disabled text-muted text-center" href="#">${labels.get('LAST_LOGIN', pageContext.request)} <%=new SimpleDateFormat("dd/MM/yyyy").format(new Date(session.getCreationTime()))%></a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item enable-icon" href="${pageContext.request.contextPath}/tests">${labels.get('ACCESS_TESTS', pageContext.request)}</a></li>
                                            <%--                                        <li><a class="dropdown-item enable-icon" href="${pageContext.request.contextPath}../error/404">${labels.get('STATS', pageContext.request)}</a></li>--%>
                                        <li><a class="dropdown-item enable-icon" href="${pageContext.request.contextPath}/test-history">${labels.get('TEST_HISTORY', pageContext.request)}</a></li>
                                        <li><a class="dropdown-item enable-icon" href="${pageContext.request.contextPath}/admin">${labels.get('ADMIN_PANEL', pageContext.request)}</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item enable-icon" href="${pageContext.request.contextPath}/logout">${labels.get('LOG_OUT', pageContext.request)}</a></li>
                                    </ul>
                                </c:when>
                                <c:otherwise>
                                    <a href="" class="dropdown-toggle text-danger fw-bold text-nav-link text-decoration-none" role="button" data-bs-toggle="dropdown">${labels.get('LOG_IN', pageContext.request)}</a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li>
                                            <form class="form" role="form" method="post" action="${pageContext.request.contextPath}/login" accept-charset="UTF-8" id="login-nav">
                                                <div class="form-group">
                                                    <label class="sr-only" for="username">${labels.get('USER', pageContext.request)}</label>
                                                    <input type="text" class="form-control" id="username" name="username" placeholder="${labels.get('DNI_PLACEHOLDER', pageContext.request)}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label class="sr-only" for="password">${labels.get('PASSWORD', pageContext.request)}</label>
                                                    <input type="password" class="form-control" id="password" name="password" placeholder="${labels.get('PASSWORD', pageContext.request)}" required>
                                                    <a class="text-decoration-none text-danger text-nav-link" href="">${labels.get('LOST_PASSWORD', pageContext.request)}</a>
                                                </div>
                                                <div class="form-group mt-3">
                                                    <button type="submit" id="submit" class="btn btn-danger btn-block btn-sm" disabled>${labels.get('LOG_IN', pageContext.request)}</button>
                                                </div>
                                            </form>
                                        </li>
                                    </ul>
                                    <script>
                                        $().ready(function () {
                                            let input = document.getElementById('username');
                                            let submit = document.getElementById('submit');

                                            input.addEventListener('input', function() {
                                                let dni = input.value;
                                                let checkFormato = (/^\d{8}[a-zA-Z]$/.test(dni));
                                                let valido = false;

                                                if(checkFormato) {
                                                    let letraDni = dni.substring(8, 9).toUpperCase();
                                                    let numerosDni = parseInt(dni.substring(0, 8));

                                                    let letras = ['T', 'R', 'W', 'A', 'G', 'M', 'Y', 'F', 'P', 'D', 'X', 'B', 'N', 'J', 'Z', 'S', 'Q', 'V', 'H', 'L', 'C', 'K', 'E', 'T'];
                                                    let checkLetra = (letras[numerosDni % 23] === letraDni);

                                                    valido = checkLetra;
                                                }
                                                submit.disabled = !valido;
                                            }, false);
                                        });
                                    </script>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <%-- ADMIN NAV END --%>