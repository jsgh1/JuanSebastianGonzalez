# Reglas de límites entre servicios

> Estado: En progreso | Ultima actualizacion: 2026-06-22
> Autor: Equipo del proyecto | Equipo: Documentacion

## Principios

1. **Autonomía:** Cada servicio es independiente; cambios internos no afectan otros
2. **Aislamiento de datos:** No compartir BDs, no acceso directo a tablas ajenas
3. **Comunicación clara:** APIs bien definidas (REST, gRPC, eventos)
4. **Responsabilidad única:** Un servicio = un contexto de dominio
5. **Contrato estable:** APIs son contrato; breaking changes requieren versionado

## Límites permitidos

### ✅ Comunicación entre servicios

#### 1. REST (Lectura)
```
Scheduling → GET /api/v1/fichas/{fichaId}
          → academic-management-service
```

#### 2. gRPC (Operaciones internas heavy)
```
Scheduling → GetRaps(rapIds)
          → academic-management-service
```

#### 3. Eventos asincronos
```
Academic publica FichaCreada
        → Scheduling escucha + reacciona
        → Audit escucha + registra
```

#### 4. Caché distribuido (Redis)
```
Scheduling cachea lista de competencias
        → Invalida al escuchar CompetenciaModificada
        → TTL: 4 horas máximo
```

#### 5. Suscripción a eventos
```
Audit se suscribe a TODOS los eventos
    → No modifica, solo registra
    → Append-only, nunca falla
```

## Límites prohibidos

### ❌ Acceso directo a BD

```javascript
// PROHIBIDO:
const fichas = db.query(`
  SELECT * FROM academic_db.fichas WHERE fichaId = $1
`); // ← No: acceso directo a tabla ajena

// PERMITIDO:
const ficha = await academicService.getFicha(fichaId);
```

### ❌ Transacciones distribuidas

```javascript
// PROHIBIDO:
const trx = db.transaction();
try {
  await scheduling.createHorario(trx, ...); // scheduling_db
  await academic.updateFicha(trx, ...);     // academic_db ← PROHIBIDO
  await trx.commit();
} catch (e) {
  await trx.rollback();
}

// PERMITIDO (eventual consistency):
const horario = await scheduling.createHorario(...);
Scheduling publica HorarioAsignado
  → Academic escucha y actualiza su caché
  → Consistencia eventual (< 5s)
```

### ❌ Compartir estructuras de datos

```typescript
// PROHIBIDO:
interface Ficha {
  id: string;
  academicData: {
    programa: string;
    competencias: Competencia[]; // ← Acoplamiento directo
  };
  schedulingData: {
    horarios: Horario[];
  };
}

// PERMITIDO (DTO separado por límite):
interface FichaDTO {
  id: string;
  programa: string;
  coordinador: string;
}

interface HorarioDTO {
  id: string;
  fichaId: string;
  franja: string;
}
```

### ❌ Breaking changes sin versionado

```typescript
// PROHIBIDO:
// academic-management v2 elimina campo
interface CompetenciaV2 {
  id: string;
  nombre: string;
  // ❌ ANTES: especialidad: string;
}

// PERMITIDO:
// academic-management respeta v1 y expone v2
GET /api/v1/competencias/{id} // Retorna schema v1
GET /api/v2/competencias/{id} // Retorna schema v2
// O header: Accept: application/vnd.competencia+json;version=2
```

### ❌ Sincronización de datos en tiempo real entre BDs

```javascript
// PROHIBIDO:
// Replicación bidireccional en vivo
Replication {
  source: academic_db,
  target: scheduling_db,
  mode: 'real-time'
}

// PERMITIDO:
// Replicación unidireccional (eventos → caché)
Scheduling cachea datos académicos
  → Se invalida al escuchar CompetenciaModificada
```

## Límites por tipo de dato

### Datos de referencia (Change rarely)
- **Dueño:** reference-data-service
- **Estrategia:** Caché distribuido (24h TTL)
- **Acceso:** REST + caché

**Ejemplo:** Centros, parámetros

### Datos transaccionales (Change often)
- **Dueño:** Servicio específico
- **Estrategia:** Lectura por API, cambios por eventos
- **Acceso:** REST para lectura, eventos para cambios

**Ejemplo:** Horarios, fichas, instructores

### Datos de auditoría (Write-only append)
- **Dueño:** audit-service
- **Estrategia:** Append-only, nunca lectura directa
- **Acceso:** Evento entrada, BD interna append

**Ejemplo:** Registro de auditoría

### Datos calculados (Recomputable)
- **Dueño:** Servicio que los calcula
- **Estrategia:** Caché corto TTL (1-4h)
- **Acceso:** REST para lectura, recalcular a demanda

**Ejemplo:** KPIs, métricas

## Patrones de evolución

### Agregar un campo a API

```
1. Agregar campo nuevo en v2 de la API
2. Dejar v1 funcionando
3. Clientes migran gradualmente
4. Deprecar v1 después de 3 meses
```

### Agregar un servicio nuevo

```
1. Definir bounded context y responsabilidad
2. Planificar qué datos replica de otros
3. Definir eventos que publica/suscribe
4. Implementar con DB propia (aislada)
5. Integrar vía eventos y APIs
6. Documentar en service-catalog.md
```

### Refactorizar responsabilidad entre servicios

```
1. Crear nuevo servicio con nueva responsabilidad
2. Servicio antiguo replica datos del nuevo (eventual)
3. Clientes migran gradualmente
4. Desmantelar responsabilidad vieja del antiguo
5. Cuando 100% migrado, deprecar servicio antiguo
```

## Anti-patrones a evitar

| Anti-patrón | Consecuencia | Alternativa |
|---|---|---|
| Servicio consulta 5+ servicios para 1 request | Lentitud, acoplamiento | Replicar datos vía eventos, caché |
| Evento con payload > 10KB | Tráfico, latencia | Enviar ID, consumidor consulta detalles |
| Circuito abierto > 30s | Cascada de fallos | Fallback a caché, graceful degradation |
| Transacción distribuida | Deadlocks, timeouts | Saga, compensating transactions |
| Compartir BD entre 2+ servicios | Acoplamiento directo | Cada uno su DB, comunicación por API |
| Request síncrono en cadena (A→B→C→D) | Timeout cascada | Publicar evento, que cada uno reaccione |
| Versionado ignorado en cambios | Breaking changes | Header Accept-Version, /api/v1/, /api/v2/ |

## Checklist de compliance

Antes de crear un servicio nuevo o cambiar límites:

- [ ] ¿Cada servicio tiene su propia BD?
- [ ] ¿Los cambios se comunican vía eventos o APIs?
- [ ] ¿Hay APIs versionadas para breaking changes?
- [ ] ¿Se documentan dependencias en dependency-map.md?
- [ ] ¿Se registra el servicio en service-catalog.md?
- [ ] ¿Se definen eventos en event-catalog.md?
- [ ] ¿Hay caché distribuido para datos de referencia?
- [ ] ¿Se implementó circuit breaker en llamadas síncronas?
- [ ] ¿La responsabilidad del servicio está clara (bounded context)?"

