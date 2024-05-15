--inserir dominio

   
 INSERT INTO tb_tipo_material (id, nome)
VALUES
    (1, 'sintetico'),
    (2, 'organico');
    
   INSERT INTO tb_tipo_destino (id, nome, descricao)
VALUES
    (1, 'Aterro', 'Local destinado ao descarte de resíduos sólidos.'),
    (2, 'Centro de Reciclagem', 'Local destinado ao processamento e separação de materiais recicláveis.'),
    (3, 'Incineradora', 'Local onde os resíduos são queimados para redução de volume e eliminação de patógenos.'),
    (4, 'Compostagem', 'Processo de decomposição de matéria orgânica para produção de adubo.'),
    (5, 'Descarte em Rios ou Oceanos', 'Infelizmente ainda uma prática comum, mas extremamente prejudicial ao meio ambiente.'),
    (6, 'Reutilização', 'Processo de dar nova vida a objetos ou materiais, evitando o descarte.'),
    (7, 'Outro', 'Tipo de destino não especificado nas opções anteriores.');
    
   INSERT INTO tb_tipo_lixo (id, nome)
VALUES
    (1, 'residencial'),
    (2, 'comercial'),
    (3, 'hospitalar'),
    (4, 'industrial'),
    (5, 'agrícola'),
    (6, 'eletrônico'),
    (7, 'radioativo'),
    (8, 'construção civil'),
    (9, 'verde'),
    (10, 'outro');
    
INSERT INTO tb_material (id, nome, tempo_decomposicao, fk_tipo_material)
VALUES
    (1, 'Plástico', '1000 anos', 1),
    (2, 'Vidro', 'Não se decompõe', 1),
    (3, 'Papel', '2-6 semanas', 1),
    (4, 'Metal', 'Não se decompõe', 1),
    (5, 'Alumínio', '200-500 anos', 1),
    (6, 'Orgânico', '2-6 semanas', 2),
    (7, 'Madeira', '10-12 anos', 2),
    (8, 'Alimentos', '2-6 semanas', 2);
    
--inserir Empresa
   
CREATE OR REPLACE FUNCTION gerar_cnpj_aleatorio() RETURNS TEXT AS $$
DECLARE
    cnpj_gerado TEXT;
    cnpj_parcial TEXT;
BEGIN
    WHILE true LOOP
       
        cnpj_parcial := '';
        FOR i IN 1..12 LOOP
            cnpj_parcial := cnpj_parcial || to_char(FLOOR(random() * 10), 'FM0');
        END LOOP;

        cnpj_gerado := cnpj_parcial;

        
        IF NOT EXISTS (SELECT 1 FROM tb_empresa WHERE cnpj = cnpj_gerado) THEN
            RETURN cnpj_gerado;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gerar_email_aleatorio(nome_empresa TEXT) RETURNS TEXT AS $$
DECLARE
    dominios TEXT[] := '{"@gmail.com", "@hotmail.com", "@hotmail.com.br", "@outlook.com", "@empresa.com"}';
    dominio TEXT;
    email TEXT;
    random_number INTEGER;
BEGIN
    dominio := dominios[FLOOR(random() * array_length(dominios, 1)) + 1];
    
   
    random_number := FLOOR(random() * 3); 
    CASE random_number
        WHEN 0 THEN
            email := REPLACE(nome_empresa, ' ', '_') || dominio; 
        WHEN 1 THEN
            email := REPLACE(nome_empresa, ' ', '.') || dominio; 
        ELSE
            email := REPLACE(nome_empresa, ' ', '') || dominio; 
        END CASE;

    RETURN email;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gerar_descricao_aleatoria() RETURNS TEXT AS $$
DECLARE
    relatorios TEXT[] := ARRAY['Descricao: 	Empresa de reciclagem ',
                                'Descricao: Empresa de descarte',
                                'Descricao: Empresa desde 1997',
                                'Descricao: Empresa de vendas',
                                'Descricao: Empresa especialista em eletronicos'];
BEGIN
    RETURN relatorios[FLOOR(random() * array_length(relatorios, 1)) + 1];
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gerar_nome_aleatorio() RETURNS TEXT AS $$
DECLARE
    consoantes TEXT := 'bcdfghjklmnpqrstvwxyz';
    vogais TEXT := 'aeiou';
    nome_completo TEXT;
BEGIN
    nome_completo := '';


    nome_completo := nome_completo || substr(consoantes, floor(random() * length(consoantes) + 1)::integer, 1);


    nome_completo := nome_completo || substr(vogais, floor(random() * length(vogais) + 1)::integer, 1);


    FOR i IN 1..2 LOOP
        nome_completo := nome_completo || chr(97 + floor(random() * 26 + 1)::integer);
    END LOOP;

    RETURN nome_completo;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gerar_numero_telefone_aleatorio() RETURNS TEXT AS $$
DECLARE
    ddd TEXT;
    numero TEXT;
BEGIN

    ddd := '(' || to_char(10 + FLOOR(random() * 34), 'FM00') || ')';
    
    numero := '';
    FOR i IN 1..4 LOOP
        numero := numero || to_char(FLOOR(random() * 10), 'FM0');
    END LOOP;
    
    numero := numero || '-' || to_char(FLOOR(random() * 10), 'FM0');
    FOR i IN 1..3 LOOP
        numero := numero || to_char(FLOOR(random() * 10), 'FM0');
    END LOOP;

    RETURN ddd || ' ' || numero;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    nome_empresa TEXT;
BEGIN
    FOR i IN 1..10000 LOOP
        nome_empresa := 'Empresa ' || gerar_nome_aleatorio();
        INSERT INTO tb_empresa (id, nome, cnpj, telefone, email, descricao)
        VALUES (i, nome_empresa, gerar_cnpj_aleatorio(), gerar_numero_telefone_aleatorio(), gerar_email_aleatorio(nome_empresa), gerar_descricao_aleatoria());
    END LOOP;
END $$;

--inserir tratamento

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

--inserir destino
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

  
        IF random() < 0.5 THEN
    
            contato_destino := gerar_numero_telefone_aleatorio();
        ELSE
        
            contato_destino := gerar_email_aleatorio(nome_destino);
        END IF;

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

--inserir transporte 

CREATE OR REPLACE FUNCTION gerar_placa_aleatoria() RETURNS TEXT AS $$
DECLARE
    letras TEXT := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    numeros TEXT := '0123456789';
    placa_gerada TEXT; 
BEGIN
    LOOP
        placa_gerada := '';
        FOR i IN 1..3 LOOP
            placa_gerada := placa_gerada || substr(letras, floor(random() * length(letras) + 1)::integer, 1);
        END LOOP;
        placa_gerada := placa_gerada || '-';
        FOR i IN 1..4 LOOP
            placa_gerada := placa_gerada || substr(numeros, floor(random() * length(numeros) + 1)::integer, 1);
        END LOOP;

       
        EXIT WHEN NOT EXISTS (SELECT 1 FROM tb_transporte WHERE tb_transporte.placa = placa_gerada);
    END LOOP;

    RETURN placa_gerada;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gerar_chassi_aleatorio() RETURNS TEXT AS $$
DECLARE
    caracteres TEXT := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    chassi TEXT;
BEGIN
    LOOP
        chassi := '';
        FOR i IN 1..17 LOOP
            chassi := chassi || substr(caracteres, floor(random() * length(caracteres) + 1)::integer, 1);
        END LOOP;

     
        EXIT WHEN NOT EXISTS (SELECT 1 FROM tb_transporte WHERE numero_chassi = chassi);
    END LOOP;

    RETURN chassi;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION gerar_transporte_aleatorio() RETURNS void AS $$
DECLARE
    i INT := 1;
    id_empresa INT;
    placa_veiculo TEXT;
    capacidade_veiculo DECIMAL;
    ano_fabricacao_veiculo INT;
    numero_chassi_veiculo TEXT;
    fabricante_veiculo VARCHAR(50);
    fabricantes TEXT[] := '{"Volkswagen", "Chevrolet", "Ford", "Fiat", "Toyota", "Honda", "Hyundai", "Mercedes-Benz", "BMW", "Audi"}';
BEGIN
    WHILE i <= 10000 LOOP
        id_empresa := FLOOR(random() * 8000) + 1;
        placa_veiculo := gerar_placa_aleatoria();
        capacidade_veiculo := random() * 10000;
        ano_fabricacao_veiculo := FLOOR(random() * (2022 - 1900 + 1)) + 1900;
        numero_chassi_veiculo := gerar_chassi_aleatorio();
        fabricante_veiculo := fabricantes[FLOOR(random() * array_length(fabricantes, 1)) + 1];

        INSERT INTO tb_transporte (id, placa, capacidade, ano_fabricacao, numero_chassi, fabricante, fk_empresa)
        VALUES (i, placa_veiculo, capacidade_veiculo, ano_fabricacao_veiculo, numero_chassi_veiculo, fabricante_veiculo, id_empresa);

        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

DO $$
BEGIN
    PERFORM gerar_transporte_aleatorio();
END $$;

select * from tb_transporte;

--inserir lixo

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


