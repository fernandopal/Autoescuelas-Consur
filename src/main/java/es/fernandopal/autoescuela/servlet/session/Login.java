package es.fernandopal.autoescuela.servlet.session;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Usuario;
import es.fernandopal.autoescuela.util.Util;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author fpalm
 */

public class Login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        final String
            username = request.getParameter("username"),
            password = request.getParameter("password");
        String alert;

        if (username == null || password == null) {
            alert = "Debes iniciar sesión primero";

        } else {
            if (username.isEmpty() || password.isEmpty()) {
                alert = "Tienes que introducir un usuario y contraseña";

            } else {
                final Controller cn = new Controller();
                final List<Usuario> usuarios = cn.getUsuarios().getAll();
                for (Usuario u : usuarios) {
                    if (u.getDni().equals(username) && Util.checkPassword(password, u.getPassword())) {
                        // Login correcto
                        final HttpSession session = request.getSession();
                        session.setAttribute("usuario", u);
                        Util.sendMessage(null, "/home", "Login correcto", request, response);
                        return;

                    }

                }
                alert = "Usuario o contraseña incorrectos";

            }

        }
        Util.sendMessage("LOGIN", "/home", alert, request, response);
    }

}