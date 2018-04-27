-- Text functions to convert a upper case string to lower, and then convert the first letter to upper case.
SELECT CONCAT(UPPER(LEFT(a.primeiro_nome, 1)), RIGHT(LOWER(a.primeiro_nome), LENGTH(a.primeiro_nome)-1))  FROM ator a
