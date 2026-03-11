package com.sena.La.Taza.de.Oro.service;

import com.sena.La.Taza.de.Oro.DTO.clienteDTO;
import com.sena.La.Taza.de.Oro.model.cliente;
import com.sena.La.Taza.de.Oro.repository.Icliente;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class clienteService {

    private final Icliente clienteRepository;

    public clienteService(Icliente clienteRepository) {
        this.clienteRepository = clienteRepository;
    }

    public List<clienteDTO> obtenerTodos() {
        return clienteRepository.findAll().stream()
            .map(cliente -> new clienteDTO(cliente.getIdCliente(), cliente.getNombre(), cliente.getCorreo(), cliente.getTelefono()))
            .toList();
    }

    public clienteDTO obtenerPorCorreo(String correo) {
        cliente clienteEncontrado = clienteRepository.findByCorreo(correo);
        return clienteEncontrado != null ? new clienteDTO(clienteEncontrado.getIdCliente(), clienteEncontrado.getNombre(), clienteEncontrado.getCorreo(), clienteEncontrado.getTelefono()) : null;
    }

    public cliente agregarCliente(cliente nuevoCliente) {
        return clienteRepository.save(nuevoCliente);
    }

    public clienteDTO actualizarCliente(int idCliente, clienteDTO clienteDTO) {
        cliente clienteExistente = clienteRepository.findById(idCliente).orElse(null);
        if (clienteExistente == null) return null;

        clienteExistente.setNombre(clienteDTO.getNombre());
        clienteExistente.setCorreo(clienteDTO.getCorreo());
        clienteExistente.setTelefono(clienteDTO.getTelefono());

        return new clienteDTO(clienteRepository.save(clienteExistente).getIdCliente(),
                clienteExistente.getNombre(),
                clienteExistente.getCorreo(),
                clienteExistente.getTelefono());
    }

    public void eliminarCliente(int idCliente) {
        clienteRepository.deleteById(idCliente);
    }
}
