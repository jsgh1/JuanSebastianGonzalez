package com.sena.La.Taza.de.Oro.repository;

import com.sena.La.Taza.de.Oro.model.metodoPago;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ImetodoPago extends JpaRepository<metodoPago, Integer> {
    metodoPago findByNombreMetodo(String nombreMetodo);
}
