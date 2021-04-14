package es.fernandopal.autoescuela.servlet.admin.usuario;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.entities.Rango;
import es.fernandopal.autoescuela.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteUsuario extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final Usuario admin = (Usuario) request.getSession().getAttribute("usuario");

            if(admin == null) {
                alert = "Necesitas iniciar sesión como administrador para poder hacer esto";
                response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/home?alert=" + alert + "&error"));
                return;

            } else {
                final String dni = request.getParameter("dni");

                if(dni == null) {
                    alert = "El dni enviado no es válido";

                } else {
                    final Controller cn = new Controller();
                    cn.getUsuarios().destroy(dni);
                    alert = "Usuario eliminado con éxito";

                    response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/admin?alert=" + alert + "&error=false"));
                    return;

                }

            }

        } catch (Exception ex) {
            alert = "No se ha podido eliminar el usuario. Error: " + ex.getMessage();

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
