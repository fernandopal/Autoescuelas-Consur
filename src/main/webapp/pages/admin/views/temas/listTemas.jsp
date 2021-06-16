<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>
<jsp:useBean id="pagination" class="es.fernandopal.autoescuela.entities.Pagination"/>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>

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
                <c:when test="${cn.tests.allTemas.size() <= 0}">
                    <tr class="table-danger">
                        <td colspan="5" class="text-center">${labels.get('NO_THEMES_TO_SHOW', pageContext.request)}</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="tema" items="${cn.tests.allTemas}">
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
        </tbody>
    </table>
</div>