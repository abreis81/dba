CRS RESOURCE ADMINISTRATION

---------------------------

 

You can use srvctl to manage these resources.  Below are syntax and examples.

 

-------------------------------------------------------------------------------

 

CRS RESOURCE STATUS

 

srvctl status database -d <database-name> [-f] [-v] [-S <level>]

srvctl status instance -d <database-name> -i <instance-name> >[,<instance-name-list>] 

       [-f] [-v] [-S <level>]

srvctl status service -d <database-name> -s <service-name>[,<service-name-list>] 

       [-f] [-v] [-S <level>]

srvctl status nodeapps [-n <node-name>]

srvctl status asm -n <node_name>

 

EXAMPLES:

 

Status of the database, all instances and all services.  

        srvctl status database -d ORACLE -v

Status of named instances with their current services.  

        srvctl status instance  -d ORACLE -i RAC01, RAC02 -v

Status of a named services.

        srvctl status service -d ORACLE -s ERP  -v

Status of all nodes supporting database applications.

        srvctl status node

 

-------------------------------------------------------------------------------

 

START CRS RESOURCES

 

srvctl start database -d <database-name> [-o < start-options>] 

       [-c <connect-string> | -q]

srvctl start instance -d <database-name> -i <instance-name> 

       [,<instance-name-list>] [-o <start-options>] [-c <connect-string> | -q]

srvctl start service -d <database-name> [-s <service-name>[,<service-name-list>]] 

       [-i <instance-name>]  [-o <start-options>] [-c <connect-string> | -q]

srvctl start nodeapps -n <node-name>

srvctl start asm -n <node_name> [-i <asm_inst_name>] [-o <start_options>]

 

EXAMPLES:

 

Start the database with all enabled instances.  

        srvctl start database -d ORACLE

Start named instances.  

        srvctl start instance  -d ORACLE -i RAC03, RAC04

Start named services.  Dependent instances are started as needed.

        srvctl start service -d ORACLE -s CRM

Start a service at the named instance.

        srvctl start  service -d ORACLE -s CRM -i RAC04

Start node applications.

        srvctl start  nodeapps -n myclust-4

 

-------------------------------------------------------------------------------

 

STOP CRS RESOURCES

 

srvctl stop database -d <database-name> [-o <stop-options>]  

       [-c <connect-string> | -q]

srvctl stop instance -d <database-name> -i <instance-name> [,<instance-name-list>] 

       [-o <stop-options>][-c <connect-string> | -q]

srvctl stop service -d <database-name> [-s <service-name>[,<service-name-list>]] 

       [-i <instance-name>][-c <connect-string> | -q] [-f]

srvctl stop nodeapps -n <node-name>

srvctl stop asm -n <node_name> [-i <asm_inst_name>] [-o <start_options>]

 

EXAMPLES:

 

Stop the database, all instances and all services.  

        srvctl stop database -d ORACLE

Stop named instances, first relocating all existing services.  

        srvctl stop instance  -d ORACLE -i RAC03,RAC04

Stop the service.

        srvctl stop service -d ORACLE -s CRM

Stop the service at the named instances.  

        srvctl stop  service -d ORACLE -s CRM -i RAC04

Stop node applications.  Note that instances and services also stop.

        srvctl stop  nodeapps -n myclust-4

 

-------------------------------------------------------------------------------

 

ADD CRS RESOURCES

 

srvctl add database -d <name> -o <oracle_home> [-m <domain_name>] [-p <spfile>] 

       [-A <name|ip>/netmask] [-r {PRIMARY | PHYSICAL_STANDBY | LOGICAL_STANDBY}] 

       [-s <start_options>] [-n <db_name>]

srvctl add instance -d <name> -i <inst_name> -n <node_name>

srvctl add service -d <name> -s <service_name> -r <preferred_list> 

       [-a <available_list>] [-P <TAF_policy>] [-u]

srvctl add nodeapps -n <node_name> -o <oracle_home> 

       [-A <name|ip>/netmask[/if1[|if2|...]]]

srvctl add asm -n <node_name> -i <asm_inst_name> -o <oracle_home>

 

OPTIONS:

 

-A      vip range, node, and database, address specification. The format of 

        address string is:

        [<logical host name>]/<VIP address>/<net mask>[/<host interface1[ | 

        host interface2 |..]>] [,] [<logical host name>]/<VIP address>/<net mask>

        [/<host interface1[ | host interface2 |..]>] 

-a      for services, list of available instances, this list cannot include 

        preferred instances

-m      domain name with the format “us.mydomain.com”

-n      node name that will support one or more instances

-o      $ORACLE_HOME to locate Oracle binaries

-P      for services, TAF preconnect policy - NONE, PRECONNECT

-r      for services, list of preferred instances, this list cannot include 

        available instances.

-s      spfile name

-u      updates the preferred or available list for the service to support the 

        specified instance. Only one instance may be specified with the -u 

        switch.  Instances that already support the service should not be 

        included.

 

EXAMPLES:

 

Add a new node:

        srvctl add nodeapps -n myclust-1 -o $ORACLE_HOME  –A  

        139.184.201.1/255.255.255.0/hme0

Add a new database.  

        srvctl add  database  -d ORACLE -o $ORACLE_HOME

Add named instances to an existing database.  

        srvctl add instance -d ORACLE -i RAC01 -n myclust-1

        srvctl add instance -d ORACLE -i RAC02 -n myclust-2

        srvctl add instance -d ORACLE -i RAC03 -n myclust-3

Add a service to an existing database with preferred instances (-r) and 

available instances (-a).  Use basic failover to the available instances.

        srvctl add service -d ORACLE -s STD_BATCH -r RAC01,RAC02 -a RAC03,RAC04

Add a service to an existing database with preferred instances in list one and 

available instances in list two. Use preconnect at the available instances.

        srvctl add service -d ORACLE -s STD_BATCH -r RAC01,RAC02 -a RAC03,RAC04  -P PRECONNECT

 

-------------------------------------------------------------------------------

 

REMOVE CRS RESOURCES

 

srvctl remove database -d <database-name>  

srvctl remove instance  -d <database-name> [-i <instance-name>] 

srvctl remove service -d <database-name> -s <service-name> [-i <instance-name>]  

srvctl remove nodeapps -n <node-name> 

 

EXAMPLES:

 

Remove the applications for a database.  

        srvctl remove database  -d ORACLE 

Remove the applications for named instances of an existing database.  

        srvctl remove instance -d ORACLE -i  RAC03 

        srvctl remove instance -d ORACLE -i  RAC04 

Remove the service.

        srvctl remove  service -d ORACLE -s STD_BATCH

Remove the service from the instances.

        srvctl remove  service  -d ORACLE -s STD_BATCH -i RAC03,RAC04

Remove all node applications from a node.

        srvctl remove  nodeapps -n myclust-4

 

-------------------------------------------------------------------------------

 

MODIFY CRS RESOURCES

 

srvctl modify database -d <name> [-n <db_name] [-o <ohome>] [-m <domain>] 

       [-p <spfile>]  [-r {PRIMARY | PHYSICAL_STANDBY | LOGICAL_STANDBY}] 

       [-s <start_options>]

srvctl modify instance -d <database-name> -i <instance-name> -n <node-name>

srvctl modify instance -d <name> -i <inst_name> {-s <asm_inst_name> | -r}

srvctl modify service -d <database-name> -s <service_name> -i <instance-name> 

       -t <instance-name> [-f]

srvctl modify service -d <database-name> -s <service_name> -i <instance-name> 

       -r  [-f]

srvctl modify nodeapps -n <node-name> [-A <address-description> ] [-x]

 

OPTIONS:

 

-i <instance-name> -t <instance-name>  the instance name (-i) is replaced by the 

   instance name (-t)

-i <instance-name> -r the named instance is modified to be a preferred instance

-A address-list for VIP application, at node level

-s <asm_inst_name> add or remove ASM dependency

 

EXAMPLES:

 

Modify an instance to execute on another node.

        srvctl modify  instance  -d ORACLE  -n myclust-4

Modify a service to execute on another node.

        srvctl modify service -d ORACLE  -s HOT_BATCH -i  RAC01 -t RAC02

Modify an instance to be a preferred instance for a service.

        srvctl modify service -d ORACLE  -s HOT_BATCH -i  RAC02 –r

 

-------------------------------------------------------------------------------

 

RELOCATE SERVICES

 

srvctl relocate service -d <database-name> -s <service-name> [-i <instance-name >]-t<instance-name > [-f]

 

EXAMPLES:

 

Relocate a service from one instance to another

        srvctl relocate  service -d ORACLE -s CRM -i RAC04 -t RAC01

 

-------------------------------------------------------------------------------

 

ENABLE CRS RESOURCES (The resource may be up or down to use this function)

 

srvctl enable database -d <database-name>

srvctl enable instance -d <database-name> -i <instance-name> [,<instance-name-list>] 

srvctl enable service -d <database-name> -s <service-name>] [, <service-name-list>] [-i <instance-name>]  

 

EXAMPLES:

 

Enable the database.  

        srvctl enable database -d ORACLE

Enable the named instances.  

        srvctl enable instance  -d ORACLE -i RAC01, RAC02

Enable the service.  

        srvctl enable  service -d ORACLE -s ERP,CRM

Enable the service at the named instance.

        srvctl enable  service -d ORACLE -s CRM -i RAC03

 

-------------------------------------------------------------------------------

 

DISABLE CRS RESOURCES (The resource must be down to use this function)

 

srvctl disable database -d <database-name>

srvctl disable instance -d <database-name> -i <instance-name> [,<instance-name-list>] 

srvctl disable service -d <database-name> -s <service-name>] [,<service-name-list>] [-i <instance-name>]  

 

EXAMPLES:

 

Disable the database globally.  

        srvctl disable database -d ORACLE

Disable the named instances.  

        srvctl disable instance  -d ORACLE -i RAC01, RAC02

Disable the service globally.  

        srvctl disable  service -d ORACLE -s ERP,CRM

Disable the service at the named instance.

        srvctl disable  service -d ORACLE  -s CRM -i RAC03,RAC04

 

-------------------------------------------------------------------------------

 

--------------------------- Begin Shell Script -------------------------------

 

#!/usr/bin/ksh

#

# Sample 10g CRS resource status query script

#

# Description:

#    - Returns formatted version of crs_stat -t, in tabular

#      format, with the complete rsc names and filtering keywords

#   - The argument, $RSC_KEY, is optional and if passed to the script, will

#     limit the output to HA resources whose names match $RSC_KEY.

# Requirements:

#   - $ORA_CRS_HOME should be set in your environment 

 

RSC_KEY=$1

QSTAT=-u

AWK=/usr/xpg4/bin/awk    # if not available use /usr/bin/awk

 

# Table header:echo ""

$AWK \

  'BEGIN {printf "%-45s %-10s %-18s\n", "HA Resource", "Target", "State";

          printf "%-45s %-10s %-18s\n", "-----------", "------", "-----";}'

 

# Table body:

$ORA_CRS_HOME/bin/crs_stat $QSTAT | $AWK \

 'BEGIN { FS="="; state = 0; }

  $1~/NAME/ && $2~/'$RSC_KEY'/ {appname = $2; state=1};

  state == 0 {next;}

  $1~/TARGET/ && state == 1 {apptarget = $2; state=2;}

  $1~/STATE/ && state == 2 {appstate = $2; state=3;}

  state == 3 {printf "%-45s %-10s %-18s\n", appname, apptarget, appstate; state=0;}'

 

--------------------------- End Shell Script -------------------------------

 

Example output:

 

[opcbsol1]/u01/home/usupport> ./crsstat

HA Resource                                   Target     State             

-----------                                   ------     -----             

ora.V10SN.V10SN1.inst                         ONLINE     ONLINE on opcbsol1

ora.V10SN.V10SN2.inst                         ONLINE     ONLINE on opcbsol2         

ora.V10SN.db                                  ONLINE     ONLINE on opcbsol2

ora.opcbsol1.ASM1.asm                         ONLINE     ONLINE on opcbsol1

ora.opcbsol1.LISTENER_OPCBSOL1.lsnr           ONLINE     ONLINE on opcbsol1

ora.opcbsol1.gsd                              ONLINE     ONLINE on opcbsol1

ora.opcbsol1.ons                              ONLINE     ONLINE on opcbsol1

ora.opcbsol1.vip                              ONLINE     ONLINE on opcbsol1

ora.opcbsol2.ASM2.asm                         ONLINE     ONLINE on opcbsol2

ora.opcbsol2.LISTENER_OPCBSOL2.lsnr           ONLINE     ONLINE on opcbsol2

ora.opcbsol2.gsd                              ONLINE     ONLINE on opcbsol2

ora.opcbsol2.ons                              ONLINE     ONLINE on opcbsol2

ora.opcbsol2.vip                              ONLINE     ONLINE on opcbsol2

 
