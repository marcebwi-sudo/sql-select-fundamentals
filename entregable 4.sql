-- =========================================================================
-- MÓDULO 4: PRE-ENTREGA - CONSULTAS SQL DE NEGOCIO
-- ESTUDIANTE: Marcela del Pilar Vargas Bermúdez
-- CERTIFICACIÓN: Data Analyst - Coderhouse
-- BASE DE DATOS: Ventas_Tech_DB (Tabla: ventas)
-- =========================================================================

-- ==========================================
-- CONSULTA 1: Resumen ejecutivo mensual
-- Total facturado, cantidad de pedidos y ticket promedio por mes.
-- ==========================================
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(id_venta) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;


-- ==========================================
-- CONSULTA 2: Ranking de productos (Top 5)
-- Top 5 de id_producto por total facturado y unidades vendidas.
-- ==========================================
SELECT 
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC
LIMIT 5;


-- ==========================================
-- CONSULTA 3: Clientes recurrentes
-- id_cliente con más de un pedido realizado y su gasto total.
-- ==========================================
SELECT 
    id_cliente,
    COUNT(id_venta) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(id_venta) > 1
ORDER BY total_gastado DESC;


-- ==========================================
-- CONSULTA 4: Meses por encima/por debajo del promedio
-- Compara el total facturado de cada mes contra el promedio mensual general usando una Subconsulta.
-- ==========================================
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado_mes,
    CASE 
        WHEN SUM(cantidad * precio_unitario) > (
            SELECT SUM(cantidad * precio_unitario) / COUNT(DISTINCT EXTRACT(MONTH FROM fecha_venta)) 
            FROM ventas
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS rendimiento_vs_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;


-- =========================================================================
-- 📈 BLOQUE DE CIERRE: HALLAZGOS CONCRETOS DE NEGOCIO (INSIGHTS)
-- =========================================================================
/*
1. CONCENTRACIÓN DE INGRESOS EN PRODUCTO TOP: El 'id_producto = 1' (Laptop Pro 15) es el rey 
   indiscutible de la facturación. Generó un total de $3,600.00 mediante la venta de 3 unidades, 
   lo que representa una parte masiva de los ingresos totales de la tienda en este periodo.

2. COMPORTAMIENTO DE CLIENTES RECURRENTES: Se identificaron tres clientes de alto valor (IDs: 1, 2 y 4) 
   que registran más de un pedido (2 pedidos cada uno). El 'id_cliente = 1' lidera el gasto acumulado 
   con un total de $2,640.00, convirtiéndose en un foco clave para estrategias de fidelización.

3. ESTACIONALIDAD DE VENTAS: Al analizar el rendimiento mensual, el mes de Marzo (Mes 3) absorbe 
   la totalidad de las transacciones registradas hasta el momento en la tabla. Esto genera que no 
   existan variaciones reales de meses 'Por debajo' del promedio en este corte de datos, marcando 
   un hito de inicio de operaciones concentrado en marzo de 2024.
*/