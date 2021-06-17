package es.fernandopal.autoescuela.servlet.admin.test;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Usuario;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteTest extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final String id = request.getParameter("id");

            if(id == null) {
                alert = "El test seleccionado no es válido";

            } else {
                final Controller cn = new Controller();
                final int idAsInt = Integer.parseInt(id);

                cn.getTests().destroy(idAsInt);
                alert = "Test eliminado con éxito";

                response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/admin?alert=" + alert + "&error=false"));
                return;

            }

        } catch (Exception ex) {
            alert = "No se ha podido eliminar el test. Error: " + ex.getMessage();

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
