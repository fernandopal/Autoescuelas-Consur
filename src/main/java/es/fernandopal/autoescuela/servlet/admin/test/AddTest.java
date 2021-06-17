package es.fernandopal.autoescuela.servlet.admin.test;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Pregunta;
import es.fernandopal.autoescuela.model.Respuesta;
import es.fernandopal.autoescuela.model.Test;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AddTest extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final String nombre = request.getParameter("nombre");
            final String tema = request.getParameter("tema");

            if(tema == null || nombre == null) {
                alert = "Alguno de los valores introducidos no era válido";

            } else {
                final int temaAsInt = Integer.parseInt(tema);
                final Controller cn = new Controller();

                final Test test = new Test();
                test.setNombre(nombre);
                test.setTema(temaAsInt);

                final ArrayList<Pregunta> preguntas = new ArrayList<>();
                for(int p = 1; p <= 10; p++) {
                    final String preguntaStr = request.getParameter("p"+p);
                    final String categoria = request.getParameter("p"+p+"c");
                    final Pregunta pregunta = new Pregunta();
                    System.out.println("########PREG: " + preguntaStr);
                    pregunta.setPregunta(preguntaStr);
                    pregunta.setTest(test);
                    pregunta.setCategoria(categoria);

                    final ArrayList<Respuesta> respuestas = new ArrayList<>();
                    if(preguntaStr != null && !preguntaStr.isEmpty()) {
                        for(int r = 1; r <= 4; r++) {
                            final String respuestaStr = request.getParameter("p"+p+"r"+r);
                            System.out.println("########RESP: " + respuestaStr);

                            final Respuesta respuesta = new Respuesta();
                            respuesta.setCorrecta(r == 1);
                            respuesta.setPregunta(pregunta);
                            respuesta.setRespuesta(respuestaStr);
                            respuestas.add(respuesta);

                        }
                        pregunta.setRespuestas(respuestas);
//                        cn.getPreguntas().create(pregunta, true);

                    } else { break; }
                    
                }
                test.setPreguntas(preguntas);
                cn.getTests().create(test, true);

                alert = "Test creado con éxito";
                Util.sendMessage(null, "/admin", alert, request, response);
                return;

            }

        } catch (Exception ex) {
            alert = "No se ha podido crear el test. Error: " + ex.getMessage();
            ex.printStackTrace();

        }
        Util.sendMessage("LOGIN", "/admin", alert, request, response);

    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }
    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }

}
