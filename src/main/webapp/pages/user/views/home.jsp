<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/app/u/fragments/header?view=home"/>

<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>

<%----%>
<main class="m-0">
    <section id="homeTitleSection">
        <div class="overlay"></div>
        <video playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop">
            <source src="${pageContext.request.contextPath}/assets/video/home-driving-bg.mp4" type="video/mp4">
        </video>
        <div class="container h-100 min-vw-100 position-relative">
            <c:if test="${!empty message}">
                <div class="alert ${empty error ? "alert-secondary" : "alert-danger"} m-3 alert-dismissible fade show" role="alert">
                        ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="d-flex h-100 text-center align-items-center">
                <div class="w-100 text-white">
                    <h1 class="display-3">${labels.get('BRAND_NAME', pageContext.request)}</h1>
                    <h3 class="lead mb-0"><span id="typed" style="white-space:pre;"></span></h3>
                </div>
            </div>
        </div>
    </section>
    <section id="homeLicenseSection" class="bg-light">
        <div class="container h-100 p-5">
            <div class="row row-cols-1 row-cols-md-3 g-2">
                <div class="col">
                    <div class="card">
                        <img src="${pageContext.request.contextPath}/assets/img/car-icon.png" class="card-img-top" alt="">
                        <div class="card-body text-center">
                            <h5 class="card-title">${labels.get('CAR_LICENSE', pageContext.request)}</h5>
                            <a href="${pageContext.request.contextPath}/ofertas" class="btn btn-sm btn-danger">${labels.get('VIEW_OFFER_INFO', pageContext.request)}</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <img src="${pageContext.request.contextPath}/assets/img/scooter-icon.png" class="card-img-top" alt="">
                        <div class="card-body text-center">
                            <h5 class="card-title">${labels.get('MOTORCYCLE_LICENSE', pageContext.request)}</h5>
                            <a href="${pageContext.request.contextPath}/ofertas" class="btn btn-sm btn-danger">${labels.get('VIEW_OFFER_INFO', pageContext.request)}</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <img src="${pageContext.request.contextPath}/assets/img/license-icon.png" class="card-img-top" alt="">
                        <div class="card-body text-center">
                            <h5 class="card-title">${labels.get('OTHER_LICENSES', pageContext.request)}</h5>
                            <a href="${pageContext.request.contextPath}/ofertas" class="btn btn-sm btn-danger">${labels.get('VIEW_OFFER_INFO', pageContext.request)}</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
<%----%>

<jsp:include page="/app/u/fragments/footer" />