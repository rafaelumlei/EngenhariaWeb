/*==============================================================*/
/* Database name:  EVENTOS                                      */
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     21-11-2011 18:19:22                          */
/*==============================================================*/


drop database if exists EVENTOS;

/*==============================================================*/
/* Database: EVENTOS                                            */
/*==============================================================*/
create database EVENTOS;

use EVENTOS;

/*==============================================================*/
/* Table: COMENTARIOS                                           */
/*==============================================================*/
create table COMENTARIOS
(
   IDCOMENTARIO         int not null,
   IDUTILIZADOR         int not null,
   IDEVENTO             int not null,
   TITULO               text not null,
   TEXT                 text not null,
   DATEHORA             datetime not null,
   primary key (IDCOMENTARIO)
);

/*==============================================================*/
/* Table: EVENTOS                                               */
/*==============================================================*/
create table EVENTOS
(
   IDEVENTO             int not null,
   IDTIPO               int not null,
   IDUTILIZADOR         int not null,
   TITULO               text not null,
   DESCRICAO            text not null,
   DATAHORAFIM          datetime not null,
   DATAHORAINICIO       datetime not null,
   GPSLAT               float not null,
   GPSLON               float not null,
   CONFIRMARDO          bool not null,
   STRCONF              char(50) not null,
   primary key (IDEVENTO)
);

/*==============================================================*/
/* Table: EVENTOSNEWSLETTER                                     */
/*==============================================================*/
create table EVENTOSNEWSLETTER
(
   IDPROXNEWSLWTTER     int not null,
   IDEVENTO             int not null,
   IDNEWSLETTER         int not null,
   primary key (IDPROXNEWSLWTTER)
);

/*==============================================================*/
/* Table: FAVORITOS                                             */
/*==============================================================*/
create table FAVORITOS
(
   IDFAVORITO           int not null,
   IDUTILIZADOR         int not null,
   IDEVENTO             int not null,
   DATAHORA             datetime not null,
   primary key (IDFAVORITO)
);

/*==============================================================*/
/* Table: LOGINS                                                */
/*==============================================================*/
create table LOGINS
(
   IDLOGIN              int not null,
   IDUTILIZADOR         int not null,
   STRSESSAO            char(50) not null,
   EXPIRE               datetime not null,
   COOKIE               bool not null,
   primary key (IDLOGIN)
);

/*==============================================================*/
/* Table: NEWSLETTER                                            */
/*==============================================================*/
create table NEWSLETTER
(
   IDNEWSLETTER         int not null,
   TITULO               text not null,
   DATAHORA             datetime not null,
   primary key (IDNEWSLETTER)
);

/*==============================================================*/
/* Table: TIPOS                                                 */
/*==============================================================*/
create table TIPOS
(
   IDTIPO               int not null,
   NOME                 char(60),
   primary key (IDTIPO)
);

/*==============================================================*/
/* Table: UTILIZADORES                                          */
/*==============================================================*/
create table UTILIZADORES
(
   IDUTILIZADOR         int not null,
   NOME                 char(60),
   EMAIL                char(256) not null,
   FOTO                 text,
   GPSLAT               float not null,
   GPSLON               float not null,
   HPASSWORD            char(25) not null,
   CRIADO               datetime not null,
   primary key (IDUTILIZADOR)
);

alter table COMENTARIOS add constraint FK_EVETOSSAOCOMENTADOS foreign key (IDEVENTO)
      references EVENTOS (IDEVENTO) on delete restrict on update restrict;

alter table COMENTARIOS add constraint FK_UTILIZADORESCREVECOMENTARIO foreign key (IDUTILIZADOR)
      references UTILIZADORES (IDUTILIZADOR) on delete restrict on update restrict;

alter table EVENTOS add constraint FK_EVENTOTEMTIPO foreign key (IDTIPO)
      references TIPOS (IDTIPO) on delete restrict on update restrict;

alter table EVENTOS add constraint FK_UTILIZADORCRIAEVENTOS foreign key (IDUTILIZADOR)
      references UTILIZADORES (IDUTILIZADOR) on delete restrict on update restrict;

alter table EVENTOSNEWSLETTER add constraint FK_EVENTOSPUBLICITADOSNEWSLETTER foreign key (IDEVENTO)
      references EVENTOS (IDEVENTO) on delete restrict on update restrict;

alter table EVENTOSNEWSLETTER add constraint FK_NEWSLETTERTEMEVENTOS foreign key (IDNEWSLETTER)
      references NEWSLETTER (IDNEWSLETTER) on delete restrict on update restrict;

alter table FAVORITOS add constraint FK_EVENTOSSAOMARCADOS foreign key (IDEVENTO)
      references EVENTOS (IDEVENTO) on delete restrict on update restrict;

alter table FAVORITOS add constraint FK_UTILIZADORTEMFAVORITOS foreign key (IDUTILIZADOR)
      references UTILIZADORES (IDUTILIZADOR) on delete restrict on update restrict;

alter table LOGINS add constraint FK_UTILIZADORESLOGINS foreign key (IDUTILIZADOR)
      references UTILIZADORES (IDUTILIZADOR) on delete restrict on update restrict;

