package es.fernandopal.autoescuela.servlet.admin.oferta;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.util.Label;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteOferta extends HttpServlet {
    private final Label labels = new Label();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final String id = request.getParameter("id");

            if (id == null) {
                alert = labels.get("INVALID_OFFER_SELECTED", request);

            } else {
                final Controller cn = new Controller();
                final int idAsInt = Integer.parseInt(id);

                cn.getOfertas().destroy(idAsInt);
                alert = labels.get("OFFER_DELETED", request);
                Util.sendMessage(null, "/admin", alert, request, response);
                return;

            }


        } catch (Exception ex) {
            alert = labels.get("CANT_DELETE_OFFER", request);
            ex.printStackTrace();

        }
        Util.sendMessage("CUSTOM", "/admin", alert, request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }
}