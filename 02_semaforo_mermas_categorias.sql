WITH ALIMENTO AS (
    SELECT 
        A.id_alimento, 
        A.categoria,
        SUM(E.kg_recibidos) AS KG_RECIBIDOS,
        SUM(E.kg_merma) AS KG_PERDIDOS
    FROM dim_alimento A 
    INNER JOIN fact_entradas E ON A.id_alimento = E.id_alimento
    GROUP BY A.id_alimento, A.categoria
)
SELECT 
    id_alimento,
    categoria,
    KG_PERDIDOS,
    CASE 
        WHEN (KG_PERDIDOS / KG_RECIBIDOS) * 100 > 10 THEN 'ALERTA CRÍTICA'
        WHEN (KG_PERDIDOS / KG_RECIBIDOS) * 100 >= 5 THEN 'ATENCIÓN'
        ELSE 'ÓPTIMO'
    END AS estado_alerta
FROM ALIMENTO
WHERE KG_RECIBIDOS > 0 
ORDER BY (KG_PERDIDOS / KG_RECIBIDOS) DESC;