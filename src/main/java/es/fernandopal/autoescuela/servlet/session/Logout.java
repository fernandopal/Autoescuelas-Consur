package es.fernandopal.autoescuela.servlet.session;

import javax.servlet.http.*;
import java.io.IOException;

public class Logout extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (request.getSession() != null) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/home?alert=Se ha cerrado la sesión"));
            return;

        }

        response.sendRedirect(request.getContextPath() + "/home");
    }

}
