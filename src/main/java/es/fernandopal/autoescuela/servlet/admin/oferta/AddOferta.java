package es.fernandopal.autoescuela.servlet.admin.oferta;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Oferta;
import es.fernandopal.autoescuela.util.Label;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class AddOferta extends HttpServlet {
    private final Label labels = new Label();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final Oferta oferta = new Oferta();

            final String nombre = request.getParameter("nombre");
            final String desc = request.getParameter("desc");
            final String precio = request.getParameter("precio");
            final String tipo = request.getParameter("tipo");

            if(nombre == null || desc == null || precio == null || tipo == null) {
                alert = labels.get("INVALID_VALUE_INSERTED", request);

            } else {
                final double precioAsNumber = Double.parseDouble(precio);
                final Controller cn = new Controller();

                oferta.setNombre(nombre);
                oferta.setDescripcion(desc);
                oferta.setPrecio(precioAsNumber);
                oferta.setTipo(tipo);
                cn.getOfertas().create(oferta);

                alert = labels.get("ADDED_OFFER", request);
                Util.sendMessage(null, "/admin", alert, request, response);
                return;

            }

        } catch (Exception ex) {
            alert = labels.get("CANT_ADD_OFFER", request);
            ex.printStackTrace();

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
