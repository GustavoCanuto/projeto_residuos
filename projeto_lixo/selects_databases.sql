--exibir database
SELECT datname FROM pg_database;

--exibir database e exluir templates
SELECT datname
FROM pg_database
WHERE datistemplate = false;

--ver nome da tabelas
SELECT  table_name
FROM information_schema.tables
WHERE table_schema = 'public'

--atributos tabela 
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'tb_cliente';
  
 --ver valores tabela
 select * from tb_veiculo;

--subselect mostrar atributos todas tabelas
 SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_name IN (
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'public'
)
order by table_name ;

--Pl para mostrar atributos todas tabelas 
DO $$
DECLARE
    rec RECORD;
   linha RECORD;
  new_line TEXT := CHR(10);
    tbl_name TEXT;
    sql_command TEXT;
BEGIN
    FOR rec IN 
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_type = 'BASE TABLE'
    LOOP
        tbl_name := rec.table_name;
        
        sql_command := 'SELECT column_name, data_type FROM information_schema.columns ' ||
                       'WHERE table_schema = ''public'' AND table_name = ' || quote_literal(tbl_name);
        
        RAISE NOTICE 'Tabela: %', tbl_name;
        FOR linha IN EXECUTE sql_command LOOP
           RAISE NOTICE '    Atributo: % - Tipo: %', linha.column_name, linha.data_type;
        END LOOP;
         RAISE NOTICE  ' %',new_line;
    END LOOP;
END $$;


--PL select para valores todas tabelas
DO $$
DECLARE
    rec RECORD;
    tbl_name TEXT;
    sql_command TEXT;
    result RECORD;
    count_records INT;
    new_line TEXT := CHR(10);
   	line_num INT := 0;
BEGIN
    FOR rec IN 
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_type = 'BASE TABLE'
    LOOP
        tbl_name := rec.table_name;
        
        EXECUTE format('SELECT count(*) FROM %I', tbl_name) INTO count_records;
        
        IF count_records = 0 THEN
            RAISE NOTICE  'Tabela %',tbl_name || CHR(10) ||' não tem dados.' || CHR(10);
        ELSE
            sql_command := 'SELECT * FROM ' || quote_ident(tbl_name) || ';';
            RAISE NOTICE 'Tabela: % - Executando Comando: %', tbl_name, sql_command;
            
            FOR result IN EXECUTE sql_command loop
	             line_num := line_num + 1;
                RAISE NOTICE '    Linha %: %',line_num, row_to_json(result);
            END LOOP;
          RAISE NOTICE  '*** fim busca *** %',new_line;
        END IF;
    END LOOP;
END $$;
