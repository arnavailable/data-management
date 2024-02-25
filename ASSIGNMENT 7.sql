-- Define Warehoue --
USE WAREHOUSE my_wh;

-- Create table RENTAL_FACT --
CREATE OR REPLACE TABLE "MYDB"."SAKILA_ANALYTICS".RENTAL_FACT (
CUSTOMER_KEY NUMBER(38,0) NOT NULL,
FILM_KEY NUMBER(38,0) NOT NULL,
DATE_KEY number(9) NOT NULL,
TIMEOFDAY_KEY NUMBER(38,0) NOT NULL,
STAFF_KEY NUMBER(38,0) NOT NULL,
STORE_LOCATION_KEY NUMBER(38,0) NOT NULL,
RENTAL_ID NUMBER(38,0) NOT NULL,
RENTAL_QUANTITY NUMBER(38,0) NOT NULL,
RENTAL_TOTAL_AMOUNT NUMBER(4,2) NOT NULL
);

-- Insert data in table RENTAL_FACT --
INSERT INTO mydb.sakila_analytics.rental_fact (
CUSTOMER_KEY,
FILM_KEY,
DATE_KEY,
TIMEOFDAY_KEY,
STAFF_KEY,
STORE_LOCATION_KEY,
RENTAL_ID,
RENTAL_QUANTITY,
RENTAL_TOTAL_AMOUNT
)
SELECT
CD.customer_key AS CUSTOMER_KEY,
F.film_key AS FILM_KEY,
D.date_key AS DATE_KEY,
T.timeofday_key AS TIMEOFDAY_KEY,
S.staff_key AS STAFF_KEY,
SL.store_location_key AS STORE_LOCATION_KEY,
R.rental_id AS RENTAL_ID,
1 AS RENTAL_QUANTITY,
P.amount AS RENTAL_TOTAL_AMOUNT
FROM mydb.sakila.customer C
JOIN mydb.sakila.rental R
ON C.customer_id = R.customer_id
JOIN mydb.sakila.inventory I
ON R.inventory_id = I.inventory_id
JOIN mydb.sakila.film FM
ON I.film_id = FM.film_id
JOIN mydb.sakila.staff SF
ON SF.staff_id = R.staff_id
JOIN mydb.sakila.payment P
ON P.rental_id = R.rental_id
JOIN mydb.sakila_analytics.customer_dim CD
ON C.customer_id = CD.customer_id
JOIN mydb.sakila_analytics.film_dim F
ON F.film_id = FM.film_id
JOIN mydb.sakila_analytics.date_dim D
ON D.date = DATE(R.rental_date)
JOIN mydb.sakila_analytics.timeofday_dim T
ON T.hour_24 = HOUR(R.rental_date)
JOIN mydb.sakila_analytics.staff_dim S
ON S.staff_id = SF.staff_id
JOIN mydb.sakila_analytics.store_location_dim SL
ON SF.store_id = SL.store_id;

-- Show all tables --
SHOW TABLES;