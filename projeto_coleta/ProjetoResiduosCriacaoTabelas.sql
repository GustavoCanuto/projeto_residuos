CREATE TABLE tb_estado(
    id  INT NOT NULL ,
    nome VARCHAR (75) NOT NULL,
    uf   CHAR(5)  NOT null,
    PRIMARY KEY (Id)
);

CREATE TABLE tb_cidade(
    id int PRIMARY KEY, 
    nome VARCHAR(120) NOT null,
    fk_estado int NOT NULL REFERENCES tb_estado(id)
   
);
									  
CREATE TABLE tb_bairro(
    id bigserial PRIMARY KEY, 
    nome VARCHAR(100) NOT null,
    logradouros varchar(255),
    fk_cidade int NOT NULL REFERENCES tb_cidade(id)
);

CREATE TABLE tb_empresa(
    id bigserial PRIMARY KEY,
    nome VARCHAR(100) not null, 
    cnpj varchar(20) not null unique,
    telefone VARCHAR(20) not null,
    email VARCHAR(60) unique, 
    tipo VARCHAR(100) not null
);


CREATE TABLE tb_funcionario(
    id bigserial PRIMARY KEY,
    nome_completo VARCHAR(100) NOT NULL,
    cpf varchar (20) not null unique,
    data_nascimento date not null, 
    email VARCHAR(50) unique ,
    fk_empresa int NOT NULL REFERENCES tb_empresa(id),
    funcao  varchar(100) not null
);

CREATE TABLE tb_veiculo(
    id bigserial PRIMARY KEY,
    tipo  VARCHAR(100) not null,
    capacidade decimal not null, 
    placa VARCHAR(20) not null unique,
    ano_fabricacao INT not null,
    fk_empresa int not null references tb_empresa(id)
);


CREATE TABLE tb_equipe(
	id bigserial NOT null primary key,
	nome varchar(255) NOT NULL,
	fk_veiculo int not NULL REFERENCES tb_veiculo(id),
	descricao varchar(255)
);


create table tb_funcionario_equipe(
	id bigserial not NULL PRIMARY key,
	fk_funcionario INT not null references tb_funcionario(id),
	fk_equipe INT not null references tb_equipe(id)
	
);

CREATE TABLE tb_destino(
    id bigserial PRIMARY KEY,
    nome VARCHAR(150) not null,
    tipo_local  VARCHAR(100) not null, 
    fk_cidade int NOT NULL REFERENCES tb_cidade(id),
    logradouro VARCHAR(200) not null, 
    numero varchar (20) not null,
    cep varchar (30) not null,
    capacidade_suportada decimal not null, 
    fk_empresa INT not null references tb_empresa(id)
);

CREATE TABLE tb_coleta(
    id bigserial PRIMARY KEY,
    timestamp_inicial TIMESTAMP not null default now(), 
    timestamp_final TIMESTAMP , 
    peso decimal ,
  	fk_equipe INT not null references tb_equipe(id), 
  	fk_bairro INT not null references tb_bairro(id), 
    fk_destino INT not null references tb_destino(id)
 
);








