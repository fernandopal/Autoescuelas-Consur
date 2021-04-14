<%@page pageEncoding="iso-8859-1" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Autoescuelas consur</title>

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
                            <a class="nav-link ${(empty param.view || param.view == 'home') ? 'text-nav-link' : ''}" aria-current="page" href="${pageContext.request.contextPath}/home">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${(param.view == 'contacto') ? 'text-nav-link' : ''}" aria-current="page" href="${pageContext.request.contextPath}/contacto">Contactanos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${(param.view == 'ofertas') ? 'text-nav-link' : ''}" aria-current="page" href="${pageContext.request.contextPath}/ofertas">Ofertas</a>
                        </li>
                    </ul>

                    <ul class="navbar-nav px-3">
                        <li class="nav-item dropdown" id="sessionDropdown">
                            <c:choose>
                                <c:when test="${sessionScope.usuario != null && sessionScope.usuario.nombre != null}">
                                    <a class="dropdown-toggle text-danger fw-bold text-nav-link text-decoration-none" href="#" role="button" data-bs-toggle="dropdown">${sessionScope.usuario.nombre} ${sessionScope.usuario.apellidos} <span class="caret"></span></a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li><a class="dropdown-item disabled text-muted text-center" href="#">Última conexión: <%=new SimpleDateFormat("dd/MM/yyyy").format(new Date(session.getCreationTime()))%></a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item enable-icon" href="${pageContext.request.contextPath}/tests">Acceso a tests</a></li>
                                        <li><a class="dropdown-item enable-icon" href="${pageContext.request.contextPath}/stats">Estadísticas</a></li>
                                        <li><a class="dropdown-item enable-icon" href="${pageContext.request.contextPath}/admin">Panel de admin</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item enable-icon" href="${pageContext.request.contextPath}/logout">Cerrar Sesión</a></li>
                                    </ul>
                                </c:when>
                                <c:otherwise>
                                    <a href="" class="dropdown-toggle text-danger fw-bold text-nav-link text-decoration-none" role="button" data-bs-toggle="dropdown">INICIAR SESIÓN</a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li>
                                            <form class="form" role="form" method="post" action="${pageContext.request.contextPath}/login" accept-charset="UTF-8" id="login-nav">
                                                <div class="form-group">
                                                    <label class="sr-only" for="username">Usuario</label>
                                                    <input type="text" class="form-control" id="username" name="username" placeholder="00000000A" pattern="^[0-9]{8,8}[A-Za-z]$" required>
                                                </div>
                                                <div class="form-group">
                                                    <label class="sr-only" for="password">Contraseña</label>
                                                    <input type="password" class="form-control" id="password" name="password" placeholder="Contraseña" required>
                                                    <a class="text-decoration-none text-danger text-nav-link" href="">He olvidado mi contraseña</a>
                                                </div>
                                                <div class="form-group mt-3">
                                                    <button type="submit" class="btn btn-danger btn-block btn-sm">Iniciar sesión</button>
                                                </div>
                                            </form>
                                        </li>
                                    </ul>
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <%-- ADMIN NAV END --%>