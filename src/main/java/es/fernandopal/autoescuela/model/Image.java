package es.fernandopal.autoescuela.model;

import javax.persistence.*;

@MappedSuperclass @Entity(name = "ImageStorage")
public class Image {

    @Id @GeneratedValue
    private Long id;

    @Lob @Basic(fetch = FetchType.LAZY)
    private byte[] image;

    public Long getId() { return id; }
}