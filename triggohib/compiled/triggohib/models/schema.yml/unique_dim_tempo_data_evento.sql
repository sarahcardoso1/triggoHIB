
    
    

select
    data_evento as unique_field,
    count(*) as n_records

from triggo_db.landing.dim_tempo
where data_evento is not null
group by data_evento
having count(*) > 1


