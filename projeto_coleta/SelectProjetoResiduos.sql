SELECT id FROM tb_bairro WHERE fk_cidade = 26;

--totais

select count(*) from tb_destino;

select count(*) from tb_estado;

select count(*) from tb_bairro ;

select count(*) from tb_cidade;

select count(*) from tb_empresa;

select count(*) from tb_funcionario;

select count(*) from tb_veiculo;

select count(*) from tb_equipe;

select count(*) from tb_coleta;

--dados

select * from tb_destino;

select * from tb_estado;

select * from tb_bairro ;

select * from tb_cidade;

select * from tb_empresa;

select * from tb_funcionario;

select * from tb_veiculo;

select * from tb_equipe;

select * from tb_coleta;

--testes

--destino no estado de sp
SELECT d.id FROM tb_destino d
			  		join tb_cidade c on d.fk_cidade = c.id
			  		WHERE c.fk_estado = 26;

-- quantidade destino por tipo_local na cidade sp			  	
SELECT count(d.id) FROM tb_destino d
			  		join tb_cidade c on d.fk_cidade = c.id
			  		WHERE c.fk_estado = 26 and tipo_local = 'Exportação';
			  	
--destino outro estado			  		
SELECT d.id FROM tb_destino d
			  		join tb_cidade c on d.fk_cidade = c.id
			  		WHERE c.fk_estado = 19;
			  	
SELECT count(d.id) FROM tb_destino d
			  		join tb_cidade c on d.fk_cidade = c.id
			  		WHERE c.fk_estado = 19;
			  		
SELECT d.id FROM tb_destino d
			  		join tb_cidade c on d.fk_cidade = c.id
			  		WHERE c.fk_estado = 11;
			  		
SELECT count(d.id) FROM tb_destino d
			  		join tb_cidade c on d.fk_cidade = c.id
			  		WHERE c.fk_estado = 11;
			  		
SELECT count(d.id) FROM tb_destino d
			  		join tb_cidade c on d.fk_cidade = c.id
			  		WHERE c.fk_estado not in(11,19,26);

--funcionarios			  	
select * from tb_funcionario order by fk_empresa, funcao;

select count(*) from tb_funcionario;

select count(*) from tb_funcionario where funcao like 'Coletor';

select count(*) from tb_funcionario where funcao like 'Coletor Auxiliar';

select count(*) from tb_funcionario where funcao like 'Motorista';

select count(*) from tb_funcionario where funcao like 'Supervisor';

--empresa
SELECT count(distinct  e.id)
FROM tb_empresa e
INNER JOIN tb_funcionario f ON e.id = f.fk_empresa
order by e.id;

SELECT count(distinct  e.id)
			FROM tb_empresa e
			join tb_funcionario f ON e.id = f.fk_empresa

select count( distinct te.id) from tb_veiculo v
				join tb_empresa te on te.id = v.fk_empresa  
				join tb_funcionario tf on tf.fk_empresa  = te.id 
				where v.tipo = 'Caminhão Compactador';

select id from tb_funcionario
			where fk_empresa =  and funcao =

--select equipe com dados relevantes			
select eq.nome,eq.id, eq.descricao, te.id, tf.funcao, tf.id, tv.tipo, tv.id  from tb_equipe eq
					join tb_veiculo tv on tv.id = eq.fk_veiculo 
					join tb_empresa te on te.id = tv.fk_empresa 
					join tb_funcionario_equipe tfe on tfe.fk_equipe = eq.id 
					join tb_funcionario tf on tf.id = tfe.fk_funcionario  
					    order by te.id, eq.nome ;
					   
select id from tb_equipe 
				where descricao like  '%Coleta%'  ;	
			
			SELECT d.id FROM tb_destino d 
						  		join tb_cidade c on d.fk_cidade = c.id 
						  		WHERE c.fk_estado = ? and c.tipo <> 'Reciclagem' limit 5
					   
select * from tb_equipe te ;

select * from tb_funcionario_equipe tfe ;

select * from tb_funcionario 
						    where id=2147;
						
select * from tb_coleta order by fk_equipe, timestamp;

select count(*) from tb_coleta;

-- select coleta com dados relevantes
select c."timestamp", e.id "id equipe",e.descricao,v.tipo, b.nome, d.tipo_local, te.nome  from tb_coleta c 
			join tb_bairro b on b.id = c.fk_bairro 
			join tb_destino d on d.id = c.fk_destino 
			join tb_equipe e  on e.id = c.fk_equipe 
			join tb_veiculo v on v.id = e.fk_veiculo 
			join tb_cidade tc on tc.id = d.fk_cidade 
			join tb_estado te on te.id = tc.fk_estado 
			where e.descricao like '%Coleta%'
			
SELECT d.id, c.fk_estado  FROM tb_destino d 
					  		join tb_cidade c on d.fk_cidade = c.id 
					  		WHERE c.fk_estado = 26 and d.tipo_local = 'Reciclagem' limit 5
					  
					  		
select e.id, tc.id  from tb_equipe e
						left join tb_coleta tc ON tc.fk_equipe  = e.id 
					    where descricao like  '%Coleta%'  and tc.fk_equipe is null	limit 30	  		

					  		
--zerando banco de dados 
			
delete from tb_coleta;

delete from tb_destino;

delete from tb_funcionario_equipe; 

delete from tb_equipe;

delete from tb_funcionario;

delete from tb_veiculo;

delete from tb_empresa;


-- Redefina a sequência para a tabela tb_empresa
ALTER SEQUENCE tb_empresa_id_seq RESTART WITH 1;

-- Redefina a sequência para a tabela tb_empresa
ALTER SEQUENCE tb_equipe_id_seq RESTART WITH 1;

-- Redefina a sequência para a tabela tb_empresa
ALTER SEQUENCE tb_funcionario_equipe_id_seq RESTART WITH 1;

-- Redefina a sequência para a tabela tb_destino
ALTER SEQUENCE tb_destino_id_seq RESTART WITH 1;

-- Redefina a sequência para a tabela tb_funcionario
ALTER SEQUENCE tb_funcionario_id_seq RESTART WITH 1;

-- Redefina a sequência para a tabela tb_veiculo
ALTER SEQUENCE tb_veiculo_id_seq RESTART WITH 1;

-- Redefina a sequência para a tabela tb_veiculo
ALTER SEQUENCE tb_coleta_id_seq RESTART WITH 1;