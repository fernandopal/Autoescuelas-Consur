<%--
  Created by IntelliJ IDEA.
  User: fpalm
  Date: 11/04/2021
  Time: 20:52
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="iso-8859-1" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/app/u/fragments/header?view=offs"/>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>

<%----%>
<main class="p-3">
    <div class="container-fluid" id="doTestsSection">
        <c:set var="currentTest" value="${cn.tests.findTest(param.id)}"/>
        <c:forEach var="pregunta" items="${currentTest.preguntas}" varStatus="status">

            <% session.setAttribute("parameters", request.getParameterMap()); %>

            <label class="fw-bold ${parameters.get('p' + status) == 'B' ? 'correcta' : 'incorrecta'}" for="pregunta-${status.count}">
                ${status.count}. ${pregunta.pregunta}
            </label>

            <ul class="pregunta">
                <c:forEach var="respuesta" items="${pregunta.respuestas}">
                    <li class="${respuesta.correcta ? 'correcta' : 'incorrecta'} rounded">
                        ${respuesta.respuesta}
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
    </div>
</main>
<%----%>