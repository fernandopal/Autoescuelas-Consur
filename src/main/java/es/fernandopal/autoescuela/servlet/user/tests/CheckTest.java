package es.fernandopal.autoescuela.servlet.user.tests;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Pregunta;
import es.fernandopal.autoescuela.model.Respuesta;
import es.fernandopal.autoescuela.model.Test;
import es.fernandopal.autoescuela.util.Label;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;

public class CheckTest extends HttpServlet {
    private final Label labels = new Label();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
        final HttpSession session = request.getSession();
        String alert = "";
        StringBuilder resultado = new StringBuilder();

        try {
            final String id = request.getParameter("id");

            if(id == null) {
                alert = labels.get("CANT_VALIDATE_TEST", session);

            } else {
                final Controller cn = new Controller();

                for(int p = 1; p <= 10; p++) {
                    final String rNum = request.getParameter("rp"+p);
                    final int correcta = Integer.parseInt(rNum);

                    resultado.append(p).append("=").append(correcta == 1 ? "B" : "M&S=").append(p < 10 ? "&" : "");

                }

                response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/resultado?id=" + id + "&" + resultado));
                return;

            }

        } catch (Exception ex) {
            alert = labels.get("CANT_CHECK_TEST", session);
            ex.printStackTrace();

        }
        Util.sendMessage("403", "/home", alert, request, response);

    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }
    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }

}
