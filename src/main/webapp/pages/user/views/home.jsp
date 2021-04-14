<%@page pageEncoding="iso-8859-1" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/app/u/fragments/header?view=home"/>

<%----%>
<main class="m-0">
    <section id="homeTitleSection">
        <div class="overlay"></div>
        <video playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop">
            <source src="${pageContext.request.contextPath}/assets/video/home-driving-bg.mp4" type="video/mp4">
        </video>
        <div class="container h-100 min-vw-100 position-relative">
            <c:if test="${!empty param.alert}">
                <div class="alert ${!empty param.error ? "alert-secondary" : "alert-danger"} m-3 alert-dismissible fade show" role="alert">
                        ${param.alert}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="d-flex h-100 text-center align-items-center">
                <div class="w-100 text-white">
                    <h1 class="display-3">Autoescuelas consur</h1>
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
                            <h5 class="card-title">Carné de coche</h5>
                            <a class="btn btn-sm btn-danger">Saber más</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <img src="${pageContext.request.contextPath}/assets/img/scooter-icon.png" class="card-img-top" alt="">
                        <div class="card-body text-center">
                            <h5 class="card-title">Carné de moto</h5>
                            <a class="btn btn-sm btn-danger">Saber más</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <img src="${pageContext.request.contextPath}/assets/img/license-icon.png" class="card-img-top" alt="">
                        <div class="card-body text-center">
                            <h5 class="card-title">Otros permisos</h5>
                            <a class="btn btn-sm btn-danger">Saber más</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
<%----%>

<jsp:include page="/app/u/fragments/footer" />