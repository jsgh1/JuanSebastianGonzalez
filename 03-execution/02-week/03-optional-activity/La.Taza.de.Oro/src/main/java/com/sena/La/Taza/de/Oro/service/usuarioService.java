package com.sena.La.Taza.de.Oro.service;

import com.sena.La.Taza.de.Oro.DTO.usuarioDTO;
import com.sena.La.Taza.de.Oro.model.usuario;
import com.sena.La.Taza.de.Oro.repository.Iusuario;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class usuarioService {

    private final Iusuario usuarioRepository;

    public usuarioService(Iusuario usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public List<usuarioDTO> obtenerTodos() {
        return usuarioRepository.findAll().stream()
                .map(this::convertirADTO)
                .collect(Collectors.toList());
    }

    public usuarioDTO obtenerPorId(int id) {
        Optional<usuario> usuario = usuarioRepository.findById(id);
        return usuario.map(this::convertirADTO).orElse(null);
    }

    public boolean existeCorreo(String correo) {
        return usuarioRepository.existsByCorreo(correo);
    }

    public boolean existeUsuario(int id) {
        return usuarioRepository.existsById(id);
    }

    public usuarioDTO guardar(usuarioDTO usuarioDto) {
        if (existeCorreo(usuarioDto.getCorreo())) {
            throw new IllegalArgumentException("El correo ya está registrado");
        }

        usuario usuario = convertirAEntidad(usuarioDto);
        usuarioRepository.save(usuario);
        return convertirADTO(usuario);
    }

    public usuarioDTO actualizar(int id, usuarioDTO usuarioDto) {
        if (!existeUsuario(id)) return null;
        usuario usuario = convertirAEntidad(usuarioDto);
        usuario.setId_usuario(id);
        usuarioRepository.save(usuario);
        return convertirADTO(usuario);
    }

    public void eliminar(int id) {
        if (existeUsuario(id)) {
            usuarioRepository.deleteById(id);
        }
    }

    // **✅ Corrección: Agregar `validarCredenciales` para el login**
    public boolean validarCredenciales(String correo, String password) {
        Optional<usuario> usuario = usuarioRepository.findByCorreo(correo);
        return usuario.isPresent() && usuario.get().getPassword().equals(password);
    }

    private usuarioDTO convertirADTO(usuario usuario) {
        return new usuarioDTO(usuario.getId_usuario(), usuario.getNombre(), usuario.getCorreo(), usuario.getPassword());
    }

    private usuario convertirAEntidad(usuarioDTO usuarioDto) {
        return new usuario(usuarioDto.getId_usuario(), usuarioDto.getNombre(), usuarioDto.getCorreo(), usuarioDto.getPassword());
    }

    public List<usuarioDTO> filtrarUsuarios(String nombre, String correo) {
        List<usuario> usuarios = usuarioRepository.filtrarUsuarios(nombre, correo);
        return usuarios.stream().map(this::convertirADTO).collect(Collectors.toList());
    }
    
}
