<%@page pageEncoding="iso-8859-1" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>

<div class="toolbar rounded">
    <a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/add/oferta">
        <i class="fas fa-plus"></i> Añadir oferta
    </a>
</div>

<div class="table-responsive bg-dark rounded">
    <table class="table table-striped table-sm table-dark">
        <thead>
            <tr class="text-center">
                <th>ID</th>
                <th>NOMBRE</th>
                <th>TIPO</th>
                <th>DESCRIPCIÓN</th>
                <th>PRECIO</th>
                <th>ACCIONES</th>
            </tr>
        </thead>
        <tbody>
        <c:choose>
            <c:when test="${cn.ofertas.count <= 0}">
                <tr class="table-danger">
                    <td colspan="6" class="text-center">No se ha encontrado ninguna oferta, <a href="${pageContext.request.contextPath}/admin/add/oferta">añade una nueva aquí</a></td>
                </tr>
            </c:when>
            <c:otherwise>
                <c:forEach var="oferta" items="${cn.ofertas.all}">
                    <tr class="text-center">
                        <td>${oferta.id}</td>
                        <td>${oferta.nombre}</td>
                        <td>${oferta.tipo}</td>
                        <td>${oferta.descripcion}</td>
                        <td>${oferta.precio}</td>
                        <td>
                            <div class="btn-group" role="group" aria-label="Acciones usuarios">
                                <a type="button" class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/admin/edit/offer?id=${oferta.id}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Editar oferta">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/admin/delete/offer?id=${oferta.id}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Eliminar oferta">
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