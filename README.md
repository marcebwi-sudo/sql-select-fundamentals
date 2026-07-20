# sql-select-fundamentals
# TechStore — Fundamentos de Consultas SQL (SELECT & Alias)

**Autoria:** Marcela del Pilar Vargas Bermúdez  
**Repositorio:** `sql-select-fundamentals`  
**Proyecto:** Módulo de Análisis de Datos 4 para TechStore 

---

## Descripción del Proyecto

Este proyecto contiene las consultas desarrolladas para el equipo de Finanzas de TechStore. El objetivo es extraer métricas e información operativa desde la base de datos de ventas (`sales`), transformando nombres técnicos de campos en reportes claros y accesibles para usuarios no técnicos.

---

Preguntas de Documentación Técnica

1. ¿Por qué es una mala práctica usar `SELECT *` en producción?

Usar `SELECT *` en sistemas en producción o dashboards automatizados es altamente desaconsejado por las siguientes razones:

Rendimiento e impacto en memoria:
Traer todas las columnas de una tabla sobrecarga la red y consume memoria innecesaria en el servidor de la base de datos y en la aplicación consumidora. Si la tabla tiene decenas de columnas o millones de filas, la consulta será lenta e ineficiente.
Mantenibilidad y ruptura de código:
Si la estructura de la tabla cambia en la base de datos, por ejemplo, si se eliminan, reordenan o agregan columnas las aplicaciones, vistas o dashboards dependientes pueden fallar o procesar datos en el orden incorrecto.
Seguridad y privacidad:
`SELECT *` puede exponer campos sensibles o confidenciales que la persona o el reporte no necesitan ver.

2. ¿Por qué son importantes los alias (`AS`) para un stakeholder no técnico?

Los stakeholders (como los equipos de finanzas, ventas o dirección) no tienen por qué conocer el modelo entidad-relación ni los nombres técnicos de la base de datos, que a menudo están en inglés o usan abreviaturas crípticas.

Ejemplos:
Sin alias: `SELECT total_amount FROM sales;`  
Resultado: Una columna encabezada como `total_amount`. Esto puede generar dudas de varios tipos, por ejemplo, es en dólares?, ¿incluye impuestos, ¿es costo o ingreso?
Con alias: `SELECT total_amount AS monto_total_facturado FROM sales;`  
Resultado: Una columna clara llamada `monto_total_facturado`.

Los alias eliminan la fricción de interpretación, previenen errores de negocio y permiten que los reportes sean autoexplicativos desde el primer segundo.
