--- Query #1

select Extract(MONTH from date) as month, count(distinct ord.id_order) as common_order,
       count(distinct id_item) as unique_qty, sum(amount) as common_qty,
       sum(amount * price) as common_profit
from order_tab ord inner join str_order so on ord.id_order = so.id_order
where Extract(YEAR from date) = Extract(YEAR from now()) group by month;

---

--- Query #2

with
     count_order(id_customer, number_of_order) as (
         select id_customer, count(id_order) as cnt
         from order_tab
         group by id_customer),
     max_customer(id_customer, register, type, address, phone) as (
         select id_customer, register, type, address, phone
         from customer
         where customer.id_customer in (
             select distinct id_customer
             from order_tab
             where id_customer in (
                 select id_customer
                 from count_order
                 where number_of_order = (
                     select max(number_of_order)
                     from count_order)
             )
         )
     ),
     all_orders(id_customer, number_all_orders, cost_all_orders) as (
         select id_customer, count(so.id_order), sum(so.price * so.amount)
         from order_tab join str_order so on order_tab.id_order = so.id_order
         where id_customer in (
             select id_customer
             from max_customer)
         group by id_customer),
     r_orders(id_customer, number_released_orders, cost_released_orders) as (
         select id_customer, count(so.id_order), sum(so.price * so.amount)
         from order_tab join str_order so on order_tab.id_order = so.id_order
         where id_customer in (
             select id_customer
             from max_customer) and release='y'
         group by id_customer),
     p_orders(id_customer, customer_payment) as (
         select id_customer, sum(so.price * so.amount)
         from order_tab join str_order so on order_tab.id_order = so.id_order
         where id_customer in (
             select id_customer
             from max_customer) and payment='y'
         group by id_customer),
     c_orders(id_customer, number_canceled_orders, cost_canceled_orders) as (
         select id_customer, count(so.id_order), sum(so.price * so.amount)
         from order_tab join str_order so on order_tab.id_order = so.id_order
         where id_customer in (
             select id_customer
             from max_customer) and canceled='y'
         group by id_customer),
     nr_orders(id_customer, number_not_released_orders, cost_not_released_orders) as (
         select id_customer, count(so.id_order), sum(so.price * so.amount)
         from order_tab join str_order so on order_tab.id_order = so.id_order
         where id_customer in (
             select id_customer
             from max_customer) and release='n'
         group by id_customer)
SELECT * FROM max_customer JOIN all_orders  USING (id_customer)
                           JOIN r_orders    USING (id_customer)
                           JOIN p_orders    USING (id_customer)
                           JOIN c_orders    USING (id_customer)
                           JOIN nr_orders   USING (id_customer);

---

--- Query #3

with
     count_arrived(id_item, item_arrived) as (
        select id_item, sum(amount) from str_waybill group by id_item
    ),
     count_item(id_item, item_amount, count_in_orders) as (
        select id_item, sum(amount), count(id_order) from str_order group by id_item
    ),
     r_orders(id_item, count_released) as (
         select id_item, count(id_order) from str_order join order_tab using (id_order) where release='y' and canceled='n' group by id_item
     ),
     c_orders(id_item, count_canceled) as (
         select id_item, count(id_order) from str_order join order_tab using (id_order) where canceled='y' group by id_item
     )
SELECT * from item JOIN count_arrived   USING (id_item)
                   JOIN count_item      USING (id_item)
                   JOIN r_orders        USING (id_item)
                   JOIN c_orders        USING (id_item)
    where item_amount > item_arrived;

---

--- Query #3a

with
     count_arrived(id_item, item_arrived) as (
        select id_item, sum(amount) from str_waybill group by id_item
    ),
     count_item(id_item, item_amount, count_in_orders) as (
        select id_item, sum(amount), count(id_order) from str_order group by id_item
    ),
     r_orders(id_item, count_released) as (
         select id_item, count(id_order) from str_order join order_tab using (id_order) where release='y' and canceled='n' group by id_item
     ),
     c_orders(id_item, count_canceled) as (
         select id_item, count(id_order) from str_order join order_tab using (id_order) where canceled='y' group by id_item
     )
SELECT * from item JOIN count_arrived   USING (id_item)
                   JOIN count_item      USING (id_item)
                   JOIN r_orders        USING (id_item)
                   JOIN c_orders        USING (id_item)
    where item_amount < item_arrived;

---

--- Query #4

with
    most_order (id_item, most_number_of_orders) as (
        select id_item, count(id_order) from str_order group by id_item order by count(id_order) DESC LIMIT 3
    ),
     less_order (id_item, less_number_of_orders) as (
         select id_item, count(id_order) from str_order join order_tab using (id_order) where canceled='y' group by id_item order by count(id_order) DESC LIMIT 3
     ),
     expected_profit (id_item, e_profit) as (
         select id_item, sum(amount) from str_order group by id_item
     ),
     getted_profit (id_item, g_profit) as (
         select id_item, sum(amount) from str_order join order_tab using (id_order) where payment='y' group by id_item
     ),
     ungetted_profit (id_item, u_profit) as (
         select id_item, sum(amount) from str_order join order_tab using (id_order) where canceled='y' group by id_item
     ),
     all_orders(id_item, most_number_of_orders, less_number_of_orders) as (
         select id_item, COALESCE(most_number_of_orders,0), COALESCE(less_number_of_orders,0) from most_order full outer join less_order using (id_item)
     )

select * from item  inner join all_orders using (id_item)
                    join expected_profit using(id_item)
                    join getted_profit using(id_item)
                    join ungetted_profit using(id_item);

---

--- Query #5

with
    orders (id_order, date_of_create, date_of_done, id_customer, type, address, phone) as (
        select id_order, date, (date + 30), id_customer, type, address, phone  from order_tab inner join customer using (id_customer) where now() > (date + 30) and payment='n' and canceled='n'
    ),
     order_info(id_order, qty, done) as (
         select id_order, sum(amount) as qty, sum(amount_ready) as done from str_order where id_order in (select id_order from orders) group by id_order
    )
select id_order, date_of_create, date_of_done, id_customer, type, address, phone, qty, done, (qty - done) as least from orders join order_info using(id_order);

---
