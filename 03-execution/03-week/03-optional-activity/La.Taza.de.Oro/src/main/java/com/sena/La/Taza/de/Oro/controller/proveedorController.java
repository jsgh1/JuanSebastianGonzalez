package com.sena.La.Taza.de.Oro.controller;

import com.sena.La.Taza.de.Oro.DTO.proveedorDTO;
import com.sena.La.Taza.de.Oro.service.proveedorService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/proveedor")
public class proveedorController {

    private final proveedorService proveedorService;

    public proveedorController(proveedorService proveedorService) {
        this.proveedorService = proveedorService;
    }

    // ✅ Obtener todos los proveedores
    @GetMapping
    public ResponseEntity<List<proveedorDTO>> obtenerTodos() {
        List<proveedorDTO> proveedores = proveedorService.obtenerTodos();
        return proveedores.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(proveedores);
    }

    // ✅ Registrar un nuevo proveedor
    @PostMapping("/agregar")
    public ResponseEntity<proveedorDTO> agregarProveedor(@RequestBody proveedorDTO proveedorDTO) {
        return ResponseEntity.ok(proveedorService.agregarProveedor(proveedorDTO));
    }

    // ✅ Actualizar un proveedor
    @PutMapping("/{id}")
    public ResponseEntity<proveedorDTO> actualizarProveedor(@PathVariable int id,
            @RequestBody proveedorDTO proveedorDTO) {
        return ResponseEntity.ok(proveedorService.actualizarProveedor(id, proveedorDTO));
    }

    // ✅ Eliminar un proveedor
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarProveedor(@PathVariable int id) {
        proveedorService.eliminarProveedor(id);
        return ResponseEntity.noContent().build();
    }

    // ✅ Obtener un proveedor por su ID
    @GetMapping("/{id}")
    public ResponseEntity<proveedorDTO> obtenerProveedorPorId(@PathVariable int id) {
        proveedorDTO proveedor = proveedorService.obtenerProveedorPorId(id);
        return ResponseEntity.ok(proveedor);
    }

}
