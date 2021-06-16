<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/app/u/fragments/header?view=offs"/>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>

<%----%>
<main class="py-3">
    <section class="container" id="offersMainSection">
        <ul class="nav justify-content-center navbar-dark bg-dark" id="pills-tab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="todos-tab" data-bs-toggle="pill" href="#todos" role="tab" aria-controls="todos" aria-selected="true">${labels.get('ALL_OFFERS', pageContext.request)}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="coche-tab" data-bs-toggle="pill" href="#coche" role="tab" aria-controls="coche" aria-selected="false">${labels.get('CAR', pageContext.request)}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="moto-tab" data-bs-toggle="pill" href="#moto" role="tab" aria-controls="moto" aria-selected="false">${labels.get('MOTORCYCLE', pageContext.request)}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="otros-tab" data-bs-toggle="pill" href="#otros" role="tab" aria-controls="otros" aria-selected="false">${labels.get('OTHERS', pageContext.request)}</a>
            </li>
        </ul>

        <c:set var="lAll" value="${cn.ofertas.all}" />

        <div class="container text-center">
            <div class="tab-content" id="tabs-content">
                <c:choose>
                    <c:when test="${lAll.size() < 1}">
                        ${labels.get('NO_OFFERS_TO_SHOW', pageContext.request)}
                    </c:when>
                    <c:otherwise>
                        <div class="tab-pane fade show active" id="todos" role="tabpanel" aria-labelledby="todos-tab">
                            <c:forEach items="${lAll}" var="off">
                                <div class="off">
                                    <a href="${pageContext.request.contextPath}/ofertas/v/${off.id}"><img src="${pageContext.request.contextPath}/assets/img/offer-icon.png"></a>
                                    <span>${off.nombre} - ${off.precio}${labels.get('CURRENCY_SYMBOL', pageContext.request)}</span>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="tab-pane fade" id="coche" role="tabpanel" aria-labelledby="coche-tab">
                            <c:forEach items="${cn.ofertas.findByType('coche')}" var="off">
                                <div class="off">
                                    <a href="${pageContext.request.contextPath}/ofertas/v/${off.id}"><img src="${pageContext.request.contextPath}/assets/img/offer-icon.png"></a>
                                    <span>${off.nombre} - ${off.precio}${labels.get('CURRENCY_SYMBOL', pageContext.request)}</span>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="tab-pane fade" id="moto" role="tabpanel" aria-labelledby="moto-tab">
                            <c:forEach items="${cn.ofertas.findByType('moto')}" var="off">
                                <div class="off">
                                    <a href="${pageContext.request.contextPath}/ofertas/v/${off.id}"><img src="${pageContext.request.contextPath}/assets/img/offer-icon.png"></a>
                                    <span>${off.nombre} - ${off.precio}${labels.get('CURRENCY_SYMBOL', pageContext.request)}</span>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="tab-pane fade" id="otros" role="tabpanel" aria-labelledby="otros-tab">
                            <c:forEach items="${cn.ofertas.findByType('otro')}" var="off">
                                <div class="off">
                                    <a href="${pageContext.request.contextPath}/ofertas/v/${off.id}"><img src="${pageContext.request.contextPath}/assets/img/offer-icon.png"></a>
                                    <span>${off.nombre} - ${off.precio}${labels.get('CURRENCY_SYMBOL', pageContext.request)}</span>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>
</main>
<%----%>

<jsp:include page="/app/u/fragments/footer"/>

