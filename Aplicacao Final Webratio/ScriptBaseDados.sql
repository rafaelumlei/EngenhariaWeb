create database eventos;
use eventos;

-- Grupo [Group]

create table `grupo` (
   `oid`  integer  not null,
   `groupname`  varchar(255),
  primary key (`oid`)
);

-- Module [Module]

create table `module` (
   `oid`  integer  not null,
   `moduleid`  varchar(255),
   `modulename`  varchar(255),
  primary key (`oid`)
);

-- Utilizador [User]

create table `utilizador` (
   `oid`  integer  not null,
   `email`  varchar(255),
   `password`  varchar(255),
   `teste`  varchar(255),
   `nome`  varchar(255),
   `foto`  varchar(255),
   `lat`  double precision,
   `lon`  double precision,
   `lat2`  double precision,
   `lon2`  double precision,
   `username`  varchar(255),
  primary key (`oid`)
);

-- Newsletter [ent1]

create table `newsletter` (
   `nr`  integer  not null,
   `titulo`  varchar(255),
   `dtenvio`  datetime,
  primary key (`nr`)
);

-- Tipo [ent2]

create table `tipo` (
   `idtipo`  integer  not null,
   `nome`  varchar(255),
  primary key (`idtipo`)
);

-- Comentario [ent4]

create table `comentario` (
   `idcomentario`  integer  not null,
   `titulo`  varchar(255),
   `texto`  longtext,
   `dtcom`  datetime,
  primary key (`idcomentario`)
);

-- Evento [ent5]

create table `evento` (
   `idevento`  integer  not null,
   `dtfim`  datetime,
   `dtinicio`  datetime,
   `titulo`  varchar(255),
   `descricao`  varchar(255),
   `lat`  double precision,
   `lon`  double precision,
   `proxnewsletter`  bit,
  primary key (`idevento`)
);

-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]

alter table `grupo`  add column  `module_oid`  integer;
alter table `grupo`   add index fk_grupo_module (`module_oid`), add constraint fk_grupo_module foreign key (`module_oid`) references `module` (`oid`);
create index `idx_grupo_module` on `grupo`(`module_oid`);


-- Group_Module [Group2Module_Module2Group]

create table `group_module` (
   `grupo_oid`  integer not null,
   `module_oid`  integer not null,
  primary key (`grupo_oid`, `module_oid`)
);

alter table `group_module`   add index fk_group_module_grupo (`grupo_oid`), add constraint fk_group_module_grupo foreign key (`grupo_oid`) references `grupo` (`oid`);
alter table `group_module`   add index fk_group_module_module (`module_oid`), add constraint fk_group_module_module foreign key (`module_oid`) references `module` (`oid`);
create index `idx_group_module_grupo` on `group_module`(`grupo_oid`);
create index `idx_group_module_module` on `group_module`(`module_oid`);

-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]

alter table `utilizador`  add column  `grupo_oid`  integer;
alter table `utilizador`   add index fk_utilizador_grupo (`grupo_oid`), add constraint fk_utilizador_grupo foreign key (`grupo_oid`) references `grupo` (`oid`);
create index `idx_utilizador_grupo` on `utilizador`(`grupo_oid`);

-- User_Group [User2Group_Group2User]

create table `user_group` (
   `utilizador_oid`  integer not null,
   `grupo_oid`  integer not null,
  primary key (`utilizador_oid`, `grupo_oid`)
);

alter table `user_group`   add index fk_user_group_utilizador (`utilizador_oid`), add constraint fk_user_group_utilizador foreign key (`utilizador_oid`) references `utilizador` (`oid`);
alter table `user_group`   add index fk_user_group_grupo (`grupo_oid`), add constraint fk_user_group_grupo foreign key (`grupo_oid`) references `grupo` (`oid`);
create index `idx_user_group_utilizador` on `user_group`(`utilizador_oid`);
create index `idx_user_group_grupo` on `user_group`(`grupo_oid`);

-- Tipo_Evento [rel1]

alter table `evento`  add column  `tipo_idtipo`  integer;
alter table `evento`   add index fk_evento_tipo (`tipo_idtipo`), add constraint fk_evento_tipo foreign key (`tipo_idtipo`) references `tipo` (`idtipo`);
create index `idx_evento_tipo` on `evento`(`tipo_idtipo`);

-- Utilizador_Comentario [rel2]

alter table `comentario`  add column  `utilizador_oid`  integer;
alter table `comentario`   add index fk_comentario_utilizador (`utilizador_oid`), add constraint fk_comentario_utilizador foreign key (`utilizador_oid`) references `utilizador` (`oid`);
create index `idx_comentario_utilizador` on `comentario`(`utilizador_oid`);

-- Evento_Comentario [rel3]

alter table `comentario`  add column  `evento_idevento`  integer;
alter table `comentario`   add index fk_comentario_evento (`evento_idevento`), add constraint fk_comentario_evento foreign key (`evento_idevento`) references `evento` (`idevento`);
create index `idx_comentario_evento` on `comentario`(`evento_idevento`);

-- Utilizador_Evento [rel4]

alter table `evento`  add column  `utilizador_oid`  integer;
alter table `evento`   add index fk_evento_utilizador (`utilizador_oid`), add constraint fk_evento_utilizador foreign key (`utilizador_oid`) references `utilizador` (`oid`);
create index `idx_evento_utilizador` on `evento`(`utilizador_oid`);

-- Favoritos [rel6]

create table `favoritos` (
   `utilizador_oid`  integer not null,
   `evento_idevento`  integer not null,
  primary key (`utilizador_oid`, `evento_idevento`)
);

alter table `favoritos`   add index fk_favoritos_utilizador (`utilizador_oid`), add constraint fk_favoritos_utilizador foreign key (`utilizador_oid`) references `utilizador` (`oid`);
alter table `favoritos`   add index fk_favoritos_evento (`evento_idevento`), add constraint fk_favoritos_evento foreign key (`evento_idevento`) references `evento` (`idevento`);
create index `idx_favoritos_utilizador` on `favoritos`(`utilizador_oid`);
create index `idx_favoritos_evento` on `favoritos`(`evento_idevento`);

--  Newsletter_Evento [rel7]

alter table `newsletter`  add column  `evento_idevento`  integer;
alter table `newsletter`   add index fk_newsletter_evento (`evento_idevento`), add constraint fk_newsletter_evento foreign key (`evento_idevento`) references `evento` (`idevento`);
create index `idx_newsletter_evento` on `newsletter`(`evento_idevento`);

-- Script de configuração dos módulos para autenticação

INSERT INTO `module` (`oid`,`moduleid`,`modulename`) VALUES (1,'sv4','registados');
INSERT INTO `module` (`oid`,`moduleid`,`modulename`) VALUES (2,'sv1','administradores');

INSERT INTO `grupo` (`oid`,`groupname`,`module_oid`) VALUES (1,'registados',1);
INSERT INTO `grupo` (`oid`,`groupname`,`module_oid`) VALUES (2,'administradores',2);

--  Utilizadores e eventos de teste

INSERT INTO `utilizador` (`oid`,`email`,`password`,`nome`,`foto`,`lat`,`lon`,`lat2`,`lon2`,`username`,`grupo_oid`,`teste`) VALUES (1,'rafael@gmail.com','nova','Rafael Eduardo de Carvalho Pereira','jm.jpg?field=page10.fld38',42.71384201504933,-5.354429687499987,54.29017450293639,10.026429687500013,'rafael',1,'upload/images/1/jm.jpg');
INSERT INTO `utilizador` (`oid`,`email`,`password`,`nome`,`foto`,`lat`,`lon`,`lat2`,`lon2`,`username`,`grupo_oid`,`teste`) VALUES (2,'admin@eventhis.com','1234567','Natal Oliveira','http://www.google.pt/ola.jpg',0,0,100,100,'admin',2,'upload/images/1/IMG20110905_001.jpg');
INSERT INTO `utilizador` (`oid`,`email`,`password`,`nome`,`foto`,`lat`,`lon`,`lat2`,`lon2`,`username`,`grupo_oid`,`teste`) VALUES (3,'la@gmail.com','12345','Luis Araujo','http://multimedia.fnac.pt/multimedia/PT/images_produits/PT/grandes150/4/5/8/4044156023854.gif',0,0,100,100,'lala',1,'upload/images/1/IMG20110905_001.jpg');
INSERT INTO `utilizador` (`oid`,`email`,`password`,`nome`,`foto`,`lat`,`lon`,`lat2`,`lon2`,`username`,`grupo_oid`,`teste`) VALUES (4,'antonio@gmail.com','nova','António Carvalho','http://cdn1.iconfinder.com/data/icons/softwaredemo/PNG/256x256/DrawingPin1_Blue.png',40.824948183814335,-8.73284912109375,41.65107744417234,-7.77154541015625,'antonio',1,'upload/images/1/IMG20110905_001.jpg');
INSERT INTO `utilizador` (`oid`,`email`,`password`,`nome`,`foto`,`lat`,`lon`,`lat2`,`lon2`,`username`,`grupo_oid`,`teste`) VALUES (6,'omnimonmaster@hotmail.com','ruilei','rui pereira','http://www.g-volutiondance.com/Images/GV08home.jpg',34.044373582597856,-15.67071533203125,47.30225321039508,-0.28985595703125,'states',1,'upload/images/1/IMG20110905_001.jpg');
INSERT INTO `utilizador` (`oid`,`email`,`password`,`nome`,`foto`,`lat`,`lon`,`lat2`,`lon2`,`username`,`grupo_oid`,`teste`) VALUES (7,'rui@gmail.com','ruirui','Rui Pereira','http://multimedia.fnac.pt/multimedia/PT/images_produits/PT/grandes150/4/5/8/4044156023854.gif',40.21319374398207,-8.67242431640625,41.87029512726479,-6.74981689453125,'ruipapa',1,'upload/images/1/IMG20110905_001.jpg');
INSERT INTO `utilizador` (`oid`,`email`,`password`,`nome`,`foto`,`lat`,`lon`,`lat2`,`lon2`,`username`,`grupo_oid`,`teste`) VALUES (8,'luis.5.aa@hotmail.com','luis','Luis','http://data.whicdn.com/images/16658538/405194_460s_v1_thumb.jpg',34.044373582597856,-15.67071533203125,47.30225321039508,-0.28985595703125,'luis',1,'upload/images/1/IMG20110905_001.jpg');

-- tipos de eventos

INSERT INTO `tipo` (`idtipo`,`nome`) VALUES (1,'regional');
INSERT INTO `tipo` (`idtipo`,`nome`) VALUES (2,'desportivo');
INSERT INTO `tipo` (`idtipo`,`nome`) VALUES (3,'religioso');
INSERT INTO `tipo` (`idtipo`,`nome`) VALUES (4,'festivo');
INSERT INTO `tipo` (`idtipo`,`nome`) VALUES (5,'astronómico');
INSERT INTO `tipo` (`idtipo`,`nome`) VALUES (6,'político');
INSERT INTO `tipo` (`idtipo`,`nome`) VALUES (7,'artístico');
INSERT INTO `tipo` (`idtipo`,`nome`) VALUES (8,'feiras');

-- eventos para exemplo

INSERT INTO `evento` (`idevento`,`dtfim`,`dtinicio`,`titulo`,`descricao`,`lat`,`lon`,`proxnewsletter`,`tipo_idtipo`,`utilizador_oid`) VALUES (1,'19:44:25','19:44:27','Festa da Nossa Senhora','A realizar em Salamonde Vieira do Minho.',41.10385002812584,-8.3251953125,'0',4,1);
INSERT INTO `evento` (`idevento`,`dtfim`,`dtinicio`,`titulo`,`descricao`,`lat`,`lon`,`proxnewsletter`,`tipo_idtipo`,`utilizador_oid`) VALUES (9,'09:30:00','09:30:00','Festa do Além Mar','Festa com muita dança e companheirismo a realizar na Georgia.',42.3868351423178,41.61202636718747,'0',4,1);
INSERT INTO `evento` (`idevento`,`dtfim`,`dtinicio`,`titulo`,`descricao`,`lat`,`lon`,`proxnewsletter`,`tipo_idtipo`,`utilizador_oid`) VALUES (5,'23:27:55','23:27:51','Feira em Honra de Nossa Senhora','Nesta feira serrá possível comprar de tudo inclusive computadores e latas de conserva.',41.54439989652676,-8.433385848999023,'0',3,1);
