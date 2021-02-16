SELECT * FROM result
WHERE StudentID = (SELECT StudentID FROM students WHERE Student LIKE '%Pekhockij%');
