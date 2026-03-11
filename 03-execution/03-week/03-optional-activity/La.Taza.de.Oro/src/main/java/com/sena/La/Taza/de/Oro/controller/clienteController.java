package com.sena.La.Taza.de.Oro.controller;

import com.sena.La.Taza.de.Oro.DTO.clienteDTO;
import com.sena.La.Taza.de.Oro.model.cliente;
import com.sena.La.Taza.de.Oro.service.clienteService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/cliente")
public class clienteController {

    private final clienteService clienteService;

    public clienteController(clienteService clienteService) {
        this.clienteService = clienteService;
    }

    @GetMapping
    public ResponseEntity<List<clienteDTO>> obtenerTodos() {
        List<clienteDTO> clientes = clienteService.obtenerTodos();
        return clientes.isEmpty() ? ResponseEntity.noContent().build() : ResponseEntity.ok(clientes);
    }

    @GetMapping("/{correo}")
    public ResponseEntity<clienteDTO> obtenerPorCorreo(@PathVariable String correo) {
        clienteDTO clienteEncontrado = clienteService.obtenerPorCorreo(correo);
        return clienteEncontrado != null ? ResponseEntity.ok(clienteEncontrado) : ResponseEntity.notFound().build();
    }

    @PostMapping("/agregar")
    public ResponseEntity<clienteDTO> agregarCliente(@RequestBody clienteDTO clienteDTO) {
        cliente nuevoCliente = new cliente(clienteDTO.getNombre(), clienteDTO.getCorreo(), clienteDTO.getTelefono());
        clienteDTO clienteGuardado = new clienteDTO(clienteService.agregarCliente(nuevoCliente).getIdCliente(),
                nuevoCliente.getNombre(), nuevoCliente.getCorreo(), nuevoCliente.getTelefono());
        return ResponseEntity.ok(clienteGuardado);
    }

    @PutMapping("/actualizar/{idCliente}")
    public ResponseEntity<clienteDTO> actualizarCliente(@PathVariable int idCliente, @RequestBody clienteDTO clienteDTO) {
        clienteDTO clienteActualizado = clienteService.actualizarCliente(idCliente, clienteDTO);
        return clienteActualizado != null ? ResponseEntity.ok(clienteActualizado) : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/eliminar/{idCliente}")
    public ResponseEntity<Void> eliminarCliente(@PathVariable int idCliente) {
        clienteService.eliminarCliente(idCliente);
        return ResponseEntity.noContent().build();
    }
}
