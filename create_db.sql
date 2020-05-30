CREATE DATABASE ladoga;

CREATE TABLE Customer(
    id_Customer SERIAL UNIQUE,
    Register date NOT NULL default now(),
    Type char(1) NOT NULL,
    Address varchar(30),
    Phone varchar(10) NOT NULL UNIQUE,
    PRIMARY KEY (id_Customer)
);

CREATE TABLE Legal_Person(
    Name varchar(20) NOT NULL,
    License varchar(20) NOT NULL UNIQUE,
    Account varchar(20) NOT NULL UNIQUE,
    Category varchar(10),
    id_Customer integer REFERENCES Customer,
    PRIMARY KEY (id_Customer)
);

CREATE TABLE Private_person(
    Surname varchar(20) NOT NULL,
    Name varchar(20) NOT NULL,
    Midname varchar(20) NOT NULL,
    Year_of_birth integer,
    Passport varchar(10) NOT NULL UNIQUE,
    id_Customer integer REFERENCES Customer,
    PRIMARY KEY (id_Customer)
);

CREATE TABLE Order_tab(
    id_Order SERIAL UNIQUE,
    id_Customer integer REFERENCES Customer,
    Date date NOT NULL default now(),
    FirstNotice date,
    Payment char(1) default 'n',
    Release char(1) default 'n',
    Canceled char(1) default 'n',
    Cancel_data date,
    PRIMARY KEY (id_Order)
);

CREATE TABLE Bill(
    id_Bill SERIAL UNIQUE,
    Type char(1) NOT NULL,
    Payment varchar(10) NOT NULL,
    Summary integer NOT NULL,
    Date_payment date default now(),
    PRIMARY KEY (id_Bill)
);

CREATE TABLE Notice(
    id_Order integer REFERENCES Order_tab,
    id_Notice SERIAL UNIQUE,
    date_notice date NOT NULL default now(),
    id_Bill integer REFERENCES Bill,
    PRIMARY KEY (id_Order, id_Notice)
);

CREATE TABLE Waybill(
    id_Waybill SERIAL UNIQUE,
    Arrive date NOT NULL default now(),
    PRIMARY KEY (id_Waybill)
);

CREATE TABLE Item(
    id_Item SERIAL UNIQUE,
    Name varchar(20) NOT NULL,
    Article integer NOT NULL UNIQUE,
    Cert varchar(20),
    Package varchar(10),
    Producer varchar(20),
    Amount integer NOT NULL,
    Price integer NOT NULL,
    PRIMARY KEY (id_Item)
);

CREATE TABLE Str_Waybill(
    id_Item integer REFERENCES Item,
    id_Waybill integer REFERENCES Waybill,
    Amount integer NOT NULL,
    Price integer NOT NULL,
    PRIMARY KEY (id_Item, id_Waybill)
);

CREATE TABLE Str_Order(
    id_Order integer REFERENCES Order_tab,
    id_Item integer REFERENCES Item,
    Amount integer NOT NULL,
    Price integer NOT NULL,
    Amount_ready integer NOT NULL default 0,
    PRIMARY KEY (id_Order, id_Item)
);