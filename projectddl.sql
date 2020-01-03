create table PERSON( 
personal_id varchar2(9) not null,
fname varchar2(15) not null,
minit char,
lname varchar2(15) not null,
age integer not null,
gender varchar2(6) check (gender in ('Female', 'Male')) not null,
street varchar2(30) not null,
city varchar2(30) not null,
state varchar2(20) not null,
zipcode integer not null,
phone varchar2(12),
primary key (personal_id)
);

ALTER TABLE PERSON
ADD email varchar2(100);

create table EMPLOYEE(
personal_id varchar2(9) not null,
super_id varchar2(9),
rank varchar2(50),
title varchar2(50),
primary key(personal_id),
foreign key(super_id) references PERSON(personal_id),
foreign key(personal_id) references PERSON(personal_id)
);




create table CUSTOMER(
personal_id varchar2(9) not null,
preferred_salesman_id varchar2(9),
primary key(personal_id),
foreign key(personal_id) references PERSON(personal_id),
foreign key(preferred_salesman_id) references PERSON(personal_id)
);

create table POTENTIAL_EMPLOYEE(
personal_id varchar2(9),
primary key(personal_id),
foreign key(personal_id) references PERSON(personal_id)
);

create table MONTHLY_SALARY(
personal_id varchar2(9) not null,
trans_num varchar2(10) not null,
pay_date date not null,
amount decimal(13,2) not null,
primary key(personal_id, trans_num),
foreign key(personal_id) references PERSON(personal_id)
);

create table DEPARTMENT(
department_id varchar2(9) not null,
department_name varchar2(50) not null,
unique(department_name),
primary key(department_id)
);

create table MARKETING_SITE(
site_id varchar2(9) not null,
site_name varchar2(50) not null,
site_location varchar2(50),
unique(site_name),
primary key(site_id)
);



create table SHIFTS(
shift_id varchar2(9) not null,
personal_id varchar2(9) not null,
department_id varchar2(9),
site_id varchar2(9),
start_time date not null,
end_time date not null,
primary key(shift_id),
foreign key(personal_id) references PERSON(personal_id),
foreign key(department_id) references DEPARTMENT(department_id),
foreign key(site_id) references MARKETING_SITE(site_id)
);

create table PRODUCT(
product_id varchar2(9) not null,
product_type varchar2(20),
product_style varchar2(20),
product_size varchar2(20),
product_price decimal(10,2),
product_weight decimal(10,2),
primary key(product_id)
);

create table JOB_POSITION(
job_id varchar2(9) not null,
department_id varchar2(9) not null,
post_date date,
job_description varchar2(300),
primary key(job_id),
foreign key(department_id) references DEPARTMENT(department_id)
);

create table SALES(
sale_id varchar2(9) not null,
product_id varchar2(9) not null,
sale_time date,
site_id varchar2(9),
customer_id varchar2(9) not null,
salesman_id varchar2(9) not null,
primary key(sale_id),
foreign key(product_id) references PRODUCT(product_id),
foreign key(customer_id) references PERSON(personal_id),
foreign key(salesman_id) references PERSON(personal_id)
);


create table APPLICATIONS(
job_id varchar2(9) not null,
candidate_id varchar2(9) not null,
primary key(job_id, candidate_id),
foreign key(job_id) references JOB_POSITION(job_id),
foreign key(candidate_id) references PERSON(personal_id)
);

create table INTERVIEW(
job_id varchar2(9) not null,
candidate_id varchar2(9) not null,
round integer not null,
interviewer_id varchar2(9) not null,
interview_date date not null,
score int,
primary key(job_id, candidate_id, round),
foreign key(job_id) references JOB_POSITION(job_id),
foreign key(candidate_id) references PERSON(personal_id),
foreign key(interviewer_id) references PERSON(personal_id)
);

create table VENDOR(
vendor_id varchar2(9) not null,
vendor_name varchar2(50) not null,
account_number integer not null,
credit_rating integer,
city varchar2(30) not null,
state varchar2(20) not null,
zipcode integer not null,
purchase_url varchar2(100),
primary key(vendor_id),
unique(vendor_name),
unique(account_number)
);

create table PART(
part_number varchar2(9) not null,
vendor_id varchar2(9) not null,
part_type varchar2(20) not null,
part_price decimal(10,2) not null,
part_weight decimal(10,2),
primary key(part_number),
foreign key(vendor_id) references VENDOR(vendor_id)
);



create table PART_PURCHASE(
vendor_id varchar2(9) not null,
part_number varchar2(9) not null,
primary key(vendor_id, part_number),
foreign key(vendor_id) references VENDOR(vendor_id),
foreign key(part_number) references PART(part_number)
);



create table PRODUCT_PARTS(
product_id varchar2(9) not null,
part_number varchar2(9) not null,
quantity integer not null,
primary key(product_id, part_number),
foreign key(part_number) references PART(part_number),
foreign key(product_id) references PRODUCT(product_id)
);


create table closed_positions(
job_id varchar2(9) not null,
employee_id varchar2(9),
department_id varchar2(9),
primary key(job_id, employee_id),
foreign key(job_id) references JOB_POSITION(job_id),
foreign key(employee_id) references person(personal_id),
foreign key(department_id) references department(department_id)
);
