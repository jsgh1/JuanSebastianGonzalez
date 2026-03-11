package com.sena.La.Taza.de.Oro.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.sena.La.Taza.de.Oro.model.ingrediente;

import java.util.List;

@Repository
public interface Iingrediente extends JpaRepository<ingrediente, Integer> {

    @Query("SELECT i FROM ingrediente i WHERE " +
           "(:nombre IS NULL OR LOWER(i.nombre) LIKE LOWER(CONCAT('%', :nombre, '%')))")
    List<ingrediente> filtrarIngredientes(@Param("nombre") String nombre);
}
