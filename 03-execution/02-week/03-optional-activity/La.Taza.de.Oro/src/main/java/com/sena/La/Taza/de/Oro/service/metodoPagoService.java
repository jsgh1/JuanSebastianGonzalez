package com.sena.La.Taza.de.Oro.service;

import com.sena.La.Taza.de.Oro.DTO.metodoPagoDTO;
import com.sena.La.Taza.de.Oro.model.metodoPago;
import com.sena.La.Taza.de.Oro.repository.ImetodoPago;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class metodoPagoService {

    private final ImetodoPago metodoPagoRepository;

    public metodoPagoService(ImetodoPago metodoPagoRepository) {
        this.metodoPagoRepository = metodoPagoRepository;
        inicializarMetodosPago();
    }

    // ✅ **Inicializa métodos de pago si no existen**
    private void inicializarMetodosPago() {
        List<String> metodosPredefinidos = Arrays.asList("Efectivo", "Tarjeta de Crédito", "Tarjeta de Débito", "Transferencia", "Paypal");

        for (String metodo : metodosPredefinidos) {
            if (metodoPagoRepository.findByNombreMetodo(metodo) == null) {
                metodoPagoRepository.save(new metodoPago(metodo));
            }
        }
    }

    public List<metodoPagoDTO> obtenerTodos() {
        return metodoPagoRepository.findAll().stream()
            .map(mp -> new metodoPagoDTO(mp.getIdMetodoPago(), mp.getNombreMetodo()))
            .toList();
    }

    public metodoPagoDTO obtenerPorNombre(String nombreMetodo) {
        metodoPago metodoEncontrado = metodoPagoRepository.findByNombreMetodo(nombreMetodo);
        return metodoEncontrado != null ? new metodoPagoDTO(metodoEncontrado.getIdMetodoPago(), metodoEncontrado.getNombreMetodo()) : null;
    }

    // ✅ **Agregar un método de pago**
    public metodoPagoDTO agregarMetodo(metodoPagoDTO metodoPagoDTO) {
        if (metodoPagoRepository.findByNombreMetodo(metodoPagoDTO.getNombreMetodo()) != null) {
            return null; // Evita duplicados
        }

        metodoPago nuevoMetodo = new metodoPago(metodoPagoDTO.getNombreMetodo());
        return new metodoPagoDTO(metodoPagoRepository.save(nuevoMetodo).getIdMetodoPago(), nuevoMetodo.getNombreMetodo());
    }

    // ✅ **Actualizar método de pago**
    public metodoPagoDTO actualizarMetodo(int idMetodoPago, metodoPagoDTO metodoPagoDTO) {
        metodoPago metodoExistente = metodoPagoRepository.findById(idMetodoPago).orElse(null);
        if (metodoExistente == null) return null;

        metodoExistente.setNombreMetodo(metodoPagoDTO.getNombreMetodo());

        return new metodoPagoDTO(metodoPagoRepository.save(metodoExistente).getIdMetodoPago(), metodoExistente.getNombreMetodo());
    }

    // ✅ **Eliminar método de pago**
    public void eliminarMetodo(int idMetodoPago) {
        metodoPagoRepository.deleteById(idMetodoPago);
    }
}
