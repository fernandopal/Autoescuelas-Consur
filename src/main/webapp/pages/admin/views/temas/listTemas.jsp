<%@page pageEncoding="iso-8859-1" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>

<div class="toolbar rounded">
    <button class="btn btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#addTemaDropdown" aria-expanded="false" aria-controls="addTemaDropdown">
        <i class="fas fa-plus"></i> Nuevo Tema
    </button>
    <div class="collapse rounded" id="addTemaDropdown">
        <form class="fullpage-form" action="${pageContext.request.contextPath}/app/a/add/tema" method="post">
            <div class="row">
                <div class="col-sm-9 col-xl-11">
                    <input type="number" class="form-control" id="tema" name="tema" placeholder="Introduce el número del tema a añadir">
                </div>
                <div class="col-sm-3 col-xl-1">
                    <button type="submit" class="btn w-100 mt-auto">Guardar</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="table-responsive bg-dark rounded">
    <table class="table table-striped table-sm table-dark">
        <thead>
            <tr class="text-center">
                <th>TEMA</th>
                <th>ACCIONES</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${cn.tests.allTemas.size() <= 0}">
                    <tr class="table-danger">
                        <td colspan="5" class="text-center">No se ha encontrado ningún tema</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="tema" items="${cn.tests.allTemas}">
                        <tr class="text-center">
                            <td>Tema ${tema}</td>
                            <td>
                                <div class="btn-group" role="group" aria-label="Acciones usuarios">
                                    <a type="button" class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/app/a/delete/tema?tema=${tema}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Eliminar tema">
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