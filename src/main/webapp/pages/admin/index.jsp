<%--
  Created by IntelliJ IDEA.
  User: fpalm
  Date: 22/03/2021
  Time: 21:00
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="ISO-8859-1" contentType="text/html; charset=UTF-8" %>
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

        <!-- JS that needs to be loaded first -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.0.2/chart.min.js"></script>

    </head>

    <body>
    <div class="page-wrapper toggled">
        <a id="show-sidebar" class="btn btn-sm btn-dark" href="#">
            <i class="fas fa-bars"></i>
        </a>
        <nav id="sidebar" class="sidebar-wrapper">
            <div class="sidebar-content">
                <div class="sidebar-brand">
                    <span>${labels.get('ADMINISTRATION', pageContext.request)}</span>
                    <div id="close-sidebar"><i class="fas fa-times"></i></div>
                </div>
                <div class="sidebar-menu">
                    <ul>
                        <li class="header-menu"><span>General</span></li>
                        <li class="enable-hover ${empty param.view || param.view == 'dashboard' ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/admin?view=dashboard">
                                <i class="fa fa-home"></i>
                                <span>${labels.get('HOME', pageContext.request)}</span>
                            </a>
                        </li>

                        <li class="header-menu"><span>Gestión</span></li>
                        <li class="enable-hover ${param.view == 'usuarios' ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/admin?view=usuarios">
                                <i class="fa fa-user-alt"></i>
                                <span>${labels.get('USERS', pageContext.request)}</span>
                                <span class="badge rounded-pill bg-secondary">${cn.usuarios.count}</span>
                            </a>
                        </li>
                        <li class="enable-hover ${param.view == 'temas' ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/admin?view=temas">
                                <i class="fas fa-book"></i>
                                <span>${labels.get('THEMES', pageContext.request)}</span>
                                <span class="badge rounded-pill bg-secondary">${cn.tests.allTemas.size()}</span>
                            </a>
                        </li>
                        <li class="enable-hover ${param.view == 'tests' ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/admin?view=tests">
                                <i class="far fa-file-alt"></i>
                                <span>${labels.get('TESTS', pageContext.request)}</span>
                                <span class="badge rounded-pill bg-secondary">${cn.tests.count}</span>
                            </a>
                        </li>
                        <li class="enable-hover ${param.view == 'coches' ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/admin?view=coches">
                                <i class="fas fa-car"></i>
                                <span>${labels.get('CARS', pageContext.request)}</span>
                                <span class="badge rounded-pill bg-secondary">${cn.coches.count}</span>
                            </a>
                        </li>
                        <li class="enable-hover ${param.view == 'ofertas' ? 'active' : ''}">
                            <a href="${pageContext.request.contextPath}/admin?view=ofertas">
                                <i class="fas fa-tags"></i>
                                <span>${labels.get('OFFERS', pageContext.request)}</span>
                                <span class="badge rounded-pill bg-secondary">${cn.ofertas.count}</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- sidebar-wrapper  -->
        <main class="page-content">
            <div class="container-fluid">
                <c:if test="${!empty message}">
                    <div class="alert ${empty error ? "alert-secondary" : "alert-danger"} m-3 alert-dismissible fade show" role="alert">
                            ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${not empty param.view}">
                        <c:choose>
                            <c:when test="${param.view == 'dashboard'}">
                                <jsp:include page="/app/a/fragments/dashboard"/>
                            </c:when>
                            <c:when test="${param.view == 'usuarios'}">
                                <jsp:include page="/app/a/fragments/usuarios"/>
                            </c:when>
                            <c:when test="${param.view == 'temas'}">
                                <jsp:include page="/app/a/fragments/temas"/>
                            </c:when>
                            <c:when test="${param.view == 'tests'}">
                                <jsp:include page="/app/a/fragments/tests"/>
                            </c:when>
                            <c:when test="${param.view == 'coches'}">
                                <jsp:include page="/app/a/fragments/coches"/>
                            </c:when>
                            <c:when test="${param.view == 'ofertas'}">
                                <jsp:include page="/app/a/fragments/ofertas"/>
                            </c:when>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <jsp:include page="/app/a/fragments/dashboard"/>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
        <!-- page-content" -->
    </div>

        <!-- Bootstrap core JavaScript-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/typed.js/2.0.11/typed.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>

    </body>
</html>
