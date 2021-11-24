--*********************
--*****Eliana Guerrero 
--*********************
--5.	Consulta de Clientes que han comprado un acumulado $100.000 en los últimos 60 días

SELECT SUB.id_cliente, P.primer_nombre, P.primer_apellido
FROM PERSONA P, CLIENTE C, 
(
	SELECT  F.id_cliente,sum(D.monto_total)total
	FROM FACTURA F, DETALLE_FACTURA D
	WHERE F.id_factura = D.id_factura
	AND D.fecha > sysdate -60
	GROUP BY F.id_cliente
)SUB 
WHERE C.persona_numero_identificacion = P.numero_identificacion
AND C.id_cliente = SUB.id_cliente
AND SUB.total = 100000;

--6.	Consulta de los 100 productos más vendidos en los últimos 30 días

SELECT R.nombre_repuesto FROM 
(
	SELECT D.id_repuesto, sum(cantidad) as total
	FROM DETALLE_FACTURA D
	WHERE D.fecha > sysdate - 30
	GROUP BY D.id_repuesto
) subconsulta
LEFT JOIN REPUESTO R on R.id_repuesto = subconsulta.id_repuesto
WHERE ROWNUM <= 100
ORDER BY subconsulta.total;



--7. Consulta de las tiendas que han vendido más de 100 UND del producto 100 en los últimos 60 días.

SELECT T.nombre_tienda
from TIENDA T,
	(
		select F.id_tienda, sum(D.cantidad) total
		from FACTURA F, DETALLE_FACTURA D
		WHERE F.id_factura = D.id_factura 
		and D.id_repuesto = 100
		and D.fecha > sysdate - 60
		group by F.id_tienda
	)sub
where T.id_tienda = sub.id_tienda
and sub.total > 100;

--8.	Consulta de todos los clientes que han tenido más de un(1) mantenimento en los últimos 30 días.

SELECT SUB.id_cliente, P.primer_nombre, P.primer_apellido
FROM PERSONA P, 
(
	SELECT C.id_cliente, C.persona_numero_identificacion
	FROM MANTENIMIENTO M, CLIENTE C, FACTURA F, DETALLE_FACTURA D
	WHERE M.id_cliente = C.id_cliente
	AND C.id_cliente =  F.id_cliente
	AND F.id_factura = D.id_factura
	AND D.fecha > sysdate - 30
)SUB
WHERE SUB.persona_numero_identificacion = P.numero_identificacion;
