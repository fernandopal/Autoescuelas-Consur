package es.fernandopal.autoescuela.model;

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
}
