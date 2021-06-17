<%@ page import="es.fernandopal.autoescuela.controller.TestJpaController" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>
<jsp:useBean id="pagination" class="es.fernandopal.autoescuela.entities.Pagination"/>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>

<%
    final TestJpaController testJpaController = cn.getTests();

    final int numeroRegistros = testJpaController.getAllTemas().size();
    int maxPages = ((numeroRegistros > pagination.getMaxResults()) ? ((numeroRegistros % pagination.getMaxResults()) - 1) : 0);

    session.setAttribute("maxPages", maxPages);

    //Paginación
    if(request.getParameter("page") != null) {
        int cpn = Integer.parseInt(request.getParameter("page"));
        cpn = cpn >= maxPages ? maxPages : Math.max(cpn, 0);
        pagination.setPage(cpn);
    }
%>

<div class="toolbar rounded">
    <button class="btn btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#addTemaDropdown" aria-expanded="false" aria-controls="addTemaDropdown">
        <i class="fas fa-plus"></i> ${labels.get('NEW_THEME', pageContext.request)}
    </button>
    <a class="btn btn-sm" target="_blank" href="${pageContext.request.contextPath}/admin/print/temas">
        <i class="fas fa-print"></i> ${labels.get('OPEN_PRINT_VIEW', pageContext.request)}
    </a>
    <div class="collapse rounded" id="addTemaDropdown">
        <form class="fullpage-form" action="${pageContext.request.contextPath}/app/a/add/tema" method="post">
            <div class="row">
                <div class="col-sm-9 col-xl-11">
                    <input type="number" class="form-control" id="tema" name="tema" placeholder="${labels.get('INSERT_THEME_NUMBER', pageContext.request)}">
                </div>
                <div class="col-sm-3 col-xl-1">
                    <button type="submit" class="btn w-100 mt-auto">${labels.get('SAVE', pageContext.request)}</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="table-responsive bg-dark rounded">
    <table class="table table-striped table-sm table-dark">
        <thead>
            <tr class="text-center">
                <th>${labels.get('UPP_THEME', pageContext.request)}</th>
                <th>${labels.get('UPP_ACTIONS', pageContext.request)}</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${numeroRegistros <= 0}">
                    <tr class="table-danger">
                        <td colspan="2" class="text-center">${labels.get('NO_THEMES_TO_SHOW', pageContext.request)}</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="tema" items="${cn.tests.getAllTemas(pagination)}">
                        <tr class="text-center">
                            <td>${labels.get('THEME', pageContext.request)} ${tema}</td>
                            <td>
                                <div class="btn-group" role="group" aria-label="${labels.get('THEME_ACTIONS', pageContext.request)}">
                                    <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/app/a/delete/tema?tema=${tema}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${labels.get('DELETE_THEME', pageContext.request)}">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <tr>
                <td colspan="2" class="text-center">
                    <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.requestURI}?view=temas&page=${empty param.page ? pagination.page : param.page <= 0 ? 0 : param.page - 1}">
                        <i class="fas fa-caret-left"></i>
                    </a>
                    <span>&nbsp;&nbsp; ${pagination.page}/${maxPages} &nbsp;&nbsp;</span>
                    <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.requestURI}?view=temas&page=${empty param.page ? ((maxPages > 0) ? 1 : 0) : ((param.page >= maxPages) ? maxPages : param.page + 1)}">
                        <i class="fas fa-caret-right"></i>
                    </a>
                </td>
            </tr>
        </tbody>
    </table>
</div>