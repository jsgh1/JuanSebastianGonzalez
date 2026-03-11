package com.sena.La.Taza.de.Oro.DTO;

public class recetaDTO {
    private int idReceta;
    private String nombre;
    private String descripcion;

    public recetaDTO() {}

    public recetaDTO(int idReceta, String nombre, String descripcion) {
        this.idReceta = idReceta;
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
