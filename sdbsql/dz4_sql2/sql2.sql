-- task1
SELECT 
CONCAT(sf.last_name , ' ', sf.first_name ) staff_name,  
c.city store_sity, 
COUNT(cm.customer_id) customer_number
FROM store s 
LEFT JOIN staff sf ON s.manager_staff_id = sf.staff_id 
LEFT JOIN address a ON s.address_id = a.address_id 
LEFT JOIN city c ON a.city_id = c.city_id 
LEFT JOIN customer cm ON s.store_id = cm.store_id 
GROUP BY s.store_id 
HAVING COUNT(cm.customer_id) >300
;

-- task2
SELECT COUNT(*) 
FROM film f 
WHERE f.`length` > (SELECT SUM(f2.`length`)/COUNT(f2.`length`) FROM film f2 )
;

-- task3
SELECT MONTH(p.payment_date) month, COUNT(r.rental_id ) rents
FROM payment p 
CROSS JOIN rental r ON p.rental_id = r.rental_id
GROUP BY MONTH(p.payment_date)
ORDER BY SUM(p.amount) DESC
LIMIT 1
;

-- task4
SELECT 
CONCAT(sf.last_name , ' ', sf.first_name ) staff_name, 
COUNT(p.payment_id) sales,
CASE 
	WHEN COUNT(p.payment_id) > 8000 THEN 'Да'
	ELSE 'Нет'
END AS премия
FROM staff sf 
LEFT JOIN payment p ON sf.staff_id = p.staff_id 
GROUP BY sf.staff_id 
;

-- task5
SELECT f.title название, COUNT(r.rental_id) количество_аренд
FROM film f 
CROSS JOIN inventory i ON f.film_id = i.inventory_id 
LEFT JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY f.film_id 
HAVING COUNT(r.rental_id) = 0
ORDER BY COUNT(r.rental_id) 
;

