package es.fernandopal.autoescuela.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
public class Respuesta implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String respuesta;
    private boolean correcta;

    @ManyToOne(fetch = FetchType.LAZY) @JoinColumn(name = "PREGUNTA_ID")
    private Pregunta pregunta;

    public Respuesta() {}
    public Respuesta(String respuesta, boolean correcta) {
        this.respuesta = respuesta;
        this.correcta = correcta;
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getRespuesta() {
        return respuesta;
    }
    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }

    public boolean isCorrecta() {
        return correcta;
    }
    public void setCorrecta(boolean correcta) {
        this.correcta = correcta;
    }

    public Pregunta getPregunta() {
        return pregunta;
    }
    public void setPregunta(Pregunta pregunta) {
        this.pregunta = pregunta;
    }
}
