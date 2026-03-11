package com.sena.La.Taza.de.Oro.controller;

import com.sena.La.Taza.de.Oro.DTO.compraDTO;
import com.sena.La.Taza.de.Oro.service.compraService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/compra")
public class compraController {

    private final compraService compraService;

    public compraController(compraService compraService) {
        this.compraService = compraService;
    }

    @GetMapping
    public ResponseEntity<List<compraDTO>> obtenerTodas() {
        return ResponseEntity.ok(compraService.obtenerTodas());
    }

    @GetMapping("/filtrar")
    public ResponseEntity<List<compraDTO>> filtrarCompras(@RequestParam(required = false) LocalDate fecha) {
        return ResponseEntity.ok(compraService.filtrarCompras(fecha));
    }

    @PostMapping("/agregar")
public ResponseEntity<?> agregarCompra(@RequestBody compraDTO compraDTO) {
    try {
        if (compraDTO.getFecha() == null || compraDTO.getTotal() <= 0) {
            return ResponseEntity.badRequest().body("Fecha inválida o total menor a cero.");
        }

        compraDTO nuevaCompra = compraService.agregarCompra(compraDTO);
        return ResponseEntity.ok(nuevaCompra);

    } catch (Exception e) {
        return ResponseEntity.status(500).body("Error interno al registrar la compra: " + e.getMessage());
    }
}


    @PutMapping("/{id}")
    public ResponseEntity<compraDTO> actualizarCompra(@PathVariable int id, @RequestBody compraDTO compraDTO) {
        return ResponseEntity.ok(compraService.actualizarCompra(id, compraDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarCompra(@PathVariable int id) {
        compraService.eliminarCompra(id);
        return ResponseEntity.noContent().build();
    }
}
