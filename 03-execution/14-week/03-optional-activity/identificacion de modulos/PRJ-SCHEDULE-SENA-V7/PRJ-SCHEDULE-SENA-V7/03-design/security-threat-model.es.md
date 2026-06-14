# Modelo de Amenazas de Seguridad

| Vector | Descripción | Control | Severidad |
|--------|-------------|---------|-----------|
| Inyección SQL | Un atacante inyecta SQL malicioso a través de las entradas | Usar consultas parametrizadas mediante `pg` | Alta |
| XSS | Un atacante inyecta scripts mediante observaciones | React escapa la salida por defecto. Validar la entrada. | Alta |
| CSRF | Falsificación de petición entre sitios | Usar una configuración CORS adecuada y cookies `SameSite` | Media |
| Acceso no autenticado | Acceso a la API sin autenticación | (MVP futuro) Autenticación JWT | Alta |

*Nota: Para este MVP inicial, se confía en límites estrictos de red y en CORS para el control de acceso, ya que la autenticación está fuera del alcance de la prueba base de base de datos.*
