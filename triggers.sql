--- Trigger #1 

CREATE OR REPLACE FUNCTION update_payment()
    RETURNS trigger AS
$BODY$
BEGIN
    IF NEW.id_bill is not null THEN
        UPDATE Order_tab SET payment = 'y' where id_order = NEW.id_order;
    END IF;
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_pay
AFTER UPDATE
ON Notice
FOR EACH ROW
EXECUTE FUNCTION update_payment();

---

--- Trigger #2

CREATE OR REPLACE FUNCTION update_amount_and_price()
    RETURNS trigger AS
$BODY$
BEGIN
    IF NEW.id_Item <> 0 THEN
        UPDATE Item SET (Price, Amount) = (NEW.Price , Amount + NEW.Amount) where id_Item = NEW.id_Item;
    END IF;
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_trigger
AFTER INSERT
ON Str_Waybill
FOR EACH ROW
EXECUTE FUNCTION update_amount_and_price();

---

--- Trigger #3

CREATE OR REPLACE FUNCTION can_cancel_order()
    RETURNS TRIGGER as
$BODY$
    begin
        IF NEW.Canceled = 'y' then
            if OLD.Payment != 'y' then
                if OLD.Canceled = 'y' then
                    RAISE EXCEPTION 'ORDER ALREADY HAS BEEN CANCELED';
                end if;
                NEW.Cancel_data = now();
                UPDATE Item SET Amount=(Amount + tab.Amount_ready)
                    from (SELECT Str_Order.Amount_ready, Str_Order.id_Item
                        from Str_Order where Str_Order.id_Order = OLD.id_Order) as tab
                    where Item.id_Item = tab.id_Item;
                UPDATE Str_Order SET Amount_ready=0 where id_Order = OLD.id_Order;
                RETURN NEW;
            end if;
            RAISE EXCEPTION 'ORDER ALREADY HAS PAYMENT';
        end if;
        RETURN NEW;
    end
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER cancel_trigger
BEFORE UPDATE
ON Order_tab
FOR EACH ROW
EXECUTE FUNCTION can_cancel_order();

---