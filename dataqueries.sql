-- 1. return id and name of interviewers where interviee's name is "Hellen Cole"
--    for job 11111

select distinct(i.interviewer_id), p.fname, p.lname
from interview i, person p
where i.interviewer_id = p.personal_id and i.job_id='11111';


-- 2. return id of all jobs which are posted by department 'marketing' in january 2011

select d.department_name, j.job_id
from department d, job_position j
where j.department_id = d.department_id and d.department_name = 'Marketing';

-- 3. return id and name of employees that do not have a supervisor

select e.personal_id, p.fname, p.lname
from employee e, person p
where e.super_id = e.personal_id and e.personal_id = p.personal_id;


-- 4. return id and location of marketing sites which have no sales records during March, 2011

select distinct(s.site_id), m.site_location
from marketing_site m, sales s
minus
select s.site_id, m.site_location
from marketing_site m, sales s
where s.site_id = m.site_id and s.sale_time between '01-MAR-11' and '31-MAR-11';


--  5. return the job id and description for jobs that do not hire a suitable candidate one month
--     after being posted

select j.job_id, j.job_description
from job_position j
minus
select j.job_id, j.job_description
from job_position j, interview i
where j.job_id = i.job_id and i.interview_date between j.post_date and ADD_MONTHS(j.post_date, 1)
having (COUNT(CASE WHEN i.score > 69 THEN 1 END)) > 4
group by(j.job_id, j.job_description);


-- 6. return id and name of salesmen how have sold products worth more than $200

select distinct(p.personal_id), p.fname, p.lname
from person p, sales s, product pr
where s.salesman_id = p.personal_id and s.product_id = pr.product_id and pr.product_price > 200;

-- 7. return id and name of departments that do not have any job postings between 1/1/2011 and 2/1/2011

select d.department_id, d.department_name
from department d, job_position j
minus
select d.department_id, d.department_name
from department d, job_position j
where d.department_id = j.department_id and j.post_date between '01-JAN-11' and '01-MAR-11';


-- 8. return id, name, and department id of employees who applied for job '12345'

select p.personal_id, p.fname, p.lname, j.department_id
from person p, job_position j, applications a
where a.candidate_id = p.personal_id and j.job_id = a.job_id and a.job_id = '12345';

-- 9. return best selling product type

select p.product_type, count(s.product_id) as units_sold
from product p, sales s
where s.product_id = p.product_id
group by(p.product_type)
order by sum(s.product_id) desc
fetch first 1 row only;

-- 10. return the product with the highest net profit (product price - sum(part cost))

select distinct(p.product_id), p.product_type, (p.product_price - v.cost) as net_profit
from product p, product_parts pp, view4 v
where p.product_id = v.product_id
order by(net_profit) desc
fetch first 1 row only;

-- 11. return the name and id of employees who have worked in all departments

select distinct(p.fname), p.lname, p.personal_id
from person p, closed_positions cp
where cp.employee_id = p.personal_id
having count(distinct cp.department_id) = 3
group by(p.fname, p.lname, p.personal_id);

-- 12. return the name and email address of interviewees selected

select p.fname, p.lname, p.email
from person p, interview i
where i.candidate_id = p.personal_id
having (COUNT(CASE WHEN i.score > 69 THEN 1 END)) > 4
group by(p.fname, p.lname, p.email);


-- 13. return the name, phone number, email of interviewees selected for all jobs they applied to

select p.fname, p.lname, p.phone, p.email
from person p, interview i
where i.candidate_id = p.personal_id
having (COUNT(CASE WHEN i.score > 69 THEN 1 END)) > 4
group by(p.fname, p.lname, p.phone, p.email);


-- 14. return employee with highest average monthly salary

select p.fname, p.lname, avg(m.amount) as average_monthly
from person p, monthly_salary m
where m.personal_id = p.personal_id
group by(p.fname, p.lname)
order by(average_monthly) desc
fetch first 1 row only;

-- 15. return the id and name of the vendor who supplies part 'cup' with weight < 4 at the cheapest price

select v.vendor_id, v.vendor_name
from vendor v, part p
where p.vendor_id = v.vendor_id and p.part_type = 'cup' and p.part_weight < 4
order by(part_price) desc
fetch first 1 row only;

select * from part;
