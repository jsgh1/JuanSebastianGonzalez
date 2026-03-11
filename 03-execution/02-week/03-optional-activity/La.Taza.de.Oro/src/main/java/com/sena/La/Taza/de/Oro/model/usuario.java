package com.sena.La.Taza.de.Oro.model;

import jakarta.persistence.*;

@Entity
@Table(name = "usuario")
public class usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private int id_usuario;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "correo", nullable = false, unique = true)
    private String correo;

    @Column(name = "password", nullable = false)
    private String password; // Hay que cambiarla para evitar errores ya que si ponemos contraseña la ñ nos da conflicto

    public usuario() {}

    public usuario(int id_usuario, String nombre, String correo, String password) {
        this.id_usuario = id_usuario;
        this.nombre = nombre;
        this.correo = correo;
        this.password = password;
    }

    public int getId_usuario() { return id_usuario; }
    public void setId_usuario(int id_usuario) { this.id_usuario = id_usuario; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
