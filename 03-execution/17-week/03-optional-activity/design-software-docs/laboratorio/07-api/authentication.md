# Autenticacion y autorizacion

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Seguridad / API

## Servicio responsable

iam-service administra usuario, rol, permiso, sesion y token.

## Flujo base

1. Usuario envia credenciales.
2. iam-service valida credenciales.
3. iam-service emite token.
4. Los servicios validan token y permisos requeridos.
5. Operaciones criticas se registran en audit-service.

## Reglas

- Tokens con expiracion.
- Refresh token controlado por sesion.
- Permisos por rol.
- Endpoints administrativos requieren rol elevado.
- No guardar contrasenas en texto plano.

## Respuestas

| Caso | Respuesta |
|---|---|
| Sin token | 401 |
| Token invalido | 401 |
| Token valido sin permiso | 403 |
| Permiso valido | Continua solicitud |

