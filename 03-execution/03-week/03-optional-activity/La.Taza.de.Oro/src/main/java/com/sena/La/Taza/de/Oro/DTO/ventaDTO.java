package com.sena.La.Taza.de.Oro.DTO;

import java.time.LocalDate;

public class ventaDTO {
    private int id_venta;
    private LocalDate fecha;
    private double total;
    private int id_vendedor;
    private String nombre_vendedor; // ✅ Se añade el nombre del vendedor

    public ventaDTO() {}

    public ventaDTO(int id_venta, LocalDate fecha, double total, int id_vendedor, String nombre_vendedor) {
        this.id_venta = id_venta;
        this.fecha = fecha;
        this.total = total;
        this.id_vendedor = id_vendedor;
        this.nombre_vendedor = nombre_vendedor;
    }

    public int getId_venta() { return id_venta; }
    public void setId_venta(int id_venta) { this.id_venta = id_venta; }

    public LocalDate getFecha() { return fecha; }
    public void setFecha(LocalDate fecha) { this.fecha = fecha; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public int getId_vendedor() { return id_vendedor; }
    public void setId_vendedor(int id_vendedor) { this.id_vendedor = id_vendedor; }

    public String getNombre_vendedor() { return nombre_vendedor; }
    public void setNombre_vendedor(String nombre_vendedor) { this.nombre_vendedor = nombre_vendedor; }
}
