package com.sena.La.Taza.de.Oro.repository;

import com.sena.La.Taza.de.Oro.model.proveedor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface Iproveedor extends JpaRepository<proveedor, Integer> {}
