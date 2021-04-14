package es.fernandopal.autoescuela.servlet.user.tests;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Pregunta;
import es.fernandopal.autoescuela.model.Respuesta;
import es.fernandopal.autoescuela.model.Test;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class CheckTest extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert = "", resultado = "";

        try {
            final String id = request.getParameter("id");

            if(id == null) {
                alert = "No se ha podido validar el test";

            } else {
                final Controller cn = new Controller();

                for(int p = 1; p <= 10; p++) {
                    final String rNum = request.getParameter("rp"+p);
                    final int correcta = Integer.parseInt(rNum);

                    resultado += 'p' + p + (correcta == 1 ? 'B' : 'M') + '&';

                }

                response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/resultado/id=" + id + "&" + resultado));
                return;

            }

        } catch (Exception ex) {
            alert = "No se ha podido crear el test. Error: " + ex.getMessage();

        }

        response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/admin?alert=" + alert + "&error"));

    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }
    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }

}
