<%@page pageEncoding="iso-8859-1" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>

<div class="table-responsive bg-dark rounded">
    <table class="table table-striped table-sm table-dark">
        <thead>
            <tr class="text-center">
                <th>MATRÍCULA</th>
                <th>ULTIMA ITV</th>
                <th>REGISTRO</th>
                <th>ACCIONES</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${cn.coches.count <= 0}">
                <tr class="table-danger">
                    <td colspan="5" class="text-center">No se ha encontrado ningún coche, <a href="${pageContext.request.contextPath}/admin/add/coche">añade uno nuevo aquí</a></td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="coche" items="${cn.coches.all}">
                    <tr class="text-center">
                        <td>${coche.matricula}</td>
                        <td>${coche.itv}</td>
                        <td>${coche.registro}</td>
                        <td>
                            <div class="btn-group" role="group" aria-label="Acciones usuarios">
                                <a type="button" class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/admin/edit/coche?matricula=${coche.matricula}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Editar coche">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/admin/delete/coche?matricula=${coche.matricula}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Eliminar coche">
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