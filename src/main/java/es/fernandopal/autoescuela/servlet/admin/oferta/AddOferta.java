package es.fernandopal.autoescuela.servlet.admin.oferta;

import es.fernandopal.autoescuela.controller.Controller;
import es.fernandopal.autoescuela.model.Oferta;

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
                alert = "Alguno de los valores introducidos no era válido";
                System.out.println("[CXX] nombre: " + nombre);
                System.out.println("[CXX] desc: " + desc);
                System.out.println("[CXX] precio: " + precio);
                System.out.println("[CXX] tipo: " + tipo);

            } else {
                final double precioAsNumber = Double.parseDouble(precio);
                final Controller cn = new Controller();

                oferta.setNombre(nombre);
                oferta.setDescripcion(desc);
                oferta.setPrecio(precioAsNumber);
                oferta.setImg(null);
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

                oferta.setImg(path);
                cn.getOfertas().edit(oferta);
                /*----------------------------------------------------------------------------------------------------*/

                alert = "Oferta añadida con éxito";

                response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/admin?alert=" + alert + "&error=false"));
                return;

            }

        } catch (Exception ex) {
            alert = "No se ha podido añadir la oferta. Error: " + ex.getMessage();

        }

        response.sendRedirect(request.getContextPath() + response.encodeRedirectURL("/admin?alert=" + alert + "&error"));

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
