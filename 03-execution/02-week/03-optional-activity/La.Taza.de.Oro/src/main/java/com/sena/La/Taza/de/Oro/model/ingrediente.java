package com.sena.La.Taza.de.Oro.model;

import jakarta.persistence.*;

@Entity
@Table(name = "ingrediente")
public class ingrediente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_ingrediente")
    private int id_ingrediente;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "cantidad", nullable = false)
    private int cantidad;

    public ingrediente() {}

    public ingrediente(int id_ingrediente, String nombre, int cantidad) {
        this.id_ingrediente = id_ingrediente;
        this.nombre = nombre;
        this.cantidad = cantidad;
    }

    public int getId_ingrediente() { return id_ingrediente; }
    public void setId_ingrediente(int id_ingrediente) { this.id_ingrediente = id_ingrediente; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }
}
