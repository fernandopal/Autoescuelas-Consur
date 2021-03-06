/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.fernandopal.autoescuela.controller;

import es.fernandopal.autoescuela.controller.exceptions.NonexistentEntityException;
import es.fernandopal.autoescuela.controller.exceptions.PreexistingEntityException;
import es.fernandopal.autoescuela.controller.exceptions.RollbackFailureException;
import es.fernandopal.autoescuela.entities.EstadoCoche;
import es.fernandopal.autoescuela.entities.Pagination;
import es.fernandopal.autoescuela.model.Coche;
import es.fernandopal.autoescuela.model.Oferta;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;

/**
 *
 * @author fpalm
 */
public class OfertaJpaController implements Serializable {

    public OfertaJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Oferta oferta) throws Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            em.persist(oferta);
            etx.commit();
        } catch (Exception ex) {
            try {
                if(etx != null) etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            if (findOferta(oferta.getId()) != null) {
                throw new PreexistingEntityException("Oferta " + oferta + " already exists.", ex);
            }
            throw ex;
        } finally { if (em != null) em.close(); }
    }
    public void edit(Oferta oferta) throws Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            em = getEntityManager();
            oferta = em.merge(oferta);
            etx.commit();
        } catch (Exception ex) {
            try {
                if(etx != null) etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = oferta.getId();
                if (findOferta(id) == null) {
                    throw new NonexistentEntityException("The oferta with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally { if (em != null) em.close(); }
    }
    public void destroy(int id) throws Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            em = getEntityManager();
            Oferta oferta;
            try {
                oferta = em.getReference(Oferta.class, id);
                oferta.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The oferta with id " + id + " no longer exists.", enfe);
            }
            em.remove(oferta);
            etx.commit();
        } catch (Exception ex) {
            try {
                etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            throw ex;
        } finally { if (em != null) em.close(); }
    }

    public List<Oferta> paginate(Pagination pagination) {
        final EntityManager em = getEntityManager();
        List<Oferta> result;
        try {
            final Query query = em.createQuery("SELECT o FROM Oferta o WHERE o.descripcion != 'TIPO'", Oferta.class);

            if(pagination != null) {
                query.setMaxResults(pagination.getMaxResults())
                        .setFirstResult(pagination.getPage() * pagination.getMaxResults());
            }

            result = query.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }
    public List<Oferta> getAll() {
        return paginate(null);
    }

    public List<Oferta> findByType(String tipo, Pagination pagination) {
        final EntityManager em = getEntityManager();
        List<Oferta> result;
        try {
            final Query query = em.createQuery("SELECT o FROM Oferta o WHERE o.tipo = :tipo AND o.descripcion != 'TIPO'")
                    .setParameter("tipo", tipo);

            if(pagination != null) {
                query.setMaxResults(pagination.getMaxResults())
                        .setFirstResult(pagination.getPage() * pagination.getMaxResults());
            }

            result = query.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }
    public List<Oferta> findByType(String tipo) {
        return findByType(tipo, null);
    }

    public Oferta findOferta(int id) {
        final EntityManager em = getEntityManager();
        Oferta result;
        try {
            result = em.find(Oferta.class, id);
        } finally { if (em != null) em.close(); }
        return result;
    }
    public List<String> getAllTypes() {
        final EntityManager em = getEntityManager();
        List<String> result;
        try {
            result = em.createQuery("SELECT DISTINCT(o.tipo) FROM Oferta o WHERE o.descripcion = 'TIPO'").getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }
    public int getCountOf(String tipo) {
        final EntityManager em = getEntityManager();
        int result;
        try {
            final Query query = em.createQuery("SELECT COUNT(o) FROM Oferta o WHERE o.tipo = :tipo AND o.descripcion != 'TIPO'");
            final Query query1 = query.setParameter("tipo", tipo);
            result = ((Long) query1.getSingleResult()).intValue();
        } finally { if (em != null) em.close(); }
        return result;
    }
    public int getCount() {
        final EntityManager em = getEntityManager();
        int result;
        try {
            final Query q = em.createQuery("select count(o) from Oferta o WHERE o.descripcion != 'TIPO'");
            result = ((Long) q.getSingleResult()).intValue();
        } finally { if (em != null) em.close(); }
        return result;
    }

}
