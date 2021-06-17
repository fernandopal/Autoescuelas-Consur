<%@ page import="es.fernandopal.autoescuela.controller.TestJpaController" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>
<jsp:useBean id="pagination" class="es.fernandopal.autoescuela.entities.Pagination"/>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>

<%
    final TestJpaController testJpaController = cn.getTests();

    final int numeroRegistros = testJpaController.getCount();
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
    <a class="btn btn-sm" target="_blank" href="${pageContext.request.contextPath}/admin/add/test">
        <i class="fas fa-plus"></i> ${labels.get('NEW_TEST', pageContext.request)}
    </a>
    <a class="btn btn-sm" target="_blank" href="${pageContext.request.contextPath}/admin/print/tests">
        <i class="fas fa-print"></i> ${labels.get('OPEN_PRINT_VIEW', pageContext.request)}
    </a>
</div>

<div class="table-responsive bg-dark rounded">
    <table class="table table-striped table-sm table-dark">
        <thead>
            <tr class="text-center">
                <th>${labels.get('UPP_ID', pageContext.request)}</th>
                <th>${labels.get('UPP_NAME', pageContext.request)}</th>
                <th>${labels.get('UPP_THEME', pageContext.request)}</th>
                <th>${labels.get('UPP_ACTIONS', pageContext.request)}</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${numeroRegistros <= 0}">
                    <tr class="table-danger">
                        <td colspan="4" class="text-center">${labels.get('NO_TESTS_TO_SHOW', pageContext.request)}</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="test" items="${cn.tests.paginate(pagination)}">
                        <tr class="text-center">
                            <td>${test.id}</td>
                            <td>${test.nombre}</td>
                            <td>${labels.get('THEME', pageContext.request)} ${test.tema}</td>
                            <td>
                                <div class="btn-group" role="group" aria-label="${labels.get('TEST_ACTIONS', pageContext.request)}">
                                    <a type="button" target="_blank" class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/admin/edit/test?id=${test.id}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${labels.get('EDIT_TEST', pageContext.request)}">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/app/a/delete/test?id=${test.id}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${labels.get('DELETE_TEST', pageContext.request)}">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <tr>
                <td colspan="4" class="text-center">
                    <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.requestURI}?view=tests&page=${empty param.page ? pagination.page : param.page <= 0 ? 0 : param.page - 1}">
                        <i class="fas fa-caret-left"></i>
                    </a>
                    <span>&nbsp;&nbsp; ${pagination.page}/${maxPages} &nbsp;&nbsp;</span>
                    <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.requestURI}?view=tests&page=${empty param.page ? pagination.page : param.page >= maxPages ? maxPages : param.page + 1}">
                        <i class="fas fa-caret-right"></i>
                    </a>
                </td>
            </tr>
        </tbody>
    </table>
</div>