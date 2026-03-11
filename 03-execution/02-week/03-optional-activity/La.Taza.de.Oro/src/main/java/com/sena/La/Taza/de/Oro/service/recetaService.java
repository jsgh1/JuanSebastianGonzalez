package com.sena.La.Taza.de.Oro.service;

import com.sena.La.Taza.de.Oro.DTO.recetaDTO;
import com.sena.La.Taza.de.Oro.model.receta;
import com.sena.La.Taza.de.Oro.repository.Ireceta;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class recetaService {

    private final Ireceta recetaRepository;

    public recetaService(Ireceta recetaRepository) {
        this.recetaRepository = recetaRepository;
    }

    // ✅ Obtener todas las recetas
    public List<recetaDTO> obtenerTodas() {
        return recetaRepository.findAll()
                .stream().map(this::convertirADTO).collect(Collectors.toList());
    }

    // ✅ Registrar una nueva receta
    public recetaDTO agregarReceta(recetaDTO recetaDTO) {
        validarDatos(recetaDTO);

        receta nuevaReceta = new receta(recetaDTO.getNombre(), recetaDTO.getDescripcion());
        recetaRepository.save(nuevaReceta);
        return convertirADTO(nuevaReceta);
    }

    // ✅ Actualizar una receta existente
    public recetaDTO actualizarReceta(int id, recetaDTO recetaDTO) {
        receta receta = recetaRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Receta no encontrada."));

        validarDatos(recetaDTO);

        receta.setNombre(recetaDTO.getNombre());
        receta.setDescripcion(recetaDTO.getDescripcion());

        recetaRepository.save(receta);
        return convertirADTO(receta);
    }

    // ✅ Eliminar una receta existente
    public void eliminarReceta(int id) {
        if (!recetaRepository.existsById(id)) {
            throw new IllegalArgumentException("Receta no encontrada.");
        }
        recetaRepository.deleteById(id);
    }

    // ✅ Conversión de entidad a DTO
    private recetaDTO convertirADTO(receta receta) {
        return new recetaDTO(
                receta.getIdReceta(),
                receta.getNombre(),
                receta.getDescripcion());
    }

    private void validarDatos(recetaDTO recetaDTO) {
        if (recetaDTO.getNombre() == null || recetaDTO.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre de la receta es obligatorio.");
        }
        if (recetaDTO.getDescripcion() == null || recetaDTO.getDescripcion().trim().isEmpty()) {
            throw new IllegalArgumentException("La descripción de la receta es obligatoria.");
        }
        if (recetaDTO.getDescripcion().length() > 500) {
            throw new IllegalArgumentException("La descripción no puede superar los 500 caracteres.");
        }
    }

    public recetaDTO obtenerRecetaPorId(int id) {
        receta receta = recetaRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Receta no encontrada."));
        return convertirADTO(receta);
    }

}
