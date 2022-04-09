
           MANUAL DE INSTALAÇÃO E UTLIZAÇÃO DO MONITORA_DB PARA ORACLE8
           ============================================================


1 - Criar a pasta \monitora_cpm onde serão armazenados os scripts de seleção dos dados no 
Oracle8. Pode ser criado com qualquer nome, no entanto usaremos uma configuração default
para a instalação.

2 - Copiar o monitora_db 8.zip e o readme_Monitora_DB_8 para a pasta \monitora_cpm.

3 - Descompactar o monitora_db 8.zip. Ele criará as pastas e os arquivos necessários para a
utilização do Monitora_DB.

4 - Alterar o nome da pasta <instance> para o nome da instância que venha a utilizar o
Monitora_DB.

5 - Alterar as propriedades dos arquivos de atalhos do sqlplus (users,performance,objects)
que estão na pasta \monitora_cpm\mondb_v1.1_8\<instance> da opção "Objeto", de acordo com o
diretório e usuário de acesso ao Banco. 
Alterar também o item "Iniciar em:" para o diretório de instalação, 
c:\monitora_cpm\mondb_v1.1_8\<instance>.

6 - Para gerar os dados dos grupos de Users, Performance ou Objects, basta executar os 
atalhos de um dos itens. Ele irá pedir a senha do usuário que foi configurado na 
"Propriedades" dos atalhos e que tenha acesso ao Dicionário de Dados. 

7 - Para consultar os dados selecionados na opção 5, executar os arquivos .html 
Navigate - Users, Navigate - Performance ou Navigate - Objects. Se precisar consultar 
dados mais recentes, deverão ser executados novamente a opção 5 de um dos grupos.

8 - Se houver mais de 1 instância a utilizar o Monitora_DB, basta criar uma pasta com o 
nome dessa nova instância e copiar a pasta \<instance> e seus arquivos e subdiretórios,
abaixo das pastas \monitora_cpm\mondb_v1.1_8. Em seguida, remover todos os arquivos do 
\monitora_cpm\mondb_v1.1_8\<instance_nova>\output, exceto o arquivo footer.js. Não esquecer
de alterar as propriedades dos arquivos de atalhos do sqlplus (users,performance,objects),
para a configuração da nova instance.







