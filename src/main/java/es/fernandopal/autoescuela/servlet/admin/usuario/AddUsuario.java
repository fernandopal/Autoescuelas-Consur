package es.fernandopal.autoescuela.servlet.admin.usuario;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.entities.Rango;
import es.fernandopal.autoescuela.model.Usuario;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AddUsuario extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final Usuario usuario = new Usuario();

            final String dni = request.getParameter("dni");
            final String nombre = request.getParameter("nombre");
            final String apellidos = request.getParameter("apellidos");
            final String rango = request.getParameter("rango");
            final String tlf = request.getParameter("tlf");

            if(dni == null || nombre == null || apellidos == null || rango == null || tlf == null) {
                alert = "Alguno de los valores introducidos no era válido";

            } else {
                usuario.setDni(dni);
                usuario.setNombre(nombre);
                usuario.setApellidos(apellidos);
                usuario.setPassword(Util.getHashForPassword(dni));
                usuario.setRango(Rango.valueOf(rango));
                usuario.setTelefono(tlf);

                final Controller cn = new Controller();
                cn.getUsuarios().create(usuario);
                alert = "Usuario creado con éxito";

                response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/admin?alert=" + alert + "&error=false"));
                return;

            }

        } catch (Exception ex) {
            alert = "No se ha podido añadir al usuario. Error: " + ex.getMessage();

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
