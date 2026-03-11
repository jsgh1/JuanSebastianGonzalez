package com.sena.La.Taza.de.Oro.service;

import com.sena.La.Taza.de.Oro.DTO.ventaDTO;
import com.sena.La.Taza.de.Oro.model.venta;
import com.sena.La.Taza.de.Oro.model.empleado;
import com.sena.La.Taza.de.Oro.repository.Iventa;
import com.sena.La.Taza.de.Oro.repository.Iempleado;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ventaService {

    private final Iventa ventaRepository;
    private final Iempleado empleadoRepository;

    public ventaService(Iventa ventaRepository, Iempleado empleadoRepository) {
        this.ventaRepository = ventaRepository;
        this.empleadoRepository = empleadoRepository;
    }

    public List<ventaDTO> obtenerTodas() {
        return ventaRepository.findAll()
                .stream().map(this::convertirADTO).collect(Collectors.toList());
    }

    public ventaDTO agregarVenta(ventaDTO ventaDTO) {
        // ✅ Validar que la fecha sea válida
        if (ventaDTO.getFecha() == null) {
            ventaDTO.setFecha(LocalDate.now()); // 🔹 Asigna la fecha actual si está vacía
        } else if (ventaDTO.getFecha().isAfter(LocalDate.now())) {
            throw new IllegalArgumentException("No se puede registrar una venta con fecha futura.");
        }

        // ✅ Validar existencia del vendedor
        Optional<empleado> vendedorOpt = empleadoRepository.findById(ventaDTO.getId_vendedor());
        if (!vendedorOpt.isPresent()) {
            throw new IllegalArgumentException("Vendedor no encontrado.");
        }

        // ✅ Crear y almacenar la venta con el vendedor asignado
        venta nuevaVenta = new venta(ventaDTO.getId_venta(), ventaDTO.getFecha(), ventaDTO.getTotal(), vendedorOpt.get());
        ventaRepository.save(nuevaVenta);
        return convertirADTO(nuevaVenta);
    }

    // ✅ Obtener venta por ID para verificar si existe antes de actualizar o eliminar
    public ventaDTO obtenerVentaPorId(int id) {
        Optional<venta> ventaOpt = ventaRepository.findById(id);
        if (!ventaOpt.isPresent()) {
            throw new IllegalArgumentException("Venta no encontrada.");
        }
        return convertirADTO(ventaOpt.get());
    }

    // ✅ Actualizar una venta existente
    public ventaDTO actualizarVenta(int id, ventaDTO ventaDTO) {
        Optional<venta> ventaOpt = ventaRepository.findById(id);
        if (!ventaOpt.isPresent()) {
            throw new IllegalArgumentException("Venta no encontrada.");
        }

        venta venta = ventaOpt.get();
        venta.setFecha(ventaDTO.getFecha());
        venta.setTotal(ventaDTO.getTotal());

        Optional<empleado> vendedorOpt = empleadoRepository.findById(ventaDTO.getId_vendedor());
        if (!vendedorOpt.isPresent()) {
            throw new IllegalArgumentException("Vendedor no encontrado.");
        }

        venta.setVendedor(vendedorOpt.get());
        ventaRepository.save(venta);
        return convertirADTO(venta);
    }

    // ✅ Eliminar una venta existente
    public void eliminarVenta(int id) {
        if (!ventaRepository.existsById(id)) {
            throw new IllegalArgumentException("Venta no encontrada.");
        }
        ventaRepository.deleteById(id);
    }

    public List<ventaDTO> filtrarVentas(LocalDate fecha, Integer id_vendedor) {
    List<venta> ventas = ventaRepository.findAll();

    if (fecha != null) {
        ventas = ventas.stream()
                .filter(v -> v.getFecha().equals(fecha))
                .collect(Collectors.toList());
    }

    if (id_vendedor != null) {
        ventas = ventas.stream()
                .filter(v -> v.getVendedor().getId_empleado() == id_vendedor)
                .collect(Collectors.toList());
    }

    return ventas.stream().map(this::convertirADTO).collect(Collectors.toList());
}


    private ventaDTO convertirADTO(venta venta) {
        return new ventaDTO(
            venta.getId_venta(), 
            venta.getFecha(), 
            venta.getTotal(), 
            venta.getVendedor().getId_empleado(),
            venta.getVendedor().getNombre() // ✅ Se añade el nombre del vendedor
        );
    }
    
}
