package com.sena.La.Taza.de.Oro.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.sena.La.Taza.de.Oro.model.usuario;
import java.util.List;
import java.util.Optional;

@Repository
public interface Iusuario extends JpaRepository<usuario, Integer> {
    boolean existsByCorreo(String correo);
    Optional<usuario> findByCorreoAndPassword(String correo, String password);
    Optional<usuario> findByCorreo(String correo);

    // ✅ **Filtro dinámico de usuarios**
    @Query("SELECT u FROM usuario u WHERE " +
           "(:nombre IS NULL OR LOWER(u.nombre) LIKE LOWER(CONCAT('%', :nombre, '%'))) " +
           "AND (:correo IS NULL OR LOWER(u.correo) LIKE LOWER(CONCAT('%', :correo, '%')))")
    List<usuario> filtrarUsuarios(@Param("nombre") String nombre, @Param("correo") String correo);
}
