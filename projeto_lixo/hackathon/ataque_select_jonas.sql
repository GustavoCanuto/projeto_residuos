--banco do jonas
create or replace function select_loop() returns void AS
$$
declare
    _iteracao integer := 0;
begin
    while _iteracao < 99999999 loop
        execute '
            SELECT *
            FROM tb_aluno
            FULL JOIN (
                SELECT *
                FROM tb_prova
            ) AS tb_prova ON 1 = 1
            FULL JOIN (
                SELECT *
                FROM tb_turma
            ) AS tb_turma ON 1 = 1
            FULL JOIN (
                SELECT *
                FROM tb_professor
            ) AS tb_professor ON 1 = 1';

        _iteracao := _iteracao + 1;
    end loop;
end;
$$
language plpgsql;

-- Chama a função para iniciar o loop
SELECT select_loop();


 SELECT * FROM tb_aluno;