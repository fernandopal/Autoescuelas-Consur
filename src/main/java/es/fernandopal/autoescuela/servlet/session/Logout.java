package es.fernandopal.autoescuela.servlet.session;

import es.fernandopal.autoescuela.util.Util;

import javax.servlet.http.*;
import java.io.IOException;

public class Logout extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (request.getSession() != null) {
            request.getSession().invalidate();
            Util.sendMessage(null, "/home", "Se ha cerrado la sesión", request, response);
            return;

        }

        response.sendRedirect(request.getContextPath() + "/home");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        this.doPost(request, response);
    }
}
