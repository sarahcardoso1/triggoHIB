
    
    

select
    cod_municipio as unique_field,
    count(*) as n_records

from triggo_db.landing.dim_localidade
where cod_municipio is not null
group by cod_municipio
having count(*) > 1


