CREATE TABLE customer(
	id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100), 
    birthday date,
    gender tinyint
);
CREATE TABLE orders(
	id INT PRIMARY KEY,
    cusid INT,
    FOREIGN KEY(cusid) REFERENCES customer(id),
    created date default(current_date()),
    status tinyint
);
CREATE TABLE category(
	id int primary key,
    name varchar(100) unique,
    status tinyint default(1)
);
CREATE TABLE product(
	id INT PRIMARY KEY,
    name VARCHAR(200),
    catId int,
    price float check (price > 0),
    sale_price float,
    constraint check (sale_price < price),
    foreign key(catId) references category(id)
);
CREATE TABLE order_detail(
	order_id INT,
    FOREIGN KEY(order_id) REFERENCES orders(id),
    product_id INT,
    FOREIGN KEY(product_id) REFERENCES product(id),
    PRIMARY KEY (order_id,product_id),
    quantity INT,
    price float
);
INSERT INTO `session02_bt_trenlop`.`product` (`id`, `name`, `catId`, `price`, `sale_price`) VALUES ('1', 'quần soóc', '2', '150000', '130000');
INSERT INTO `session02_bt_trenlop`.`product` (`id`, `name`, `catId`, `price`, `sale_price`) VALUES ('2', 'áo thun', '1', '250000', '200000');
INSERT INTO `session02_bt_trenlop`.`product` (`id`, `name`, `catId`, `price`, `sale_price`) VALUES ('3', 'áo phao', '1', '7500000', '3500000');
INSERT INTO `session02_bt_trenlop`.`product` (`id`, `name`, `catId`, `price`, `sale_price`) VALUES ('4', 'giày da', '4', '2500000', '2000000');
INSERT INTO `session02_bt_trenlop`.`product` (`id`, `name`, `catId`, `price`, `sale_price`) VALUES ('5', 'mũ lưới trai', '3', '800000', '600000');
INSERT INTO `session02_bt_trenlop`.`product` (`id`, `name`, `catId`, `price`, `sale_price`) VALUES ('6', 'mũ bảo hiểm trai', '3', '500000', '450000');

INSERT INTO `session02_bt_trenlop`.`order_detail` (`order_id`, `product_id`, `quantity`, `price`) VALUES ('1', '1', '2', '250000');
INSERT INTO `session02_bt_trenlop`.`order_detail` (`order_id`, `product_id`, `quantity`, `price`) VALUES ('1', '2', '2', '200000');
INSERT INTO `session02_bt_trenlop`.`order_detail` (`order_id`, `product_id`, `quantity`, `price`) VALUES ('2', '5', '1', '800000');
INSERT INTO `session02_bt_trenlop`.`order_detail` (`order_id`, `product_id`, `quantity`, `price`) VALUES ('3', '4', '2', '2000000');
INSERT INTO `session02_bt_trenlop`.`order_detail` (`order_id`, `product_id`, `quantity`, `price`) VALUES ('4', '3', '1', '3500000');
INSERT INTO `session02_bt_trenlop`.`order_detail` (`order_id`, `product_id`, `quantity`, `price`) VALUES ('5', '2', '1', '250000');
alter table orders add column note text;
INSERT INTO `session02_bt_trenlop`.`customer` (`id`, `name`, `email`, `birthday`, `gender`) VALUES ('6', 'Nguyễn X', 'x@gmail.com', '1996/11/11', '1');
select * from category where status=1;
select * from product;
select * from product where sale_price > 0;
select id,name,price,sale_price,100*(1-(sale_price/price)) as 'percent_price' from product;
UPDATE `session02_bt_trenlop`.`product` SET `price` = '200000' WHERE (`id` = '1');
delete from product where id = 6;

SELECT o.id,c.name as tên_người_đặt,o.created as ngày_đặt,o.status as trạng_thái,SUM(d.quantity) as'số lượng sản phẩm',SUM(d.quantity*d.price) as 'thành tiền' 
from orders o
join  customer c
on o.cusid=c.id
join order_detail d
on d.order_id=o.id
GROUP BY o.id, c.name, o.created, o.status;
select o.order_id,p.name as tên_sản_phẩm, o.quantity as số_lượng,o.price as đơn_giá, (o.price*o.quantity) as thành_tiền
from order_detail o
join product p
on o.product_id = p.id;

select c.*,COUNT(*) as total_product
from category c
join product p
on c.id=p.catId
group by c.id,c.name;