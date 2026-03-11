package com.sena.La.Taza.de.Oro.model;

import jakarta.persistence.*;

@Entity
@Table(name = "metodo_pago")
public class metodoPago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_metodo_pago")
    private int idMetodoPago;

    @Column(name = "nombre_metodo", nullable = false, unique = true, length = 50)
    private String nombreMetodo;

    public metodoPago() {}

    public metodoPago(String nombreMetodo) {
        this.nombreMetodo = nombreMetodo;
    }

    public int getIdMetodoPago() { return idMetodoPago; }
    public void setIdMetodoPago(int idMetodoPago) { this.idMetodoPago = idMetodoPago; }

    public String getNombreMetodo() { return nombreMetodo; }
    public void setNombreMetodo(String nombreMetodo) { this.nombreMetodo = nombreMetodo; }
}
