# Almacenamiento y gestión de documentos

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Documentacion

## Estrategia de almacenamiento

### Database per Service

Cada servicio tiene su propia base de datos independiente:

| Servicio | BD | Motor | Propósito |
|----------|----|----|----------|
| iam-service | iam_db | PostgreSQL | Usuarios, roles, sesiones |
| reference-data-service | ref_db | PostgreSQL | Centros, regiones, parámetros |
| academic-management-service | academic_db | PostgreSQL | Programas, competencias, RAPs, fichas |
| training-environment-service | env_db | PostgreSQL | Ambientes, inventario, disponibilidad |
| scheduling-service | scheduling_db | PostgreSQL | Horarios, sesiones, conflictos |
| actors-service | actors_db | PostgreSQL | Instructores, aprendices, empresas |
| document-service | document_db | PostgreSQL | Documentos, plantillas, versiones |
| monitoring-service | monitoring_db | PostgreSQL | KPIs, alertas, métricas históricas |
| audit-service | audit_db | PostgreSQL (append-only) | Auditoría inmutable |

### Replicación de datos

Cuando un servicio necesita datos de otro:

1. **Opción 1: Consulta síncrona** (vía REST o gRPC)
   - Uso: Validaciones en tiempo real
   - Ejemplo: scheduling valida instructor disponible en actors-service

2. **Opción 2: Replicación eventual** (mediante eventos)
   - Uso: Datos frecuentemente consultados
   - Ejemplo: scheduling replica lista de RAPs activos de academic-management
   - Garantía: Consistencia eventual (< 5 segundos)

3. **Opción 3: Caché compartido** (Redis)
   - Uso: Datos de referencia que cambian poco
   - Ejemplo: centros, parámetros
   - TTL: 24 horas

## Documentos y archivos

### Estructura en Cloud Storage

```
cloud-storage/
├── certificados/
│   ├── {fichaId}/{aprendizId}/
│   │   ├── {ano}-{mes}-{dia}_certificado.pdf
│   │   └── {ano}-{mes}-{dia}_certificado.pdf (v2)
│
├── diplomas/
│   ├── {fichaId}/{aprendizId}/
│   │   └── {ano}-{mes}-{dia}_diploma.pdf
│
├── reportes/
│   ├── {año}/
│   │   ├── {mes}/
│   │   │   ├── reporte_ocupacion_{dia}.pdf
│   │   │   └── reporte_kpi_{dia}.xlsx
│
├── plantillas/
│   ├── certificado_base.docx
│   ├── diploma_base.docx
│   ├── reporte_horarios_base.docx
│
└── temporales/
    ├── {sessionId}/
    │   └── (archivos de generación, se limpian después de 24h)
```

### Servicio de documentos

**document-service** gestiona:
- Generación de PDFs a partir de plantillas
- Versionado de documentos
- Almacenamiento en cloud storage
- Ciclo de vida: borrador → generado → archivado
- Descarga y acceso control de permisos

### Plantillas

Basadas en **templates renderizables**:

**Certificado**
- Entrada: Ficha ID, Aprendiz ID, RAPs completados
- Salida: PDF con logo SENA, datos personales, competencias
- Variables: `{nombreAprendiz}`, `{documentoAprendiz}`, `{competencias}`, `{fecha}`

**Diploma**
- Entrada: Ficha ID, Aprendiz ID
- Salida: PDF de egresado
- Variables: Similar a certificado

**Reporte de horarios**
- Entrada: Ficha ID, Rango de fechas
- Salida: PDF con tabla horarios x instructor/ambiente

**Reporte KPI**
- Entrada: Centro ID, Fecha
- Salida: XLSX con ocupación, carga instructores, eficiencia

## Retención de datos

### Datos transaccionales

| Entidad | Retención | Motivo |
|---------|-----------|--------|
| Horarios completados | 7 años | Legal |
| Auditoría | 7 años | Legal |
| Documentos generados | 3 años | Consulta histórica |
| Sesiones de usuario | 90 días | Compliance |
| Logs de aplicación | 30 días | Troubleshooting |
| Alertas vistas | 1 año | Histórico |

### Limpieza automática

Jobs programados:
- **Diariamente (01:00):** Eliminar archivos temporales > 24h
- **Semanalmente (domingo 02:00):** Archivar auditoría > 7 años
- **Mensualmente (primer día 03:00):** Comprimir logs > 30 días

## Seguridad de datos

### Encriptación

- **En tránsito:** TLS 1.3 para REST, mTLS para gRPC
- **En reposo:** AES-256 para datos sensibles (documentos, audit)
- **Llaves:** Rotación trimestral, gestión en Key Vault

### Backup

- **Frecuencia:** Diaria para BD transaccionales
- **RPO:** < 1 hora
- **RTO:** < 4 horas
- **Retención:** 30 días en storage primario, 1 año en archive
- **Redundancia:** Multi-región (activa-pasiva)

### Compliance

- Cumplimiento SGPL (seguridad de la información)
- Cumplimiento normativa SENA sobre datos de aprendices
- Anonimización de PII en reportes analíticos"

