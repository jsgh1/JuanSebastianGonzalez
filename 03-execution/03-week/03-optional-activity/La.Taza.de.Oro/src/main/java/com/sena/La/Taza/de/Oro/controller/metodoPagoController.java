package com.sena.La.Taza.de.Oro.controller;

import com.sena.La.Taza.de.Oro.DTO.metodoPagoDTO;
import com.sena.La.Taza.de.Oro.service.metodoPagoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/metodoPago")
public class metodoPagoController {

    private final metodoPagoService metodoPagoService;

    public metodoPagoController(metodoPagoService metodoPagoService) {
        this.metodoPagoService = metodoPagoService;
    }

    @GetMapping
    public ResponseEntity<List<metodoPagoDTO>> obtenerTodos() {
        List<metodoPagoDTO> metodos = metodoPagoService.obtenerTodos();
        return metodos.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(metodos);
    }

    @GetMapping("/{nombreMetodo}")
    public ResponseEntity<metodoPagoDTO> obtenerPorNombre(@PathVariable String nombreMetodo) {
        metodoPagoDTO metodoEncontrado = metodoPagoService.obtenerPorNombre(nombreMetodo);
        return metodoEncontrado != null ? ResponseEntity.ok(metodoEncontrado) : ResponseEntity.notFound().build();
    }

    @PostMapping("/agregar")
    public ResponseEntity<metodoPagoDTO> agregarMetodo(@RequestBody metodoPagoDTO metodoPagoDTO) {
        metodoPagoDTO metodoGuardado = metodoPagoService.agregarMetodo(metodoPagoDTO);
        return ResponseEntity.ok(metodoGuardado);
    }

    @PutMapping("/actualizar/{idMetodoPago}")
    public ResponseEntity<metodoPagoDTO> actualizarMetodo(@PathVariable int idMetodoPago, @RequestBody metodoPagoDTO metodoPagoDTO) {
        metodoPagoDTO metodoActualizado = metodoPagoService.actualizarMetodo(idMetodoPago, metodoPagoDTO);
        return metodoActualizado != null ? ResponseEntity.ok(metodoActualizado) : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/eliminar/{idMetodoPago}")
    public ResponseEntity<Void> eliminarMetodo(@PathVariable int idMetodoPago) {
        metodoPagoService.eliminarMetodo(idMetodoPago);
        return ResponseEntity.noContent().build();
    }
}
