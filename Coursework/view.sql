USE Restaurant;
GO

CREATE VIEW Order_info AS
SELECT New_order.ID, Worker.Surname AS 'Waiter', 
Table_number.Number AS 'Table number', New_order.Order_date, 
New_order.Order_time, New_order.Price
FROM New_order JOIN Worker ON Waiter_ID = Worker.ID JOIN Table_number ON Table_ID = Table_number.ID
GO

CREATE VIEW Order_row_info AS
SELECT Order_row.ID, Order_info.ID AS 'Order ID', Order_info.Waiter, 
Order_info.[Table number], Order_info.Order_date, Order_info.Order_time, 
Menu.Food, Menu.Food_type, Order_row.Price, Order_row.Amount, Worker.Surname AS 'Worker'
FROM Order_row JOIN Order_info ON Order_ID = Order_info.ID 
JOIN Menu ON Order_row.Food_ID = Menu.ID LEFT JOIN Worker ON Order_row.Worker_ID=Worker.ID
GO
