/* Q1 - Who is the senior most employee? */

SELECT * FROM employee
ORDER BY levels desc
LIMIT 1

/* Q2 - Which country has the most invoices? */

SELECT COUNT(*) AS total_invoices, billing_country
FROM invoice
GROUP BY billing_country
ORDER BY total_invoices desc
LIMIT 1

/* Q3 - 3 top values of total invoice */

SELECT total FROM invoice
ORDER BY total desc
LIMIT 3

/* Q4 - Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice
totals */

SELECT SUM(total) AS invoice_total, billing_city
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total desc

/* Q5 - Write a query that returns the person who has spent the most money */

SELECT SUM(total) AS customer_total, customer_id
FROM invoice
GROUP BY customer_id
ORDER BY customer_total desc

SELECT customer_id, first_name, last_name FROM customer
WHERE customer_id = 5

/* alternate solution */

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) as total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total desc
LIMIT 1

/* Q6 - Write query to return the email, first name, last name, of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A */

SELECT distinct email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
SELECT track_id FROM track
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock')
ORDER BY email

/* Q7 - Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands */
SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs desc
LIMIT 10

/* Q8 - Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first */
SELECT name, milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS average_track_length
    FROM track)
ORDER BY milliseconds DESC
































