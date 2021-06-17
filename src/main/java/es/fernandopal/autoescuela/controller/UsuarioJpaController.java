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
import es.fernandopal.autoescuela.entities.Rango;
import es.fernandopal.autoescuela.model.Usuario;
import java.io.Serializable;
import java.util.List;
import java.util.Locale;
import javax.persistence.*;

/**
 *
 * @author fpalm
 */
public class UsuarioJpaController implements Serializable {

    public UsuarioJpaController(EntityManagerFactory emf) {
        this.emf = emf;
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Usuario usuario) throws Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            em.persist(usuario);
            etx.commit();
        } catch (Exception ex) {
            try {
                if(etx != null) etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            if (findUsuario(usuario.getDni()) != null) {
                throw new PreexistingEntityException("Usuario " + usuario + " already exists.", ex);
            }
            throw ex;
        } finally { if (em != null) em.close(); }
    }
    public void edit(Usuario usuario) throws Exception {
        EntityManager em = null;
        EntityTransaction etx = null;

        try {
            em = getEntityManager();
            etx = em.getTransaction();
            etx.begin();
            usuario = em.merge(usuario);
            etx.commit();
        } catch (Exception ex) {
            try {
                if(etx != null) etx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                String id = usuario.getDni();
                if (findUsuario(id) == null) {
                    throw new NonexistentEntityException("The usuario with id " + id + " no longer exists.");
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
            Usuario usuario;
            try {
                usuario = em.getReference(Usuario.class, id);
                usuario.getDni();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The usuario with id " + id + " no longer exists.", enfe);
            }
            em.remove(usuario);
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

    public List<Usuario> paginate(Pagination pagination) {
        final EntityManager em = getEntityManager();
        List<Usuario> result;
        try {
            final Query query = em.createQuery("SELECT u FROM Usuario u", Usuario.class);

            if(pagination != null) {
                query.setMaxResults(pagination.getMaxResults())
                        .setFirstResult(pagination.getPage() * pagination.getMaxResults());
            }

            result = query.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }
    public List<Usuario> getAll() {
        return paginate(null);
    }

    public List<Usuario> getByRango(String rango, Pagination pagination) {
        final EntityManager em = getEntityManager();
        List<Usuario> result;
        try {
            final Query query = em.createQuery("SELECT o FROM Usuario o WHERE o.rango = :rango", Usuario.class)
                    .setParameter("rango", Rango.valueOf(rango));

            if(pagination != null) {
                query.setMaxResults(pagination.getMaxResults())
                        .setFirstResult(pagination.getPage() * pagination.getMaxResults());
            }

            result = query.getResultList();
        } finally { if (em != null) em.close(); }
        return result;
    }
    public List<Usuario> getByRango(String rango) {
        return getByRango(rango, null);
    }

    public Usuario findUsuario(String id) {
        final EntityManager em = getEntityManager();
        Usuario result;
        try {
            result = em.find(Usuario.class, id);
        } finally { if (em != null) em.close(); }
        return result;
    }

    public int getCount() {
        final EntityManager em = getEntityManager();
        int result;
        try {
            final Query q = em.createQuery("select count(o) from Usuario as o", Usuario.class);
            result = ((Long) q.getSingleResult()).intValue();
        } finally { if (em != null) em.close(); }
        return result;
    }

}
