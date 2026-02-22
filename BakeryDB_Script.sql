
CREATE DATABASE Bakery;
GO

USE Bakery;
GO

-- 1. СОЗДАНИЕ СТРУКТУРЫ ТАБЛИЦ
CREATE TABLE Roles (
    RoleID   INT           PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(50)  NOT NULL UNIQUE
);

CREATE TABLE Users (
    UserID       INT           PRIMARY KEY IDENTITY(1,1),
    Username     NVARCHAR(50)  NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    RoleID       INT           NOT NULL,
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

CREATE TABLE Products (
    ProductID     INT            PRIMARY KEY IDENTITY(1,1),
    Name          NVARCHAR(100)  NOT NULL,
    Category      NVARCHAR(50)   NOT NULL,
    Price         DECIMAL(10, 2) NOT NULL CONSTRAINT CHK_Products_Price CHECK (Price > 0),
    StockQuantity INT            NOT NULL DEFAULT 0 CONSTRAINT CHK_Products_Stock CHECK (StockQuantity >= 0)
);

CREATE TABLE Suppliers (
    SupplierID  INT           PRIMARY KEY IDENTITY(1,1),
    Name        NVARCHAR(100) NOT NULL,
    ContactInfo NVARCHAR(255) NULL
);

CREATE TABLE Clients (
    ClientID    INT           PRIMARY KEY IDENTITY(1,1),
    Name        NVARCHAR(100) NOT NULL,
    ContactInfo NVARCHAR(255) NULL
);

CREATE TABLE Orders (
    OrderID   INT           PRIMARY KEY IDENTITY(1,1),
    ClientID  INT           NOT NULL,
    OrderDate DATETIME      NOT NULL DEFAULT GETDATE(),
    Status    NVARCHAR(50)  NOT NULL DEFAULT N'Новый'
        CONSTRAINT CHK_Orders_Status CHECK (Status IN (N'Новый', N'В обработке', N'Выполнен', N'Отменён')),
    CONSTRAINT FK_Orders_Clients FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID       INT NOT NULL,
    ProductID     INT NOT NULL,
    Quantity      INT NOT NULL CONSTRAINT CHK_OrderDetails_Qty CHECK (Quantity > 0),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- 2. ЗАПОЛНЕНИЕ ДАННЫМИ
SET DATEFORMAT ymd;
GO

-- Роли
INSERT INTO Roles (RoleName) VALUES 
(N'Администратор'), (N'Менеджер по продажам'), (N'Складской работник'), (N'Логист');

-- Пользователи (admin123, manager123, stock123)
INSERT INTO Users (Username, PasswordHash, RoleID) VALUES
(N'admin',    N'240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 1),
(N'manager1', N'866485796cfa8d7c0cf7111640205b83076433547577511d81f8030ae99ecea5', 2),
(N'manager2', N'866485796cfa8d7c0cf7111640205b83076433547577511d81f8030ae99ecea5', 2),
(N'stock_user', N'2865dd81e909d7ddaa85076b6187102140e01fe48fd203f1d7a73b0b515fbac5', 3);

-- Продукция (20 позиций)
INSERT INTO Products (Name, Category, Price, StockQuantity) VALUES
(N'Хлеб ржаной', N'Хлеб', 35.00, 250), (N'Батон нарезной', N'Хлеб', 28.00, 300),
(N'Бородинский', N'Хлеб', 42.00, 150), (N'Багет французский', N'Хлеб', 55.00, 80),
(N'Чиабатта', N'Хлеб', 60.00, 60), (N'Круассан классический', N'Выпечка', 45.00, 100),
(N'Круассан с шоколадом', N'Выпечка', 65.00, 70), (N'Улитка с изюмом', N'Выпечка', 40.00, 120),
(N'Слойка с творогом', N'Выпечка', 38.00, 110), (N'Пончик глазированный', N'Выпечка', 50.00, 90),
(N'Кекс лимонный', N'Кексы', 120.00, 30), (N'Маффин черничный', N'Кексы', 85.00, 45),
(N'Торт Наполеон', N'Торты', 850.00, 10), (N'Торт Медовик', N'Торты', 780.00, 12),
(N'Торт Прага', N'Торты', 920.00, 8), (N'Пирожное Эклер', N'Десерты', 75.00, 50),
(N'Пирожное Картошка', N'Десерты', 55.00, 65), (N'Печенье овсяное', N'Печенье', 180.00, 40),
(N'Сушки с маком', N'Снеки', 95.00, 100), (N'Пирог с яблоком', N'Выпечка', 350.00, 15);

-- Поставщики
INSERT INTO Suppliers (Name, ContactInfo) VALUES 
(N'АО Мелькомбинат №4', N'sales@melkomb.ru'), (N'ООО Молочный Мир', N'+7 495 555-01-02'),
(N'Мир Упаковки', N'info@packworld.com'), (N'СахарИнвест', N'opt@sugar.ru');

-- Клиенты (10 записей)
INSERT INTO Clients (Name, ContactInfo) VALUES 
(N'Сеть Пятёрочка', N'corp@5ka.ru'), (N'Магазин У дома', N'+7 900 111-22-33'),
(N'Кафе Шоколадница', N'zakaz@shoko.ru'), (N'Ресторан Прага', N'prague@rest.ru'),
(N'ИП Сидоров', N'sidorov@mail.ru'), (N'Школа №1502', N'school1502@edu.ru'),
(N'Булочная №1', N'bulochnaya@list.ru'), (N'Отель Метрополь', N'reception@metropol.ru'),
(N'Кондитерская Смак', N'smak@smak.ru'), (N'Супермаркет Виктория', N'opt@victoria.ru');

-- Заказы (15 заказов)
INSERT INTO Orders (ClientID, OrderDate, Status) VALUES
(1, '2025-11-20 08:30:00', N'Выполнен'), (2, '2025-11-21 09:00:00', N'Выполнен'),
(3, '2025-12-05 10:15:00', N'Выполнен'), (4, '2025-12-15 11:00:00', N'Выполнен'),
(5, '2026-01-10 08:45:00', N'Выполнен'), (6, '2026-01-20 09:30:00', N'Выполнен'),
(7, '2026-02-01 10:00:00', N'Выполнен'), (8, '2026-02-10 08:00:00', N'Выполнен'),
(9, '2026-02-14 14:00:00', N'Выполнен'), (10, '2026-02-17 09:00:00', N'В обработке'),
(1, '2026-02-18 07:30:00', N'Новый'), (2, '2026-02-18 10:00:00', N'Новый'),
(3, '2026-02-19 08:15:00', N'Новый'), (4, '2026-02-19 08:45:00', N'Новый'),
(10, '2026-02-19 09:30:00', N'Новый');

-- Позиции заказов (разные продукты для каждого заказа)
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 100), (1, 2, 150), (1, 3, 50),
(2, 2, 30), (2, 8, 20),
(3, 6, 40), (3, 7, 30), (3, 16, 25),
(4, 13, 2), (4, 14, 3), (4, 15, 2),
(5, 1, 20), (5, 4, 15),
(6, 2, 200), (6, 9, 50),
(7, 4, 30), (7, 5, 20), (7, 10, 40),
(8, 13, 5), (8, 11, 10),
(9, 16, 30), (9, 17, 30), (9, 7, 20),
(10, 1, 500), (10, 2, 500),
(11, 2, 100), (11, 8, 40),
(12, 1, 50), (12, 12, 10),
(13, 18, 5), (13, 19, 10),
(14, 14, 1), (14, 20, 2),
(15, 3, 100), (15, 4, 40);
GO

-- 3. ПРОВЕРКА ДАННЫХ
PRINT N'База успешно заполнена!';
SELECT 'Пользователи' as [Т], COUNT(*) as [Кол-во] FROM Users
UNION ALL SELECT 'Товары', COUNT(*) FROM Products
UNION ALL SELECT 'Клиенты', COUNT(*) FROM Clients
UNION ALL SELECT 'Заказы', COUNT(*) FROM Orders;

-- Вывод последних 5 заказов с итоговой суммой
SELECT TOP 5 
    o.OrderID, 
    c.Name AS [Клиент], 
    o.Status, 
    o.OrderDate,
    SUM(od.Quantity * p.Price) AS [Сумма]
FROM Orders o
JOIN Clients c ON o.ClientID = c.ClientID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID, c.Name, o.Status, o.OrderDate
ORDER BY o.OrderDate DESC;