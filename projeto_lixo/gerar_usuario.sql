CREATE USER trainee WITH PASSWORD 'trainee';

GRANT ALL PRIVILEGES ON DATABASE lixo TO trainee;

GRANT ALL PRIVILEGES ON SCHEMA public TO trainee;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO trainee;

DO $$ 
DECLARE 
    contador INT := 1;
    usuario TEXT;
BEGIN
    WHILE contador <= 15 LOOP
        BEGIN
            usuario := 'user' || contador;
            EXECUTE format('CREATE USER %I WITH PASSWORD %L CONNECTION LIMIT 10', usuario, usuario);
           
            EXECUTE format('GRANT ALL PRIVILEGES ON DATABASE lixo TO %I', usuario);
            EXECUTE format('GRANT ALL PRIVILEGES ON SCHEMA public TO %I', usuario);
            EXECUTE format('GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO %I', usuario);
            EXECUTE format('GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO %I', usuario);
            EXECUTE format('GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO %I', usuario);
           
           -- Definindo statement_timeout e work_mem para o usuário criado
            --EXECUTE format('ALTER ROLE %I SET statement_timeout = ''2min''', usuario);
            --EXECUTE format('ALTER ROLE %I SET work_mem = ''4MB''', usuario);
           
            RAISE NOTICE 'Usuário % criado com sucesso', usuario;
        EXCEPTION WHEN duplicate_object THEN
            RAISE NOTICE 'Usuário % já existe', usuario;
        END;
        contador := contador + 1;
    END LOOP;
END $$;

--ver todos usuarios
SELECT usename
FROM pg_catalog.pg_user;

--verificar limitacoes usuarios
SET ROLE user1;  -- ou qualquer outro usuário criado
SELECT name, setting
FROM pg_settings
WHERE name IN ('statement_timeout', 'work_mem');

SELECT rolname, rolconfig
FROM pg_roles
WHERE rolname = 'nome_do_usuario';

--excluir usuarios
DO $$
DECLARE
    username RECORD;
BEGIN
    FOR username IN SELECT usename FROM pg_user WHERE usename != current_user LOOP
        EXECUTE 'DROP OWNED BY "' || username.usename || '" CASCADE';
        EXECUTE 'DROP USER IF EXISTS "' || username.usename || '"';
    END LOOP;
END $$;

