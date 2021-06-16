package es.fernandopal.autoescuela.model;

import es.fernandopal.autoescuela.entities.EstadoCoche;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

@Entity
@Table(name = "coches")
public class Coche implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id private String matricula;
    private String registro;
    private String itv;
    private EstadoCoche estadoCoche;

    public String getMatricula() {
        return matricula;
    }
    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getRegistro() {
        return registro;
    }
    public void setRegistro(String registro) {
        this.registro = registro;
    }

    public String getItv() {
        return itv;
    }
    public void setItv(String itv) {
        this.itv = itv;
    }

    public EstadoCoche getEstado() {
        return estadoCoche;
    }
    public void setEstado(EstadoCoche estadoCoche) {
        this.estadoCoche = estadoCoche;
    }
}
