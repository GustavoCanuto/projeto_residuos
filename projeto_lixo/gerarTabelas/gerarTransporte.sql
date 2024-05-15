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

        -- Verificar se a placa já existe na tabela
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

        -- Verificar se o chassi já existe na tabela
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

delete from tb_transporte;
ALTER SEQUENCE tb_transporte_id_seq RESTART WITH 1;
