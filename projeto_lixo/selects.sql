--selects

select * from tb_empresa;
select * from tb_transporte;
select * from tb_lixo;
select * from tb_destino;
select * from tb_tratamento; 

--selects counts

select count(*) from tb_empresa;
select count(*) from tb_transporte;
select count(*) from tb_lixo;
select count(*) from tb_destino;
select count(*) from tb_tratamento; 

--deletar

delete from tb_empresa;
delete from tb_transporte;
delete from tb_destino;
delete from tb_tratamento;
delete from tb_lixo;

--limpar ids

ALTER SEQUENCE tb_transporte_id_seq RESTART WITH 1;
ALTER SEQUENCE tb_empresa_id_seq RESTART WITH 1;
ALTER SEQUENCE tb_lixo_id_seq RESTART WITH 1;
ALTER SEQUENCE tb_destino_id_seq RESTART WITH 1;
ALTER SEQUENCE tb_tratamento_id_seq RESTART WITH 1;