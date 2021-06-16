<%--
  Created by IntelliJ IDEA.
  User: fpalm
  Date: 11/04/2021
  Time: 20:52
  To change this template use File | Settings | File Templates.
--%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/app/u/fragments/header?view=offs"/>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>

<%----%>
<main class="p-3">
    <div class="container-fluid" id="doTestsSection">
        <c:set var="currentTest" value="${cn.tests.findTest(param.id)}"/>
        <% session.setAttribute("correctas", 0); %>

        <span>${labels.get('TEST_SCORE', pageContext.request)} ${session.getAttribute("correctas")}/10</span>
        <a role="button" href="${pageContext.request.contextPath}/tests?test=${param.id}" class="btn btn-sm btn-primary">${labels.get('RETAKE_TEST', pageContext.request)}</a>

        <br>

        <c:forEach var="pregunta" items="${currentTest.preguntas}" varStatus="status">

            <% session.setAttribute("parameters", request.getParameterMap()); %>

            <label class="fw-bold ${parameters.get(status) == "B" ? "correcta" : "incorrecta"}" for="pregunta-${status.count}">
                    ${status.count}. ${pregunta.pregunta}
            </label>

            <ul class="pregunta">
                <c:forEach var="respuesta" items="${pregunta.respuestas}">
                    <c:choose>
                        <c:when test="${respuesta.correcta}">
                            <% session.setAttribute("correctas", (int)session.getAttribute("correctas") + 1); %>
                            <li class="correcta rounded">${respuesta.respuesta}</li>
                        </c:when>
                        <c:otherwise>
                            <li class="${parameters.get(status) == "B" ? "incorrecta" : ""} rounded">${respuesta.respuesta}</li>
                            <li class="rounded">${respuesta.respuesta}</li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </c:forEach>

        <br>

        <span>${labels.get('TEST_SCORE', pageContext.request)} ${session.getAttribute("correctas")}/10</span>
        <a role="button" href="${pageContext.request.contextPath}/tests?test=${param.id}" class="btn btn-sm btn-primary">${labels.get('RETAKE_TEST', pageContext.request)}</a>
    </div>
</main>
<%----%>