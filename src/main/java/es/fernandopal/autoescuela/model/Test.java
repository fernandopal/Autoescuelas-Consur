package es.fernandopal.autoescuela.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
public class Test implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String nombre;
    private int tema;

    @OneToMany(mappedBy = "test", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Pregunta> preguntas;

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

    public int getTema() {
        return tema;
    }
    public void setTema(int tema) {
        this.tema = tema;
    }

    public List<Pregunta> getPreguntas() {
        return preguntas;
    }
    public void setPreguntas(List<Pregunta> preguntas) {
        this.preguntas = preguntas;
    }
}