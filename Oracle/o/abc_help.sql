/*
+==============================================================================================+
|                      RELACAO DE SCRIPTS PARA ADMINISTRACAO EM ORACLE SERVER                  |
|----------------------------------------------------------------------------------------------|
|SCRIPT                DOS       DESCRICAO                                                     |
|==============================================================================================|
|add_constraint                  adicionar constraints a tabela existente                      |
|add_dblink                      criar um dblink                                               |
|add_grants                      conceder grant de execute sobre objetos do owner              |
|add_index                       criar um indice                                               |
|add_logfile                     adicionar / alterar / dropar / renomear um logfile            |
|add_profile                     criar um profile                                              |
|add_snapshot                    criar um snapshot / snapshot log                              |
|add_synonym                     criar um sinonimo                                             |
|add_tabela                      criar uma tabela e seus indices                               |
|add_tablespace                  criar um tablespace                                           |
|add_users                       criar um usuario                                              |
|alter_objs                      revalidar objetos invalidos                                   |
|alter_tablespace                altera uma tablespace, adicionando datafile e novos storage   |
|analyse_index                   atualizar as tabelas de estatisticas do oracle                |
|analyse_table                   atualizar as tabelas de estatisticas do oracle                |
|backup_hot                      fazer backup quente do banco de dados oracle                  |
|backup_hot2                     fazer backup quente do banco de dados oracle                  |
|calcula_tabela                  calcula necessidades da tabela e seus indices                 |
|constraint_count                conta a qtd de constraint da base de dados                    |
|constraint_table                lista as constraints da tabela                                |
|consulta_dba_geral                                                                            |
|deallocate                      total de blocos e total  bytes, ultimo bloco usado, ultimo    |
|                                extent do datafile usado e outros                             |
|diag_diario                     diagnostico dos segmentos de rollback, espaco na tablespace,  |
|                                tabelas com chain, proximo extent que cabera na tablespace,   |
|                                segmentos de rollback com mais 30 extents alocados,           |
|                                objeto invalido                                               |
|diag_tabela                     atributos  tabelas, primary key, unique key, foreign key,     |
|                                indices                                                       |
|disk_io                         cria uma view sobre v$filestat, estatistica por datafile      |
|                                de pacotes lidos e gravados fisicamente                       |
|dispatcher                                                                                    |
|drop_constraint                 dropa uma constraint na tabela desejada                       |
|explain                         analise do plano de acesso sobre as tabelas do banco, observar|
|                                se o banco esta por: RULE, CHOOSE, FIRST_ROWS                 |
|export_full.par                 parametrizacao para export do banco de dados                  |
|fk_sem_indice                   localiza as foreign sem indice (toda e fk devera te um indice)|
|formata_valor                   funcao para formatacao de valores                             |
|ger_user                        recria o perfil do usuarios com base no dicionario oracle     |
|global_name                     informa a instance em uso                                     |
|grant_procedure                 grant de execute na procedure para o usuario                  |
|grant_sinonimo                  compila objetos, grant, sinonimo                              |
|help_dba.txt                    passo a passo da criacao de um banco e seus objetos           |
|importa_full.par                parametrizacao de import da base de dados                     |
|index_listar                    lista todos os indices da tabela informada                    |
|io                              pacotes lidos e gravados nos datafiles                        |
|jobs                            relacao dos jobs a serem executados                           |
|le_alt                          indica a data/hora ultimo ddl feito sobre o objeto            |
|le_conta                        quantidade de segmentos por tablespace                        |
|limites_oracle                  informacao de limites no oracle                               |
|lst_dep                         lista todas as dependencias do objeto                         |
|lst_df                ls_df     filesystem x datafiles                                        |
|lst_startup           lst_st~1  Data e hora do startup                                        |
|lst_plan_table        lst_pl~1  Listar Plan Table
|lst_tbs_df            lst_tb~1  Tablespace x Filesystem x Datafiles
|lst_prof_user         lst_pr~1  Profiles x Usuarios



prompt lst_role        lst_role  Roles (Role e Tipo)
prompt lst_role_obj    lst_ro~1  Roles x privilegios de Objeto
prompt lst_role_sys    lst_ro~2  Roles x privilegios de Sistema
prompt lst_role_user   lst_ro~3  Role Atribuidas a Usuarios
prompt lst_user        lst_user  Usuarios Oracle (TBS default, temp, profiles)
prompt lst_user_role   lst_us~1  Usuarios x Role Atribuidas
prompt lst_indexes     lst_in~1  Tabela x indices
prompt lst_invalid     lst_in~2  Objetos invalidos
prompt lst_ext         lst_ext   Verificar numero de extensoes por segmento
prompt lst_free        lst_free  Espaco livre, utilizado e total por tablespace
prompt lst_mapa_free   lst_mapa  Mapa de extensoes livres
prompt lst_segs        lst_segs  Informacao sobre segmentos (Table e Index)
prompt
prompt utl_comp        utl_comp  Criar script para compilar objetos
prompt utl_connect     utl_co~1  Forcar conexao com outro username sem senha
prompt
prompt ger_user        ger_user  Criar script de criacao de usuarios

rem *** fim ***



prompt lst_startup     lst_st~1  Data e hora do startup
prompt lst_plan_table  lst_pl~1  Listar Plan Table
prompt lst_df          lst_df    Filesystem x Datafiles
prompt lst_tbs_df      lst_tb~1  Tablespace x Filesystem x Datafiles
prompt lst_prof_user   lst_pr~1  Profiles x Usuarios
prompt lst_role        lst_role  Roles (Role e Tipo)
prompt lst_role_obj    lst_ro~1  Roles x privilegios de Objeto
prompt lst_role_sys    lst_ro~2  Roles x privilegios de Sistema
prompt lst_role_user   lst_ro~3  Role Atribuidas a Usuarios
prompt lst_user        lst_user  Usuarios Oracle (TBS default, temp, profiles)
prompt lst_user_role   lst_us~1  Usuarios x Role Atribuidas
prompt lst_indexes     lst_in~1  Tabela x indices
prompt lst_invalid     lst_in~2  Objetos invalidos
prompt lst_dep         lst_dep   Dependencias de Objetos
prompt lst_ext         lst_ext   Verificar numero de extensoes por segmento
prompt lst_free        lst_free  Espaco livre, utilizado e total por tablespace
prompt lst_mapa_free   lst_mapa  Mapa de extensoes livres
prompt lst_segs        lst_segs  Informacao sobre segmentos (Table e Index)
prompt
prompt utl_comp        utl_comp  Criar script para compilar objetos
prompt utl_connect     utl_co~1  Forcar conexao com outro username sem senha
prompt
prompt ger_user        ger_user  Criar script de criacao de usuarios

rem *** fim ***
