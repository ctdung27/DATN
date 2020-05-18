use coffemanagement;

insert into role(code,name) values('admin','admin');
insert into role(code,name) values('staff','staff');

insert into user(username,password,fullname,status)
values('admin','$2a$10$/RUbuT9KIqk6f8enaTQiLOXzhnUkiwEJRdtzdrMXXwU7dgnLKTCYG','admin',1);
insert into user(username,password,fullname,status)
values('nguyenvana','$2a$10$/RUbuT9KIqk6f8enaTQiLOXzhnUkiwEJRdtzdrMXXwU7dgnLKTCYG','nguyễn văn A',1);

INSERT INTO user_role(user_id,role_id) VALUES (1,1);
INSERT INTO user_role(user_id,role_id) VALUES (2,2);

insert into area(code,name) values('KHU_A','Khu A');
insert into area(code,name) values('KHU_B','Khu B');

insert into seat(code,name,areaid) values('BAN_1','Bàn 1',1);
insert into seat(code,name,areaid) values('BAN_2','Bàn 2',1);
insert into seat(code,name,areaid) values('BAN_3','Bàn 3',1);
insert into seat(code,name,areaid) values('BAN_4','Bàn 4',1);
insert into seat(code,name,areaid) values('BAN_5','Bàn 5',2);
insert into seat(code,name,areaid) values('BAN_6','Bàn 6',2);
insert into seat(code,name,areaid) values('BAN_7','Bàn 7',2);
insert into seat(code,name,areaid) values('BAN_8','Bàn 8',2);

insert into productcategory(code,name) values('CAFE','Cà phê');
insert into productcategory(code,name) values('FRUIT','Thức uống trái cây');

insert into product(code,name,price,productcategoryid)
values('CAFE_DEN','Cà phê đen',29000,1);
insert into product(name,code,price,productcategoryid)
values('CAFE_SUA','Cà phê sữa',29000,1);
insert into product(name,code,price,productcategoryid)
values('SINH_TO_CAM_XOAI','Sinh tố cam xoài',29000,2);
insert into product(name,code,price,productcategoryid)
values('SINH_TO_VIET_QUAT','Sinh tố việt quất',29000,2);