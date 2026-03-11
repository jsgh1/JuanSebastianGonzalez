package com.sena.La.Taza.de.Oro.model;

import jakarta.persistence.*;

@Entity
@Table(name = "receta")
public class receta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_receta", updatable = false)
    private int idReceta;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "descripcion", nullable = false, length = 500)
    private String descripcion;

    // ✅ Constructor vacío
    public receta() {}

    // ✅ Constructor con todos los campos
    public receta(int idReceta, String nombre, String descripcion) {
        this.idReceta = idReceta;
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    // ✅ Constructor sin ID (para creación de nuevas recetas)
    public receta(String nombre, String descripcion) {
        this.nombre = nombre;
        this.descripcion = descripcion;
    }

    public int getIdReceta() { return idReceta; }
    public void setIdReceta(int idReceta) { this.idReceta = idReceta; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
}
