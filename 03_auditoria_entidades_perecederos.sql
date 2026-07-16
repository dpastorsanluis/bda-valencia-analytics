SELECT en.nombre AS entidad,
	en.municipio,
COUNT(r.id_reparto) AS num_repartos,
ROUND(SUM(r.kg_repartidos), 1) AS kg_perecederos
FROM fact_repartos r
JOIN dim_entidad en ON r.id_entidad = en.id_entidad
JOIN dim_alimento a ON r.id_alimento = a.id_alimento
WHERE a.perecedero = 'Sí'
GROUP BY en.nombre, en.municipio
HAVING SUM(r.kg_repartidos) > 3000
ORDER BY kg_perecederos DESC;