
           MANUAL DE INSTALA��O E UTLIZA��O DO MONITORA_DB PARA ORACLE8
           ============================================================


1 - Criar a pasta \monitora_cpm onde ser�o armazenados os scripts de sele��o dos dados no 
Oracle8. Pode ser criado com qualquer nome, no entanto usaremos uma configura��o default
para a instala��o.

2 - Copiar o monitora_db 8.zip e o readme_Monitora_DB_8 para a pasta \monitora_cpm.

3 - Descompactar o monitora_db 8.zip. Ele criar� as pastas e os arquivos necess�rios para a
utiliza��o do Monitora_DB.

4 - Alterar o nome da pasta <instance> para o nome da inst�ncia que venha a utilizar o
Monitora_DB.

5 - Alterar as propriedades dos arquivos de atalhos do sqlplus (users,performance,objects)
que est�o na pasta \monitora_cpm\mondb_v1.1_8\<instance> da op��o "Objeto", de acordo com o
diret�rio e usu�rio de acesso ao Banco. 
Alterar tamb�m o item "Iniciar em:" para o diret�rio de instala��o, 
c:\monitora_cpm\mondb_v1.1_8\<instance>.

6 - Para gerar os dados dos grupos de Users, Performance ou Objects, basta executar os 
atalhos de um dos itens. Ele ir� pedir a senha do usu�rio que foi configurado na 
"Propriedades" dos atalhos e que tenha acesso ao Dicion�rio de Dados. 

7 - Para consultar os dados selecionados na op��o 5, executar os arquivos .html 
Navigate - Users, Navigate - Performance ou Navigate - Objects. Se precisar consultar 
dados mais recentes, dever�o ser executados novamente a op��o 5 de um dos grupos.

8 - Se houver mais de 1 inst�ncia a utilizar o Monitora_DB, basta criar uma pasta com o 
nome dessa nova inst�ncia e copiar a pasta \<instance> e seus arquivos e subdiret�rios,
abaixo das pastas \monitora_cpm\mondb_v1.1_8. Em seguida, remover todos os arquivos do 
\monitora_cpm\mondb_v1.1_8\<instance_nova>\output, exceto o arquivo footer.js. N�o esquecer
de alterar as propriedades dos arquivos de atalhos do sqlplus (users,performance,objects),
para a configura��o da nova instance.







