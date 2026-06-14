# Guía de Patrones

## Patrón Elegido
Arquitectura Limpia (Dominio, Repositorio, Servicio, Handler).

## Estructura de Carpetas (Nivel 3)
```
backend/
├── src/
│   ├── domain/
│   ├── repository/
│   ├── service/
│   ├── handler/
```

## Reglas de Dependencia
- `domain` no depende de nada.
- `repository` depende de `domain` y del controlador de base de datos.
- `service` depende de `domain` y de las interfaces de `repository`.
- `handler` depende de `service`.

## Lista de Validación
- [x] ¿El dominio tiene imports del framework? (Debe ser NO)
- [x] ¿Los handlers contienen lógica de negocio? (Debe ser NO)
- [x] ¿Los nombres de archivo están en `snake_case`? (Sí)
