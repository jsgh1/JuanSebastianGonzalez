package com.sena.La.Taza.de.Oro.service;

import com.sena.La.Taza.de.Oro.DTO.productoDTO;
import com.sena.La.Taza.de.Oro.model.producto;
import com.sena.La.Taza.de.Oro.repository.Iproducto;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class productoService {

    private final Iproducto productoRepository;

    public productoService(Iproducto productoRepository) {
        this.productoRepository = productoRepository;
    }

    // **Obtener todos los productos**
    public List<productoDTO> obtenerTodos() {
        return productoRepository.findAll()
                .stream().map(this::convertirADTO).collect(Collectors.toList());
    }

    // **Filtrar productos por nombre y categoría**
    public List<productoDTO> filtrarProductos(String nombre, String categoria) {
        return productoRepository.filtrarProductos(nombre, categoria)
                .stream().map(this::convertirADTO).collect(Collectors.toList());
    }

    // **Registrar un nuevo producto**
    public productoDTO agregarProducto(productoDTO productoDTO) {
        producto producto = convertirAEntidad(productoDTO);
        productoRepository.save(producto);
        return convertirADTO(producto);
    }

    // **Actualizar producto existente**
    public productoDTO actualizarProducto(int id, productoDTO productoDTO) {
        Optional<producto> productoOpt = productoRepository.findById(id);
        if (!productoOpt.isPresent()) return null;

        producto producto = productoOpt.get();
        producto.setNombre(productoDTO.getNombre());
        producto.setCategoria(productoDTO.getCategoria());
        producto.setPrecio(productoDTO.getPrecio());
        producto.setCantidad(productoDTO.getCantidad()); // ✅ Se asegura que la cantidad también se actualice

        productoRepository.save(producto);
        return convertirADTO(producto);
    }

    // **Eliminar producto por ID**
    public void eliminarProducto(int id) {
        productoRepository.deleteById(id);
    }

    // **Convertir entidad a DTO**
    private productoDTO convertirADTO(producto producto) {
        return new productoDTO(producto.getId_producto(), producto.getNombre(), producto.getCategoria(), producto.getPrecio(), producto.getCantidad());
    }

    // **Convertir DTO a entidad**
    private producto convertirAEntidad(productoDTO productoDTO) {
        return new producto(productoDTO.getId_producto(), productoDTO.getNombre(), productoDTO.getCategoria(), productoDTO.getPrecio(), productoDTO.getCantidad());
    }
}
