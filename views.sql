create view view1 as
select p.fname as name, avg(m.amount) as amount
from monthly_salary m, person p
where m.personal_id = p.personal_id
group by(p.fname);

create view view2 as
select p.fname as Candidate, i.candidate_id as candidate_id, count(i.score) as rounds_passed
from interview i, person p
where i.candidate_id = p.personal_id AND i.score > 70
group by(p.fname, i.candidate_id);

create view view3 as
select p.product_type as product_type, count(p.product_type) as quantity
from product p
group by(p.product_type)
order by(quantity) desc;

create view view4 as
select pr.product_id as product_id, sum(pa.part_price * pp.quantity) as cost
from product pr, part pa, product_parts pp
where pp.product_id = pr.product_id and pp.part_number = pa.part_number
group by(pr.product_id)

select * from view1;
select * from view2;
select * from view3;
select * from view4;
