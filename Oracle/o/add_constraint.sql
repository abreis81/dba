/*
  script:   add_constraint.sql
  objetivo: adicionar uma constraint e storage para tabela
  autor:    Josivan
  data:     

  DEFERRABLE CONSTRAINTS
  ----------------------

  uma constraints a partir de oracle 8 pode ter a sua validacao adiada para o
  momento em que eh feito COMMIT. as constraints que possuem esta capacidade 
  dizem-se ADIADAS ( deferrable ), em oposicao as restricoes imediatas do oracle 7
  o melhor de tudo eh o fato das restricoes adiadas poderem se comportar como
  restricoes imediatas, consoante a definicao do seu comportamento inicial.
  existem dois tipos de restricoes adiadas:

  inicialmente imediatas
  inicialmente adiadas

  as restricoes adiadas que sao inicialmente imediatas comportam-se sempre como as
  restricoes do oracle 7, mas se no inicio da transacao for emitido um dos seguintes
  comandos abaixo, entao so no fim da transacao eh que sera forcada a sua validacao
  ( ficarao adiadas )

  SET CONSTRAINTS ALL DEFERRED;                - todas as validacoes das consistencias serao feitas apos o COMMIT
  SET CONSTRAINTS <nome_constraints> DEFERRED; - a constraint sera validada apos o COMMIT
  ALTER SESSION SET CONSTRAINTS = DEFERRED;    - alter o comportamento da sessao e todas as constraints serao validadas apos o COMMIT


  as restricoes adiadas que sao inicialmente adiadas comportam-se sempre como tal, se desejar
  o seu comportamento seja imediato numa determinada transacao, entao deve emitir o comando.

  SET CONSTRAINT <nome_constraint> immediate;

  exemplo de tabelas:

  create table divisa
  ( codigo      varchar2(3)
   ,descr       varchar2(30)
   ,constraint pk_divisa primary key (codigo)
    deferrable initially immediate );

  create table socio
  ( codigo       number
   ,nome         varchar2(80)
   ,divisa       varchar2(3)
   ,sexo         varchar2(1)
   ,constraint pk_socio primary key (codigo)
   ,constraint fk_socio_divisa foreign key(divisa) references divisa(codigo)
   deferrable initially deferred );

  se for inserido um registro na tabela socio sem correspondente na tabela divisa
  nao havera problemas visto que so no final apos o commit sera feito a validacao
  desta regra (FK).


  ENABLE NOVALIDATE
  -----------------
 
  em oracle 8 existe a hipotese de ativar uma restricao sem que os dados ja existentes
  na tabela sejam validados, mas no entanto todos os dados inseridos depois da
  ativacao vao passar a ser validados. para esta operacao ser efetuada com sucesso eh
  necessario existir um indice nao unico definido sobre as colunas que definem a chave
  primaria.

  ALTER TABLE TRANS_ABAST ENABLE NOVALIDATE CONSTRAINT pk_trans_abast;

*/

alter table galpdba.trans_abast
add constraint pk_trans_abast primary key( idt_trans_abast )
storage( initial 800k
       minextent 20
            next 800k
     pctincrease 0 )
/


alter table JET.TT528_AV_SET_LOCAL
  add( constraint PK_TT528_AV_SET_LOCAL primary key( DATA_VIAGEM
                                                    ,EMPRESA_AEREA
                                                    ,NATUREZA_VOO
                                                    ,LINHA
                                                    ,VERSAO_VOO
                                                    ,ORIGEM
                                                    ,DESTINO )
              storage ( initial 20m
                        next 500k
                        pctincrease 0 )
  tablespace ts_jet_index01 )
/

alter table funcionario
add constraint pk_funcionario primary key( codigo )
/

alter table funcionario
add constraint fk_funcionario_uf foreign key(uf) references estado(codigo)
/

alter table funcionario
add constraint fk_funcionario_dep foreign key(dep) references departamento(codigo)
/

ALTER TABLE TRANS_ABAST ENABLE NOVALIDATE CONSTRAINT
ADD CONSTRAINT FK_TRANS_TALAO_LEITU FOREIGN KEY(NUM_TALAO_LEITU_TRANS)
REFERENCES TALAO_LEITU(NUM_TALAO_LEITU)
/

alter table trans_abast
disable constraint pk........
/
