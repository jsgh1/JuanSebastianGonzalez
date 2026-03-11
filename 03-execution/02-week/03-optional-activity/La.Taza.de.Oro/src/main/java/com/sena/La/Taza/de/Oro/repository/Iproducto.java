package com.sena.La.Taza.de.Oro.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.sena.La.Taza.de.Oro.model.producto;

import java.util.List;

@Repository
public interface Iproducto extends JpaRepository<producto, Integer> {
    
    @Query("SELECT p FROM producto p WHERE " +
           "(:nombre IS NULL OR LOWER(p.nombre) LIKE LOWER(CONCAT('%', :nombre, '%'))) " +
           "AND (:categoria IS NULL OR LOWER(p.categoria) LIKE LOWER(CONCAT('%', :categoria, '%')))")
    List<producto> filtrarProductos(@Param("nombre") String nombre, @Param("categoria") String categoria);
}
