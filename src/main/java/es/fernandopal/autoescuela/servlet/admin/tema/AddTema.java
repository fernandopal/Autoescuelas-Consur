package es.fernandopal.autoescuela.servlet.admin.tema;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.entities.Rango;
import es.fernandopal.autoescuela.model.Test;
import es.fernandopal.autoescuela.model.Usuario;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddTema extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final Test test = new Test();

            final String tema = request.getParameter("tema");

            if(tema == null) {
                alert = "Alguno de los valores introducidos no era válido";

            } else {
                //Creamos un test con valores nulos y nombre 'TEMA', estos test no se muestran en ningún lado pero se usan
                //para evitarnos crear una tabla adicional para guardar solo los temas disponibles

                final int temaAsInt = Integer.parseInt(tema);
                final Controller cn = new Controller();

                if(cn.getTests().findByTema(temaAsInt).isEmpty()) {
                    test.setTema(temaAsInt);
                    test.setPreguntas(null);
                    test.setNombre("TEMA");

                    cn.getTests().create(test, false);
                    alert = "Tema añadido con éxito";

                    response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/admin?alert=" + alert + "&error=false"));
                    return;

                } else {
                    alert = "Ese tema ya existe, no pueden existir duplicados";

                }

            }

        } catch (Exception ex) {
            alert = "No se ha podido añadir el tema. Error: " + ex.getMessage();

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
