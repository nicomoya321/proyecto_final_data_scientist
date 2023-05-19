CREATE DATABASE datasc;
USE datasc;


DROP TABLE rent;

CREATE TABLE IF NOT EXISTS rent(
ID INT,
name VARCHAR(100),
hostId INT,
hostIdConfirm VARCHAR(50),
hostName VARCHAR(50),
neighbourhoodGroup VARCHAR(100),
neighbourhood VARCHAR(100),
lat INT,
lon INT,
country VARCHAR(100),
serviceFeed INT,
minimumNights INT,
numberOfReviews VARCHAR(100),
lastReview VARCHAR(100),
reviewsPerMonth INT,
reviewRateNumber VARCHAR(100),
calculatedHost VARCHAR(100),
availability DECIMAL(10,2),
houseRules VARCHAR (200),
license VARCHAR(100)
);

LOAD DATA local INFILE 'C:/Users/nicon/Downloads/Airbnb_Open_Data.csv' 
INTO TABLE rent
FIELDS TERMINATED BY ',' ENCLOSED BY '' ESCAPED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;


UPDATE `rent` SET name = 'Sin Dato' WHERE TRIM(name) = "" OR ISNULL(name);
UPDATE `rent` SET hostIdConfirm = 'Sin Dato' WHERE TRIM(hostIdConfirm) = "" OR ISNULL(hostIdConfirm);
UPDATE `rent` SET hostName= 'Sin Dato' WHERE TRIM(hostName) = "" OR ISNULL(hostName);
UPDATE `rent` SET neighbourhood= 'Sin Dato' WHERE TRIM(neighbourhood) = "" OR ISNULL(neighbourhood);
UPDATE `rent` SET neighbourhood= 'Sin Dato' WHERE TRIM(neighbourhood) = "" OR ISNULL(neighbourhood);
UPDATE `rent` SET license = 'Sin Dato' WHERE TRIM(license) = "" OR ISNULL(license);
UPDATE `rent` SET country= 'Sin Dato' WHERE TRIM(country) = "" OR ISNULL(country);


UPDATE `rent` SET hostIdConfirm= 'Sin Dato' WHERE TRIM(hostIdConfirm) = "" OR ISNULL (hostIdConfirm);

/*Normalizacion a Letra Capital*/
UPDATE rent SET  name = UC_Words(TRIM(name)),
                    neighbourhood = UC_Words(TRIM(neighbourhood));
                    
ALTER TABLE `rent` DROP `serviceFeed`;
ALTER TABLE `rent` DROP `minimumNights`;
ALTER TABLE `rent` DROP `lat`;
ALTER TABLE `rent` DROP `lon`;

SELECT
*
FROM
rent;

-- Detección de Outliers
SELECT v.*, o.promedio, o.maximo, o.minimo
from rent v
JOIN (SELECT ID, avg(calculatedHost) as promedio, avg(calculatedHost) + (3 * stddev(calculatedHost)) as maximo,
						avg(calculatedHost) - (3 * stddev(calculatedHost)) as minimo
	from rent
	GROUP BY ID) o
ON (v.ID = o.ID)
WHERE v.calculatedHost > o.maximo OR v.calculatedHost < minimo;
SELECT *
FROM rent
WHERE ID < 42890;
SELECT v.*, o.promedio, o.maximo, o.minimo
from rent v
JOIN (SELECT ID, avg(availability) as promedio, avg(availability) + (3 * stddev(availability)) as maximo,
						avg(availability) - (3 * stddev(availability)) as minimo
	from rent
	GROUP BY ID) o
;