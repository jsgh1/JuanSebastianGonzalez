package com.sena.La.Taza.de.Oro.controller;

import com.sena.La.Taza.de.Oro.DTO.ventaDTO;
import com.sena.La.Taza.de.Oro.service.ventaService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/venta")
public class ventaController {

    private final ventaService ventaService;

    public ventaController(ventaService ventaService) {
        this.ventaService = ventaService;
    }

    // ✅ Obtener todas las ventas
    @GetMapping
    public ResponseEntity<List<ventaDTO>> obtenerTodas() {
        return ResponseEntity.ok(ventaService.obtenerTodas());
    }

    // ✅ Registrar una nueva venta
    @PostMapping("/agregar")
    public ResponseEntity<ventaDTO> agregarVenta(@RequestBody ventaDTO ventaDTO) {
        return ResponseEntity.ok(ventaService.agregarVenta(ventaDTO));
    }

    // ✅ Actualizar una venta existente
    @PutMapping("/{id}")
    public ResponseEntity<ventaDTO> actualizarVenta(@PathVariable int id, @RequestBody ventaDTO ventaDTO) {
        Optional<ventaDTO> ventaOpt = Optional.ofNullable(ventaService.actualizarVenta(id, ventaDTO));
        if (!ventaOpt.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(ventaOpt.get());
    }

    // ✅ Eliminar una venta con verificación previa
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarVenta(@PathVariable int id) {
        Optional<ventaDTO> ventaOpt = Optional.ofNullable(ventaService.obtenerVentaPorId(id));
        if (!ventaOpt.isPresent()) {
            return ResponseEntity.notFound().build(); // 🔹 Retornar 404 si la venta no existe
        }

        ventaService.eliminarVenta(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/filtrar")
public ResponseEntity<List<ventaDTO>> filtrarVentas(
        @RequestParam(required = false) LocalDate fecha,
        @RequestParam(required = false) Integer id_vendedor) {

    List<ventaDTO> ventasFiltradas = ventaService.filtrarVentas(fecha, id_vendedor);
    return ResponseEntity.ok(ventasFiltradas);
}

}
