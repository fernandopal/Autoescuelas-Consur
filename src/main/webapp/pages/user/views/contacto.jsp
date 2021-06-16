<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="labels" class="es.fernandopal.autoescuela.util.Label"/>
<jsp:include page="/app/u/fragments/header?view=contacto"/>

<%----%>
<main class="p-5">
    <section id="contactMainSection">
        <div class="container-fluid">

            <div class="row">
                <div class="col-md-5">

                    <select id="selectAutoescuela" class="form-select mb-2" aria-label="${labels.get('SELECT_DRIVING_SCHOOL', pageContext.request)}">
                        <option selected value="sevilla">${labels.get('SEVILLA', pageContext.request)}</option>
                        <option value="huelva">${labels.get('HUELVA', pageContext.request)}</option>
                    </select>

                    <div class="map">
                        <div class="map_canvas">
                            <iframe id="mapCanvas" src="https://maps.google.com/maps?q=Calle%20Medalla%20Milagrosa,%2031,%2041009%20Sevilla&t=&z=13&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>

                            <script>
                                let select = document.getElementById("selectAutoescuela");
                                let map = document.getElementById("mapCanvas");

                                select.addEventListener("change", function () {
                                    let selectedValue = select.value;
                                    if(selectedValue === "sevilla") {
                                        map.setAttribute("src", "https://maps.google.com/maps?q=Calle%20Medalla%20Milagrosa,%2031,%2041009%20Sevilla&t=&z=13&ie=UTF8&iwloc=&output=embed");
                                    } else {
                                        map.setAttribute("src", "https://maps.google.com/maps?q=Av.%20Andaluc%C3%ADa,%2019,%2021004%20Huelva&t=&z=15&ie=UTF8&iwloc=&output=embed");
                                    }
                                })
                            </script>

                            <style>
                                iframe, .map, .map_canvas {
                                    width: 100%;
                                    height: 100%;
                                }
                                .map {
                                    position: relative;
                                    text-align: right;
                                }
                                .map_canvas {
                                    overflow: hidden;
                                    background: none!important;
                                }
                            </style>
                        </div>
                    </div>

                </div>
                <div class="col-md-6">

                    <form>
                        <div class="mb-3">
                            <label for="emailInput">${labels.get('INSERT_EMAIL', pageContext.request)}</label>
                            <input type="email" class="form-control" id="emailInput" placeholder="${labels.get('EMAIL_PLACEHOLDER', pageContext.request)}">
                        </div>
                        <div class="mb-3">
                            <label for="mensajeInput">${labels.get('WRITE_YOUR_MESSAGE_HERE', pageContext.request)}</label>
                            <textarea class="form-control" placeholder="${labels.get('WRITE_YOUR_MESSAGE_HERE', pageContext.request)}" id="mensajeInput" style="height: 100px;"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">${labels.get('SEND', pageContext.request)}</button>
                    </form>

                </div>
            </div>

        </div>
    </section>
</main>
<%----%>

<jsp:include page="/app/u/fragments/footer"/>

