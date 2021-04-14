package es.fernandopal.autoescuela.servlet.admin.tema;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Test;
import es.fernandopal.autoescuela.model.Usuario;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class DeleteTema extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final Usuario admin = (Usuario) request.getSession().getAttribute("usuario");

            if(admin == null) {
                alert = "Necesitas iniciar sesión como administrador para poder hacer esto";
                response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/home?alert=" + alert + "&error"));
                return;

            } else {
                final String tema = request.getParameter("tema");

                if(tema == null) {
                    alert = "El tema indicado no es válido";

                } else {
                    final Controller cn = new Controller();
                    final int temaAsInt = Integer.parseInt(tema);

                    final List<Test> temas = cn.getTests().findByTema(temaAsInt);
                    for (Test t : temas) {
                        if(t.getNombre().equals("TEMA") && t.getTema() == temaAsInt) {
                            cn.getTests().destroy(t.getId());
                            break;

                        }

                    }

                    alert = "Tema eliminado con éxito";

                    response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/admin?alert=" + alert + "&error=false"));
                    return;

                }

            }

        } catch (Exception ex) {
            alert = "No se ha podido eliminar el tema. Error: " + ex.getMessage();

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
