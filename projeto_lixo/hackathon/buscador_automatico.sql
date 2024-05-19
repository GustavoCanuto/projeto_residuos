-- Alterar um dado na tabela
UPDATE tb_destino
SET nome= 'test55'
WHERE id = 3534;

-- Verificar o dado atualizado
SELECT *
FROM tb_destino
WHERE id = 3534;

--ver nome da tabelas
SELECT  table_name
FROM information_schema.tables
WHERE table_schema = 'public'

--atributos tabela 
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'tb_transporte';
  
 
 --automatizando para buscar valor magna 
DO $$
DECLARE
    row_table RECORD;
    row_column RECORD;
    query TEXT;
    tbl_name TEXT;
    col_name TEXT;
    id_value INTEGER;
BEGIN
    -- Para cada tabela
    FOR row_table IN
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'public'
    LOOP
        -- Para cada coluna da tabela
        FOR row_column IN
            SELECT column_name, data_type
            FROM information_schema.columns
            WHERE table_schema = 'public'
              AND table_name = row_table.table_name
        LOOP
            -- Verificar se a coluna é de texto ou não
            IF row_column.data_type = 'character varying' OR row_column.data_type = 'text' THEN
                -- Construir e executar a consulta para verificar se a palavra 'test55' está presente
                query := 'SELECT ' || row_column.column_name || ' AS value, id FROM ' || row_table.table_name || ' WHERE ' || row_column.column_name || ' SIMILAR TO ''%test55%''';
                
                -- Executar a consulta
                FOR tbl_name, id_value IN EXECUTE query LOOP
                    -- Retornar os resultados
                    RAISE NOTICE 'Tabela: %, id: %, Valor: %', row_table.table_name, id_value, tbl_name;
                END LOOP;
            END IF;
        END LOOP;
    END LOOP;
END $$;