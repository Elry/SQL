1:
SELECT fu.primeiro_nome, count(a.funcionario_id) AS quantidade, sum(p.valor) AS valor FROM funcionario fu
    INNER JOIN aluguel a ON fu.funcionario_id = a.funcionario_id
    INNER JOIN pagamento p ON a.aluguel_id = p.aluguel_id    
    WHERE a.data_de_aluguel BETWEEN '2005-05-01' AND '2005-05-31'
    GROUP BY fu.funcionario_id
    
2:
SELECT filme_id, titulo FROM filme WHERE titulo LIKE '%DINOSAUR%'

3:
SELECT c.primeiro_nome, c.ultimo_nome, c.email FROM cliente c
    INNER JOIN pagamento p ON c.cliente_id = P.cliente_id
    WHERE p.valor = 0

4:
SELECT c.primeiro_nome, c.ultimo_nome, c.email FROM cliente c
UNION
SELECT f.primeiro_nome, f.ultimo_nome, f.email FROM funcionario f

5: 
SELECT c.nome, sum(p.valor) AS montante FROM categoria c
    INNER JOIN filme_categoria fc ON c.categoria_id = fc.categoria_id
    INNER JOIN filme f ON fc.filme_id = f.filme_id 
    INNER JOIN inventario i ON f.filme_id = i.filme_id 
    INNER JOIN aluguel a ON i.inventario_id = a.inventario_id
    INNER JOIN pagamento p ON a.aluguel_id = p.aluguel_id
    GROUP BY c.nome 
    ORDER BY montante DESC
