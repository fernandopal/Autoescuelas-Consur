        <%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
        <jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>
        <footer class="footer bg-dark text-center text-white">
            <!-- Grid container -->
            <div class="container p-4">
                <section class="mb-4">
                    <!-- Facebook -->
                    <a class="px-2 text-decoration-none text-footer-link" href="https://facebook.com/autoescuelasconsur" role="button">
                        <i class="fab fa-facebook-f"></i>
                    </a>

                    <!-- Twitter -->
                    <a class="px-2 text-decoration-none text-footer-link" href="https://twitter.com/autoescuelasconsur" role="button">
                        <i class="fab fa-twitter"></i>
                    </a>

                    <!-- Instagram -->
                    <a class="px-2 text-decoration-none text-footer-link" href="https://instagram.com/autoescuelasconsur" role="button">
                        <i class="fab fa-instagram"></i>
                    </a>
                </section>

                <section class="mb-4">
                    <p>${labels.get('FOOTER_SLOGAN', pageContext.request)}</p>
                </section>

                <section>
                    <div class="row" id="hideOnDesktop">
                        <div class="col">
                            <select id="selectAutoescuelaFooter" class="form-select mb-2" aria-label="Selecciona tu autoescuela mas cercana">
                                <option selected value="sevilla">${labels.get('SEVILLA', pageContext.request)}</option>
                                <option value="huelva">${labels.get('HUELVA', pageContext.request)}</option>
                            </select>

                            <h5 class="text-uppercase" id="officeTitle">${labels.get('OFFICE_IN', pageContext.request).replace('{city_name}', labels.get('SEVILLA', pageContext.request))}</h5>
                            <ul class="list-unstyled mb-0 contact-">
                                <li>
                                    <a href="tel:955123123" class="text-white-50 text-decoration-none" id="officePhone">955 123 123</a>
                                </li>
                                <li>
                                    <a href="mailto:sevilla@autoescuelasconsur.es" class="text-white-50 text-decoration-none" id="officeMail">sevilla@autoescuelasconsur.es</a>
                                </li>
                            </ul>

                            <script>
                                let footerSelect = document.getElementById("selectAutoescuelaFooter");
                                let officeTitle = document.getElementById("officeTitle");
                                let officePhone = document.getElementById("officePhone");
                                let officeMail = document.getElementById("officeMail");

                                footerSelect.addEventListener("change", function () {
                                    let selectedValue = footerSelect.value;
                                    if(selectedValue === "sevilla") {
                                        officeTitle.innerHTML = "${labels.get('OFFICE_IN', pageContext.request).replace('{city_name}', labels.get('SEVILLA', pageContext.request))}";
                                        officePhone.innerHTML = "955 123 123";
                                        officePhone.setAttribute("href", "tel:955123123");
                                        officeMail.innerHTML = "sevilla@autoescuelasconsur.es";
                                        officeMail.setAttribute("href", "mailto:sevilla@autoescuelasconsur.es");

                                    } else {
                                        officeTitle.innerHTML = "${labels.get('OFFICE_IN', pageContext.request).replace('{city_name}', labels.get('HUELVA', pageContext.request))}";
                                        officePhone.innerHTML = "965 321 321";
                                        officePhone.setAttribute("href", "tel:965321321");
                                        officeMail.innerHTML = "huelva@autoescuelasconsur.es";
                                        officeMail.setAttribute("href", "mailto:huelva@autoescuelasconsur.es");

                                    }
                                })
                            </script>
                        </div>
                    </div>

                    <div class="row" id="hideOnMobile">
                        <div class="col-lg-6 col-md-12 mb-4 mb-md-0">
                            <h5 class="text-uppercase">${labels.get('OFFICE_IN', pageContext.request).replace('{city_name}', labels.get('SEVILLA', pageContext.request))}</h5>

                            <ul class="list-unstyled mb-0 contact-">
                                <li>
                                    <a href="tel:955123123" class="text-white-50 text-decoration-none">955 123 123</a>
                                </li>
                                <li>
                                    <a href="mailto:sevilla@autoescuelasconsur.es" class="text-white-50 text-decoration-none">sevilla@autoescuelasconsur.es</a>
                                </li>
                            </ul>
                        </div>

                        <div class="col-lg-6 col-md-12 mb-4 mb-md-0">
                            <h5 class="text-uppercase">${labels.get('OFFICE_IN', pageContext.request).replace('{city_name}', labels.get('HUELVA', pageContext.request))}</h5>

                            <ul class="list-unstyled mb-0">
                                <li>
                                    <a href="tel:965321321" class="text-white-50 text-decoration-none">965 321 321</a>
                                </li>
                                <li>
                                    <a href="mailto:huelva@autoescuelasconsur.es" class="text-white-50 text-decoration-none">huelva@autoescuelasconsur.es</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </section>
            </div>
            <!-- Grid container -->

            <!-- Copyright -->
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
                ${labels.get('DESIGN_BY', pageContext.request)}
                <a class="text-danger text-decoration-none" href="https://www.fernandopal.es/">Fernando Palomo Moreno</a>
            </div>
            <!-- Copyright -->
        </footer>

        <!-- Bootstrap core JavaScript-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/typed.js/2.0.11/typed.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    </body>
</html>