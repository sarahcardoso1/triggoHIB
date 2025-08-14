
    
    

select
    data_obito as unique_field,
    count(*) as n_records

from triggo_db.landing.int_obito
where data_obito is not null
group by data_obito
having count(*) > 1


