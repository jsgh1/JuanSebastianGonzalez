package com.sena.La.Taza.de.Oro.controller;

import com.sena.La.Taza.de.Oro.DTO.empleadoDTO;
import com.sena.La.Taza.de.Oro.service.empleadoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/empleado")
public class empleadoController {

    private final empleadoService empleadoService;

    public empleadoController(empleadoService empleadoService) {
        this.empleadoService = empleadoService;
    }

    @GetMapping
    public ResponseEntity<List<empleadoDTO>> obtenerTodos() {
        return ResponseEntity.ok(empleadoService.obtenerTodos());
    }

    @GetMapping("/filtrar")
    public ResponseEntity<List<empleadoDTO>> filtrarEmpleados(
            @RequestParam(required = false) String nombre,
            @RequestParam(required = false) String cargo) {
        return ResponseEntity.ok(empleadoService.filtrarEmpleados(nombre, cargo));
    }

    @PostMapping("/agregar")
    public ResponseEntity<empleadoDTO> agregarEmpleado(@RequestBody empleadoDTO empleadoDTO) {
        return ResponseEntity.ok(empleadoService.agregarEmpleado(empleadoDTO));
    }

    @PutMapping("/{id}")
    public ResponseEntity<empleadoDTO> actualizarEmpleado(@PathVariable int id, @RequestBody empleadoDTO empleadoDTO) {
        return ResponseEntity.ok(empleadoService.actualizarEmpleado(id, empleadoDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarEmpleado(@PathVariable int id) {
        empleadoService.eliminarEmpleado(id);
        return ResponseEntity.noContent().build();
    }
}
