package es.fernandopal.autoescuela.servlet.admin.tema;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Test;
import es.fernandopal.autoescuela.util.Label;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddTema extends HttpServlet {
    private final Label labels = new Label();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final Test test = new Test();

            final String tema = request.getParameter("tema");

            if(tema == null) {
                alert = "Alguno de los valores introducidos no era válido";

            } else {
                //Creamos un test con valores nulos y nombre 'THEME', estos test no se muestran en ningún lado pero se usan
                //para evitarnos crear una tabla adicional para guardar solo los temas disponibles

                final int temaAsInt = Integer.parseInt(tema);
                final Controller cn = new Controller();

                if(cn.getTests().findByTema(temaAsInt).isEmpty()) {
                    test.setTema(temaAsInt);
                    test.setPreguntas(null);
                    test.setNombre("TEMA");

                    cn.getTests().create(test, false);
                    alert = labels.get("ADDED_TEMA", request);
                    Util.sendMessage(null, "/admin", alert, request, response);
                    return;

                } else {
                    alert = labels.get("THEME_ALREADY_EXISTS", request);

                }

            }

        } catch (Exception ex) {
            alert = labels.get("CANT_ADD_THEME", request);

        }
        Util.sendMessage("CUSTOM", "/admin", alert, request, response);

    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }
    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }

}
