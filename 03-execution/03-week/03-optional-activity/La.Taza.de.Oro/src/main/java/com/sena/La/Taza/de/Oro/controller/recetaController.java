package com.sena.La.Taza.de.Oro.controller;

import com.sena.La.Taza.de.Oro.DTO.recetaDTO;
import com.sena.La.Taza.de.Oro.service.recetaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/receta")
public class recetaController {

    private final recetaService recetaService;

    public recetaController(recetaService recetaService) {
        this.recetaService = recetaService;
    }

    // ✅ Obtener todas las recetas
    @GetMapping
    public ResponseEntity<List<recetaDTO>> obtenerTodas() {
        List<recetaDTO> recetas = recetaService.obtenerTodas();
        return recetas.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(recetas);
    }

    // ✅ Registrar una nueva receta
    @PostMapping("/agregar")
    public ResponseEntity<recetaDTO> agregarReceta(@RequestBody recetaDTO recetaDTO) {
        recetaDTO nuevaReceta = recetaService.agregarReceta(recetaDTO);
        return ResponseEntity.ok(nuevaReceta);
    }

    // ✅ Actualizar una receta existente
    @PutMapping("/{id}")
    public ResponseEntity<recetaDTO> actualizarReceta(@PathVariable int id, @RequestBody recetaDTO recetaDTO) {
        recetaDTO recetaActualizada = recetaService.actualizarReceta(id, recetaDTO);
        return ResponseEntity.ok(recetaActualizada);
    }

    // ✅ Eliminar una receta
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarReceta(@PathVariable int id) {
        recetaService.eliminarReceta(id);
        return ResponseEntity.noContent().build();
    }

    // ✅ Obtener una receta por su ID
    @GetMapping("/{id}")
    public ResponseEntity<recetaDTO> obtenerRecetaPorId(@PathVariable int id) {
        recetaDTO receta = recetaService.obtenerRecetaPorId(id);
        return ResponseEntity.ok(receta);
    }

}
