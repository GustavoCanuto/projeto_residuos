CREATE OR REPLACE FUNCTION gerar_cnpj_aleatorio() RETURNS TEXT AS $$
DECLARE
    cnpj_gerado TEXT;
    cnpj_parcial TEXT;
BEGIN
    WHILE true LOOP
        -- Gere os 12 primeiros dígitos do CNPJ
        cnpj_parcial := '';
        FOR i IN 1..12 LOOP
            cnpj_parcial := cnpj_parcial || to_char(FLOOR(random() * 10), 'FM0');
        END LOOP;

        cnpj_gerado := cnpj_parcial;

        -- Verifique se o CNPJ gerado é único
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
    
    -- Decidir aleatoriamente se vai substituir espaços por "_" ou "." ou deixar sem alterações
    random_number := FLOOR(random() * 3); -- Gera um número aleatório entre 0 e 2
    CASE random_number
        WHEN 0 THEN
            email := REPLACE(nome_empresa, ' ', '_') || dominio; -- Substitui espaços por "_"
        WHEN 1 THEN
            email := REPLACE(nome_empresa, ' ', '.') || dominio; -- Substitui espaços por "."
        ELSE
            email := REPLACE(nome_empresa, ' ', '') || dominio; -- Substitui espaços por ""
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

    -- Gere o primeiro caractere
    nome_completo := nome_completo || substr(consoantes, floor(random() * length(consoantes) + 1)::integer, 1);

    -- Gere a segunda letra
    nome_completo := nome_completo || substr(vogais, floor(random() * length(vogais) + 1)::integer, 1);

    -- Gere as duas últimas letras aleatórias
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
    -- Gere um DDD aleatório entre 10 e 43
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

-- usando:
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

select * from tb_empresa;

delete from tb_empresa;
ALTER SEQUENCE tb_empresa_id_seq RESTART WITH 1;