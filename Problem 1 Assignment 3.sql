-- Load the schema
-- psql -U postgres -d postgres -f chinook_schema.sql

-- Problem 1
-- 1.  Retrieve all customers from USA
SELECT * FROM chinook."Customer" WHERE "Country" = 'USA';

-- 2. List all tracks from genre 'Rock'
SELECT
  T."Name" AS TrackName,
  G."Name" AS GenreName
FROM
  chinook."Track" AS T
  JOIN chinook."Genre" AS G ON T."GenreId" = G."GenreId"
WHERE
  G."Name" = 'Rock';

-- 3. Get all invoices generated in 2010.
SELECT * FROM chinook."Invoice" WHERE EXTRACT(YEAR FROM "InvoiceDate") = 2010;

-- 4. List all albums by the band 'AC/DC'
SELECT
  Al."Title" AS AlbumTitle,
  Ar."Name" AS ArtistName
FROM
  chinook."Album" AS Al
  JOIN chinook."Artist" AS Ar ON Al."ArtistId" = Ar."ArtistId"
WHERE
  Ar."Name" = 'AC/DC';

-- 5. Count the number of tracks in the album 'Let There Be Rock'.
SELECT
  COUNT(T."TrackId") AS NumberOfTracks
FROM
  chinook."Track" AS T
  JOIN chinook."Album" AS A ON T."AlbumId" = A."AlbumId"
WHERE
  A."Title" = 'Let There Be Rock';

-- 6. Find the total sales per customer.
SELECT
  C."FirstName",
  C."LastName",
  SUM(I."Total") AS TotalSales
FROM
  chinook."Customer" AS C
  JOIN chinook."Invoice" AS I ON C."CustomerId" = I."CustomerId"
GROUP BY
  C."CustomerId"
ORDER BY
  TotalSales DESC;

-- 7. List the top 5 most expensive tracks.
SELECT * FROM chinook."Track" ORDER BY "UnitPrice" DESC LIMIT 5;

-- 8. Find customers who have spent more than $100.
SELECT "CustomerId", SUM("Total") AS TotalSpent FROM chinook."Invoice" GROUP BY "CustomerId" HAVING SUM("Total") > 100;

-- 9. Get the average price of tracks for each genre.
SELECT
  G."Name" AS Genre,
  ROUND(AVG(T."UnitPrice"),2) AS AveragePrice
FROM
  chinook."Genre" AS G
  JOIN chinook."Track" AS T ON G."GenreId" = T."GenreId"
GROUP BY
  G."Name"
ORDER BY
  AveragePrice DESC;

-- 10. List the most popular genres based on the number of tracks sold.
SELECT
  G."Name" AS Genre,
  SUM(IL."Quantity") AS TracksSold
FROM
  chinook."Genre" AS G
  JOIN chinook."Track" AS T ON G."GenreId" = T."GenreId"
  JOIN chinook."InvoiceLine" AS IL ON T."TrackId" = IL."TrackId"
GROUP BY
  G."Name"
ORDER BY
  TracksSold DESC;