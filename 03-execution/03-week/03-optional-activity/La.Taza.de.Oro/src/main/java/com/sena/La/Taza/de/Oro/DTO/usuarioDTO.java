package com.sena.La.Taza.de.Oro.DTO;

public class usuarioDTO {
    private int id_usuario;
    private String nombre;
    private String correo;
    private String password; // 🔄 Agregué "password" para que se incluya en el DTO

    public usuarioDTO() {}

    public usuarioDTO(int id_usuario, String nombre, String correo, String password) {
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
