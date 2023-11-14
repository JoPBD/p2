-- -- Exercicio 4
CREATE TABLE log(
	cod_log SERIAL PRIMARY KEY,
	nome_youtuber varchar(200),
	categoria VARCHAR(200),
	inicio INT	
);

-- -- Exercicio 3
-- ALTER TABLE tb_top_youtubers ADD COLUMN ativo INTEGER DEFAULT 1 CHECK (ativo IN (0, 1));
-- --testando
-- INSERT INTO tb_top_youtubers(ativo) VALUES (2)

-- 2 Trigger
-- Escreva um trigger com as seguintes características
-- - executa antes de operações insert e de operações update
-- - nível row
-- - não admite que quaisquer campos numéricos possuam valor negativo
-- Mensagem de commit: feat(tg): valores negativos jamais


CREATE OR REPLACE TRIGGER tg_validador_de_numero_negativo
BEFORE INSERT OR UPDATE ON tb_top_youtubers
FOR EACH ROW 
EXECUTE PROCEDURE fn_sem_valor_negativo()

CREATE OR REPLACE FUNCTION fn_sem_valor_negativo()
RETURNS TRIGGER 
LANGUAGE plpgsql AS $$
BEGIN	
	IF NEW.rank > 0 AND NEW.video_count > 0 AND NEW.video_views > 0 AND started > 0 THEN
		RETURN NEW;
	ELSE
		RETURN NULL;
	END IF;
END;
$$

-- CREATE TABLE tb_top_youtubers(
-- cod_top_youtubers SERIAL PRIMARY KEY,
-- rank INT,
-- youtuber VARCHAR(200),
-- subscribers INT,
-- video_views NUMERIC(10,2),
-- video_count INT,
-- category VARCHAR(200),
-- started INT
-- );