-- Взяли тему: бронироввание авто.



CREATE TABLE Roles (
roles_ID INT IDENTITY(1,1) PRIMARY KEY,
    roles_name NVARCHAR(20) NOT NULL);

CREATE TABLE Users (
users_ID INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    patronymic NVARCHAR(100),
    phone NVARCHAR(25) NOT NULL,

    FK_role_id INT NOT NULL REFERENCES Roles(roles_id)
);
CREATE TABLE Car (
car_ID INT IDENTITY(1,1) PRIMARY KEY,
    serial_number NVARCHAR(50) NOT NULL,
    brand NVARCHAR(100) NOT NULL,
    release_year DATE NOT NULL,
    mileage DECIMAL NOT NULL
);

CREATE TABLE Rental_point (
rental_point_ID INT IDENTITY(1,1) PRIMARY KEY,
    city NVARCHAR(100) NOT NULL,
    adress NVARCHAR(255) NOT NULL,
    work_hours NVARCHAR(100) NOT NULL,
    capacity INT NOT NULL,

users_ID INT NOT NULL REFERENCES Users(users_id)); -- пункт проката


CREATE TABLE Status (
status_ID INT IDENTITY(1,1) PRIMARY KEY,
status_state NVARCHAR(100) NOT NULL,
);

CREATE TABLE Car_contract (
car_contract_ID INT IDENTITY(1,1) PRIMARY KEY,
    FK_rental_point_ID INT NOT NULL REFERENCES Rental_point(rental_point_ID),
    FK_return_point_ID INT NOT NULL REFERENCES Rental_point(rental_point_ID),
    FK_car_ID INT NOT NULL REFERENCES Car(car_ID),
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    FK_status INT NOT NULL REFERENCES Status(status_ID)
); -- договор аренды


CREATE TABLE Booking (
booking_ID INT IDENTITY(1,1) PRIMARY KEY,
    FK_client_ID INT NOT NULL REFERENCES Users(users_ID),
    FK_Car_contract INT NOT NULL REFERENCES Car_contract(car_contract_ID)
);



INSERT INTO Roles (roles_name) 
VALUES 
    (N'Клиент'),
    (N'Поставщик'),
    (N'Менеджер');

INSERT INTO Users (first_name, last_name, patronymic, phone, FK_role_id) 
VALUES 
    (N'Иван', N'Смирнов', N'Алексеевич', N'+79991234567', 1),
    (N'Елена', N'Кузнецова', N'Сергеевна', N'+79997654321', 2);

INSERT INTO Car (serial_number, brand, release_year, mileage) 
VALUES 
    (N'А123ВС77', N'Yotota Yaris', '2022-05-15', 34500.50),
    (N'Е456КХ99', N'Ria Kio', '2021-08-20', 61200.00);

INSERT INTO Rental_point (city, adress, work_hours, capacity, users_ID) 
VALUES 
    (N'МАсква', N'ул. Тверская, д. 10', N'08:00 - 22:00', 25, 2),
    (N'МАсква', N'Ленинградский пр-т, д. 45', N'Круглосуточно', 40, 2);

INSERT INTO Status (status_state) 
VALUES 
    (N'Свободна'),
    (N'Возвращается'),
    (N'???'),
    (N'В аренде');

INSERT INTO Car_contract (FK_rental_point_ID, FK_return_point_ID, FK_car_ID, start_date, end_date, FK_status) 
VALUES 
    (1, 2, 1, '2026-11-16T10:00:00', '2026-11-20T10:00:00', 1),
    (2, 2, 2, '2026-11-01T12:00:00', '2026-11-05T18:00:00', 2);

INSERT INTO Booking (FK_client_ID, FK_Car_contract) 
VALUES 
    (1, 1),
    (1, 2);
