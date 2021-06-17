<%--
  Created by IntelliJ IDEA.
  User: fpalm
  Date: 18/03/2021
  Time: 13:07
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>
<jsp:include page="/app/u/fragments/header?view=offs"/>

<%----%>
<main class="p-3">
    <div class="container">
        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">${sessionScope.usuario.dni}</a></li>
                <li class="breadcrumb-item active" aria-current="page">${labels.get('TEST', pageContext.request)}</li>
            </ol>
        </nav>
    </div>

    <div class="container-fluid" id="doTestsSection">
        <div class="row">
            <div class="col-md-4 col-lg-3 col-xl-2 col-xxl-1">
                <ul class="list-group">
                    <c:forEach var="tema" items="${cn.tests.allTemas}">
                        <a  href="${pageContext.request.contextPath}/tests?tema=${tema}"
                            class="list-group-item list-group-item-action ${param.tema == tema ? 'active' : ''}"
                            aria-current="${param.tema == tema}"
                        >${labels.get('THEME', pageContext.request)} ${tema}</a>
                    </c:forEach>
                </ul>
            </div>
            <div class="col">
                <c:choose>
                    <c:when test="${!empty message}">
                        <p>${message}</p>
                    </c:when>
                    <c:when test="${!empty param.test && empty param.tema}">
                        <c:set var="currentTest" value="${cn.tests.findTest(param.test)}"/>
                        <c:choose>
                            <c:when test="${currentTest == null || empty currentTest}">
                                <span class="text-danger">${labels.get('TEST_NOT_FOUND', pageContext.request)}</span>
                            </c:when>

                            <c:otherwise>
                                <h3>${currentTest.nombre}</h3>
                                <c:forEach var="pregunta" items="${currentTest.preguntas}" varStatus="status">
                                    <label class="fw-bold" for="pregunta-${status.count}">${status.count}. ${pregunta.pregunta}</label>

                                    <ul class="pregunta" id="P${pregunta.id}">
                                        <c:forEach var="respuesta" items="${pregunta.respuestas}">
                                            <li class="rounded respuesta" vl="${respuesta.correcta ? '1' : '0'}" pr="${pregunta.id}">${respuesta.respuesta}</li>
                                        </c:forEach>
                                    </ul>
                                </c:forEach>

                                <p class="text-danger fst-italic">${labels.get('ALL_FIELDS_REQUIRED', pageContext.request)}</p>
                                <p class="fw-bold">${labels.get('TEST_SCORE', pageContext.request)} <span id="score">0</span>/10</p>
                                <form class="fullpage-form rounded" action="${pageContext.request.contextPath}/app/checktest" method="post">
                                    <input type="text" name="test" id="test" value="${param.test}" hidden>
                                    <input type="text" name="resultado" id="resultado" value="" hidden>
                                    <button type="submit" class="btn btn-danger" id="enviar" disabled>${labels.get('SEND_AND_SAVE', pageContext.request)}</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </c:when>

                    <c:when test="${!empty param.tema && empty param.test}">
                        <c:forEach var="test" items="${cn.tests.findByTema(param.tema)}">
                            <div class="card text-white bg-dark mb-3 d-inline-block" style="max-width: 18rem;">
                                <div class="card-header">${test.nombre}</div>
                                <div class="card-body">
                                    <div class="card-text">
                                        <p>${labels.get('ATTEMPS', pageContext.request)}:
                                            <span class="text-danger">${cn.intentos.getSuspensos(sessionScope.usuario, test).size()}</span>
                                            <span>/</span>
                                            <span class="text-success">${cn.intentos.getAprobados(sessionScope.usuario, test).size()}</span>
                                        </p>
                                        <a class="text-danger" href="${pageContext.request.contextPath}/tests?test=${test.id}">${labels.get('START_TEST', pageContext.request)}</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <span>${labels.get('CHOOSE_THEME_TO_SEE_LIST', pageContext.request)}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script>
        $().ready(function () {
            let contestadas = [];
            let correctas = 0;

            $(".respuesta").on('click', function(event) {
                let respuesta = $(this);
                if($.inArray(respuesta.attr('pr'), contestadas) === -1) {
                    if(respuesta.attr('vl') === '1') {
                        respuesta.addClass('correcta');
                        correctas++;
                    } else {
                        respuesta.addClass('incorrecta');
                        $('#P' + respuesta.attr('pr')).children('li').each(function () {
                            if($(this).attr('vl') === '1') {
                                $(this).addClass('correcta');
                            }
                        });
                    }
                    contestadas.push(respuesta.attr('pr'));
                }

                $("#score").text(correctas + '');

                if(contestadas.length >= 10) {
                    $("#enviar").removeAttr("disabled");
                    $("#resultado").val('' + correctas);
                }
            });
        });
    </script>
</main>
<%----%>