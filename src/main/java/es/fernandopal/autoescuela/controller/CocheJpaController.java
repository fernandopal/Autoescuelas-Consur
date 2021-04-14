/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.fernandopal.autoescuela.controller;

import es.fernandopal.autoescuela.controller.exceptions.NonexistentEntityException;
import es.fernandopal.autoescuela.controller.exceptions.PreexistingEntityException;
import es.fernandopal.autoescuela.controller.exceptions.RollbackFailureException;
import es.fernandopal.autoescuela.model.Coche;
import java.io.Serializable;
import java.util.List;
import javax.persistence.*;

/**
 *
 * @author fpalm
 */
public class CocheJpaController implements Serializable {

    public CocheJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Coche coche) throws Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            em.persist(coche);
            etx.commit();
        } catch (Exception ex) {
            try {
                if(etx != null) etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            if (findCoche(coche.getMatricula()) != null) {
                throw new PreexistingEntityException("Coche " + coche + " already exists.", ex);
            }
            throw ex;
        } finally { if (em != null) em.close(); }
    }

    public void edit(Coche coche) throws Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            em = getEntityManager();
            coche = em.merge(coche);
            etx.commit();
        } catch (Exception ex) {
            try {
                if(etx != null) etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                String id = coche.getMatricula();
                if (findCoche(id) == null) {
                    throw new NonexistentEntityException("The coche with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally { if (em != null) em.close(); }
    }

    public void destroy(String id) throws Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            em = getEntityManager();
            Coche coche;
            try {
                coche = em.getReference(Coche.class, id);
                coche.getMatricula();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The coche with id " + id + " no longer exists.", enfe);
            }
            em.remove(coche);
            etx.commit();
        } catch (Exception ex) {
            try {
                if(etx != null) etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            throw ex;
        } finally { if (em != null) em.close(); }
    }

    public List<Coche> getAll() {
        return findCocheEntities(true, -1, -1);
    }

    public List<Coche> findCocheEntities(int maxResults, int firstResult) {
        return findCocheEntities(false, maxResults, firstResult);
    }

    private List<Coche> findCocheEntities(boolean all, int maxResults, int firstResult) {
        final EntityManager em = getEntityManager();
        List<Coche> result;
        try {
            Query q = em.createQuery("select object(o) from Coche as o");
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            result = q.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }

    public Coche findCoche(String id) {
        final EntityManager em = getEntityManager();
        Coche result;
        try {
            result = em.find(Coche.class, id);
        } finally { if (em != null) em.close(); }
        return result;
    }

    public int getCount() {
        final EntityManager em = getEntityManager();
        int result;
        try {
            final Query q = em.createQuery("select count(o) from Coche as o");
            result = ((Long) q.getSingleResult()).intValue();
        } finally { if (em != null) em.close(); }
        return result;
    }

}
