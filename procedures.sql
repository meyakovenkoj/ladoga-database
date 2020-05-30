--- Procedure #1

CREATE OR REPLACE PROCEDURE make_order(inout new_order integer, cus_phone varchar(10),
                                        item_article integer, item_amount integer, inout msg varchar(50) default 'OK')
as $BODY$
DECLARE
    item_id integer;
    item_price integer;
    customer_id integer;
begin
    customer_id := (select id_customer from customer where phone=cus_phone);
    if customer_id is not null then
    if new_order != 0 then
        if (select id_Item from Item where Item.Article = item_article) IS NOT NULL then
            item_id := (select id_Item from Item where Item.Article = item_article);
            if (select id_Order from Order_tab where Order_tab.id_Order = new_order) IS NOT NULL then
                item_price := (select Price from Item where Item.id_Item = item_id);
                if (select id_Order from str_order
                        where Str_Order.id_Order = new_order and Str_Order.id_Item = item_id) is not null then
                    update Str_Order set Amount = Amount + item_amount
                        where Str_Order.id_Item = item_id and Str_Order.id_Order = new_order;
                    RETURN;
                end if;
                insert into Str_Order(id_Order, id_Item, Amount, Price)
                    VALUES (new_order, item_id, item_amount, item_price);
                RETURN;
            end if;
            msg := 'THERE IS NO SUCH ORDER';
            RETURN;
        end if;
        msg := 'THERE IS NO SUCH ITEM';
        RETURN;
    end if;
    if (select id_Item from Item where Item.Article = item_article) IS NOT NULL then
        insert into order_tab(id_Customer) values (customer_id);
        new_order := lastval();
        item_id := (select id_Item from Item where Item.Article = item_article);
        item_price := (select Price from Item where Item.id_Item = item_id);
        insert into str_order(id_Order, id_Item, Amount, Price) values (new_order, item_id, item_amount, item_price);
        RETURN;
    end if;
    msg := 'THERE IS NO SUCH ITEM';
    RETURN;
    end if;
    msg := 'THERE IS NO SUCH CUSTOMER';
    RETURN;
end
$BODY$
LANGUAGE plpgsql;

--- Usage
call make_order(0, '899929', 97, 4);
---

--- Procedure #2

CREATE OR REPLACE PROCEDURE add_items_to_orders()
as
    $BODY$
    declare
        items cursor for select id_Item, Amount from Item for update;
        str_orders cursor for select Str_Order.id_Order, id_Item, Amount,Amount_ready
            from Str_Order inner join Order_tab on Str_Order.id_Order = Order_tab.id_Order
            order by date for update;
        _item integer;
        _amount integer;
        _order integer;
        _ord_item integer;
        _need integer;
        _have integer;
        _new integer;
    begin
        open items;
        loop
            fetch items into _item, _amount;
            IF NOT FOUND THEN EXIT;END IF;
            open str_orders;
            loop
                fetch str_orders into _order, _ord_item, _need, _have;
                IF NOT FOUND THEN EXIT;END IF;
                if (SELECT Canceled from Order_tab where id_Order=_order and Canceled='n') is not null then
                    if ((_need - _have) > 0 and _ord_item = _item) then
                        if (_amount > 0) then
                            _new = least((_need - _have), _amount);
                            _amount = (_amount - _new);
                            UPDATE Str_Order set Amount_ready=(Str_Order.Amount_ready + _new)
                                where Str_Order.id_Order = _order and Str_Order.id_Item = _ord_item;
                        end if;
                    end if;
                end if;
            end loop;
            UPDATE Item set Amount=_amount where Item.id_Item = _item;
            close str_orders;
        end loop;
        close items;
        call order_notify();
    end
    $BODY$
LANGUAGE plpgsql;

--- Procedure #2a

CREATE OR REPLACE PROCEDURE order_notify()
as
    $BODY$
    declare
        ready_orders cursor for select id_order, sum(amount) as total, sum(amount_ready) as ready from Str_Order group by id_order;
        _order integer;
        _total integer;
        _ready integer;
    begin
        open ready_orders;
        loop
            fetch ready_orders into _order, _total, _ready;
            IF NOT FOUND THEN EXIT;END IF;
            if (_total = _ready) then
                if(SELECT canceled from Order_tab where id_Order=_order and Canceled='n' and Release='n') is not null then
                    INSERT INTO Notice(id_order) VALUES (_order);
                    UPDATE Order_tab set (release, firstnotice)=('y',now()) where id_Order=_order;
                end if;
            end if;
        end loop;
        close ready_orders;
    end
    $BODY$
LANGUAGE plpgsql;

--- Usage
call add_items_to_orders();
---