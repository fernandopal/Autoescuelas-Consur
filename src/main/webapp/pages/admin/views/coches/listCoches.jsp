<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>
<jsp:useBean id="pagination" class="es.fernandopal.autoescuela.entities.Pagination"/>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>

<div class="toolbar rounded">
    <a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/add/coche">
        <i class="fas fa-plus"></i> A�adir coche
    </a>
    <a class="btn btn-sm" target="_blank" href="${pageContext.request.contextPath}/admin/print/coches">
        <i class="fas fa-print"></i> Abrir vista de impresi�n
    </a>
</div>

<div class="table-responsive bg-dark rounded">
    <div class="toolbar rounded darken p-3">
        <a class="btn btn-sm ${empty param.filterBy ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin?view=coches">borrar filtros</a>
        <a class="btn btn-sm ${param.filterBy == 0 ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin?view=coches&filterBy=0">mostrar disponibles</a>
        <a class="btn btn-sm ${param.filterBy == 1 ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin?view=coches&filterBy=1">mostrar en uso</a>
        <a class="btn btn-sm ${param.filterBy == 2 ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin?view=coches&filterBy=2">mostrar en taller</a>
    </div>
    <table class="table table-striped table-sm table-dark">
        <thead>
            <tr class="text-center">
                <th>MATR�CULA</th>
                <th>ULTIMA ITV</th>
                <th>REGISTRO</th>
                <th>ACCIONES</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${cn.coches.count <= 0}">
                <tr class="table-danger">
                    <td colspan="5" class="text-center">No se ha encontrado ning�n coche, <a href="${pageContext.request.contextPath}/admin/add/coche">a�ade uno nuevo aqu�</a></td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="coche" items="${empty param.filterBy ? cn.coches.all : cn.coches.getCochesByEstado(param.filterBy == 0 ? 'DISPONIBLE' : param.filterBy == 1 ? 'EN_USO' : 'EN_TALLER')}">
                    <tr class="text-center">
                        <td class="${coche.estado == 'DISPONIBLE' ? 'text-success' : coche.estado == 'EN_USO' ? 'text-warning' : 'text-danger'}">${coche.matricula}</td>
                        <td>${coche.itv}</td>
                        <td>${coche.registro}</td>
                        <td>
                            <div class="btn-group" role="group" aria-label="Acciones usuarios">
                                <a type="button" class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/admin/edit/coche?matricula=${coche.matricula}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Editar coche">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/app/a/delete/coche?matricula=${coche.matricula}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Eliminar coche">
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