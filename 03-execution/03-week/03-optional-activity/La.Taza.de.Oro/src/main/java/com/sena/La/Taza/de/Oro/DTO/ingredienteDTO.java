package com.sena.La.Taza.de.Oro.DTO;

public class ingredienteDTO {
    private int id_ingrediente;
    private String nombre;
    private int cantidad;

    public ingredienteDTO() {}

    public ingredienteDTO(int id_ingrediente, String nombre, int cantidad) {
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
