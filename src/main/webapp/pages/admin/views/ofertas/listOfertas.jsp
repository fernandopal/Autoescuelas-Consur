<%@ page import="es.fernandopal.autoescuela.controller.OfertaJpaController" %>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>
<jsp:useBean id="pagination" class="es.fernandopal.autoescuela.entities.Pagination"/>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>

<%
    final OfertaJpaController ofertaJpaController = cn.getOfertas();

    final int numeroRegistros = ofertaJpaController.getCount();
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
    <a class="btn btn-sm" target="_blank" href="${pageContext.request.contextPath}/admin/add/oferta">
        <i class="fas fa-plus"></i> ${labels.get('ADD_OFFER', pageContext.request)}
    </a>
    <a class="btn btn-sm" target="_blank" href="${pageContext.request.contextPath}/admin/print/ofertas">
        <i class="fas fa-print"></i> ${labels.get('OPEN_PRINT_VIEW', pageContext.request)}
    </a>
</div>

<div class="table-responsive bg-dark rounded">
    <table class="table table-striped table-sm table-dark">
        <thead>
            <tr class="text-center">
                <th>${labels.get('UPP_ID', pageContext.request)}</th>
                <th>${labels.get('UPP_NAME', pageContext.request)}</th>
                <th>${labels.get('UPP_TYPE', pageContext.request)}</th>
                <th>${labels.get('UPP_DESCRIPTION', pageContext.request)}</th>
                <th>${labels.get('UPP_PRICE', pageContext.request)}</th>
                <th>${labels.get('UPP_ACTIONS', pageContext.request)}</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${numeroRegistros <= 0}">
                    <tr class="table-danger">
                        <td colspan="6" class="text-center">${labels.get('NO_OFFERS_TO_SHOW', pageContext.request)}</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="oferta" items="${cn.ofertas.paginate(pagination)}">
                        <tr class="text-center">
                            <td>${oferta.id}</td>
                            <td>${oferta.nombre}</td>
                            <td>${oferta.tipo}</td>
                            <td>${oferta.descripcion}</td>
                            <td>${oferta.precio}</td>
                            <td>
                                <div class="btn-group" role="group" aria-label="${labels.get('OFFER_ACTIONS', pageContext.request)}">
<%--                                    <a type="button" target="_blank" class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/admin/edit/oferta?id=${oferta.id}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${labels.get('EDIT_OFFER', pageContext.request)}">--%>
<%--                                        <i class="fas fa-edit"></i>--%>
<%--                                    </a>--%>
                                    <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/app/a/delete/oferta?id=${oferta.id}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${labels.get('DELETE_OFFER', pageContext.request)}">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <tr>
                <td colspan="6" class="text-center">
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