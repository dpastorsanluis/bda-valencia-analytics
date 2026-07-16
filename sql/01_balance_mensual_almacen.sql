with entradas as (
	select c.anyo_mes,
	sum(e.kg_recibidos) as 'kg recibidos',
	sum(e.kg_merma) as 'kg merma',
	sum(e.kg_aprovechado) as 'kg aprovechados'
	from fact_entradas e
	inner join dim_calendario c on e.fecha=c.fecha
	group by c.anyo_mes),
repartos as (
	select c.anyo_mes,
	sum(r.kg_repartidos) as 'kg repartidos'
	from fact_repartos r 
	inner join dim_calendario c on r.fecha_reparto=c.fecha
	group by c.anyo_mes)
select e.anyo_mes,
round(e.'kg recibidos',1) as 'kg recibidos',
round(e.'kg merma',1) as 'kg merma',
round(e.'kg aprovechados',1) as 'kg aprovechados',
round(coalesce(r.'kg repartidos', 0), 1) AS 'kg repartidos',
round(e.'kg aprovechados'-coalesce(r.'kg repartidos',0),1) as 'balance total'
from entradas e
left join repartos r on e.anyo_mes=r.anyo_mes
order by e.anyo_mes asc;
