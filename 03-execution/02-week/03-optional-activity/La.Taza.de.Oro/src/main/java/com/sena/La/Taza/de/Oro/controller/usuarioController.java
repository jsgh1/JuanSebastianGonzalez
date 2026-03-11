package com.sena.La.Taza.de.Oro.controller;

import com.sena.La.Taza.de.Oro.DTO.usuarioDTO;
import com.sena.La.Taza.de.Oro.service.usuarioService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/usuario")
@CrossOrigin(origins = "http://127.0.0.1:5500") // Permitir acceso desde el frontend
public class usuarioController {

    private final usuarioService usuarioService;

    public usuarioController(usuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    @GetMapping
    public ResponseEntity<List<usuarioDTO>> listarUsuarios() {
        return ResponseEntity.ok(usuarioService.obtenerTodos());
    }

    @GetMapping("/{id}")
    public ResponseEntity<usuarioDTO> obtenerUsuario(@PathVariable int id) {
        usuarioDTO usuario = usuarioService.obtenerPorId(id);
        return usuario != null ? ResponseEntity.ok(usuario) : ResponseEntity.status(HttpStatus.NOT_FOUND).build();
    }

    @GetMapping("/exists")
    public ResponseEntity<Boolean> verificarCorreo(@RequestParam String email) {
        boolean existe = usuarioService.existeCorreo(email);
        return ResponseEntity.ok(existe);
    }

    @PostMapping("/register")
    public ResponseEntity<Map<String, String>> registerUser(@RequestBody usuarioDTO usuario) {
        try {
            if (usuarioService.existeCorreo(usuario.getCorreo())) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "El correo ya está registrado."));
            }

            usuarioService.guardar(usuario);
            return ResponseEntity.ok(Map.of("message", "Registro exitoso"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("message", "Error interno en el servidor"));
        }
    }

    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> loginUser(@RequestBody usuarioDTO usuario) {
        try {
            boolean valid = usuarioService.validarCredenciales(usuario.getCorreo(), usuario.getPassword());
            if (!valid) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("message", "Credenciales incorrectas"));
            }
            return ResponseEntity.ok(Map.of("message", "Login exitoso", "token", "123456789ABCDEF"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("message", "Error interno en el servidor"));
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<usuarioDTO> actualizarUsuario(@PathVariable int id, @RequestBody usuarioDTO usuario) {
        usuarioDTO usuarioActualizado = usuarioService.actualizar(id, usuario);
        return usuarioActualizado != null ? ResponseEntity.ok(usuarioActualizado) : ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, String>> eliminarUsuario(@PathVariable int id) {
        if (!usuarioService.existeUsuario(id)) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("message", "Usuario no encontrado"));
        }
        usuarioService.eliminar(id);
        return ResponseEntity.ok(Map.of("message", "Usuario eliminado correctamente"));
    }

    @GetMapping("/filtrar")
public ResponseEntity<List<usuarioDTO>> filtrarUsuarios(
        @RequestParam(required = false) String nombre,
        @RequestParam(required = false) String correo) {
    List<usuarioDTO> usuariosFiltrados = usuarioService.filtrarUsuarios(nombre, correo);
    return ResponseEntity.ok(usuariosFiltrados);
}

}


