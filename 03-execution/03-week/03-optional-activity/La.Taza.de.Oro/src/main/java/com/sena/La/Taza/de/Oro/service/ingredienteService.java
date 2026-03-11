package com.sena.La.Taza.de.Oro.service;

import com.sena.La.Taza.de.Oro.DTO.ingredienteDTO;
import com.sena.La.Taza.de.Oro.model.ingrediente;
import com.sena.La.Taza.de.Oro.repository.Iingrediente;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ingredienteService {

    private final Iingrediente ingredienteRepository;

    public ingredienteService(Iingrediente ingredienteRepository) {
        this.ingredienteRepository = ingredienteRepository;
    }

    public List<ingredienteDTO> obtenerTodos() {
        return ingredienteRepository.findAll()
                .stream().map(this::convertirADTO).collect(Collectors.toList());
    }

    public List<ingredienteDTO> filtrarIngredientes(String nombre) {
        return ingredienteRepository.filtrarIngredientes(nombre)
                .stream().map(this::convertirADTO).collect(Collectors.toList());
    }

    public ingredienteDTO agregarIngrediente(ingredienteDTO ingredienteDTO) {
        ingrediente ingrediente = convertirAEntidad(ingredienteDTO);
        ingredienteRepository.save(ingrediente);
        return convertirADTO(ingrediente);
    }

    public ingredienteDTO actualizarIngrediente(int id, ingredienteDTO ingredienteDTO) {
        Optional<ingrediente> ingredienteOpt = ingredienteRepository.findById(id);
        if (!ingredienteOpt.isPresent()) return null;

        ingrediente ingrediente = ingredienteOpt.get();
        ingrediente.setNombre(ingredienteDTO.getNombre());
        ingrediente.setCantidad(ingredienteDTO.getCantidad());

        ingredienteRepository.save(ingrediente);
        return convertirADTO(ingrediente);
    }

    public void eliminarIngrediente(int id) {
        ingredienteRepository.deleteById(id);
    }

    private ingredienteDTO convertirADTO(ingrediente ingrediente) {
        return new ingredienteDTO(ingrediente.getId_ingrediente(), ingrediente.getNombre(), ingrediente.getCantidad());
    }

    private ingrediente convertirAEntidad(ingredienteDTO ingredienteDTO) {
        return new ingrediente(ingredienteDTO.getId_ingrediente(), ingredienteDTO.getNombre(), ingredienteDTO.getCantidad());
    }
}
