with new_phys as
  (insert into customer (type, address, phone)
   values ('p',
           'Moscow, Gagarina st., 13',
           '819193674') returning id_customer)
insert into private_person (surname, name, midname, year_of_birth, passport, id_customer)
values ('Miller',
        'John',
        'James',
        1978,
        '3536478',
          (select id_customer
           from new_phys));

with new_phys as
  (insert into customer (type, address, phone)
   values ('p',
           'Novosib, Gagarina st., 13',
           '6161728') returning id_customer)
insert into private_person (surname, name, midname, year_of_birth, passport, id_customer)
values ('FIll',
        'Paul',
        'Ivan',
        2000,
        '7382782',
          (select id_customer
           from new_phys));

with new_phys as
  (insert into customer (type, address, phone)
   values ('p',
           'SPB, Gagarina st., 12',
           '28637837') returning id_customer)
insert into private_person (surname, name, midname, year_of_birth, passport, id_customer)
values ('Popoe',
        'Jack',
        'Hehe',
        1993,
        '2378298',
          (select id_customer
           from new_phys));

with new_phys as
  (insert into customer (type, address, phone)
   values ('p',
           'Moscow, Sovets st., 53',
           '3478736') returning id_customer)
insert into private_person (surname, name, midname, year_of_birth, passport, id_customer)
values ('Ereon',
        'Node',
        'Manu',
        1988,
        '3728632',
          (select id_customer
           from new_phys));

with new_phys as
  (insert into customer (type, address, phone)
   values ('p',
           'EKB, Dodo st., 43',
           '72384673') returning id_customer)
insert into private_person (surname, name, midname, year_of_birth, passport, id_customer)
values ('Oele',
        'Memem',
        'Fill',
        1998,
        '1627516',
          (select id_customer
           from new_phys));

with new_phys as
  (insert into customer (type, address, phone)
   values ('p',
           'Moscow, Moved st., 93',
           '76345826') returning id_customer)
insert into private_person (surname, name, midname, year_of_birth, passport, id_customer)
values ('Memelot',
        'Fill',
        'Pae',
        1999,
        '29839837',
          (select id_customer
           from new_phys));

with new_legal as
  (insert into customer (type, address, phone)
   values ('l',
           'Moscow, HIBER st., 3',
           '84884284') returning id_customer)
insert into legal_person (name, license, account, category, id_customer)
values ('MCompany',
        '2777384',
        '3844837',
        'company',
          (select id_customer
           from new_legal));

with new_legal as
  (insert into customer (type, address, phone)
   values ('l',
           'Moscow, Modod st., 19',
           '8276487') returning id_customer)
insert into legal_person (name, license, account, category, id_customer)
values ('Cheburka',
        '373845',
        '85849',
        'org',
          (select id_customer
           from new_legal));

with new_legal as
  (insert into customer (type, address, phone)
   values ('l',
           'Moscow, Viet st., 28',
           '274873') returning id_customer)
insert into legal_person (name, license, account, category, id_customer)
values ('Berezka',
        '9287498',
        '4987894',
        'company',
          (select id_customer
           from new_legal));

with new_legal as
  (insert into customer (type, address, phone)
   values ('l',
           'NSK, Sober st., 53',
           '9856875') returning id_customer)
insert into legal_person (name, license, account, category, id_customer)
values ('Okko',
        '3786287',
        '7386827',
        'llc',
          (select id_customer
           from new_legal));

with new_legal as
  (insert into customer (type, address, phone)
   values ('l',
           'SPB, Kirovo st., 3',
           '46235658') returning id_customer)
insert into legal_person (name, license, account, category, id_customer)
values ('Mordor',
        '28364',
        '4893785',
        'person',
          (select id_customer
           from new_legal));

with new_waybill as
  (INSERT INTO Waybill(arrive)
   VALUES (now()) returning id_waybill),
     new_item as
  (INSERT INTO Item(Name, Article, Amount, Price)
   VALUES ('ochki',
           728,
           256,
           120) returning id_item,
                          price)
INSERT INTO Str_Waybill(id_Item, id_Waybill, Amount, Price)
VALUES (
          (select id_item
           from new_item),
          (select id_waybill
           from new_waybill),10,
          (select price
           from new_item));

with new_waybill as
  (INSERT INTO Waybill(arrive)
   VALUES (now()) returning id_waybill),
     new_item as
  (INSERT INTO Item(Name, Article, Amount, Price)
   VALUES ('hololens',
           739,
           37,
           772) returning id_item,
                          price)
INSERT INTO Str_Waybill(id_Item, id_Waybill, Amount, Price)
VALUES (
          (select id_item
           from new_item),
          (select id_waybill
           from new_waybill),10,
          (select price
           from new_item));

with new_waybill as
  (INSERT INTO Waybill(arrive)
   VALUES (now()) returning id_waybill),
     new_item as
  (INSERT INTO Item(Name, Article, Amount, Price)
   VALUES ('tv',
           162,
           288,
           18) returning id_item,
                         price)
INSERT INTO Str_Waybill(id_Item, id_Waybill, Amount, Price)
VALUES (
          (select id_item
           from new_item),
          (select id_waybill
           from new_waybill),10,
          (select price
           from new_item));

with new_waybill as
  (INSERT INTO Waybill(arrive)
   VALUES (now()) returning id_waybill),
     new_item as
  (INSERT INTO Item(Name, Article, Amount, Price)
   VALUES ('sober',
           388,
           2783,
           38) returning id_item,
                         price)
INSERT INTO Str_Waybill(id_Item, id_Waybill, Amount, Price)
VALUES (
          (select id_item
           from new_item),
          (select id_waybill
           from new_waybill),10,
          (select price
           from new_item));

with new_waybill as
  (INSERT INTO Waybill(arrive)
   VALUES (now()) returning id_waybill),
     new_item as
  (INSERT INTO Item(Name, Article, Amount, Price)
   VALUES ('voda',
           32,
           34,
           192) returning id_item,
                          price)
INSERT INTO Str_Waybill(id_Item, id_Waybill, Amount, Price)
VALUES (
          (select id_item
           from new_item),
          (select id_waybill
           from new_waybill),10,
          (select price
           from new_item));

with new_waybill as
  (INSERT INTO Waybill(arrive)
   VALUES (now()) returning id_waybill),
     new_item as
  (INSERT INTO Item(Name, Article, Amount, Price)
   VALUES ('hriter',
           19,
           23,
           23) returning id_item,
                         price)
INSERT INTO Str_Waybill(id_Item, id_Waybill, Amount, Price)
VALUES (
          (select id_item
           from new_item),
          (select id_waybill
           from new_waybill),10,
          (select price
           from new_item));

call make_order(0, '819193674', 739, 10);

call make_order(0, '819193674', 19, 10);

call make_order(0, '819193674', 7, 10);

call make_order(0, '819193674', 57, 10);

call make_order(0, '819193674', 739, 10);

call make_order(0, '819193674', 32, 10);

call make_order(0, '819193674', 728, 10);

call make_order(0, '819193674', 739, 10);

call make_order(0, '819193674', 7, 10);

call make_order(0, '819193674', 57, 10);

call make_order(0, '819193674', 32, 10);

call make_order(0, '899929999', 57, 10);

call make_order(0, '899929999', 7, 10);

call make_order(0, '899929999', 728, 10);

call make_order(0, '899929999', 162, 10);

call make_order(0, '76345826', 32, 10);

call make_order(0, '76345826', 728, 10);

call make_order(0, '76345826', 57, 10);

call make_order(0, '76345826', 162, 10);

call make_order(0, '8276487', 739, 10);

call make_order(0, '8276487', 57, 10);

call make_order(0, '8276487', 7, 10);

call make_order(0, '46235658', 739, 10);

call make_order(0, '46235658', 7, 10);

call make_order(0, '46235658', 728, 10);

call make_order(0, '46235658', 7, 10);

call make_order(0, '84884284', 728, 10);

call make_order(0, '84884284', 728, 10);

call make_order(0, '84884284', 32, 10);

call make_order(0, '84884284', 19, 10);

call make_order(0, '84884284', 7, 10);

call make_order(0, '84884284', 57, 10);

call make_order(0, '84884284', 728, 10);

call make_order(0, '84884284', 739, 10);

call make_order(0, '84884284', 162, 10);

call make_order(0, '84884284', 7, 10);

call make_order(0, '84884284', 57, 10);

call make_order(0, '84884284', 162, 10);

call make_order(0, '84884284', 32, 10);

call make_order(0, '6161728', 162, 10);

call make_order(0, '6161728', 739, 10);

call make_order(0, '6161728', 7, 10);

call make_order(0, '6161728', 728, 10);

call make_order(0, '6161728', 57, 10);

call make_order(0, '9856875', 32, 10);

call make_order(0, '9856875', 739, 10);

call make_order(0, '9856875', 162, 10);

call make_order(0, '9856875', 7, 10);

call add_items_to_orders();

with payment as
  (insert into bill (type, payment, summary)
   values ('w',
           '88824557',
           100) returning id_bill)
update notice
set id_bill =
  (select id_bill
   from payment)
where id_order = 10
  and id_notice =
    (select max(id_notice)
     from notice
     where id_order = 10);

with payment as
  (insert into bill (type, payment, summary)
   values ('w',
           '367638',
           1370) returning id_bill)
update notice
set id_bill =
  (select id_bill
   from payment)
where id_order = 42
  and id_notice =
    (select max(id_notice)
     from notice
     where id_order = 42);

with payment as
  (insert into bill (type, payment, summary)
   values ('w',
           '74367',
           273) returning id_bill)
update notice
set id_bill =
  (select id_bill
   from payment)
where id_order = 40
  and id_notice =
    (select max(id_notice)
     from notice
     where id_order = 40);

with payment as
  (insert into bill (type, payment, summary)
   values ('w',
           '783468',
           394) returning id_bill)
update notice
set id_bill =
  (select id_bill
   from payment)
where id_order = 32
  and id_notice =
    (select max(id_notice)
     from notice
     where id_order = 32);

with payment as
  (insert into bill (type, payment, summary)
   values ('w',
           '483979',
           39) returning id_bill)
update notice
set id_bill =
  (select id_bill
   from payment)
where id_order = 15
  and id_notice =
    (select max(id_notice)
     from notice
     where id_order = 15);

with payment as
  (insert into bill (type, payment, summary)
   values ('w',
           '476399',
           394) returning id_bill)
update notice
set id_bill =
  (select id_bill
   from payment)
where id_order = 19
  and id_notice =
    (select max(id_notice)
     from notice
     where id_order = 19);

with payment as
  (insert into bill (type, payment, summary)
   values ('w',
           '39694',
           19) returning id_bill)
update notice
set id_bill =
  (select id_bill
   from payment)
where id_order = 17
  and id_notice =
    (select max(id_notice)
     from notice
     where id_order = 17);

with payment as
  (insert into bill (type, payment, summary)
   values ('w',
           '84597894',
           849) returning id_bill)
update notice
set id_bill =
  (select id_bill
   from payment)
where id_order = 30
  and id_notice =
    (select max(id_notice)
     from notice
     where id_order = 30);

with payment as
  (insert into bill (type, payment, summary)
   values ('w',
           '2786469',
           399) returning id_bill)
update notice
set id_bill =
  (select id_bill
   from payment)
where id_order = 28
  and id_notice =
    (select max(id_notice)
     from notice
     where id_order = 28);

with payment as
  (insert into bill (type, payment, summary)
   values ('w',
           '753769',
           621) returning id_bill)
update notice
set id_bill =
  (select id_bill
   from payment)
where id_order = 13
  and id_notice =
    (select max(id_notice)
     from notice
     where id_order = 13);

with payment as
  (insert into bill (type, payment, summary)
   values ('w',
           '2897598',
           127) returning id_bill)
update notice
set id_bill =
  (select id_bill
   from payment)
where id_order = 44
  and id_notice =
    (select max(id_notice)
     from notice
     where id_order = 44);

