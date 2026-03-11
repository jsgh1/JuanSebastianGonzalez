package com.sena.La.Taza.de.Oro.DTO;

import java.time.LocalDate;

public class compraDTO {
    private int id_compra;
    private LocalDate fecha;
    private double total;

    public compraDTO() {}

    public compraDTO(int id_compra, LocalDate fecha, double total) {
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
