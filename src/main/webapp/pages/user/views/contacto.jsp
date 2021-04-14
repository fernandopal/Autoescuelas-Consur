<%@page pageEncoding="iso-8859-1" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/app/u/fragments/header?view=contacto"/>

<%----%>
<main class="p-5">
    <section id="contactMainSection">
        <div class="container-fluid">

            <div class="row">
                <div class="col-md-5">

                    <select id="selectAutoescuela" class="form-select mb-2" aria-label="Selecciona tu autoescuela mas cercana">
                        <option selected value="sevilla">Sevilla</option>
                        <option value="huelva">Huelva</option>
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
                            <label for="emailInput">Introduce tu correo electrónico</label>
                            <input type="email" class="form-control" id="emailInput" placeholder="nombre@ejemplo.com">
                        </div>
                        <div class="mb-3">
                            <label for="mensajeInput">Escribe aquí tu mensaje</label>
                            <textarea class="form-control" placeholder="Escribe aquí tu mensaje" id="mensajeInput" style="height: 100px;"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Enviar</button>
                    </form>

                </div>
            </div>

        </div>
    </section>
</main>
<%----%>

<jsp:include page="/app/u/fragments/footer"/>

