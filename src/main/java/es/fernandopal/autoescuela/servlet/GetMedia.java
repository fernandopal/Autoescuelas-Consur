package es.fernandopal.autoescuela.servlet;

import es.fernandopal.autoescuela.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;

public class GetMedia extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        final Usuario user = (Usuario) request.getSession().getAttribute("usuario");
        if(user == null || user.getDni() == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;

        }

        System.out.println("=======================================================================");
        String resource = request.getRequestURI();
        resource = URLDecoder.decode(resource, "UTF-8");
        final String fs = File.separator;
        System.out.println("R1|| " + resource);
        int pos = resource.indexOf("/media/") + "/media/".length();
        resource = resource.substring(pos);
        System.out.println("R2|| " + resource);
        String path = "/WEB-INF/uploads/" + user.getDni() + "/" + resource;
        System.out.println("P1|| " + path);
        response.setHeader("Cache-Control", "no-cache");
        request.getRequestDispatcher(path).include(request, response);
        System.out.println("=======================================================================");
    }

    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException { processRequest(request, response); }
    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}
