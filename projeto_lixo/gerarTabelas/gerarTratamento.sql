CREATE OR REPLACE FUNCTION gerar_relatorio_aleatorio() RETURNS TEXT AS $$
DECLARE
    relatorios TEXT[] := ARRAY['Relatório: Tratamento realizado sem problemas',
                                'Relatório: Dificuldades com esse material',
                                'Relatório: Ocorreu acidente de trabalho',
                                'Relatório: Material não é reciclado',
                                'Relatório: Material tóxico'];
BEGIN
    RETURN relatorios[FLOOR(random() * array_length(relatorios, 1)) + 1];
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gerar_tratamentos_aleatorios() RETURNS void AS $$
DECLARE
    i INT := 1;
    id_empresa INT;
BEGIN
    WHILE i <= 10000 LOOP
        id_empresa := FLOOR(random() * 8000) + 1;

        INSERT INTO tb_tratamento (id, tempo_processo, volume_entrada, volume_saida, custo, relatorio, eficiencia, fk_empresa)
        VALUES (i, 
                FLOOR(random() * 480) + 1,  -- Entre 1 e 480 minutos (8 horas)
                random() * 1000,
                random() * 800,
                random() * 1000,
                gerar_relatorio_aleatorio(),
                FLOOR(random() * 101),
                id_empresa);

        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT gerar_tratamentos_aleatorios();

select * from tb_tratamento; 

delete from tb_tratamento;
ALTER SEQUENCE tb_tratamento_id_seq RESTART WITH 1;