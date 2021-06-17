<%@ page import="es.fernandopal.autoescuela.controller.IntentoJpaController" %><%--
  Created by IntelliJ IDEA.
  User: fpalm
  Date: 18/03/2021
  Time: 13:07
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>
<jsp:useBean id="pagination" class="es.fernandopal.autoescuela.entities.Pagination"/>
<jsp:include page="/app/u/fragments/header?view=offs"/>

<%
    final IntentoJpaController intentoJpaController = cn.getIntentos();

    final int numeroRegistros = intentoJpaController.getAll().size();
    int maxPages = ((numeroRegistros > pagination.getMaxResults()) ? ((numeroRegistros % pagination.getMaxResults()) - 1) : 0);

    session.setAttribute("maxPages", maxPages);

    //Paginación
    if(request.getParameter("page") != null) {
        int cpn = Integer.parseInt(request.getParameter("page"));
        cpn = cpn >= maxPages ? maxPages : Math.max(cpn, 0);
        pagination.setPage(cpn);
    }
%>

<%----%>
<main class="p-3">
    <div class="container">
        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">${sessionScope.usuario.dni}</a></li>
                <li class="breadcrumb-item active" aria-current="page">${labels.get('TEST', pageContext.request)}</li>
            </ol>
        </nav>
    </div>

    <div class="container-fluid" id="doTestsSection">
        <div class="row">
            <div class="col">
                <table class="table table-striped table-sm table-dark">
                    <thead>
                    <tr class="text-center">
                        <th>FECHA</th>
                        <th>APROBADO</th>
                        <th>ACIERTOS</th>
                        <th>TEST</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${numeroRegistros <= 0}">
                            <tr class="table-danger">
                                <td colspan="4" class="text-center">No hay intentos, realiza algún test</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="intento" items="${cn.intentos.all}">
                                <tr class="text-center">
                                    <td>${intento.fecha}</td>
                                    <td>${intento.aprobado}</td>
                                    <td>${intento.aciertos}</td>
                                    <td>${intento.test.nombre}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    <tr>
                        <td colspan="4" class="text-center">
                            <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.requestURI}?view=coches&page=${empty param.page ? pagination.page : param.page <= 0 ? 0 : param.page - 1}&filter=${filter}">
                                <i class="fas fa-caret-left"></i>
                            </a>
                            <span>&nbsp;&nbsp; ${pagination.page}/${maxPages} &nbsp;&nbsp;</span>
                            <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.requestURI}?view=coches&page=${empty param.page ? pagination.page : param.page >= maxPages ? maxPages : param.page + 1}&filter=${filter}">
                                <i class="fas fa-caret-right"></i>
                            </a>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>
<%----%>