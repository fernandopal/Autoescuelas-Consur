package es.fernandopal.autoescuela.servlet.tests;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Intento;
import es.fernandopal.autoescuela.model.Test;
import es.fernandopal.autoescuela.model.Usuario;
import es.fernandopal.autoescuela.util.Label;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class CheckTest extends HttpServlet {
    private final Label labels = new Label();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        final String resultado = request.getParameter("resultado");
        final String test = request.getParameter("test");
        String alert;

        try {
            if (resultado == null || test == null) {
                alert = labels.get("INVALID_VALUE_INSERTED", request);

            } else {
                final Controller cn = new Controller();
                final int correctas = Integer.parseInt(resultado);
                final int testId = Integer.parseInt(test);

                final boolean aprobado = correctas >= 9;

                final Test currentTest = cn.getTests().findTest(testId);
                final Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
                final SimpleDateFormat DF = new SimpleDateFormat("dd/MM/yyyy");
                final Intento intento = new Intento();
                intento.setTest(currentTest);
                intento.setAprobado(aprobado);
                intento.setUsuario(usuario);
                intento.setAciertos(correctas);
                intento.setFecha(DF.parse(new Date().toString()).toString());

                cn.getIntentos().create(intento);

                Util.sendMessage(null, "/tests", "Has obtenido {A} de un máximo de 10 puntos. {R}".replace("{A}", resultado).replace("{R}", aprobado ? "Apruebas" : "Suspendes"), request, response);
                return;

            }
        } catch (Exception e) {
            alert = labels.get("UNKNOWN_ERROR", request);
            e.printStackTrace();
        }
        Util.sendMessage("CUSTOM", "/home", alert, request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}
