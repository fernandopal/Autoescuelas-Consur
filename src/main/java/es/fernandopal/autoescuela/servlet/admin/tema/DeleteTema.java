package es.fernandopal.autoescuela.servlet.admin.tema;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Test;
import es.fernandopal.autoescuela.model.Usuario;
import es.fernandopal.autoescuela.util.Label;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class DeleteTema extends HttpServlet {
    private final Label labels = new Label();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final String tema = request.getParameter("tema");

            if(tema == null) {
                alert = labels.get("INVALID_THEME", request);

            } else {
                final Controller cn = new Controller();
                final int temaAsInt = Integer.parseInt(tema);

                final List<Test> temas = cn.getTests().findByTema(temaAsInt);
                for (Test t : temas) {
                    if(t.getNombre().equals("THEME") && t.getTema() == temaAsInt) {
                        cn.getTests().destroy(t.getId());
                        break;

                    }

                }

                alert = labels.get("DELETED_TEMA", request);
                Util.sendMessage("CUSTOM", "/admin", alert, request, response);
                return;

            }

        } catch (Exception ex) {
            alert = labels.get("CANT_DELETE_THEME", request);

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
