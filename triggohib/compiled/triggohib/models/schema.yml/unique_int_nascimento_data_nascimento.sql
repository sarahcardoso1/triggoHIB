
    
    

select
    data_nascimento as unique_field,
    count(*) as n_records

from triggo_db.landing.int_nascimento
where data_nascimento is not null
group by data_nascimento
having count(*) > 1


