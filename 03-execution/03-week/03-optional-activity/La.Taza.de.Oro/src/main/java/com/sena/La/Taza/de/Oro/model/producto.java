package com.sena.La.Taza.de.Oro.model;

import jakarta.persistence.*;

@Entity
@Table(name = "producto")
public class producto {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_producto;

    private String nombre;
    private String categoria;
    private double precio;
    private int cantidad; // ✅ Se agrega cantidad

    public producto() {}

    public producto(int id_producto, String nombre, String categoria, double precio, int cantidad) {
        this.id_producto = id_producto;
        this.nombre = nombre;
        this.categoria = categoria;
        this.precio = precio;
        this.cantidad = cantidad; // ✅ Se asigna cantidad
    }

    public int getId_producto() { return id_producto; }
    public void setId_producto(int id_producto) { this.id_producto = id_producto; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public int getCantidad() { return cantidad; } // ✅ Getter de cantidad
    public void setCantidad(int cantidad) { this.cantidad = cantidad; } // ✅ Setter de cantidad
}
