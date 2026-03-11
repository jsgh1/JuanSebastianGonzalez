package com.sena.La.Taza.de.Oro.controller;

import com.sena.La.Taza.de.Oro.DTO.ingredienteDTO;
import com.sena.La.Taza.de.Oro.service.ingredienteService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/ingrediente")
public class ingredienteController {

    private final ingredienteService ingredienteService;

    public ingredienteController(ingredienteService ingredienteService) {
        this.ingredienteService = ingredienteService;
    }

    @GetMapping
    public ResponseEntity<List<ingredienteDTO>> obtenerTodos() {
        return ResponseEntity.ok(ingredienteService.obtenerTodos());
    }

    @GetMapping("/filtrar")
    public ResponseEntity<List<ingredienteDTO>> filtrarIngredientes(@RequestParam(required = false) String nombre) {
        return ResponseEntity.ok(ingredienteService.filtrarIngredientes(nombre));
    }

    @PostMapping("/agregar")
    public ResponseEntity<ingredienteDTO> agregarIngrediente(@RequestBody ingredienteDTO ingredienteDTO) {
        return ResponseEntity.ok(ingredienteService.agregarIngrediente(ingredienteDTO));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ingredienteDTO> actualizarIngrediente(@PathVariable int id, @RequestBody ingredienteDTO ingredienteDTO) {
        return ResponseEntity.ok(ingredienteService.actualizarIngrediente(id, ingredienteDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarIngrediente(@PathVariable int id) {
        ingredienteService.eliminarIngrediente(id);
        return ResponseEntity.noContent().build();
    }
}
