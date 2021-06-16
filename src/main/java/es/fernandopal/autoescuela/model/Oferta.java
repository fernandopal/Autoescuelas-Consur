package es.fernandopal.autoescuela.model;


import es.fernandopal.autoescuela.controller.Controller;
import javax.persistence.*;
import java.awt.*;
import java.io.Serializable;

@Entity
@Table(name = "ofertas")
public class Oferta implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String nombre;
    private String tipo;
    private String descripcion;
//    private String img;
    @Lob
    @Basic(fetch = FetchType.LAZY)
    private byte[] img;
    private double precio;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTipo() {
        return tipo;
    }
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecio() {
        return precio;
    }
    public void setPrecio(double precio) {
        this.precio = precio;
    }

//    public String getImg() {
//        return img;
//    }
//    public void setImg(String img) {
//        this.img = img;
//    }

//    public Image generateImage(Usuario user) {
//        final Controller cn = new Controller();
//        final String id = user.getDni();
//        StreamResource sr = new StreamResource("user", () ->  {
//            Usuario attached = cn.us
//            return new ByteArrayInputStream(attached.getProfilePicture());
//        });
//        sr.setContentType("image/png");
//        Image image = new Image(sr, "profile-picture");
//        return image;
//    }
}
