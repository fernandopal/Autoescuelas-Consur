<%--
  Created by IntelliJ IDEA.
  User: fpalomo
  Date: 09/05/2021
  Time: 12:21
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>

<style>
    table, tr, th, td {
        border: 1px solid black;
        border-collapse: collapse;
    }
    td, th {
        padding: .5rem;
    }
</style>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>NOMBRE</th>
            <th>TIPO</th>
            <th>DESCRIPCI�N</th>
            <th>PRECIO</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="oferta" items="${cn.ofertas.all}">
            <tr>
                <td>${oferta.id}</td>
                <td>${oferta.nombre}</td>
                <td>${oferta.tipo}</td>
                <td>${oferta.descripcion}</td>
                <td>${oferta.precio}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>