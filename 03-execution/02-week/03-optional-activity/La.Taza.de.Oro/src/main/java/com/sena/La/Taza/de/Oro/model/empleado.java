package com.sena.La.Taza.de.Oro.model;

import jakarta.persistence.*;

@Entity
@Table(name = "empleado")
public class empleado {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_empleado")
    private int id_empleado;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "cargo", nullable = false)
    private String cargo;

    @Column(name = "salario", nullable = false) // ✅ Se agrega salario
    private double salario;

    public empleado() {}

    public empleado(int id_empleado, String nombre, String cargo, double salario) {
        this.id_empleado = id_empleado;
        this.nombre = nombre;
        this.cargo = cargo;
        this.salario = salario; // ✅ Se asigna salario
    }

    public int getId_empleado() { return id_empleado; }
    public void setId_empleado(int id_empleado) { this.id_empleado = id_empleado; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCargo() { return cargo; }
    public void setCargo(String cargo) { this.cargo = cargo; }

    public double getSalario() { return salario; } // ✅ Getter de salario
    public void setSalario(double salario) { this.salario = salario; } // ✅ Setter de salario
}
