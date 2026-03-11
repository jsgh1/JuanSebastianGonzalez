package com.sena.La.Taza.de.Oro.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "venta")
public class venta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_venta")
    private int id_venta;

    @Column(name = "fecha", nullable = false)
    private LocalDate fecha;

    @Column(name = "total", nullable = false)
    private double total;

    @ManyToOne
    @JoinColumn(name = "id_vendedor", nullable = false)
    private empleado vendedor;

    public venta() {}

    public venta(int id_venta, LocalDate fecha, double total, empleado vendedor) {
        this.id_venta = id_venta;
        this.fecha = fecha;
        this.total = total;
        this.vendedor = vendedor;
    }

    public int getId_venta() { return id_venta; }
    public void setId_venta(int id_venta) { this.id_venta = id_venta; }

    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public empleado getVendedor() { return vendedor; }
    public void setVendedor(empleado vendedor) { this.vendedor = vendedor; }
}
