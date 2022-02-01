CREATE TABLE `actor` (
  `actor_id` smallint PRIMARY KEY,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `last_update` timestamp
);

CREATE TABLE `address` (
  `address_id` smallint PRIMARY KEY,
  `address` varchar(50),
  `address2` varchar(50),
  `district` varchar(20),
  `city_id` smallint,
  `postal_code` varchar(10),
  `phone` varchar(20),
  `location` geometry,
  `last_update` timestamp
);

CREATE TABLE `category` (
  `category_id` tinyint PRIMARY KEY,
  `name` varchar(25),
  `last_update` timestamp
);

CREATE TABLE `city` (
  `city_id` smallint PRIMARY KEY,
  `city` varchar(50),
  `country_id` smallint,
  `last_update` timestamp
);

CREATE TABLE `country` (
  `country_id` smallint PRIMARY KEY,
  `country` varchar(50),
  `last_update` timestamp
);

CREATE TABLE `customer` (
  `customer_id` smallint PRIMARY KEY,
  `store_id` tinyint,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `email` varchar(50),
  `address_id` smallint,
  `active` tinyint(1),
  `create_date` datetime,
  `last_update` timestamp
);

CREATE TABLE `film` (
  `film_id` smallint PRIMARY KEY,
  `title` varchar(255),
  `description` text,
  `release_year` year,
  `language_id` tinyint,
  `original_language_id` tinyint,
  `rental_duration` tinyint,
  `rental_rate` decimal(4,2),
  `length` smallint,
  `replacement_cost` decimal(5,2),
  `rating` enum,
  `special_features` set('Trailers','Commentaries','Deleted Scenes','Behind the Scenes'),
  `last_update` timestamp
);

CREATE TABLE `film_actor` (
  `actor_id` smallint,
  `film_id` smallint,
  `last_update` timestamp,
  PRIMARY KEY (`actor_id`, `film_id`)
);

CREATE TABLE `film_category` (
  `film_id` smallint,
  `category_id` tinyint,
  `last_update` timestamp,
  PRIMARY KEY (`film_id`, `category_id`)
);

CREATE TABLE `film_text` (
  `film_id` smallint PRIMARY KEY,
  `title` varchar(255),
  `description` text
);

CREATE TABLE `inventory` (
  `inventory_id` mediumint,
  `film_id` smallint,
  `store_id` tinyint,
  `last_update` timestamp,
  PRIMARY KEY (`inventory_id`, `film_id`, `store_id`)
);

CREATE TABLE `language` (
  `language_id` tinyint PRIMARY KEY,
  `name` char(20),
  `last_update` timestamp
);

CREATE TABLE `payment` (
  `payment_id` smallint PRIMARY KEY,
  `customer_id` smallint,
  `staff_id` tinyint,
  `rental_id` int,
  `amount` decimal(5,2),
  `payment_date` datetime,
  `last_update` timestamp
);

CREATE TABLE `rental` (
  `rental_id` int PRIMARY KEY,
  `rental_date` datetime,
  `inventory_id` mediumint,
  `customer_id` smallint,
  `return_date` datetime,
  `staff_id` tinyint,
  `last_update` timestamp,
  `months` varchar(20),
  `weekdays` varchar(20),
  `day_type` varchar(20)
);

CREATE TABLE `staff` (
  `staff_id` tinyint PRIMARY KEY,
  `first_name` varchar(45),
  `last_name` varchar(45),
  `address_id` smallint,
  `email` varchar(50),
  `store_id` tinyint,
  `active` tinyint(1),
  `username` varchar(16),
  `password` varchar(40),
  `last_update` timestamp
);

CREATE TABLE `store` (
  `store_id` tinyint PRIMARY KEY,
  `manager_staff_id` tinyint,
  `address_id` smallint,
  `last_update` timestamp
);

ALTER TABLE `staff` ADD FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

ALTER TABLE `staff` ADD FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `payment` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`rental_id`) REFERENCES `payment` (`rental_id`);

ALTER TABLE `customer` ADD FOREIGN KEY (`customer_id`) REFERENCES `rental` (`customer_id`);

ALTER TABLE `customer` ADD FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

ALTER TABLE `customer` ADD FOREIGN KEY (`store_id`) REFERENCES `inventory` (`store_id`);

ALTER TABLE `inventory` ADD FOREIGN KEY (`inventory_id`) REFERENCES `rental` (`inventory_id`);

ALTER TABLE `store` ADD FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

ALTER TABLE `inventory` ADD FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

ALTER TABLE `customer` ADD FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

ALTER TABLE `city` ADD FOREIGN KEY (`city_id`) REFERENCES `address` (`city_id`);

ALTER TABLE `country` ADD FOREIGN KEY (`country_id`) REFERENCES `city` (`country_id`);

ALTER TABLE `inventory` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `rental` ADD FOREIGN KEY (`staff_id`) REFERENCES `payment` (`staff_id`);

ALTER TABLE `payment` ADD FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

ALTER TABLE `film_category` ADD FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

ALTER TABLE `actor` ADD FOREIGN KEY (`actor_id`) REFERENCES `film_actor` (`actor_id`);

ALTER TABLE `film_actor` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `film_category` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`);

ALTER TABLE `language` ADD FOREIGN KEY (`language_id`) REFERENCES `film` (`language_id`);

