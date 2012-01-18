-- Group [Group]
create table `group` (
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


-- User [User]
create table `user` (
   `oid`  integer  not null,
   `username`  varchar(255),
   `password`  varchar(255),
   `email`  varchar(255),
  primary key (`oid`)
);


-- Newsletter [ent1]
create table `newsletter` (
   `titulo`  varchar(255),
   `dtenvio`  time,
   `nr`  integer  not null,
  primary key (`nr`)
);


-- Tipo [ent2]
create table `tipo` (
   `idtipo`  integer  not null,
   `nome`  varchar(255),
  primary key (`idtipo`)
);


-- Utilizador [ent3]
create table `utilizador` (
   `iduser`  integer  not null,
   `email`  varchar(255),
   `nome`  varchar(255),
   `hpassword`  varchar(255),
   `lat`  double precision,
   `lon`  double precision,
   `foto`  varchar(255),
  primary key (`iduser`)
);


-- Comentario [ent4]
create table `comentario` (
   `idcomentario`  integer  not null,
   `titulo`  varchar(255),
   `texto`  varchar(255),
   `dtcom`  time,
  primary key (`idcomentario`)
);


-- Evento [ent5]
create table `evento` (
   `idevento`  integer  not null,
   `dtfim`  time,
   `dtinicio`  time,
   `titulo`  varchar(255),
   `descricao`  varchar(255),
   `lat`  double precision,
   `lon`  double precision,
  primary key (`idevento`)
);


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table `group`  add column  `module_oid`  integer;
alter table `group`   add index fk_group_module (`module_oid`), add constraint fk_group_module foreign key (`module_oid`) references `module` (`oid`);


-- Group_Module [Group2Module_Module2Group]
create table `group_module` (
   `group_oid`  integer not null,
   `module_oid`  integer not null,
  primary key (`group_oid`, `module_oid`)
);
alter table `group_module`   add index fk_group_module_group (`group_oid`), add constraint fk_group_module_group foreign key (`group_oid`) references `group` (`oid`);
alter table `group_module`   add index fk_group_module_module (`module_oid`), add constraint fk_group_module_module foreign key (`module_oid`) references `module` (`oid`);


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table `user`  add column  `group_oid`  integer;
alter table `user`   add index fk_user_group (`group_oid`), add constraint fk_user_group foreign key (`group_oid`) references `group` (`oid`);


-- User_Group [User2Group_Group2User]
create table `user_group` (
   `user_oid`  integer not null,
   `group_oid`  integer not null,
  primary key (`user_oid`, `group_oid`)
);
alter table `user_group`   add index fk_user_group_user (`user_oid`), add constraint fk_user_group_user foreign key (`user_oid`) references `user` (`oid`);
alter table `user_group`   add index fk_user_group_group (`group_oid`), add constraint fk_user_group_group foreign key (`group_oid`) references `group` (`oid`);


-- Tipo_Evento [rel1]
alter table `evento`  add column  `tipo_idtipo`  integer;
alter table `evento`   add index fk_evento_tipo (`tipo_idtipo`), add constraint fk_evento_tipo foreign key (`tipo_idtipo`) references `tipo` (`idtipo`);


-- Utilizador_Comentario [rel2]
alter table `comentario`  add column  `utilizador_iduser`  integer;
alter table `comentario`   add index fk_comentario_utilizador (`utilizador_iduser`), add constraint fk_comentario_utilizador foreign key (`utilizador_iduser`) references `utilizador` (`iduser`);


-- Evento_Comentario [rel3]
alter table `comentario`  add column  `evento_idevento`  integer;
alter table `comentario`   add index fk_comentario_evento (`evento_idevento`), add constraint fk_comentario_evento foreign key (`evento_idevento`) references `evento` (`idevento`);


-- Utilizador_Evento [rel4]
alter table `evento`  add column  `utilizador_iduser`  integer;
alter table `evento`   add index fk_evento_utilizador (`utilizador_iduser`), add constraint fk_evento_utilizador foreign key (`utilizador_iduser`) references `utilizador` (`iduser`);


-- Utilizador_Evento_2 [rel6]
create table `utilizador_evento_2` (
   `utilizador_iduser`  integer not null,
   `evento_idevento`  integer not null,
  primary key (`utilizador_iduser`, `evento_idevento`)
);
alter table `utilizador_evento_2`   add index fk_utilizador_evento_2_utiliza (`utilizador_iduser`), add constraint fk_utilizador_evento_2_utiliza foreign key (`utilizador_iduser`) references `utilizador` (`iduser`);
alter table `utilizador_evento_2`   add index fk_utilizador_evento_2_evento (`evento_idevento`), add constraint fk_utilizador_evento_2_evento foreign key (`evento_idevento`) references `evento` (`idevento`);


-- Newsletter_Evento [rel7]
create table `newsletter_evento` (
   `newsletter_nr`  integer not null,
   `evento_idevento`  integer not null,
  primary key (`newsletter_nr`, `evento_idevento`)
);
alter table `newsletter_evento`   add index fk_newsletter_evento_newslette (`newsletter_nr`), add constraint fk_newsletter_evento_newslette foreign key (`newsletter_nr`) references `newsletter` (`nr`);
alter table `newsletter_evento`   add index fk_newsletter_evento_evento (`evento_idevento`), add constraint fk_newsletter_evento_evento foreign key (`evento_idevento`) references `evento` (`idevento`);


