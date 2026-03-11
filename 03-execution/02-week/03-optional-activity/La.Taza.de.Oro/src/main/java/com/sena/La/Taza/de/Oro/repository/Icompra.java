package com.sena.La.Taza.de.Oro.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.sena.La.Taza.de.Oro.model.compra;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface Icompra extends JpaRepository<compra, Integer> {

    @Query("SELECT c FROM compra c WHERE " +
           "(:fecha IS NULL OR c.fecha = :fecha)")
    List<compra> filtrarCompras(@Param("fecha") LocalDate fecha);
}
