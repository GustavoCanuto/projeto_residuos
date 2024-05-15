CREATE OR REPLACE FUNCTION gerar_destinos_aleatorios() RETURNS void AS $$
DECLARE
    i INT := 1;
    id_empresa INT;
    id_tipo_destino INT;
    nome_destino TEXT;
    contato_destino TEXT;
    area_territorial_destino DECIMAL;
    capacidade_destino DECIMAL;
    horario_funcionamento_destino TEXT;
BEGIN
    WHILE i <= 10000 LOOP
        id_empresa := FLOOR(random() * 8000) + 1;
        id_tipo_destino := FLOOR(random() * 7) + 1;
       nome_destino := 'Destino ' || gerar_nome_aleatorio();

        -- Gera um contato aleatório (telefone ou email)
        IF random() < 0.5 THEN
            -- Gera um telefone aleatório
            contato_destino := gerar_numero_telefone_aleatorio();
        ELSE
            -- Gera um email aleatório
            contato_destino := gerar_email_aleatorio(nome_destino);
        END IF;

        -- Gera valores aleatórios para a área territorial, capacidade e horário de funcionamento
        area_territorial_destino := random() * 1000;
        capacidade_destino := random() * 1000;
       horario_funcionamento_destino :=  to_char(FLOOR(random() * 3) + 7, 'FM00') || 'h às ' || to_char(FLOOR(random() * 5) + 16, 'FM00') || 'h';

        
        INSERT INTO tb_destino (id, nome, area_territorial, capacidade, contato, horario_funcionamento, fk_empresa, fk_tipo_destino)
        VALUES (i, 
                nome_destino,
                area_territorial_destino,
                capacidade_destino,
                contato_destino,
                horario_funcionamento_destino,
                id_empresa,
                id_tipo_destino);

        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT gerar_destinos_aleatorios();

select * from tb_destino;

delete from tb_destino;
ALTER SEQUENCE tb_destino_id_seq RESTART WITH 1;