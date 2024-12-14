-- task1
SELECT DISTINCT a.district FROM address a 
WHERE a.district LIKE 'K%a' AND a.district NOT LIKE '% %'
ORDER BY district ASC;

-- task2
SELECT * FROM payment p 
WHERE CAST(p.payment_date AS DATE) BETWEEN '2005-06-15' AND '2005-06-18'
AND p.amount > 10.00
ORDER BY p.payment_date;

-- task3
SELECT * FROM rental r 
ORDER BY r.rental_date DESC 
LIMIT 5;

-- task4
SELECT 
REPLACE(LOWER(c.first_name),'ll','pp') first_name , 
LOWER(c.last_name) last_name, 
c.email, 
c.active 
FROM customer c 
WHERE c.active = 1
AND (c.first_name LIKE 'KELLY' OR c.first_name LIKE 'WILLIE')
;

-- task5
SELECT c.email,
CONCAT(UPPER(SUBSTRING(SUBSTRING_INDEX(c.email,'@',1),1,1)),
LOWER(SUBSTRING(SUBSTRING_INDEX(c.email,'@',1),2))
) email_name,
CONCAT(UPPER(SUBSTRING(SUBSTRING_INDEX(c.email,'@',-1),1,1)),
LOWER(SUBSTRING(SUBSTRING_INDEX(c.email,'@',-1),2))
) email_domain
FROM customer c ;