package com.sena.La.Taza.de.Oro.service;

import com.sena.La.Taza.de.Oro.DTO.proveedorDTO;
import com.sena.La.Taza.de.Oro.model.proveedor;
import com.sena.La.Taza.de.Oro.repository.Iproveedor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class proveedorService {

    private final Iproveedor proveedorRepository;

    public proveedorService(Iproveedor proveedorRepository) {
        this.proveedorRepository = proveedorRepository;
    }

    // ✅ Obtener todos los proveedores
    public List<proveedorDTO> obtenerTodos() {
        return proveedorRepository.findAll()
                .stream().map(this::convertirADTO).collect(Collectors.toList());
    }

    // ✅ Registrar un proveedor nuevo
    public proveedorDTO agregarProveedor(proveedorDTO proveedorDTO) {
        validarDatos(proveedorDTO);
        proveedor nuevoProveedor = new proveedor(proveedorDTO.getNombre(), proveedorDTO.getContacto());
        proveedorRepository.save(nuevoProveedor);
        return convertirADTO(nuevoProveedor);
    }

    // ✅ Actualizar un proveedor existente
    public proveedorDTO actualizarProveedor(int id, proveedorDTO proveedorDTO) {
        proveedor proveedor = proveedorRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Proveedor no encontrado."));
        
        validarDatos(proveedorDTO);

        proveedor.setNombre(proveedorDTO.getNombre());
        proveedor.setContacto(proveedorDTO.getContacto());

        proveedorRepository.save(proveedor);
        return convertirADTO(proveedor);
    }

    // ✅ Eliminar un proveedor
    public void eliminarProveedor(int id) {
        if (!proveedorRepository.existsById(id)) {
            throw new IllegalArgumentException("Proveedor no encontrado.");
        }
        proveedorRepository.deleteById(id);
    }

    // ✅ Conversión de entidad a DTO
    private proveedorDTO convertirADTO(proveedor proveedor) {
        return new proveedorDTO(proveedor.getId_proveedor(), proveedor.getNombre(), proveedor.getContacto());
    }

    // ✅ Validación de datos antes de guardar
    private void validarDatos(proveedorDTO proveedorDTO) {
        if (proveedorDTO.getNombre() == null || proveedorDTO.getNombre().trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre del proveedor es obligatorio.");
        }
        if (proveedorDTO.getContacto() == null || proveedorDTO.getContacto().trim().isEmpty()) {
            throw new IllegalArgumentException("El contacto del proveedor es obligatorio.");
        }
    }

    public proveedorDTO obtenerProveedorPorId(int id) {
        proveedor proveedor = proveedorRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Proveedor no encontrado."));
        return convertirADTO(proveedor);
    }
    
}
