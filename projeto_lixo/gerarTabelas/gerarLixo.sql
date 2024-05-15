CREATE OR REPLACE FUNCTION gerar_lixo_aleatorio() RETURNS void AS $$
DECLARE
    i INT := 1;
    id_transporte INT;
    peso_lixo DECIMAL;
    volume_lixo DECIMAL;
    descricao_lixo VARCHAR(255);
    indice_reciclabilidade INT;
    custo_descarte DECIMAL;
    fk_material INT;
    fk_destino INT;
    fk_tratamento INT;
    fk_tipo_lixo INT;
    frases_lixo TEXT[] := '{"Lixo Recolhido", "Lixo trazido pelo governo", "Lixo trazido por coporativa", "Lixo"}';
BEGIN
    WHILE i <= 10000 LOOP
        id_transporte := FLOOR(random() * 9000) + 1;
        peso_lixo := random() * 100;
        volume_lixo := random() * 100;
        descricao_lixo := 'Descricao '||frases_lixo[FLOOR(random() * array_length(frases_lixo, 1)) + 1];
        indice_reciclabilidade := FLOOR(random() * 101);
        custo_descarte := random() * 1000;
        fk_material := FLOOR(random() * 8) + 1;
        fk_destino := FLOOR(random() * 8000) + 1;
        fk_tipo_lixo := FLOOR(random() * 10) + 1;

        IF indice_reciclabilidade < 50 THEN
            fk_tratamento := NULL;
        ELSE
            fk_tratamento := FLOOR(random() * 9000) + 1;
        END IF;

        INSERT INTO tb_lixo (id, peso, volume, descricao, indice_reciclabilidade, custo_descarte, fk_material, fk_destino, fk_tratamento, fk_tipo_lixo, fk_transporte)
        VALUES (i, peso_lixo, volume_lixo, descricao_lixo, indice_reciclabilidade, custo_descarte, fk_material, fk_destino, fk_tratamento, fk_tipo_lixo, id_transporte);

        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

DO $$
BEGIN
    PERFORM gerar_lixo_aleatorio();
END $$;

select * from tb_lixo;

delete from tb_lixo;
ALTER SEQUENCE tb_lixo_id_seq RESTART WITH 1;