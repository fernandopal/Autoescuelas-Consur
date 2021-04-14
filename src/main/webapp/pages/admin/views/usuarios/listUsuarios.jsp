<%@page pageEncoding="iso-8859-1" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>

<div class="toolbar rounded">
    <a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/add/usuario">
        <i class="fas fa-plus"></i> Nuevo Usuario
    </a>
</div>

<div class="table-responsive bg-dark rounded">
    <table class="table table-striped table-sm table-dark">
        <thead>
            <tr class="text-center">
                <th>DNI</th>
                <th>NOMBRE</th>
                <th>TELÉFONO</th>
                <th>RANGO</th>
                <th>ACCIONES</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${cn.usuarios.count <= 0}">
                <tr class="table-danger">
                    <td colspan="5" class="text-center">No se ha encontrado ningún usuario</td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="user" items="${cn.usuarios.all}">
                    <tr class="text-center">
                        <td>${user.dni}</td>
                        <td>${user.apellidos}, ${user.nombre}</td>
                        <td>${user.telefono}</td>
                        <td>${user.rango}</td>
                        <td>
                            <div class="btn-group" role="group" aria-label="Acciones usuarios">
                                <a type="button" class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/app/a/delete/usuario?dni=${user.dni}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Editar usuario">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/app/a/delete/usuario?dni=${user.dni}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Eliminar usuario">
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