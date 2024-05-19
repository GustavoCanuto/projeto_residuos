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

--sessao ativa
SELECT 
    pid, 
    usename, 
    application_name, 
    client_addr, 
    backend_start, 
    state, 
    query 
FROM 
    pg_stat_activity
WHERE 
    state = 'active';
    
--por usuario
SELECT 
    pid, 
    usename, 
    application_name, 
    client_addr, 
    backend_start, 
    state, 
    query 
FROM 
    pg_stat_activity
WHERE 
    usename = 'user1';
    
 