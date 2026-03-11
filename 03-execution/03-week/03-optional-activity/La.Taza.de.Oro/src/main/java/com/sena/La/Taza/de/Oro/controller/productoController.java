package com.sena.La.Taza.de.Oro.controller;

import com.sena.La.Taza.de.Oro.DTO.productoDTO;
import com.sena.La.Taza.de.Oro.service.productoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/producto")
public class productoController {

    private final productoService productoService;

    public productoController(productoService productoService) {
        this.productoService = productoService;
    }

    @GetMapping
    public ResponseEntity<List<productoDTO>> obtenerTodos() {
        return ResponseEntity.ok(productoService.obtenerTodos());
    }

    @GetMapping("/filtrar")
    public ResponseEntity<List<productoDTO>> filtrarProductos(
            @RequestParam(required = false) String nombre,
            @RequestParam(required = false) String categoria) {
        return ResponseEntity.ok(productoService.filtrarProductos(nombre, categoria));
    }

    @PostMapping("/agregar")
    public ResponseEntity<productoDTO> agregarProducto(@RequestBody productoDTO productoDTO) {
        return ResponseEntity.ok(productoService.agregarProducto(productoDTO));
    }

    @PutMapping("/{id}")
    public ResponseEntity<productoDTO> actualizarProducto(@PathVariable int id, @RequestBody productoDTO productoDTO) {
        return ResponseEntity.ok(productoService.actualizarProducto(id, productoDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarProducto(@PathVariable int id) {
        productoService.eliminarProducto(id);
        return ResponseEntity.noContent().build();
    }
}
