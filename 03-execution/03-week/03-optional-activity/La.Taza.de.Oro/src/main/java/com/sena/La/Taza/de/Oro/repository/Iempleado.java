package com.sena.La.Taza.de.Oro.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.sena.La.Taza.de.Oro.model.empleado;

import java.util.List;

@Repository
public interface Iempleado extends JpaRepository<empleado, Integer> {

    @Query("SELECT e FROM empleado e WHERE " +
           "(:nombre IS NULL OR LOWER(e.nombre) LIKE LOWER(CONCAT('%', :nombre, '%'))) " +
           "AND (:cargo IS NULL OR LOWER(e.cargo) LIKE LOWER(CONCAT('%', :cargo, '%')))")
    List<empleado> filtrarEmpleados(@Param("nombre") String nombre, @Param("cargo") String cargo);
}
