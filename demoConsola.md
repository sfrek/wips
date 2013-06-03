# Primera Máquina

## Tenant y Usuario

* Creamos un proyecto/_tenant_ nuevo __demoUno__:

```
keystone tenant-create --name demoUno
```

```
+-------------+----------------------------------+
|   Property  |              Value               |
+-------------+----------------------------------+
| description |                                  |
|   enabled   |               True               |
|      id     | 14417275b406425ca062a003bd2b0116 |
|     name    |             demoUno              |
+-------------+----------------------------------+
```

* Usuario asociado al _tenant_ anterior, cuyo id en __14417275b406425ca062a003bd2b0116__:

```
keystone user-create --name=tester --pass=tester --tenant-id 14417275b406425ca062a003bd2b0116 --email=tester@wolkit.local
```

```
+----------+----------------------------------+
| Property |              Value               |
+----------+----------------------------------+
|  email   |       tester@wolkit.local        |
| enabled  |               True               |
|    id    | 7aded81efbb24488907550679875b114 |
|   name   |              tester              |
| tenantId | 14417275b406425ca062a003bd2b0116 |
+----------+----------------------------------+
```

* Buscamos el rol que queremos dar al usuario:

```
keystone role-list 
```

```
+----------------------------------+----------------------+
|                id                |         name         |
+----------------------------------+----------------------+
| a189c95578114fba9c32c00d23a3733b |    KeystoneAdmin     |
| 85fb0291ed7b4c9a981d2e476c93f6fb | KeystoneServiceAdmin |
| dea8273611ed4e838287a283c0752584 |        Member        |
| 9fe2ff9ee4384b1894a90878d3e92bab |       _member_       |
| 21953e95fd4d4d989bb0a31b7fe1a460 |        admin         |
+----------------------------------+----------------------+
```

* Le damos el rol de _Member_ ( __dea8273611ed4e838287a283c0752584__ ) al usuario creado:

```
keystone user-role-add --tenant-id 14417275b406425ca062a003bd2b0116 \
--user-id 7aded81efbb24488907550679875b114 \
--role-id dea8273611ed4e838287a283c0752584
``` 

* La sentencia anterior parece haber fallado, así que comprobamos:

```
root@controller01:~# keystone user-role-list --tenant-id 14417275b406425ca062a003bd2b0116 --user-id 7aded81efbb24488907550679875b114
+----------------------------------+----------+----------------------------------+----------------------------------+
|                id                |   name   |             user_id              |            tenant_id             |
+----------------------------------+----------+----------------------------------+----------------------------------+
| dea8273611ed4e838287a283c0752584 |  Member  | 7aded81efbb24488907550679875b114 | 14417275b406425ca062a003bd2b0116 |
+----------------------------------+----------+----------------------------------+----------------------------------+
```

## Red

* Creamos una red para el _tenant_ ( __14417275b406425ca062a003bd2b0116__ )

```
quantum net-create --tenant-id 14417275b406425ca062a003bd2b0116 net_demoUno
```

```
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| id                        | b2ee8892-1630-4efe-8f99-58146b93c23f |
| name                      | net_demoUno                          |
| provider:network_type     | gre                                  |
| provider:physical_network |                                      |
| provider:segmentation_id  | 1                                    |
| router:external           | False                                |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tenant_id                 | 14417275b406425ca062a003bd2b0116     |
+---------------------------+--------------------------------------+
```

* Creamos la _subnet_ ( __192.168.192.0/24__ ) para la red anterior ( __b2ee8892-1630-4efe-8f99-58146b93c23f__ )

```
quantum subnet-create --tenant-id 14417275b406425ca062a003bd2b0116 net_demoUno 192.168.192.0/24
```

```
+------------------+------------------------------------------------------+
| Field            | Value                                                |
+------------------+------------------------------------------------------+
| allocation_pools | {"start": "192.168.192.2", "end": "192.168.192.254"} |
| cidr             | 192.168.192.0/24                                     |
| dns_nameservers  |                                                      |
| enable_dhcp      | True                                                 |
| gateway_ip       | 192.168.192.1                                        |
| host_routes      |                                                      |
| id               | e950ea89-3366-4023-89e5-dcffd63de0f6                 |
| ip_version       | 4                                                    |
| name             |                                                      |
| network_id       | b2ee8892-1630-4efe-8f99-58146b93c23f                 |
| tenant_id        | 14417275b406425ca062a003bd2b0116                     |
+------------------+------------------------------------------------------+
```

* Creamos un router para el _tenant_ ( __14417275b406425ca062a003bd2b0116__ )

```
quantum router-create --tenant-id 14417275b406425ca062a003bd2b0116 router_demoUno
```

```
+-----------------------+--------------------------------------+
| Field                 | Value                                |
+-----------------------+--------------------------------------+
| admin_state_up        | True                                 |
| external_gateway_info |                                      |
| id                    | c7e63eb0-92b7-478f-a70f-d18d29a0e2f2 |
| name                  | router_demoUno                       |
| status                | ACTIVE                               |
| tenant_id             | 14417275b406425ca062a003bd2b0116     |
+-----------------------+--------------------------------------+
```

* Añadimos el _router_ ( ____ ) al _agente l3_ que este _running_

```
quantum agent-list 
```

```
+--------------------------------------+--------------------+------------------------+-------+----------------+
| id                                   | agent_type         | host                   | alive | admin_state_up |
+--------------------------------------+--------------------+------------------------+-------+----------------+
| 1d8522b3-2eb7-445c-9c92-623148c5ae65 | L3 agent           | network01.wolkit.local | :-)   | True           |
| 7005f2ad-1401-4b4c-afa8-59f27aff97dc | Open vSwitch agent | network01.wolkit.local | :-)   | True           |
| 8148b598-83c1-4077-9568-c2430c9f387c | DHCP agent         | network01.wolkit.local | :-)   | True           |
| 83be333e-de77-4b58-9aad-c591621b9753 | Open vSwitch agent | Computo01.wolkit.local | :-)   | True           |
+--------------------------------------+--------------------+------------------------+-------+----------------+
```

* _l3 agennt ID_: __1d8522b3-2eb7-445c-9c92-623148c5ae65__

```
quantum l3-agent-router-add 1d8522b3-2eb7-445c-9c92-623148c5ae65 router_demoUno
```

```
Added router router_demoUno to L3 agent
```

* Añadimos el _router_ ( __c7e63eb0-92b7-478f-a70f-d18d29a0e2f2__ )a la _subnet_ ( __e950ea89-3366-4023-89e5-dcffd63de0f6__ )

```
quantum router-interface-add c7e63eb0-92b7-478f-a70f-d18d29a0e2f2 e950ea89-3366-4023-89e5-dcffd63de0f6
```

```
Added interface to router c7e63eb0-92b7-478f-a70f-d18d29a0e2f2
```

* Reinicio los servicios _"Quantum"_, para ello utilizo [fabric][1] desde _monit_:

```python
from fabric.api import *

env.hosts = [ "controller01.wolkit.local", "network01.wolkit.local", "computo01.wolkit.local" ]
env.user = "root"

def restart_quantum():
	run("cd /etc/init.d/; for i in $( ls quantum-* ); do sudo service $i restart; done")
```

```
root@monitor:~/scripts/fabric# fab -f restart_quantum.py restart_quantum
[controller01.wolkit.local] Executing task 'restart_quantum'
[controller01.wolkit.local] run: cd /etc/init.d/; for i in $( ls quantum-* ); do sudo service $i restart; done
[controller01.wolkit.local] out: quantum-server stop/waiting
[controller01.wolkit.local] out: quantum-server start/running, process 4138

[network01.wolkit.local] Executing task 'restart_quantum'
[network01.wolkit.local] run: cd /etc/init.d/; for i in $( ls quantum-* ); do sudo service $i restart; done
[network01.wolkit.local] out: quantum-dhcp-agent stop/waiting
[network01.wolkit.local] out: quantum-dhcp-agent start/running, process 24917
[network01.wolkit.local] out: quantum-l3-agent stop/waiting
[network01.wolkit.local] out: quantum-l3-agent start/running, process 24933
[network01.wolkit.local] out: quantum-metadata-agent stop/waiting
[network01.wolkit.local] out: quantum-metadata-agent start/running, process 24943
[network01.wolkit.local] out: quantum-plugin-openvswitch-agent stop/waiting
[network01.wolkit.local] out: quantum-plugin-openvswitch-agent start/running, process 24952

[computo01.wolkit.local] Executing task 'restart_quantum'
[computo01.wolkit.local] run: cd /etc/init.d/; for i in $( ls quantum-* ); do sudo service $i restart; done
[computo01.wolkit.local] out: quantum-plugin-openvswitch-agent stop/waiting
[computo01.wolkit.local] out: quantum-plugin-openvswitch-agent start/running, process 20198


Done.
Disconnecting from network01.wolkit.local... done.
Disconnecting from controller01.wolkit.local... done.
Disconnecting from computo01.wolkit.local... done.
```

* Creamos la _external network_ ( _floating_ ) con el rango que nos ha facilitado __84.124.37.64/26__ pero hay que eliminar de la ecuación la ip *84.124.37.66* que está en uso.

> necesitamos el *tenant_id* del *admin_tenant*:
> * `keystone tenant-list` y obtenemos el *admin_tenant_id*: __e110d39b0818488fb15ad1b50283a28b__

```
quantum net-create --tenant-id e110d39b0818488fb15ad1b50283a28b extNet01 --router:external=True
```

```
+---------------------------+--------------------------------------+
| Field                     | Value                                |
+---------------------------+--------------------------------------+
| admin_state_up            | True                                 |
| id                        | 797dac10-af89-4374-b902-38538e57643f |
| name                      | extNet01                             |
| provider:network_type     | gre                                  |
| provider:physical_network |                                      |
| provider:segmentation_id  | 2                                    |
| router:external           | True                                 |
| shared                    | False                                |
| status                    | ACTIVE                               |
| subnets                   |                                      |
| tenant_id                 | e110d39b0818488fb15ad1b50283a28b     |
+---------------------------+--------------------------------------+
```

* Asociamos _subnet_ a la red _extNet01_.

> El rango que nos ha dejado es __84.124.37.64/26__:
> 
> ```
> figarcia@corelia:~$ ipcalc 84.124.37.64/26
> Address:   84.124.37.64         01010100.01111100.00100101.01 000000
> Netmask:   255.255.255.192 = 26 11111111.11111111.11111111.11 000000
> Wildcard:  0.0.0.63             00000000.00000000.00000000.00 111111
> =>
> Network:   84.124.37.64/26      01010100.01111100.00100101.01 000000
> HostMin:   84.124.37.65         01010100.01111100.00100101.01 000001
> HostMax:   84.124.37.126        01010100.01111100.00100101.01 111110
> Broadcast: 84.124.37.127        01010100.01111100.00100101.01 111111
> Hosts/Net: 62                    Class A
> ``` 
>
> * _gateway_: __84.124.37.65__
> * _IPs útiles_: de __84.124.37.67__ a la __84.124.37.75__
> * Usamos para el _controller_: __84.124.37.67__
> * Dejo __84.124.37.68__ libre por si acaso necesitamos otra para la infraestructura, por ejemplo _storage_.


```
quantum subnet-create --tenant-id e110d39b0818488fb15ad1b50283a28b --allocation-pool start=84.124.37.69,end=84.124.37.75 --gateway 84.124.37.65 extNet01 84.124.37.64/26 --enable_dhcp=False
```

``` 
+------------------+--------------------------------------------------+
| Field            | Value                                            |
+------------------+--------------------------------------------------+
| allocation_pools | {"start": "84.124.37.69", "end": "84.124.37.75"} |
| cidr             | 84.124.37.64/26                                  |
| dns_nameservers  |                                                  |
| enable_dhcp      | False                                            |
| gateway_ip       | 84.124.37.65                                     |
| host_routes      |                                                  |
| id               | 438597eb-cd38-4bb9-a872-3e7064a753f9             |
| ip_version       | 4                                                |
| name             |                                                  |
| network_id       | 797dac10-af89-4374-b902-38538e57643f             |
| tenant_id        | e110d39b0818488fb15ad1b50283a28b                 |
+------------------+--------------------------------------------------+
```

* Asociamos el _router_ ( __router_demoUno__ *id*:__c7e63eb0-92b7-478f-a70f-d18d29a0e2f2__ ) a la _external network_ ( __extNet01__ *id*: __797dac10-af89-4374-b902-38538e57643f__ )

```
quantum router-gateway-set c7e63eb0-92b7-478f-a70f-d18d29a0e2f2 797dac10-af89-4374-b902-38538e57643f
```

```
Set gateway for router c7e63eb0-92b7-478f-a70f-d18d29a0e2f2
```

## _Frist MV_

* Creamos un fichero de _credenciales_ __demoUno.rc__ para _demoUno_ con los siguientes datos:

```
export OS_TENANT_NAME=demoUno
export OS_USERNAME=tester
export OS_PASSWORD=tester
export OS_AUTH_URL="http://172.16.172.201:5000/v2.0/"
```

* Cargamos las _credenciales_ `source demoUno.rc`
* Modificamos las _security rules_:

* Para el _ping_:

```
root@controller01:~# nova --no-cache secgroup-add-rule default icmp -1 -1 0.0.0.0/0
+-------------+-----------+---------+-----------+--------------+
| IP Protocol | From Port | To Port | IP Range  | Source Group |
+-------------+-----------+---------+-----------+--------------+
| icmp        | -1        | -1      | 0.0.0.0/0 |              |
+-------------+-----------+---------+-----------+--------------+
``` 

* Para el _ssh_:

```
root@controller01:~# nova --no-cache secgroup-add-rule default tcp 22 22 0.0.0.0/0
+-------------+-----------+---------+-----------+--------------+
| IP Protocol | From Port | To Port | IP Range  | Source Group |
+-------------+-----------+---------+-----------+--------------+
| tcp         | 22        | 22      | 0.0.0.0/0 |              |
+-------------+-----------+---------+-----------+--------------+
```

* Necesito _id_ de la imagen a levantar: __acd2be5a-b741-4639-ad5f-a575d27c5695__


```
nova --no-cache boot --image acd2be5a-b741-4639-ad5f-a575d27c5695 --flavor 1 my_first_vm
``` 

```
```





[0]: https://github.com/mseknibilel/OpenStack-Grizzly-Install-Guide/blob/OVS_MultiNode/OpenStack_Grizzly_Install_Guide.rst
[1]: https://github.com/fabric/fabric




