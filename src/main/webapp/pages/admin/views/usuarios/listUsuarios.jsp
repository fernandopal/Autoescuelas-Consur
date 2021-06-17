<%@ page import="es.fernandopal.autoescuela.controller.UsuarioJpaController" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>
<jsp:useBean id="pagination" class="es.fernandopal.autoescuela.entities.Pagination"/>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>

<%
    final UsuarioJpaController usuarioJpaController = cn.getUsuarios();
    final String filter = request.getParameter("filter");

    final int numeroRegistros = usuarioJpaController.getCount();
    int maxPages = ((numeroRegistros > pagination.getMaxResults()) ? ((numeroRegistros % pagination.getMaxResults()) - 1) : 0);

    session.setAttribute("filter", filter == null || filter.isEmpty() ? null : Integer.parseInt(filter));
    session.setAttribute("maxPages", maxPages);

    //Paginación
    if(request.getParameter("page") != null) {
        int cpn = Integer.parseInt(request.getParameter("page"));
        cpn = cpn >= maxPages ? maxPages : Math.max(cpn, 0);
        pagination.setPage(cpn);
    }
%>

<div class="toolbar rounded">
    <a class="btn btn-sm" target="_blank" href="${pageContext.request.contextPath}/admin/add/usuario">
        <i class="fas fa-plus"></i> ${labels.get('NEW_USER', pageContext.request)}
    </a>
    <a class="btn btn-sm" target="_blank" href="${pageContext.request.contextPath}/admin/print/usuarios">
        <i class="fas fa-print"></i> ${labels.get('OPEN_PRINT_VIEW', pageContext.request)}
    </a>
</div>

<div class="table-responsive bg-dark rounded">
    <div class="toolbar rounded darken p-3">
        <a class="btn btn-sm ${filter == null ? 'disabled' : ''}" href="${pageContext.request.requestURI}?view=usuarios">${labels.get('CLEAR_FILTERS', pageContext.request)}</a>
        <a class="btn btn-sm ${filter == 0 ? 'disabled' : ''}" href="${pageContext.request.requestURI}?view=usuarios&filter=0">${labels.get('SHOW_ADMINISTRATORS', pageContext.request)}</a>
        <a class="btn btn-sm ${filter == 1 ? 'disabled' : ''}" href="${pageContext.request.requestURI}?view=usuarios&filter=1">${labels.get('SHOW_TEACHERS', pageContext.request)}</a>
        <a class="btn btn-sm ${filter == 2 ? 'disabled' : ''}" href="${pageContext.request.requestURI}?view=usuarios&filter=2">${labels.get('SHOW_STUDENTS', pageContext.request)}</a>
    </div>
    <table class="table table-striped table-sm table-dark">
        <thead>
            <tr class="text-center">
                <th>${labels.get('UPP_DNI', pageContext.request)}</th>
                <th>${labels.get('UPP_NAME', pageContext.request)}</th>
                <th>${labels.get('UPP_PHONE', pageContext.request)}</th>
                <th>${labels.get('UPP_RANK', pageContext.request)}</th>
                <th>${labels.get('UPP_ACTIONS', pageContext.request)}</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${numeroRegistros <= 0}">
                    <tr class="table-danger">
                        <td colspan="5" class="text-center">${labels.get('NO_USERS_TO_SHOW', pageContext.request)}</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="user" items="${filter != null ? cn.usuarios.getByRango((filter == 0 ? 'ADMIN' : filter == 1 ? 'PROFESOR' : 'ALUMNO'), pagination) : cn.usuarios.paginate(pagination)}">
                        <tr class="text-center">
                            <td>${user.dni}</td>
                            <td>${user.apellidos}, ${user.nombre}</td>
                            <td>${user.telefono}</td>
                            <td>${user.rango}</td>
                            <td>
                                <div class="btn-group" role="group" aria-label="${labels.get('USER_ACTIONS', pageContext.request)}">
<%--                                    <a type="button" target="_blank" class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/admin/edit/usuario?dni=${user.dni}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${labels.get('EDIT_USER', pageContext.request)}">--%>
<%--                                        <i class="fas fa-edit"></i>--%>
<%--                                    </a>--%>
                                    <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/app/a/delete/usuario?dni=${user.dni}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${labels.get('DELETE_USER', pageContext.request)}">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <tr>
                <td colspan="5" class="text-center">
                    <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.requestURI}?view=usuarios&page=${empty param.page ? pagination.page : param.page <= 0 ? 0 : param.page - 1}&filter=${filter}">
                        <i class="fas fa-caret-left"></i>
                    </a>
                    <span>&nbsp;&nbsp; ${pagination.page}/${maxPages} &nbsp;&nbsp;</span>
                    <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.requestURI}?view=usuarios&page=${empty param.page ? pagination.page : param.page >= maxPages ? maxPages : param.page + 1}&filter=${filter}">
                        <i class="fas fa-caret-right"></i>
                    </a>
                </td>
            </tr>
        </tbody>
    </table>
</div>