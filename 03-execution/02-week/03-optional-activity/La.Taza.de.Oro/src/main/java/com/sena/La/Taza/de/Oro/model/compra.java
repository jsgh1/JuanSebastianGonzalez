package com.sena.La.Taza.de.Oro.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "compra")
public class compra {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_compra")
    private int id_compra;

    @Column(name = "fecha", nullable = false)
    private LocalDate fecha;

    @Column(name = "total", nullable = false)
    private double total;

    public compra() {}

    public compra(int id_compra, LocalDate fecha, double total) {
        this.id_compra = id_compra;
        this.fecha = fecha;
        this.total = total;
    }

    public int getId_compra() { return id_compra; }
    public void setId_compra(int id_compra) { this.id_compra = id_compra; }

    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
}
