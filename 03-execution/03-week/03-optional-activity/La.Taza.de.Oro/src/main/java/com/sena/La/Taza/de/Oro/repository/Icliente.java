package com.sena.La.Taza.de.Oro.repository;

import com.sena.La.Taza.de.Oro.model.cliente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Icliente extends JpaRepository<cliente, Integer> {
    cliente findByCorreo(String correo); // 🔹 Buscar cliente por correo electrónico
}
