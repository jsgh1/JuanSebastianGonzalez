package com.sena.La.Taza.de.Oro.model;

import jakarta.persistence.*;

@Entity
@Table(name = "proveedor")
public class proveedor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_proveedor")
    private int id_proveedor;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "contacto", nullable = false)
    private String contacto;

    // ✅ Constructor vacío
    public proveedor() {}

    // ✅ Constructor con todos los campos (para recuperación desde la DB)
    public proveedor(int id_proveedor, String nombre, String contacto) {
        this.id_proveedor = id_proveedor;
        this.nombre = nombre;
        this.contacto = contacto;
    }

    // ✅ Constructor sin ID (para creación de nuevos proveedores)
    public proveedor(String nombre, String contacto) {
        this.nombre = nombre;
        this.contacto = contacto;
    }

    public int getId_proveedor() { return id_proveedor; }
    public void setId_proveedor(int id_proveedor) { this.id_proveedor = id_proveedor; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getContacto() { return contacto; }
    public void setContacto(String contacto) { this.contacto = contacto; }
}
