<%@page pageEncoding="iso-8859-1" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="cn" class="es.fernandopal.autoescuela.controller.Controller"/>

<div id="dashboard">
    <div class="row g-2">
        <div class="col-sm-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Usuarios</h5>
                    <p class="card-text">
                        <b><i class="fas fa-user-graduate fa-fw"></i> Alumnos:</b> ${cn.usuarios.getByRango("ALUMNO").size()} <br>
                        <b><i class="fas fa-chalkboard-teacher fa-fw"></i> Profesores:</b> ${cn.usuarios.getByRango("PROFESOR").size()} <br>
                        <b><i class="fas fa-user-shield fa-fw"></i> Administradores:</b> ${cn.usuarios.getByRango("ADMIN").size()} <br>
                    </p>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Tests</h5>
                    <p class="card-text">
                        <b><i class="far fa-file-alt fa-fw"></i> Temas:</b> ${cn.tests.allTemas.size()} <br>
                        <b><i class="fas fa-question fa-fw"></i> Preguntas:</b> ${cn.preguntas.count} <br>
                        <b><i class="fas fa-book fa-fw"></i> Tests:</b> ${cn.tests.count} <br>
                    </p>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Coches</h5>
                    <p class="card-text">
                        <b><i class="fas fa-coins"></i> Alquilados:</b> 0 <br>
                        <b><i class="fas fa-lock"></i> En propiedad:</b> 0 <br>
                        <b><i class="fas fa-wrench"></i> Averiados:</b> 0 <br>
                    </p>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-5">
            <c:choose>
                <c:when test="${cn.ofertas.count <= 0}">
                    <p class="graph rounded">
                        Actualmente no hay ninguna oferta por lo que este gráfico no está disponible
                    </p>
                </c:when>
                <c:otherwise>
                    <canvas id="testsPerCategory" class="graph rounded"></canvas>
                    <script>
                        let ctx = document.getElementById('testsPerCategory').getContext('2d');
                        let myChart = new Chart(ctx, {
                            type: 'pie',
                            data: {
                                labels: ['Coche', 'Moto', 'Otros'],
                                datasets: [{
                                    label: '# ofertas/categoría',
                                    data: [
                                        ${cn.ofertas.getCountOf('coche')},
                                        ${cn.ofertas.getCountOf('moto')},
                                        ${cn.ofertas.getCountOf('otros')},
                                    ],
                                    borderColor: "rgb(206,212,218)",
                                    backgroundColor: [
                                        'rgba(220,53,69,0.75)',
                                        'rgb(220,217,53,0.75)',
                                        'rgb(53,153,220,0.75)'
                                    ],
                                    hoverOffset: 3
                                }]
                            },
                            options: {
                                plugins: {
                                    legend: {
                                        display: true,
                                        labels: {
                                            color: 'rgb(206,212,218)'
                                        }
                                    }
                                }
                            }
                        });
                    </script>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="col-sm-5">
            <c:choose>
                <c:when test="${cn.preguntas.count <= 0}">
                    <p class="graph rounded">
                        Actualmente no hay ninguna pregunta por lo que este gráfico no está disponible
                    </p>
                </c:when>
                <c:otherwise>
                    <canvas id="questionsPerCategory" class="graph rounded"></canvas>
                    <script>
                        let ctx = document.getElementById('questionsPerCategory').getContext('2d');
                        let myChart = new Chart(ctx, {
                            type: 'pie',
                            data: {
                                labels: [
                                    <c:forEach var="categoria" items="${cn.preguntas.allCategories}">
                                        '${categoria}',
                                    </c:forEach>
                                ],
                                datasets: [{
                                    label: '# ofertas/categoría',
                                    data: [
                                        <c:forEach var="categoria" items="${cn.preguntas.allCategories}">
                                            ${cn.preguntas.getCountOf(categoria)},
                                        </c:forEach>
                                    ],
                                    borderColor: "rgb(206,212,218)",
                                    backgroundColor: [
                                        '#25CCF7','#FD7272','#54a0ff','#00d2d3',
                                        '#1abc9c','#2ecc71','#3498db','#9b59b6','#34495e',
                                        '#16a085','#27ae60','#2980b9','#8e44ad','#2c3e50',
                                        '#f1c40f','#e67e22','#e74c3c','#ecf0f1','#95a5a6',
                                        '#f39c12','#d35400','#c0392b','#bdc3c7','#7f8c8d',
                                        '#55efc4','#81ecec','#74b9ff','#a29bfe','#dfe6e9',
                                        '#00b894','#00cec9','#0984e3','#6c5ce7','#ffeaa7',
                                        '#fab1a0','#ff7675','#fd79a8','#fdcb6e','#e17055',
                                        '#d63031','#feca57','#5f27cd','#54a0ff','#01a3a4'
                                    ],
                                    hoverOffset: 3
                                }]
                            },
                            options: {
                                plugins: {
                                    legend: {
                                        display: true,
                                        labels: {
                                            color: 'rgb(206,212,218)'
                                        }
                                    }
                                }
                            }
                        });
                    </script>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>