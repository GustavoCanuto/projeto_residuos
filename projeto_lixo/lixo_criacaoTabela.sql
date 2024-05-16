--DOMINIO

create table TB_TIPO_MATERIAL (
    ID serial,
    NOME varchar(75),
    constraint NN_NOME_TB_TIPO_MATERIAL check(NOME is not null),
    constraint PK_TB_TIPO_MATERIAL primary key (ID)
);

create table TB_TIPO_DESTINO(
	ID  serial,
    NOME varchar (75) not null,
    DESCRICAO varchar,
    constraint NN_NOME_TB_TIPO_DESTINO check(NOME is not null),
    constraint PK_TB_TIPO_DESTINO primary key (ID)
);

create table TB_TIPO_LIXO(
	ID  serial,
    NOME varchar(75) not null,
    constraint NN_NOME_TB_TIPO_LIXO check(NOME is not null),
    constraint PK_TB_TIPO_LIXO primary key (ID)
);

create table TB_MATERIAL(
	ID serial,
	NOME varchar not null,
	TEMPO_DECOMPOSICAO varchar, 
	FK_TIPO_MATERIAL int not null,
    constraint FK_TIPO_MATERIAL_TB_MATERIAL foreign key(FK_TIPO_MATERIAL) references TB_TIPO_MATERIAL(ID),
    constraint NN_FK_TIPO_MATERIAL_TB_MATERIAL check(FK_TIPO_MATERIAL is not null),
    constraint NN_NOME_TB_MATERIAL check(NOME is not null),
    constraint PK_TB_MATERIAL primary key (ID)
);

--TRANSACAO

create table TB_EMPRESA(
	ID  serial,
    NOME varchar not null,
    CNPJ varchar not null,
    TELEFONE varchar,
    EMAIL varchar,
    DESCRICAO varchar,
    constraint NN_NOME_TB_EMPRESA check(NOME is not null),
    constraint NN_CNPJ_TB_EMPRESA check(CNPJ is not null),
    constraint UQ_CNPJ_TB_EMPRESA unique(CNPJ),
    constraint PK_TB_EMPRESA primary key (ID)
);

create table TB_TRATAMENTO(
	ID  serial,
    TEMPO_PROCESSO int not null,
    VOLUME_ENTRADA decimal,
    VOLUME_SAIDA decimal,
    CUSTO decimal,
    RELATORIO varchar,
    EFICIENCIA int,
    FK_EMPRESA int not null,
    constraint FK_EMPRESA_TB_TRATAMENTO foreign key(FK_EMPRESA) references TB_EMPRESA(ID),
    constraint NN_FK_EMPRESA_TB_TRATAMENTO check(FK_EMPRESA is not null),
    constraint NN_TEMPO_PROCESSO_TB_TRATAMENTO check(TEMPO_PROCESSO is not null),
    constraint PK_TB_TRATAMENTO primary key (ID)
);

create table TB_DESTINO(
	ID  serial,
    NOME varchar not null,
    AREA_TERRITORIAL decimal not null,
    CAPACIDADE decimal not null,
    CONTATO varchar,
    HORARIO_FUNCIONAMENTO varchar,
    FK_EMPRESA int not null,
    FK_TIPO_DESTINO int not null,
    
    constraint FK_EMPRESA_TB_DESTINO foreign key(FK_EMPRESA) references TB_EMPRESA(ID),
     constraint NN_FK_EMPRESA_TB_DESTINO check(FK_EMPRESA is not null),
     
    constraint FK_TIPO_DESTINO_TB_DESTINO foreign key(FK_TIPO_DESTINO) references TB_TIPO_DESTINO(ID),
     constraint NN_FK_TIPO_DESTINO_TB_DESTINO check(FK_TIPO_DESTINO is not null),
    
        constraint NN_NOME_TB_DESTINO check(NOME is not null),
            constraint NN_AREA_TERRITORIAL_TB_DESTINO check(AREA_TERRITORIAL is not null),
                constraint NN_CAPACIDADE_TB_DESTINO check(CAPACIDADE is not null),
    constraint PK_TB_DESTINO primary key (ID)
);

create table TB_TRANSPORTE (
     ID  serial,
	 PLACA varchar not null UNIQUE,
	 CAPACIDADE decimal not null,
	 ANO_FABRICACAO int,
	 NUMERO_CHASSI varchar(50) UNIQUE,
	 FABRICANTE varchar,
     FK_EMPRESA int not null,
     
    constraint FK_EMPRESA_TB_TRANSPORTE foreign key(FK_EMPRESA) references TB_EMPRESA(ID),
     constraint NN_FK_EMPRESA_TB_TRANSPORTE check(FK_EMPRESA is not null),
     
     constraint NN_PLACA_TB_TRANSPORTE check(PLACA is not null),
       constraint UQ_PLACA_TB_TRANSPORTE unique(PLACA),
       
     constraint NN_CAPACIDADE_TB_TRANSPORTE check(CAPACIDADE is not null),
     
     constraint UQ_NUMERO_CHASSI_TB_TRANSPORTE unique(NUMERO_CHASSI),
     
     constraint PK_TB_TRANSPORTE primary key (ID)
);

create table TB_LIXO(
	ID  serial,
    PESO decimal not null,
    VOLUME decimal not null,
    DESCRICAO varchar,
    INDICE_RECICLABILIDADE int,
    CUSTO_DESCARTE decimal not null,
    
    FK_MATERIAL int not null REFERENCES TB_MATERIAL(ID),
    FK_DESTINO int not null REFERENCES TB_DESTINO(ID),
    FK_TRATAMENTO int REFERENCES TB_TRATAMENTO(ID),
    FK_TIPO_LIXO int not null REFERENCES TB_TIPO_LIXO(ID),
    FK_TRANSPORTE int not null REFERENCES TB_TRANSPORTE(ID),
    
    constraint NN_PESO_TB_LIXO check(PESO is not null),
    constraint NN_VOLUME_TB_LIXO check(VOLUME is not null),
     constraint NN_CUSTO_DESCARTE_TB_LIXO check(CUSTO_DESCARTE is not null),
     
    constraint PK_TB_LIXO primary key (ID)
);





