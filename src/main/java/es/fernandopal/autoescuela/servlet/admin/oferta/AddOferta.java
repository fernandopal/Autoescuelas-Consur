package es.fernandopal.autoescuela.servlet.admin.oferta;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Oferta;
import es.fernandopal.autoescuela.util.Label;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;

public class AddOferta extends HttpServlet {
    private final Label labels = new Label();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String alert;

        try {
            final Oferta oferta = new Oferta();

            while(request.getParameterNames().hasMoreElements()) {
                System.out.println("[CXX] param: " + request.getParameterNames().nextElement());
            }

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
//                oferta.setImg(null);
                oferta.setTipo(tipo);
                cn.getOfertas().create(oferta);

                /*----------------------------------------------------------------------------------------------------*/
                final Part filePart = request.getPart("img");
                final String fs = File.separator;
                String path = getServletContext().getRealPath("WEB-INF") + fs + "uploads" + fs + "ofertas" + fs + oferta.getId();
                //                    /Blog-ProyectoFinal-1.0-SNAPSHOT/WEB-INF/uploads/x/pets/x/x.jpeg
                System.out.println("=====================================================");
                System.out.println(path);
                createFolder(path);
                path += fs + filePart.getSubmittedFileName();
                final FileOutputStream salida = new FileOutputStream(path);
                final InputStream entrada = filePart.getInputStream();
                final int tamBuffer = Integer.parseInt(getServletConfig().getInitParameter("tamBuffer"));
                final byte[] buffer = new byte[tamBuffer];
                int leidos;
                while (entrada.available() > 0) {
                    leidos = entrada.read(buffer);
                    salida.write(buffer, 0, leidos);

                }
                salida.close();
                entrada.close();
                filePart.delete();

                path = request.getContextPath() + "/media/ofertas/" + oferta.getId() + "/" + filePart.getSubmittedFileName();

//                oferta.setImg(path);
                cn.getOfertas().edit(oferta);
                /*----------------------------------------------------------------------------------------------------*/

                alert = labels.get("ADDED_OFERTA", request);
                Util.sendMessage(null, "/admin", alert, request, response);
                return;

            }

        } catch (Exception ex) {
            alert = labels.get("CANT_ADD_OFFER", request);

        }
        Util.sendMessage("CUSTOM", "/admin", alert, request, response);

    }

    private void createFolder(String folder) {
        try {
            Files.createDirectories(Paths.get(folder));
        } catch (IOException e) {
            e.printStackTrace();

        }

    }

    @Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }
    @Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        processRequest(request, response);
    }

}
