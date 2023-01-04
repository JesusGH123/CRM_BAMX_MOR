-- "BAMX" database v3.3.1
DROP DATABASE IF EXISTS BAMX;
CREATE DATABASE BAMX;
USE BAMX;

DROP TABLE IF EXISTS Donor;
CREATE TABLE Donor(
	donor_id INT NOT NULL AUTO_INCREMENT,
	donor_name CHAR(50),
    donor_city CHAR(50),
    donor_colony CHAR(50),
    donor_organization CHAR(100),
    donor_website1 CHAR(50),
    donor_website2 CHAR(50),
    donor_cfdi BLOB,

    PRIMARY KEY(donor_id)
);

DROP TABLE IF EXISTS Product;
CREATE TABLE Product(
	product_id INT NOT NULL AUTO_INCREMENT,
	product_name CHAR(25) NOT NULL,

    PRIMARY KEY(product_id)
);

DROP TABLE IF EXISTS DonorProduct;
CREATE TABLE DonorProduct(
	donation_id INT NOT NULL AUTO_INCREMENT,
	donor_id INT NOT NULL,
    product_id INT NOT NULL,
    donation_date TIMESTAMP,
    donation_observation CHAR(200),
    product_quantity FLOAT,
    product_unit CHAR(25),

    PRIMARY KEY(donation_id),
    FOREIGN KEY(donor_id) REFERENCES Donor(donor_id),
    FOREIGN KEY(product_id) REFERENCES Product(product_id)
);

DROP TABLE IF EXISTS DonorMail;
CREATE TABLE DonorMail(
	mail_id INT NOT NULL AUTO_INCREMENT,
	donor_id INT NOT NULL,
    donor_mail CHAR(100),

    PRIMARY KEY(mail_id),
    FOREIGN KEY(donor_id) REFERENCES Donor(donor_id)
);

DROP TABLE IF EXISTS DonorPhone;
CREATE TABLE DonorPhone(
	phone_id INT NOT NULL AUTO_INCREMENT,
	donor_id INT NOT NULL,
    donor_phone CHAR(15),

    PRIMARY KEY(phone_id),
    FOREIGN KEY(donor_id) REFERENCES Donor(donor_id)
);

DROP TABLE IF EXISTS DonorType;
CREATE TABLE DonorType(
	id INT NOT NULL AUTO_INCREMENT,
	donor_id INT NOT NULL,
    donor_type INT NOT NULL,

    PRIMARY KEY(id),
    FOREIGN KEY(donor_type) REFERENCES Type(type_id)
);

DROP TABLE IF EXISTS Unit;
CREATE TABLE Unit(
	unit_name CHAR(25) NOT NULL,

    PRIMARY KEY(unit_name)
);

DROP TABLE IF EXISTS Type;
CREATE TABLE Type(
	type_id INT NOT NULL AUTO_INCREMENT,
    type_name CHAR(25),

    PRIMARY KEY(type_id)
);

DROP TABLE IF EXISTS Category;
CREATE TABLE Category(
	cat_id INT NOT NULL AUTO_INCREMENT,
    cat_name CHAR(25),

    PRIMARY KEY(cat_id)
);

DROP TABLE IF EXISTS DonorCategory;
CREATE TABLE DonorCategory(
    donorID INT NOT NULL,
    categoryID INT NOT NULL,

    FOREIGN KEY (donorID) REFERENCES Donor(donor_id),
    FOREIGN KEY (categoryID) REFERENCES Category(cat_id),
    PRIMARY KEY (donorID, categoryID)
);

-- CRUD Procedures

-- Create a donor
DROP PROCEDURE CreateDonor;
DELIMITER //
CREATE PROCEDURE CreateDonor (
	donor_name CHAR(50),
    donor_city CHAR(50),
    donor_colony CHAR(50),
    donor_organization CHAR(100),
    donor_type CHAR(100),
    donor_website1 CHAR(50),
    donor_website2 CHAR(50),
    donor_category CHAR(15),
    donor_cfdi BLOB
)
BEGIN
	INSERT INTO Donor VALUES(null, donor_name, donor_city, donor_colony, donor_organization, donor_type, donor_website1, donor_website2, donor_category, donor_cfdi);
END //
DELIMITER ;

-- Add data contact to a donor
DROP PROCEDURE AddPhoneToDonor;
DELIMITER //
CREATE PROCEDURE AddPhoneToDonor(
	donor_id INT,
	donor_phone CHAR(15)
)
BEGIN
	INSERT INTO DonorPhone VALUES(null, donor_id, donor_phone);
END //
DELIMITER ;

DROP PROCEDURE AddMailToDonor;
DELIMITER //
CREATE PROCEDURE AddMailToDonor(
	donor_id INT,
    donor_mail CHAR(100)
)
BEGIN
	INSERT INTO DonorMail VALUES(null, donor_id, donor_mail);
END //
DELIMITER ;

-- Add products for donators
DROP PROCEDURE AddProductForDonation;
DELIMITER //
CREATE PROCEDURE AddProductForDonation(
	new_product_name CHAR(25)
)
BEGIN

	IF NOT EXISTS (SELECT product_name FROM Product WHERE product_name = LOWER(new_product_name)) THEN
		INSERT INTO Product VALUES (null, LOWER(new_product_name));
	END IF;
END //
DELIMITER ;

-- Add a new unit
DROP PROCEDURE AddDonationUnit;
DELIMITER //
CREATE PROCEDURE AddDonationUnit(
	unit_name CHAR(25)
)
BEGIN
	IF NOT EXISTS (SELECT Unit.unit_name FROM Unit WHERE Unit.unit_name = unit_name) THEN
		INSERT INTO Unit VALUES (LOWER(unit_name));
	END IF;
END //
DELIMITER ;

-- Add donation/products for a donor
DROP PROCEDURE AddDonationToDonor;
DELIMITER //
CREATE PROCEDURE AddDonationToDonor(
	donor_id INT,
    product_name CHAR(25),
    donation_date TIMESTAMP,
    donation_observation CHAR(200),
    product_quantity FLOAT,
    product_unit CHAR(25)
)
BEGIN
	INSERT INTO DonorProduct VALUES(null, donor_id, product_name, donation_date, donation_observation, product_quantity, product_unit);
END //
DELIMITER ;

-- Delete donor from all tables
DROP PROCEDURE DeleteDonor;
DELIMITER //
CREATE PROCEDURE DeleteDonor(
	donor_id INT
)
BEGIN
	IF EXISTS (SELECT * FROM DonorPhone WHERE DonorPhone.donor_id = donor_id) THEN
		DELETE FROM DonorPhone WHERE DonorPhone.donor_id = donor_id;
	END IF;
	IF EXISTS (SELECT * FROM DonorMail WHERE DonorMail.donor_id = donor_id) THEN
		DELETE FROM DonorMail WHERE DonorMail.donor_id = donor_id;
	END IF;
    IF EXISTS (SELECT * FROM DonorProduct WHERE DonorProduct.donor_id = donor_id) THEN
		DELETE FROM DonorProduct WHERE DonorProduct.donor_id = donor_id;
    END IF;
	DELETE FROM Donor WHERE Donor.donor_id = donor_id;
END //
DELIMITER ;

SELECT * FROM Donor;
SELECT * FROM DonorPhone;
SELECT * FROM DonorMail;

SELECT * FROM Category;
SELECT * FROM DonorCategory;

INSERT INTO bamx.donor (donor_id, donor_name, donor_city, donor_colony, donor_organization, donor_website1, donor_website2, donor_cfdi) VALUES (1, 'Israel Sanchez', 'Temixco', 'Centro', 'Walmart', 'www.walmart.mx', 'www.soriana.cdmx.gob.mx', null);

INSERT INTO bamx.category (cat_id, cat_name) VALUES (0, 'Casual');
INSERT INTO bamx.category (cat_id, cat_name) VALUES (0, 'Por temporada');
INSERT INTO bamx.category (cat_id, cat_name) VALUES (0, 'Recurrente');

