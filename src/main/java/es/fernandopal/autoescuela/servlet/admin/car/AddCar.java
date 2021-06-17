package es.fernandopal.autoescuela.servlet.admin.car;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.entities.EstadoCoche;
import es.fernandopal.autoescuela.model.Coche;
import es.fernandopal.autoescuela.model.Oferta;
import es.fernandopal.autoescuela.util.Label;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;

public class AddCar extends HttpServlet {
    private final Label labels = new Label();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final Coche coche = new Coche();

            final String matricula = request.getParameter("matricula");
            final String fechaItv = request.getParameter("fecha-itv");
            final String fechaReg = request.getParameter("fecha-reg");

            if(matricula == null || fechaItv == null || fechaReg == null) {
                alert = labels.get("INVALID_VALUE_INSERTED", request);

            } else {
                final Controller cn = new Controller();
                final SimpleDateFormat inDF = new SimpleDateFormat("yyyy-MM-dd");
                final SimpleDateFormat outDF = new SimpleDateFormat("dd/MM/yyyy");

                coche.setMatricula(matricula);
                coche.setEstado(EstadoCoche.DISPONIBLE);
                coche.setRegistro(outDF.format(inDF.parse(fechaReg)));
                coche.setItv(outDF.format(inDF.parse(fechaItv)));
                cn.getCoches().create(coche);

                alert = labels.get("ADDED_CAR", request);
                Util.sendMessage(null, "/admin", alert, request, response);
                return;

            }

        } catch (Exception ex) {
            alert = labels.get("CANT_ADD_CAR", request);
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
