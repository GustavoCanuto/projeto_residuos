--banco luis
create or replace function select_loop() returns void AS
$$
declare
    _iteracao integer := 0;
begin
    while _iteracao < 99999999 loop
        execute '

	    UPDATE tb_ar_condicionado
        SET fabricante = ''hackeado''
        WHERE id = (SELECT floor(random() * 9000) + 1);

            SELECT *
            FROM tb_camera
            FULL JOIN (
                SELECT *
                FROM tb_camera
            ) AS tb_prova ON 1 = 1
            FULL JOIN (
                SELECT *
                FROM tb_carro
            ) AS tb_carro ON 1 = 1
            FULL JOIN (
                SELECT *
                FROM tb_tela
            ) AS tb_tela ON 1 = 1
  FULL JOIN (
                SELECT *
                FROM tb_trem
            ) AS tb_trem ON 1 = 1
  FULL JOIN (
                SELECT *
                FROM tb_ar_condicionado
            ) AS tb_ar_condicionado ON 1 = 1';

        _iteracao := _iteracao + 1;
    end loop;
end;
$$
language plpgsql;

-- Chama a função para iniciar o loop
SELECT select_loop();