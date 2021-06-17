/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.fernandopal.autoescuela.controller;

import es.fernandopal.autoescuela.controller.exceptions.NonexistentEntityException;
import es.fernandopal.autoescuela.controller.exceptions.PreexistingEntityException;
import es.fernandopal.autoescuela.controller.exceptions.RollbackFailureException;
import es.fernandopal.autoescuela.model.Intento;
import es.fernandopal.autoescuela.model.Test;
import es.fernandopal.autoescuela.model.Usuario;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 *
 * @author fpalm
 */
public class IntentoJpaController implements Serializable {

    public IntentoJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Intento intento) throws Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            em.persist(intento);
            etx.commit();
        } catch (Exception ex) {
            try {
                etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            if (findIntento(intento.getId()) != null) {
                throw new PreexistingEntityException("Intento " + intento + " already exists.", ex);
            }
            throw ex;
        } finally { if (em != null) em.close(); }
    }

    public void edit(Intento intento) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            em = getEntityManager();
            intento = em.merge(intento);
            etx.commit();
        } catch (Exception ex) {
            try {
                etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = intento.getId();
                if (findIntento(id) == null) {
                    throw new NonexistentEntityException("The intento with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally { if (em != null) em.close(); }
    }

    public void destroy(String id) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            em = getEntityManager();
            Intento intento;
            try {
                intento = em.getReference(Intento.class, id);
                intento.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The intento with id " + id + " no longer exists.", enfe);
            }
            em.remove(intento);
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

    public List<Intento> getAll() {
        return findIntentoEntities(true, -1, -1);
    }

    public List<Intento> findIntentoEntities(int maxResults, int firstResult) {
        return findIntentoEntities(false, maxResults, firstResult);
    }

    private List<Intento> findIntentoEntities(boolean all, int maxResults, int firstResult) {
        final EntityManager em = getEntityManager();
        List<Intento> result;
        try {
            Query q = em.createQuery("select object(o) from Intento as o");
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            result = q.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }

    public Intento findIntento(int id) {
        final EntityManager em = getEntityManager();
        Intento result;
        try {
            result = em.find(Intento.class, id);
        } finally { if (em != null) em.close(); }
        return result;
    }

    public int getIntentoCount() {
        final EntityManager em = getEntityManager();
        int result;
        try {
            final Query q = em.createQuery("select count(o) from Intento as o");
            result = ((Long) q.getSingleResult()).intValue();
        } finally { if (em != null) em.close(); }
        return result;
    }

    public List<Intento> getByUser(Usuario usuario, Test test) {
        final EntityManager em = getEntityManager();
        List<Intento> result;
        try {
            final Query query = em.createQuery("SELECT intento FROM Intento intento WHERE intento.test = :test AND intento.usuario = :usuario");
            final Query query1 = query.setParameter("test", test).setParameter("usuario", usuario);
            result = query1.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }

    public List<Intento> getAprobados(Usuario usuario, Test test) {
        final EntityManager em = getEntityManager();
        List<Intento> result;
        try {
            final Query query = em.createQuery("SELECT intento FROM Intento intento WHERE intento.test = :test AND intento.usuario = :usuario AND intento.aprobado = true");
            final Query query1 = query.setParameter("test", test).setParameter("usuario", usuario);
            result = query1.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }

    public List<Intento> getSuspensos(Usuario usuario, Test test) {
        final EntityManager em = getEntityManager();
        List<Intento> result;
        try {
            final Query query = em.createQuery("SELECT intento FROM Intento intento WHERE intento.test = :test AND intento.usuario = :usuario AND intento.aprobado = false");
            final Query query1 = query.setParameter("test", test).setParameter("usuario", usuario);
            result = query1.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }

}
