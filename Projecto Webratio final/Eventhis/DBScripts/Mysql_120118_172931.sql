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


-- Newsletter_Evento [rel7]
alter table `newsletter`  add column  `evento_idevento`  integer;
alter table `newsletter`   add index fk_newsletter_evento (`evento_idevento`), add constraint fk_newsletter_evento foreign key (`evento_idevento`) references `evento` (`idevento`);
create index `idx_newsletter_evento` on `newsletter`(`evento_idevento`);


