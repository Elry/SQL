DELIMITER $$
    CREATE OR REPLACE PROCEDURE new_category(old_id int, new_id int, new_categoryName varchar(25))
    BEGIN
        INSERT INTO categoria (categoria_id, nome) VALUES (new_id, new_categoryName);        
        UPDATE filme_categoria SET categoria_id = new_id WHERE categoria_id = old_id;
        DELETE FROM categoria WHERE categoria_id = old_id;        
    END $$
DELIMITER ;

CALL new_category(2, 20, 'Anime');

--#####----#####----#####----#####----#####----#####----#####----#####----#####----#####----#####----#####----#####----#####--

DELIMITER $$
    CREATE OR REPLACE PROCEDURE new_actor(old_id int, new_id int, new_name varchar(45), new_lastName varchar(45))
    BEGIN
        INSERT INTO ator (primeiro_nome, ultimo_nome, ator_id) VALUES (new_name, new_lastName, new_id);
        UPDATE filme_ator SET ator_id = new_id WHERE ator_id = old_id;
        DELETE FROM ator WHERE ator_id = old_id;
    END $$
DELIMITER ;

CALL new_actor(199, 202, 'Anna', 'Brinatti');

-- TRIGGER
ALTER TABLE filme ADD disponivel INT;

DELIMITER $$
CREATE OR REPLACE PROCEDURE update_avaiable(id_update INT)
    BEGIN
        UPDATE filme f SET disponivel = (SELECT COUNT(0) FROM inventario i WHERE i.filme_id = f.filme_id)
            -
            (SELECT COUNT(0) FROM aluguel a INNER JOIN inventario i ON a.inventario_id = i.inventario_id WHERE i.filme_id = f.filme_id AND data_de_devolucao IS NULL)
            WHERE f.filme_id = id_update;
    END$$

CREATE TRIGGER avaiable_rent_insert AFTER INSERT ON aluguel FOR EACH ROW 
    BEGIN
        CALL update_avaiable((SELECT filme_id FROM inventario i WHERE i.inventario_id = NEW.inventario_id));
    END $$
DELIMITER ;

INSERT INTO aluguel (`data_de_aluguel`, `inventario_id`, `cliente_id`, `data_de_devolucao`, `funcionario_id`) 
 VALUES ('2018-06-05', 2047,  155, NULL, 1)