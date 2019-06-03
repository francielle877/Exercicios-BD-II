create database produto;
go
use produto;

/* drop database produto; */

create table secao
  (cod_secao   integer            not null primary key,
   dsc_secao   varchar(30)	  null);
go

create table produto
  (cod_prod     integer           not null primary key,
   cod_secao    integer           not null,
   dsc_produto  varchar (40)      not null,
   val_ultcusto numeric (7,2)     not null,
   qtd_estq     integer           not null,
   constraint prod_sec_fk foreign key(cod_secao) references secao (cod_secao));
go

create table preco_produto
  (id_historico     integer       not null primary key,
   cod_prod         integer       not null,
   val_venda        numeric (7,2) not null,
   dat_inivigencia date           not null,
   constraint prod_prec_fk foreign key(cod_prod) references produto (cod_prod));
go

insert into secao
    values (10,'Infantil'),
	       (20,'Juvenil'),
		   (30,'Adulto'),
		   (40,'Senior');
go

insert into produto 
    values (05,30,'Blusa Manga Longa',28.10,20),
		   (10,20,'Camiseta Regata',15.20,10),
		   (15,20,'Camiseta Fechada',16.89,0),
		   (20,10,'Macacao Curto',25.45,12);
go

insert into preco_produto 
    values (1,05,35.00,'2017-01-02'),
		   (2,10,22.50,'2017-01-02'),
		   (3,15,25.00,'2017-02-05'),
		   (4,20,32.00,'2018-06-21'),
		   (5,10,25.50,'2018-05-20');
go

select * from secao
go

select * from produto
go

select * from preco_produto
go

/* Funções de Linha */

select dsc_produto, len (dsc_produto) as 'Total de Catacteres'
	from produto;
go

select dsc_produto, lower (dsc_produto) as 'Nome Curso em Minusculo'
	from produto;
go

select dsc_produto, upper (dsc_produto) as 'Nome Curso em Maisculo'
	from produto;
go

select dsc_produto, LEFT (dsc_produto, 3) as 'LEFT - Descrição Produto'
	from produto;
go

select dsc_produto, RIGHT (dsc_produto, 4) as 'RIGHT - Descrição Produto'
	from produto;
go

select dsc_produto, RIGHT (LTRIM(dsc_produto),1) as 'RIGHT/LTRIM - Descrição Produto'
	from produto;
go

select dsc_produto, RIGHT (RTRIM(dsc_produto),3) as 'RIGHT/RTRIM - Descrição Produto'
	from produto;
go

/* Funções de Data */
select getdate() as 'Data Atual'
go

select datepart(year, getdate())	as 'Ano Atual'
go

select datepart(month, getdate())	as 'Mês Atual'
go

select datepart(day, getdate())		as 'Dia Atual'
go

select datepart(hour, getdate())	as 'Hora Atual'
go

select datepart(minute, getdate())	as 'Minutos Atual'
go

select datepart(second, getdate())	as 'Segundos Atual'
go

select datepart(weekday, getdate()) as 'Dia da Semana Atual'
go

select datepart(year, dat_inivigencia) 'Ano da Data de Vigencia'
	from preco_produto
go

select datepart(month, dat_inivigencia) 'Mês da Data de Vigencia', dat_inivigencia
	from preco_produto
go

select datepart(day, dat_inivigencia) 'Dia da Data de Vigencia', dat_inivigencia				
	from preco_produto
go

select datepart(dayofyear, dat_inivigencia) 'Dia do Ano da Data de Vigencia', dat_inivigencia				
	from preco_produto
go

select datepart(week, dat_inivigencia) 'Semana da Data de Vigencia'	, dat_inivigencia			
	from preco_produto
go

select datediff(day, dat_inivigencia, getdate()) 'Dias Corridos', getdate () 'Data Atual', 
					 dat_inivigencia 'Data Vigencia PRoduto'				
	from preco_produto
go

/* Arredondamento Universal */

select round (45.925, 2) as 'Arredondamento para acima',
	   round (45.923, 2) as 'Arredondamento para baixo',
	   round (45.923, 0) as 'Arredondamento na 2ª casa da milhar',
	   round (45.923, 1) as 'Arredondamento na centena',
	   round (44.923,-1) as 'Arredondamento na milhar para baixo',
	   round (45.925,-1) as 'Arredondamento na milhar para cima';
go

/* Funções de Usuário do Sistema */ 

select * from sysusers;
go

select user_name();
go

select name from sysusers where name = user_name(1);
go

select name from sysusers where name = user_name(3);
go

/* Usuário Logado no BD */

select system_user;

declare @sys_usr char(30);
set @sys_usr = system_user;
select 'O usuário logado no BD é:' + @sys_usr;

/* Suser_Name ([ server_user_id ]) */

select SUSER_NAME();
select SUSER_SNAME(1);




