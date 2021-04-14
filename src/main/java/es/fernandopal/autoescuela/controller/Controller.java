package es.fernandopal.autoescuela.controller;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class Controller {
    private final EntityManagerFactory persistenceUnit = Persistence.createEntityManagerFactory("Autoescuela");

    private final CocheJpaController coches = new CocheJpaController(persistenceUnit);
    private final OfertaJpaController ofertas = new OfertaJpaController(persistenceUnit);
    private final PreguntaJpaController preguntas = new PreguntaJpaController(persistenceUnit);
    private final RespuestaJpaController respuestas = new RespuestaJpaController(persistenceUnit);
    private final TestJpaController tests = new TestJpaController(persistenceUnit);
    private final UsuarioJpaController usuarios = new UsuarioJpaController(persistenceUnit);
    private final IntentoJpaController intentos = new IntentoJpaController(persistenceUnit);

    public EntityManagerFactory getPersistenceUnit() {
        return persistenceUnit;
    }
    public CocheJpaController getCoches() {
        return coches;
    }
    public OfertaJpaController getOfertas() {
        return ofertas;
    }
    public PreguntaJpaController getPreguntas() {
        return preguntas;
    }
    public RespuestaJpaController getRespuestas() {
        return respuestas;
    }
    public TestJpaController getTests() {
        return tests;
    }
    public UsuarioJpaController getUsuarios() {
        return usuarios;
    }
    public IntentoJpaController getIntentos() {
        return intentos;
    }
}