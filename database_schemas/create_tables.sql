DROP TABLE IF EXISTS buyers;
CREATE TABLE `buyers` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `phone_number` char(10),
  `first_name` varchar(255),
  `last_name` varchar(255),
  `wallet_balance` decimal
);

DROP TABLE IF EXISTS addresses;
CREATE TABLE `addresses` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint,
  `address_line1` varchar(255),
  `address_line2` varchar(255),
  `city` varchar(255),
  `pincode` varchar(255),
  `country` varchar(255)
);

DROP TABLE IF EXISTS payment_cards;
CREATE TABLE `payment_cards` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint,
  `name_on_card` varchar(255),
  `card_number` char(16),
  `cvv` varchar(255)
);

DROP TABLE IF EXISTS order_items;
CREATE TABLE `order_items` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `order_id` bigint,
  `product_id` bigint,
  `quantity` bigint DEFAULT 1
);

DROP TABLE IF EXISTS orders;
CREATE TABLE `orders` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `status` ENUM ("on_the_way", "delivered", "cancelled"),
  `created_at` varchar(40),
  `arriving_on` varchar(40),
  `order_total` decimal,
  `billing_address` bigint,
  `payment_method` ENUM ("wallet", "card")
);

DROP TABLE IF EXISTS products;
CREATE TABLE `products` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255),
  `image` varchar(255),
  `description` text,
  `category` ENUM ('furniture', 'lighting', 'plants', 'show_pieces'),
  `brand` ENUM ('home_centre', 'ddecor', 'stylestop'),
  `seller_id` bigint NOT NULL,
  `price` decimal,
  `left_in_stock` bigint,
  `discount_id` bigint
);

DROP TABLE IF EXISTS discounts;
CREATE TABLE `discounts` (
  `id` bigint PRIMARY KEY,
  `name` varchar(255),
  `percent` decimal
);

DROP TABLE IF EXISTS cart_items;
CREATE TABLE `cart_items` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint,
  `product_id` bigint,
  `quantity` bigint
);

DROP TABLE IF EXISTS sellers;
CREATE TABLE `sellers` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `phone_number` char(10),
  `seller_name` varchar(255),
  `account_balance` decimal
);

ALTER TABLE `order_items` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `products` ADD FOREIGN KEY (`seller_id`) REFERENCES `sellers` (`id`);

ALTER TABLE `addresses` ADD FOREIGN KEY (`user_id`) REFERENCES `buyers` (`id`);

ALTER TABLE `products` ADD FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`);

ALTER TABLE `buyers` ADD FOREIGN KEY (`id`) REFERENCES `payment_cards` (`user_id`);

ALTER TABLE `cart_items` ADD FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`user_id`) REFERENCES `buyers` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`billing_address`) REFERENCES `addresses` (`id`);

ALTER TABLE `cart_items` ADD FOREIGN KEY (`user_id`) REFERENCES `buyers` (`id`);
