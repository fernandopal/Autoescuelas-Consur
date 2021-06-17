/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package es.fernandopal.autoescuela.controller;

import es.fernandopal.autoescuela.controller.exceptions.NonexistentEntityException;
import es.fernandopal.autoescuela.controller.exceptions.PreexistingEntityException;
import es.fernandopal.autoescuela.controller.exceptions.RollbackFailureException;
import es.fernandopal.autoescuela.entities.Pagination;
import es.fernandopal.autoescuela.model.Test;
import es.fernandopal.autoescuela.model.Usuario;

import java.io.Serializable;
import java.util.List;
import javax.persistence.*;

/**
 *
 * @author fpalm
 */
public class TestJpaController implements Serializable {

    public TestJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Test test, boolean merge) throws Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            if(merge) em.merge(test); else em.persist(test);
            etx.commit();
        } catch (Exception ex) {
            try {
                if(etx != null) etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            if (findTest(test.getId()) != null) {
                throw new PreexistingEntityException("Test " + test + " already exists.", ex);
            }
            throw ex;
        } finally { if (em != null) em.close(); }
    }

    public void edit(Test test) throws Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            test = em.merge(test);
            etx.commit();
        } catch (Exception ex) {
            try {
                if(etx != null) etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                int id = test.getId();
                if (findTest(id) == null) {
                    throw new NonexistentEntityException("The test with id " + id + " no longer exists.");
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
            Test test;
            try {
                test = em.getReference(Test.class, id);
                test.getId();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The test with id " + id + " no longer exists.", enfe);
            }
            em.remove(test);
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

    public List<Test> paginate(Pagination pagination) {
        final EntityManager em = getEntityManager();
        List<Test> result;
        try {
            final Query query = em.createQuery("SELECT t FROM Test t WHERE t.nombre != 'TEMA' ORDER BY t.nombre ASC", Test.class);

            if(pagination != null) {
                query.setMaxResults(pagination.getMaxResults())
                        .setFirstResult(pagination.getPage() * pagination.getMaxResults());
            }

            result = query.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }
    public List<Test> getAll() {
        return paginate(null);
    }

    public List<String> getAllTemas(Pagination pagination) {
        final EntityManager em = getEntityManager();
        List<String> result;
        try {
            final Query query = em.createQuery("SELECT DISTINCT(t.tema) FROM Test t WHERE t.nombre = 'TEMA' ORDER BY t.tema ASC");

            if(pagination != null) {
                query.setMaxResults(pagination.getMaxResults())
                        .setFirstResult(pagination.getPage() * pagination.getMaxResults());
            }

            result = query.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }
    public List<String> getAllTemas() {
        return getAllTemas(null);
    }

    public List<Test> findByTema(int tema) {
        final EntityManager em = getEntityManager();
        List<Test> result;
        try {
            final Query query = em.createQuery("SELECT o FROM Test o WHERE o.tema = :tema AND o.nombre != 'TEMA'");
            final Query query1 = query.setParameter("tema", tema);
            result = query1.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }
    public Test findTest(int id) {
        final EntityManager em = getEntityManager();
        Test result;
        try {
            result = em.find(Test.class, id);
        } finally { if (em != null) em.close(); }
        return result;
    }
    public int getCount() {
        final EntityManager em = getEntityManager();
        int result;
        try {
            final Query q = em.createQuery("select count(o) from Test o WHERE o.nombre != 'TEMA'");
            result = ((Long) q.getSingleResult()).intValue();
        } finally { if (em != null) em.close(); }
        return result;
    }

}
