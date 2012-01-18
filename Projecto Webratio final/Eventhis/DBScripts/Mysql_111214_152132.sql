-- Grupo [Group]
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


-- Utilizador [User]
create table `user` (
   `oid`  integer  not null,
   `email`  varchar(255),
   `password`  varchar(255),
   `nome`  varchar(255),
   `foto`  varchar(255),
   `lat`  double precision,
   `lon`  double precision,
   `foto`  varchar(255),
   `username`  varchar(255),
  primary key (`oid`)
);


-- Newsletter [ent1]
create table `newsletter` (
   `nr`  integer  not null,
   `titulo`  varchar(255),
   `dtenvio`  time,
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
   `proxnewsletter`  bit,
  primary key (`idevento`)
);


-- Login [ent6]
create table `login` (
   `idlogin`  integer  not null,
   `datelogin`  varchar(255),
   `cookie`  bit,
   `expdate`  varchar(255),
   `stringsessao`  varchar(255),
  primary key (`idlogin`)
);


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table `group`  add column  `module_oid`  integer;
alter table `group`   add index fk_group_module (`module_oid`), add constraint fk_group_module foreign key (`module_oid`) references `module` (`oid`);
create index `idx_group_module` on `group`(`module_oid`);


-- Group_Module [Group2Module_Module2Group]
create table `group_module` (
   `group_oid`  integer not null,
   `module_oid`  integer not null,
  primary key (`group_oid`, `module_oid`)
);
alter table `group_module`   add index fk_group_module_group (`group_oid`), add constraint fk_group_module_group foreign key (`group_oid`) references `group` (`oid`);
alter table `group_module`   add index fk_group_module_module (`module_oid`), add constraint fk_group_module_module foreign key (`module_oid`) references `module` (`oid`);
create index `idx_group_module_group` on `group_module`(`group_oid`);
create index `idx_group_module_module` on `group_module`(`module_oid`);


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table `user`  add column  `group_oid`  integer;
alter table `user`   add index fk_user_group (`group_oid`), add constraint fk_user_group foreign key (`group_oid`) references `group` (`oid`);
create index `idx_user_group` on `user`(`group_oid`);


-- User_Group [User2Group_Group2User]
create table `user_group` (
   `user_oid`  integer not null,
   `group_oid`  integer not null,
  primary key (`user_oid`, `group_oid`)
);
alter table `user_group`   add index fk_user_group_user (`user_oid`), add constraint fk_user_group_user foreign key (`user_oid`) references `user` (`oid`);
alter table `user_group`   add index fk_user_group_group (`group_oid`), add constraint fk_user_group_group foreign key (`group_oid`) references `group` (`oid`);
create index `idx_user_group_user` on `user_group`(`user_oid`);
create index `idx_user_group_group` on `user_group`(`group_oid`);


-- Tipo_Evento [rel1]
alter table `evento`  add column  `tipo_idtipo`  integer;
alter table `evento`   add index fk_evento_tipo (`tipo_idtipo`), add constraint fk_evento_tipo foreign key (`tipo_idtipo`) references `tipo` (`idtipo`);
create index `idx_evento_tipo` on `evento`(`tipo_idtipo`);


-- Utilizador_Comentario [rel2]
alter table `comentario`   add index fk_comentario_user (), add constraint fk_comentario_user foreign key () references `user` ();
create index `idx_comentario_user` on `comentario`();


-- Evento_Comentario [rel3]
alter table `comentario`  add column  `evento_idevento`  integer;
alter table `comentario`   add index fk_comentario_evento (`evento_idevento`), add constraint fk_comentario_evento foreign key (`evento_idevento`) references `evento` (`idevento`);
create index `idx_comentario_evento` on `comentario`(`evento_idevento`);


-- Utilizador_Evento [rel4]
alter table `evento`   add index fk_evento_user (), add constraint fk_evento_user foreign key () references `user` ();
create index `idx_evento_user` on `evento`();


-- Utilizador_Login [rel5]
alter table `login`  add column  `user_oid`  integer;
alter table `login`   add index fk_login_user (`user_oid`), add constraint fk_login_user foreign key (`user_oid`) references `user` (`oid`);
create index `idx_login_user` on `login`(`user_oid`);


-- Favoritos [rel6]
create table `utilizador_evento_2` (
   `evento_idevento`  integer not null,
  primary key (`evento_idevento`)
);
alter table `utilizador_evento_2`   add index fk_utilizador_evento_2_user (), add constraint fk_utilizador_evento_2_user foreign key () references `user` ();
alter table `utilizador_evento_2`   add index fk_utilizador_evento_2_evento (`evento_idevento`), add constraint fk_utilizador_evento_2_evento foreign key (`evento_idevento`) references `evento` (`idevento`);
create index `idx_utilizador_evento_2_user` on `utilizador_evento_2`();
create index `idx_utilizador_evento_2_evento` on `utilizador_evento_2`(`evento_idevento`);


-- Newsletter_Evento [rel7]
alter table `newsletter`  add column  `evento_idevento`  integer;
alter table `newsletter_evento`   add index fk_newsletter_evento (`evento_idevento`), add constraint fk_newsletter_evento foreign key (`evento_idevento`) references `evento` (`idevento`);
create index `idx_newsletter_evento` on `newsletter_evento`(`evento_idevento`);


