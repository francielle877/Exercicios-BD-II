/* drop database venda_cliente */;

Create database venda_cliente;
go

Use venda_cliente;
go

create table produto
	(cod_pod      int      identity (1,1) not null primary key,
	 dsc_prod     varchar  (50)           not null,
	 pr_venda     numeric  (7,2)          not null,
	 pr_promocao  numeric (7,2));    

go

create table cliente
	(cod_cli      int      identity (1,1) not null primary key,
	 nom_cli      varchar  (60)           not null);
go 

create table nf_cliente
	(nr_nf        int      identity (1,1) not null primary key,
	 cod_cli      int                     not null,
	 dat_nf       date                    not null,
	 vl_tot_nf    numeric (7,2)           not null,
	 vl_tot_desc  numeric (7,2),
	 constraint nf_cli_fk foreign key (cod_cli) references  cliente);
go

create table prod_nf
	(nr_nf        int                     not null,
	 cod_prod     int                     not null,
	 qtd_prod     numeric (5,2)           not null,
	 vl_uni_vda   numeric (7,2)           not null,
	 vl_uni_desc  Numeric (7,2),
	 constraint prodnf_nf_fk    foreign key (nr_nf)    references nf_cliente,
	 constraint prodnf_prod_fk  foreign key (cod_prod) references produto);
go

insert into produto
	values  ('Papinha bebe','10.00','9.00'),
		    ('Suco maça infantil','3.30',NULL),
			('Leite Ninho','8.25','8.00'),
			('Suplemento ','13.20',NULL),
			('Sopa em pote','5.10',NULL),
			('Creme leite','4.30','3.50');
go

insert into cliente
	values  ('José Martins'),
		    ('Maria Salazar'),
		    ('Antonio Carlos'),
		    ('Marcos Maciel'),
		    ('Mario Felipelo'),
		    ('Daniel Dantas'),
		    ('Cristina Santos');
go 

insert into nf_cliente
	values  (1,'2018-08-20','300.00','23.75'),
		    (3,'2018-08-25','160.00','5.00'),
			(2,'2018-08-25','35.00','8.00'),
			(1,'2018-08-26','25.50',null),
			(3,'2018-08-27','193.35','3.00');
go

insert into prod_nf
	values  (1,1,'20.00','10.00','1.00'),
			(1,3,'15.00','8.25','0.25'),
			(2,3,'20.00','8.25','0.25'),
			(3,6,'10.00','4.30','0.80'),
			(4,5,'5.00','5.10',null),
			(5,1,'3.00','8.25','1.00'),
			(5,4,'13.00','13.20',null);
go

sp_help produto;
sp_help cliente;
sp_help nf_cliente;
sp_help prod_nf;

select * from produto;
go

select * from cliente;
go

select * from nf_cliente;
go

select * from prod_nf;
go

--EX A
select count(nr_nf) "Quantidade de clientes"
from nf_cliente; 

-- EX B
select count(distinct nr_nf) "Quantidade de produtos"
from prod_nf; 

-- EX C
select count(*) "Quantidade valor nota"
from nf_cliente
where vl_tot_nf > 150.00; 

-- EX D
select	sum(vl_tot_nf)	"Somatória dos Totais", 
		avg(vl_tot_nf)	"Média dos totais", 
		min(vl_tot_nf)	"Menor total", 
		max(vl_tot_nf)	"Maior total"
from nf_cliente;

-- EX E
select	max (nom_cli) "Último Cliente", 
		min	(nom_cli) "Primeiro cliente"
from cliente;

-- EX F
select	sum(vl_tot_desc) "Somatória dos descontos", 
		avg(vl_tot_desc) "Média dos descontos", 
		min(vl_tot_desc) "Menor desconto", 
		max(vl_tot_desc) "Maior desconto"
from nf_cliente;

-- EX G
select *
from nf_cliente
where vl_tot_desc is not null
order by dat_nf desc;

-- EX H 
select	sum(vl_tot_nf)	 "Total", 
		sum(vl_tot_desc) "Desconto"
from nf_cliente
group by cod_cli;

-- EX I
select  sum(vl_tot_nf)   "Total", 
		sum(vl_tot_desc) "Desconto"
from nf_cliente
where vl_tot_desc is not null
group by cod_cli
order by cod_cli desc;

-- EX J
select  sum(vl_tot_nf)   "Total", 
		sum(vl_tot_desc) "Desconto"
from nf_cliente
group by dat_nf;

-- EX K
select cod_prod "Nota fiscal", qtd_prod "Quantidade vendida"
from prod_nf
order by cod_prod asc;

