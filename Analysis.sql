SELECT * FROM datacleaned;

-- Jumlah traveler setiap negara
SELECT `Traveler nationality`, COUNT(DISTINCT `Trip ID`) AS `Total Traveler` FROM datacleaned GROUP BY `Traveler nationality` ORDER BY `Total Traveler` DESC;


-- Destinasi Paling diminati
SELECT Destination, COUNT(DISTINCT `Trip ID`) AS `Total Visitor` FROM datacleaned GROUP BY Destination ORDER BY `Total Visitor` DESC;