
--Oppgave 1

SELECT COUNT(*), filmcharacter
FROM filmcharacter
GROUP BY filmcharacter
HAVING COUNT(*) > 800
ORDER BY COUNT(*) DESC;

--Oppgave 2

SELECT fp.personid, p.lastname, f.title, c.country
FROM filmparticipation fp
NATURAL JOIN person p 
NATURAL JOIN filmcountry c
NATURAL JOIN filmcharacter fc
LEFT JOIN film f 
ON fp.filmid = f.filmid
WHERE filmcharacter = 'Ingrid'
AND firstname = 'Ingrid';

-- Oppgave 3

SELECT p.firstname, p.lastname, fc.filmcharacter, f.title
FROM filmparticipation fp
INNER JOIN filmcharacter fc
ON fp.partid = fc.partid
INNER JOIN person p
ON fp.personid = p.personid
LEFT JOIN film f
ON fp.filmid = f.filmid
WHERE p.personid = 3914169
AND fc.filmcharacter IS NOT NULL;

-- Oppgave 4

SELECT p.personid, p.firstname, p.lastname,count(*)
FROM filmparticipation fp
INNER JOIN filmcharacter fc
ON fp.partid = fc.partid
INNER JOIN person p
ON fp.personid = p.personid
WHERE filmcharacter = 'Ingrid'
GROUP BY p.personid, p.firstname,p.lastname
ORDER BY count(*) DESC
LIMIT 1;

-- Oppgave 5

SELECT p.personid, p.firstname, fc.filmcharacter, count(*)
FROM filmparticipation fp
NATURAL JOIN person p 
NATURAL JOIN filmcharacter fc
WHERE p.firstname = fc.filmcharacter
GROUP BY p.personid,p.firstname, fc.filmcharacter
ORDER BY count(*) DESC
;

-- Oppgave 6

SELECT f.title,fp.parttype,count(*)
FROM filmparticipation fp
NATURAL JOIN film f 
NATURAL JOIN filmitem fi
GROUP BY f.title, fp.parttype, fi.filmtype
HAVING f.title LIKE 'Lord of the Rings%'
AND fi.filmtype LIKE 'C'
;

-- Oppgave 7

SELECT f.filmid
FROM film f 
INNER JOIN filmgenre fg 
ON f.filmid = fg.filmid
WHERE fg.genre IN ('Comedy', 'Film-Noir')
GROUP BY f.filmid
HAVING COUNT(*) = 2;

-- Oppgave 8

SELECT f.filmid,f.title, count(genre)
FROM film f
LEFT JOIN filmgenre fg 
ON f.filmid = fg.filmid
WHERE f.title LIKE '%Antoine %' 
GROUP BY f.filmid,f.title;

-- Oppgave 9

SELECT DISTINCT fp.personid, p.firstname, p.lastname
FROM filmparticipation fp
INNER JOIN person p
ON fp.personid = p.personid
INNER JOIN filmcharacter fc
ON fp.partid = fc.partid 
WHERE fp.personid in (
	SELECT personid 
	FROM filmparticipation
	GROUP BY personid
	HAVING count(*) > 199)
AND fc.filmcharacter in
	(SELECT fc.filmcharacter
	FROM filmcharacter fc
	GROUP BY filmcharacter
	HAVING count(*) = 1);

