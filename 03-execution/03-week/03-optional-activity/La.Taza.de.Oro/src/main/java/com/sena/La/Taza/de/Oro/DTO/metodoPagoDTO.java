package com.sena.La.Taza.de.Oro.DTO;

public class metodoPagoDTO {

    private int idMetodoPago;
    private String nombreMetodo;

    public metodoPagoDTO() {}

    public metodoPagoDTO(int idMetodoPago, String nombreMetodo) {
        this.idMetodoPago = idMetodoPago;
        this.nombreMetodo = nombreMetodo;
    }

    public int getIdMetodoPago() { return idMetodoPago; }
    public void setIdMetodoPago(int idMetodoPago) { this.idMetodoPago = idMetodoPago; }

    public String getNombreMetodo() { return nombreMetodo; }
    public void setNombreMetodo(String nombreMetodo) { this.nombreMetodo = nombreMetodo; }
}
