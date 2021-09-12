DROP DATABASE restaurant;
CREATE DATABASE restaurant;
USE restaurant;
CREATE TABLE employee(
	emID int primary key,
    employee_name varchar(30),
    phone_number int,
    shift varchar(30),
    employee_role varchar(30),
    check (shift = 'day' or shift = 'night')
);

CREATE TABLE shipper(
	emID int primary key,
    type_of_vehicle varchar(30),
    constraint fk_shipper_employee foreign key (emID) references employee (emID)
);

CREATE TABLE accountant(
	emID int primary key,
    constraint fk_accountant_employee foreign key (emID) references employee (emID)
);

CREATE TABLE security_guard(
	emID int primary key,
	constraint fk_security_guard_employee foreign key (emID) references employee (emID)
);

CREATE TABLE waiter(
	emID int primary key,
    constraint fk_waiter_employee foreign key (emID) references employee (emID)
);

CREATE TABLE chef(
	emID int primary key,
	constraint fk_chef_employee foreign key (emID) references employee (emID)
);

CREATE TABLE manager(
	emID int primary key,
    constraint fk_manager_employee foreign key (emID) references employee (emID)
);

CREATE TABLE manage(
	timekeeping float,
    emID int primary key,
    managerID int,
    constraint fk_manage_employee foreign key (emID) references employee (emID),
	constraint fk_manage_manager foreign key (managerID) references manager (emID)
);

CREATE TABLE administrator(
	emID int primary key,
    email varchar(30) null,
    constraint fk_administrator_employee foreign key (emID) references employee (emID)
);

CREATE TABLE customer(
	cID int primary key,
    customer_name varchar(30),
    phone_number int,
    number_of_people int
);

CREATE TABLE users(
	user_name varchar(30) primary key,
    email varchar (30),
	national_id varchar(12),
    address varchar(150)
);

CREATE TABLE crud(
	recheck varchar(30),
    reviewed_rating float,
    duration_hour_per_day float,
    emId int,
    user_name varchar(30)  primary key,
    constraint crud_employee foreign key (emID) references employee (emID),
    constraint crud_users foreign key (user_name) references users (user_name)
);

CREATE TABLE status_of_order(
	oID int primary key,
    date_of_order date,
    discount float null,
    check_list varchar(30),
    emID int,
    cID int,
    payment_method varchar(30),
    user_name varchar(30) NULL ,
    check (discount = '0.25' or discount = '0.5'),
    constraint fk_status_of_order_employee foreign key (emID) references employee (emID),
    constraint fk_status_of_order_customer foreign key (cID) references customer (cID),
    constraint fk_status_of_order_users foreign key (user_name) references users (user_name)
);

CREATE TABLE receipt(
	receipt_number int primary key,
	oID int,
    cId int,
    total_payment int,
	emID int,
    constraint fk_receipt_accountant foreign key (emID) references accountant (emID),
    constraint fk_receipt_status_of_order foreign key (oID) references status_of_order (oID),
    constraint fk_receipt_customer foreign key (cID) references customer (cID)
);


CREATE TABLE provider(
    provider_number int primary key,
    name_of_provider varchar(50),
    phone_number int,
    date_of_issues date,
    emID int,
    constraint provider_manager foreign key (emID) references manager (emID)
);

CREATE TABLE ingredient(
	iID varchar(30) primary key,
    name_of_ingredient varchar(30),
    ingredient_price int,
    unit varchar(30),
    provider_number int,
    constraint fk_ingredient_provider foreign key (provider_number) references provider (provider_number)
);

CREATE TABLE meal(
	menu varchar(30) primary key,
	emID int,
    constraint meal_chef foreign key (emID) references chef (emID)
);

CREATE TABLE use_of_portion(
	portion_use float,
	menu varchar(30) primary key,
	iID varchar(30),
    constraint use_of_portion_meal foreign key (menu) references meal (menu),
    constraint use_of_portion_ingredient foreign key (iID) references ingredient (iID)
);

insert into employee values (1028, 'Lam Gia Bao', 0916175566, 'day', 'accountant');
insert into employee values (1235, 'Luong Xuan Truong', 0988585568, 'day', 'manager');
insert into employee values (1456, 'Vu Viet Huong', 0978557560, 'night', 'accountant');
insert into employee values (1475, 'Khalid Mi Golem', 0988585571, 'night', 'manager');
insert into employee values (2315, 'Nguyen Phu Quy', 0942858857, 'day', 'administrator');
insert into employee values (2541, 'Doan Chi Binh', 0988587345, 'day', 'shipper');
insert into employee values (2543, 'Hoang Gia Cat Thinh', 0988585578, 'night', 'shipper');
insert into employee values (3180, 'Tran Huy Khanh', 0988585587, 'night', 'waiter');
insert into employee values (5556, 'Kris Wu', 0988582411, 'day', 'chef');
insert into employee values (6401, 'Duong Hoang Anh Khoa', 0903875923, 'day', 'security');
insert into employee values (6480, 'Lam Gia Khang', 0988585586, 'day', 'waiter');
insert into employee values (8423, 'Nguyen Hoai Linh', 0934185505, 'night', 'chef');


insert into shipper values (2541, 'Motor');
insert into shipper values (2543, 'Motor');


insert into accountant values (1028);
insert into accountant values (1456);



insert into security_guard values (6401);


insert into waiter values (3180);
insert into waiter values (6480);


insert into chef values (5556);
insert into chef values (8423);


insert into manager values (1235);
insert into manager values (1475);

insert into manage values (11, 1456, 1475);
insert into manage values (12, 8423, 1475);
insert into manage values (12, 2543, 1475);
insert into manage values (7.5, 2315, 1235);
insert into manage values (16, 2541, 1235);
insert into manage values (16, 1028, 1235);
insert into manage values (16, 6480, 1235);
insert into manage values (16, 5556, 1235);
insert into manage values (16, 6401, 1235);
insert into manage values (14, 3180, 1475);


insert into administrator values (2315, 'nguyenphuquy@gmail.com');


insert into customer values (3482, 'Dang Tuan Anh', 0919814702, 4);
insert into customer values (3521, 'Pham Hoang Anh', 0977475566, 2);
insert into customer values (3494, 'Do Gia Bao', 0975924124, 4);
insert into customer values (3581, 'Nguyen Le Hieu', 0924919274, 4);
insert into customer values (3527, 'Mac Trung Duc', 0983568618, 6);
insert into customer values (3550, 'Hoang Duc Anh', 940282363, 3);
insert into customer values (3517, 'Michael Pham', 0916385316, 3);
insert into customer values (3523, 'Daniel Smith', 0938504583, 4);
insert into customer values (3510, 'John Dell', 0915085455, 3);
insert into customer values (3551, 'Luu Trang Anh', 0939723432, 3);

INSERT INTO users VALUES ('jack97', 'jack97@gmail.com', 206978673819, '84 Pham Van Chieu Ward 9 Go Vap District Ho Chi Minh Vietnam');
INSERT INTO users VALUES ('chaoyenmach', 'chaoyenmach@gmail.com', 563616534504, '713B Dien Bien Phu Ward 22 Binh Thanh District Ho Chi Minh Vietnam');
INSERT INTO users VALUES ('phobokhonghanh', 'phobokhonghanh@gmail.com', 791290981457, '100 Tran Hung Dao Pham Ngu Lao Ward District 1, Ho Chi Minh Vietnam');
INSERT INTO users VALUES ('congdungngonhanh', 'congdungngonhanh@gmail.com', 397052573330, '114 Street No. 2 Do Thanh Residence Ward 04 District 3, Ho Chi Minh Vietnam');
INSERT INTO users VALUES ('dunghanhatm', 'dunghanhatm@gmail.com', 542659193128, '294 lo 8 Cu Chi Ho Chi Minh City Vietnam');
INSERT INTO users VALUES ('viyeumaden', 'viyeumaden@gmail.com', 576167114329, '29A Nguyen Dinh Chieu Da Kao Ward District 1 Ho Chi Minh Vietnam');
INSERT INTO users VALUES ('hoado', 'hoado@gmail.com', 528440752052, '65 Le Loi Dist 1 Ho Chi Minh City Vietnam');
INSERT INTO users VALUES ('kicm', 'kicm@gmail.com', 316824027259, '400 - 402 Ton Dan Ward 4 District 4 Ho Chi Minh Vietnam');
INSERT INTO users VALUES ('bundaumamtom', 'bundaumamtom@gmail.com', 186492426733, '19 Nguyen Binh Khiem Da Kao Ward District 1 Ho Chi Minh Vietnam');
INSERT INTO users VALUES ('comtam', 'comtam@gmail.com', 776986750239, '290 Cach Mang Thang Tam Ward 12 District 10 Ho Chi Minh Vietnam
');

insert into status_of_order values (1247130, 20210816, null, 'no', 2541, null, 'Cash', 'jack97');
insert into status_of_order values (5512134, 20210817, null, 'yes', null, 3527, 'Cash', NULL);
insert into status_of_order values (5512136, 20210817, null, 'yes', null, 3521, 'Cash', NULL);
insert into status_of_order values (1247125, 20210816, null, 'no', 2543, null, 'Cash', 'chaoyenmach');
insert into status_of_order values (1247121, 20210816, 	null, 'yes', null, 3581, 'Cash', NULL);
insert into status_of_order values (1247124, 20210816, 	null, 'yes', null, 3517, 'Cash', NULL);
insert into status_of_order values (1247122, 20210816, 	null, 'no', 2541, null, 'Cash', 'phobokhonghanh');
insert into status_of_order values (5512135, 20210817, 	null, 'no', 2541, null, 'Cash', 'congdungngonhanh');
insert into status_of_order values (1247123, 20210816, 	null, 'no', null, 3510, 'Banking transfer', NULL);
insert into status_of_order values (1247126, 20210816, 	null, 'no', 2543, null, 'Cash', 'dunghanhatm');
insert into status_of_order values (1247127, 20210816, 	null, 'yes', null, 3550, 'Banking transfer', NULL);
insert into status_of_order values (1247131, 20210816, 	null, 'no', 2543, null, 'Cash', 'viyeumaden');
insert into status_of_order values (1247129, 20210816, 	null, 'yes', null, 3482, 'Banking transfer', NULL);
insert into status_of_order values (1247133, 20210816, 	null, 'yes', null, 3523, 'Banking transfer', NULL);
insert into status_of_order values (1247128, 20210816, 	null, 'yes', null, 3551, 'Cash', NULL);
insert into status_of_order values (1247132, 20210817, 	null, 'yes', null, 3494, 'Cash', NULL);

insert into crud values ('TRUE', 10, 0.15, 2315, 'jack97');
insert into crud values ('FALSE', 10, 0.26, 2315, 'chaoyenmach');
insert into crud values ('TRUE', 10, 0.55, 2315, 'phobokhonghanh');
insert into crud values ('TRUE', 10, 0.13, 2315, 'congdungngonhanh');
insert into crud values ('TRUE', 10, 0.12, 2315, 'dunghanhatm');
insert into crud values ('TRUE', 10, 0.11, 2315, 'viyeumaden');
insert into crud values ('TRUE', 7.3, 0.22, 2315, 'hoado');
insert into crud values('TRUE', 7.2, 0.16, 2315, 'kicm');
insert into crud values('TRUE', 8.2, 0.19, 2315, 'bundaumamtom');
insert into crud values('TRUE', 6.2, 0.36, 2315, 'comtam');

insert into receipt values (1009, 1247128, 3551, 523000, 1456);
insert into receipt values (1497, 1247125, NULL, 633000, 1028);
insert into receipt values (1547, 1247121, 3581, 354000, 1028);
insert into receipt values (1687, 1247124, 3517, 167000, 1028);
insert into receipt values (4628, 1247122, NULL, 423000, 1028);
insert into receipt values (2547, 1247127, 3550, 234000, 1028);
insert into receipt values (3457, 1247126, NULL, 413000, 1028);
insert into receipt values (3547, 1247123, 3510, 635000, 1028);
insert into receipt values (6108, 1247129, 3482, 534000, 1456);
insert into receipt values (9974, 1247130, NULL, 214000, 1456);
insert into receipt values (1113, 5512136, 3521, 634000, 1456);
insert into receipt values (6730, 1247131, null, 124000, 1028);
insert into receipt values (4141, 1247133, 3523, 150000, 1456);
insert into receipt values (3760, 5512134, 3527, 234000, 1456);
insert into receipt values (4671, 5512135, null, 213000, 1456);
insert into receipt values (2247, 1247132, 3494, 423000, 1028);


insert into provider values (1, 'Hoang Dong private enterprise', 0970252003, 20210816, 1235);
insert into provider values (2, 'Tien Giang vegetable company', 0976960012, 20210816, 1475);
insert into provider values (3, 'Viet Hiep cooking spices company', 0989827109, 20210816, 1235);
insert into provider values (4, 'Hoang Dong private enterprise', 0970252003, 20210817, 1235);
insert into provider values (5, 'Hoang Dong private enterprise', 0970252003, 20210818, 1235);
insert into provider values (6, 'Hoang Dong private enterprise', 0970252003, 20210819, 1475);
insert into provider values (7, 'Tien Giang vegetable company', 0976960012, 20210819, 1475);
insert into provider values (8, 'Hoang Dong private enterprise', 0970252003, 20210820, 1235);
insert into provider values (9, 'Hoang Dong private enterprise', 0970252003, 20210821, 1475);
insert into provider values (10, 'Tien Giang vegetable company', 0976960012, 20210821, 1475);


insert into ingredient values (341863, 'Beef', 250000, 'kg', 1);
insert into ingredient values (488754, 'Chicken meat', 38000, 'kg', 2);
insert into ingredient values (977907, 'Fish', 120000, 'kg', 3);
insert into ingredient values (235454, 'Shrimp', 180000, 'kg', 4);
insert into ingredient values (896855, 'Goose meat', 160000, 'kg', 5);
insert into ingredient values (979656, 'Crab', 350000, 'kg', 6);
insert into ingredient values (329087, 'Duck meat', 64000, 'kg', 7);
insert into ingredient values (785967, 'Rice noodles', 2000, 'kg', 8);
insert into ingredient values (214574, 'Snail', 35000, 'kg', 9);

insert into meal values ('Bun mam', 5556);
insert into meal values ('Bun bo hue', 5556);
insert into meal values ('Bun ca nha trang', 8423);
insert into meal values ('Bun ca chau doc', 8423);
insert into meal values ('Bun nuoc leo', 5556);
insert into meal values ('Bun canh chua Nam Bo', 5556);
insert into meal values ('Mien ga', 8423);
insert into meal values ('Mien ngan', 8423);
insert into meal values ('Banh da cua', 8423);
insert into meal values ('Bun oc', 8423);
insert into meal values ('Hu tiu vam vang', 5556);
insert into meal values ('Bun rieu cua', 5556);
insert into meal values ('Mi quang', 8423);
insert into meal values ('Pho', 8423);
insert into meal values ('Mi hoanh thanh', 8423);
insert into meal values ('Bun mang vit', 5556);

INSERT INTO use_of_portion VALUES (35.5, 'Bun bo hue', 341863);
INSERT INTO use_of_portion VALUES (37, 'Bun rieu cua', 979656);
INSERT INTO use_of_portion VALUES (32.7, 'Bun nuoc leo', 785967);
INSERT INTO use_of_portion VALUES (45.1, 'Bun ca Nha Trang', 977907);
INSERT INTO use_of_portion VALUES (39.2, 'Bun mam', 235454);
INSERT INTO use_of_portion VALUES (29.8, 'Bun ca chau doc', 977907);
INSERT INTO use_of_portion VALUES (31.5, 'Bun mang vit', 329087);
INSERT INTO use_of_portion VALUES (29, 'Mien ga', 488754);
INSERT INTO use_of_portion VALUES (30.9, 'Bun canh chua nam bo', 785967);
INSERT INTO use_of_portion VALUES (41, 'Banh da cua', 979656);
INSERT INTO use_of_portion VALUES (39.3, 'Mien ngan', 896855);
INSERT INTO use_of_portion VALUES (33.1, 'Hu tiu nam vang', 785967);
INSERT INTO use_of_portion VALUES (31.3, 'Bun oc', 214574);


# Querry 1
SELECT	e.emID , (m.timekeeping - 10) * 50000 AS supporting_income
FROM	employee e, manage m
WHERE	e.emID = m.emID AND m.timekeeping > 2 AND e.employee_role = 'shipper' AND e.shift = 'night';

# Querry 2
SELECT e.employee_name, e.shift, e.employee_role
FROM	employee e
WHERE	e.shift = 'day' AND employee_name NOT IN(
    SELECT e.employee_name
    FROM	employee e
    WHERE	e.shift = 'day' AND e.employee_role = 'administrator');

# Querry 3
SELECT	round(avg(cr.reviewed_rating), 1), o.date_of_order
FROM	users u, status_of_order o, CRUD cr
WHERE	o.date_of_order = 20210816 ;


#Querry 5
SELECT i.name_of_ingredient, pr.date_of_issues, pr.name_of_provider
FROM	ingredient i, Provider pr
WHERE	pr.provider_number = i.provider_number AND pr.date_of_issues = 20210819
UNION
SELECT i.name_of_ingredient, pr.date_of_issues, pr.name_of_provider
FROM	ingredient i, Provider pr
WHERE	pr.provider_number = i.provider_number AND pr.date_of_issues = 20210820
UNION
SELECT i.name_of_ingredient, pr.date_of_issues, pr.name_of_provider
FROM	ingredient i, Provider pr
WHERE	pr.provider_number = i.provider_number AND pr.date_of_issues = 20210821;

#Querry 6
SELECT	u.user_name, o.payment_method, o.date_of_order, r1.total_payment, r2.total_payment *0.3 AS Discount_voucher
FROM		users u, status_of_order o, receipt r1, receipt r2
WHERE	r1.receipt_number = r2.receipt_number AND r1.cId = o.cID AND u.user_name = o.user_name AND r1.total_payment > 150000 AND o.date_of_order = 20210816 AND o.payment_method = 'Cash' AND o.cID IS NOT NULL
UNION
SELECT	u.user_name, o.payment_method, o.date_of_order, r1.total_payment, r2.total_payment *0.3 AS Discount_voucher
FROM		users u, status_of_order o, receipt r1, receipt r2
WHERE	r1.receipt_number = r2.receipt_number AND r1.cId = o.cID AND u.user_name = o.user_name AND r1.total_payment > 150000 AND o.date_of_order = 20210816 AND o.payment_method = 'Banking transfer' AND o.cID IS NOT NULL;

# Querry 4
SELECT	u.user_name, u.email, r.total_payment, o.date_of_order
FROM	users u, Receipt r, status_of_order o
WHERE	u.user_name = o.user_name AND r.oID = o.oID AND r.total_payment > 300000;

# Querry 7
SELECT DISTINCT 	 c.customer_name, floor(r.total_payment / 100000) * 0.05 AS Discount
FROM		customer c, users u, receipt r, status_of_order o
WHERE	c.cID = r.cID AND c.cID = o.cID AND o.date_of_order = 20210817;

# Querry 8
SELECT 	e.employee_name, m.timekeeping / 7 * 140000 AS salary
FROM		employee e, manage m
WHERE	 e.emID = m.emID AND m.timekeeping >= 7
UNION
SELECT 	e.employee_name, (m.timekeeping / 7 * 140000 - (7 - m.timekeeping) * 10000 )AS salary
FROM		employee e, manage m
WHERE	 e.emID = m.emID AND m.timekeeping < 7;

# Querry 9
SELECT	i.name_of_ingredient, i.ingredient_price, i.unit, pr.date_of_issues
FROM		ingredient i, provider pr
WHERE	i.provider_number = pr.provider_number AND i.ingredient_price > 70000;

# Querry 10
SELECT DISTINCT 	c.customer_name, r.total_payment, o.date_of_order
FROM		customer c, users u, receipt r, status_of_order o
WHERE	c.cID = r.cID AND c.cID = o.cID AND o.payment_method = 'Cash' AND o.date_of_order = 20210816;

# Querry 11
SELECT  pr.provider_number, pr.date_of_issues, name_of_provider , count(*)
FROM      provider pr, ingredient i
WHERE  pr.provider_number = i.provider_number AND pr.date_of_issues = 20210817
GROUP BY   pr.name_of_provider
ORDER BY count(*) desc limit 1;

# Querry 12
SELECT 	c.cID, c.customer_name, o.date_of_order, MAX(c.number_of_people), MIN(c.number_of_people)
FROM		customer c, status_of_order o
WHERE	c.cID = o.cID
GROUP BY	o.date_of_order;

# Querry 13
SELECT 	m.emID, e.employee_name, count(*) as number_of_employee
FROM		employee e, manage m
WHERE	m.emID = e.emID
GROUP BY	m.managerID

