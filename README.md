# Sistema de Auditoría con Triggers (SQL)

Este proyecto implementa un mecanismo de auditoría automático sobre una tabla de clientes en MySQL utilizando disparadores (`TRIGGERS`).

## 📁 Contenido del Script

1. **Estructura**: Creación de la tabla `clientes` y la tabla `auditoria_cliente`.
2. **Triggers implementados**:
   * `triggerInsert`: Registra en la auditoría cada vez que se agrega un cliente nuevo.
   * `triggerUpdate`: Guarda el historial con los valores anteriores y nuevos ante cualquier modificación.
   * `triggerDelete`: Almacena el registro de los datos que fueron eliminados del sistema.

## 🚀 Cómo usarlo
Ejecutá el script en tu base de datos MySQL:
```sql
SOURCE triggers.sql;
