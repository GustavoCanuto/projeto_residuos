--ver usuarios conectados 
SELECT 
    pid, 
    usename, 
    application_name, 
    client_addr, 
    client_port, 
    backend_start, 
    state, 
    query 
FROM 
    pg_stat_activity
WHERE 
   client_addr IS NOT NULL
AND client_addr <> '127.0.0.1';

--finalizar sessao de um usuario 
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'lixo'
  AND usename = 'user8';
  
 
--funcao para consultar e finalizar sessao 
 CREATE OR REPLACE FUNCTION check_and_terminate_sessions() RETURNS void AS $$
DECLARE
    row record;
BEGIN
    -- Loop para consultar os usuários conectados
    FOR row IN
        SELECT pg_stat_activity.pid
        FROM pg_stat_activity
        WHERE client_addr IS NOT NULL
          AND client_addr <> '127.0.0.1'
    LOOP
        -- Finalizar a sessão do usuário
        PERFORM pg_terminate_backend(row.pid);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--temporizador 
CREATE OR REPLACE FUNCTION schedule_terminate_sessions_job() RETURNS void AS $$
BEGIN
    LOOP
        -- Executar a função para verificar e finalizar sessões
        PERFORM check_and_terminate_sessions();
        
        -- Aguardar 5 segundos
        PERFORM pg_sleep(5);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Iniciar o job agendado
SELECT schedule_terminate_sessions_job();