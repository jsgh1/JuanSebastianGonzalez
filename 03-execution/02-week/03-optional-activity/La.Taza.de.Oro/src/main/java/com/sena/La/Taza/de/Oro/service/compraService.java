package com.sena.La.Taza.de.Oro.service;

import com.sena.La.Taza.de.Oro.DTO.compraDTO;
import com.sena.La.Taza.de.Oro.model.compra;
import com.sena.La.Taza.de.Oro.repository.Icompra;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class compraService {

    private final Icompra compraRepository;

    public compraService(Icompra compraRepository) {
        this.compraRepository = compraRepository;
    }

    public List<compraDTO> obtenerTodas() {
        return compraRepository.findAll()
                .stream().map(this::convertirADTO).collect(Collectors.toList());
    }

    public List<compraDTO> filtrarCompras(LocalDate fecha) {
        return compraRepository.filtrarCompras(fecha)
                .stream().map(this::convertirADTO).collect(Collectors.toList());
    }

    public compraDTO agregarCompra(compraDTO compraDTO) {
        if (compraDTO.getFecha() == null) {
            compraDTO.setFecha(LocalDate.now()); // ✅ Asigna la fecha actual si está vacía
        }
    
        if (compraDTO.getFecha().isAfter(LocalDate.now())) {
            throw new IllegalArgumentException("No se puede registrar una compra con fecha futura.");
        }
    
        try {
            compra compra = convertirAEntidad(compraDTO);
            compraRepository.save(compra);
            return convertirADTO(compra);
        } catch (Exception e) {
            throw new RuntimeException("Error al guardar la compra en la base de datos: " + e.getMessage());
        }
    }
    

    public compraDTO actualizarCompra(int id, compraDTO compraDTO) {
        Optional<compra> compraOpt = compraRepository.findById(id);
        if (!compraOpt.isPresent()) return null;

        compra compra = compraOpt.get();
        compra.setFecha(compraDTO.getFecha());
        compra.setTotal(compraDTO.getTotal());

        compraRepository.save(compra);
        return convertirADTO(compra);
    }

    public void eliminarCompra(int id) {
        compraRepository.deleteById(id);
    }

    private compraDTO convertirADTO(compra compra) {
        return new compraDTO(compra.getId_compra(), compra.getFecha(), compra.getTotal());
    }

    private compra convertirAEntidad(compraDTO compraDTO) {
        return new compra(compraDTO.getId_compra(), compraDTO.getFecha(), compraDTO.getTotal());
    }
}
