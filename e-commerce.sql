
CREATE DATABASE e_commerce;

\c e_commerce;

CREATE TABLE customer(
        id Int BIGSERIAL,
        first_name     Varchar (255),
        last_name     Varchar (255),
        email     Varchar (200),
        password     Varchar (200),
        phone_number     Varchar (100),
        PRIMARY KEY (id)
);

CREATE TABLE command(
        id  Int BIGSERIAL,
        command_date Date,
        id_customer  Int,
        id_product Int ,
        how_many_product Int,
        PRIMARY KEY (id)
);


CREATE TABLE product(
        id  Int BIGSERIAL,
        product_name  Varchar (255),
        product_price     Int,
        depot_date     Date,
        is_available boolean,
        product_category Varchar (255),
        -- id_product_category  Int,
        buying_date current_date,
        PRIMARY KEY (id)
);


-- CREATE TABLE product_category(
--         id  Int BIGSERIAL,
--         category_name     Varchar (255),
--         PRIMARY KEY (id)
-- );

CREATE TABLE payement(
        id Int BIGSERIAL,
        payement_date     Date,
        payement_method     Varchar (100),
        id_command  Int,
        PRIMARY KEY (id)
);


ALTER TABLE command ADD CONSTRAINT FK_command_id_customer FOREIGN KEY (id_customer) REFERENCES customer(id);
ALTER TABLE command ADD CONSTRAINT FK_command_id_product FOREIGN KEY (id_product) REFERENCES product(id);
ALTER TABLE product ADD CONSTRAINT FK_product_id_product_category FOREIGN KEY (id_product_category) REFERENCES product_category(id);
ALTER TABLE payement ADD CONSTRAINT FK_payement_id_command FOREIGN KEY (id_command) REFERENCES command(id);

-- afficher tous les produits :
SELECT count(*) FROM product;
-- moin cher , plus cher par catégories :
SELECT min(product.product_price) as le moins cher , max(product.product_price) as le plus cher from product group by product.product_category;
-- le prix total par comd de rakoto :
SELECT sum(product.product_price) as somme from customer ct inner join command cmd on ct.id = cmd.id_customer join product p on p.id = cmd.id_product group by command.id;
-- le top des produits vendus :
SELECT count(command.id) as achats FROM command inner join product on command.id_product = product.id group by product.product_name order by  achats desc ;
-- le chiffre d'affaire de l'année 
SELECT sum(product.product_price) as C_A FROM product where EXTRACT(year from product.buying_date) = '2024'; 

-- exercice 2 -----------------------------------------------------------------
 
 CREATE INDEX index_first_name on "user"(first_name);
 CREATE VIEW users_detail as select user_id, first_name,age ,email,number_of_posts from "user" u join posts p on u.posts_id = p.posts_id;
 SELECT first_name,age FROM users_detail where age<'20' and number_of_posts >0;
 SELECT first_name,age FROM "user" u join posts p on u.posts_id = p.posts_id where age<'20' and number_of_posts >0;          