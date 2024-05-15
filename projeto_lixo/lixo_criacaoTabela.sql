--DOMINIO

create table TB_TIPO_MATERIAL (
    ID serial,
    NOME varchar(75),
    constraint PK_TB_TIPO_MATERIAL primary key (ID),
    constraint NN_NOME_TB_TIPO_MATERIAL check(NOME is not null)
);

create table TB_TIPO_DESTINO(
	ID  serial,
    NOME varchar (75) NOT NULL,
    DESCRICAO varchar,
    constraint PK_TB_TIPO_DESTINO primary key (ID)
);

create table TB_TIPO_LIXO(
	ID  serial,
    NOME varchar(75) NOT NULL,
    constraint PK_TB_TIPO_LIXO primary key (ID)
);

create table TB_MATERIAL(
	ID serial,
	NOME varchar NOT NULL,
	TEMPO_DECOMPOSICAO varchar, 
    FK_TIPO_MATERIAL int NOT NULL REFERENCES TB_TIPO_MATERIAL(ID),
    constraint PK_TB_MATERIAL primary key (ID)
);

--TRANSACAO

create table TB_EMPRESA(
	ID  serial,
    NOME varchar NOT NULL,
    CNPJ varchar NOT NULL UNIQUE,
    TELEFONE varchar,
    EMAIL varchar,
    DESCRICAO varchar,
    constraint PK_TB_EMPRESA primary key (ID)
);

create table TB_TRATAMENTO(
	ID  serial,
    TEMPO_PROCESSO int NOT NULL,
    VOLUME_ENTRADA decimal,
    VOLUME_SAIDA decimal,
    CUSTO decimal,
    RELATORIO varchar,
    EFICIENCIA int,
    FK_EMPRESA int NOT NULL REFERENCES TB_EMPRESA(ID),
    constraint PK_TB_TRATAMENTO primary key (ID)
);

create table TB_DESTINO(
	ID  serial,
    NOME varchar NOT NULL,
    AREA_TERRITORIAL decimal NOT NULL,
    CAPACIDADE decimal NOT NULL,
    CONTATO varchar,
    HORARIO_FUNCIONAMENTO varchar,
    FK_EMPRESA int NOT NULL REFERENCES TB_EMPRESA(ID),
    FK_TIPO_DESTINO int NOT NULL REFERENCES TB_TIPO_DESTINO(ID),
    constraint PK_TB_DESTINO primary key (ID)
);

create table TB_TRANSPORTE (
     ID  serial,
	 PLACA varchar NOT NULL UNIQUE,
	 CAPACIDADE decimal NOT NULL,
	 ANO_FABRICACAO int,
	 NUMERO_CHASSI varchar(50) UNIQUE,
	 FABRICANTE varchar,
     FK_EMPRESA int NOT NULL REFERENCES TB_EMPRESA(ID),
     constraint PK_TB_TRANSPORTE primary key (ID)
);

create table TB_LIXO(
	ID  serial,
    PESO decimal NOT NULL,
    VOLUME decimal NOT NULL,
    DESCRICAO varchar,
    INDICE_RECICLABILIDADE int,
    CUSTO_DESCARTE decimal NOT NULL,
    FK_MATERIAL int NOT NULL REFERENCES TB_MATERIAL(ID),
    FK_DESTINO int NOT NULL REFERENCES TB_DESTINO(ID),
    FK_TRATAMENTO int REFERENCES TB_TRATAMENTO(ID),
    FK_TIPO_LIXO int NOT NULL REFERENCES TB_TIPO_LIXO(ID),
    FK_TRANSPORTE int NOT NULL REFERENCES TB_TRANSPORTE(ID),
    constraint PK_TB_LIXO primary key (ID)
);





