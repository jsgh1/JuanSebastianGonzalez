package com.sena.La.Taza.de.Oro.service;

import com.sena.La.Taza.de.Oro.DTO.empleadoDTO;
import com.sena.La.Taza.de.Oro.model.empleado;
import com.sena.La.Taza.de.Oro.repository.Iempleado;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class empleadoService {

    private final Iempleado empleadoRepository;

    public empleadoService(Iempleado empleadoRepository) {
        this.empleadoRepository = empleadoRepository;
    }

    public List<empleadoDTO> obtenerTodos() {
        return empleadoRepository.findAll()
                .stream().map(this::convertirADTO).collect(Collectors.toList());
    }

    public List<empleadoDTO> filtrarEmpleados(String nombre, String cargo) {
        return empleadoRepository.filtrarEmpleados(nombre, cargo)
                .stream().map(this::convertirADTO).collect(Collectors.toList());
    }

    public empleadoDTO agregarEmpleado(empleadoDTO empleadoDTO) {
        empleado empleado = convertirAEntidad(empleadoDTO);
        empleadoRepository.save(empleado);
        return convertirADTO(empleado);
    }

    public empleadoDTO actualizarEmpleado(int id, empleadoDTO empleadoDTO) {
        Optional<empleado> empleadoOpt = empleadoRepository.findById(id);
        if (!empleadoOpt.isPresent()) return null;

        empleado empleado = empleadoOpt.get();
        empleado.setNombre(empleadoDTO.getNombre());
        empleado.setCargo(empleadoDTO.getCargo());
        empleado.setSalario(empleadoDTO.getSalario());

        empleadoRepository.save(empleado);
        return convertirADTO(empleado);
    }

    public void eliminarEmpleado(int id) {
        empleadoRepository.deleteById(id);
    }

    private empleadoDTO convertirADTO(empleado empleado) {
        return new empleadoDTO(empleado.getId_empleado(), empleado.getNombre(), empleado.getCargo(), empleado.getSalario());
    }

    private empleado convertirAEntidad(empleadoDTO empleadoDTO) {
        return new empleado(empleadoDTO.getId_empleado(), empleadoDTO.getNombre(), empleadoDTO.getCargo(), empleadoDTO.getSalario());
    }
}
