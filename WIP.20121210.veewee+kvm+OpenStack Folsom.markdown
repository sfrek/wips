OpenStack Folson en Ubuntu 12.04
================================

Para realizar la instalación me guío por un post de [Hendrik Volkmer][1], pero voy a usar [KVM][2] en vez de [VirtualBox][3], para ello me ayudaré de [veewee][4].

Levantar máquinas con [veewee][]
--------------------------------

El servidor de "virtualización" que uso corre una [Debian][5] [Wheezy][6], aunque supongo que se podrá usar cualquier "distro".  
Para usar [veewee][] necesitamos [ruby][7], [rubygems][9], etc. En este caso no voy a usar ni [rvm][10], ni [rbenv][11], si no que tiro directamente de la paquetería: 
	kvm:~# gem --version
	1.8.23

Instalamos _veewee_: 
	gem install -y --no-rdoc --no-ri veewee veewee-templates-updater

También necesitamos [ruby-libvirt][12] y [em-winrm][13]: 
	gem install -y --no-rdoc --no-ri ruby-libvirt
	gem install -y --no-rdoc --no-ri em-winrm

> ##### Error al instalar [em-winrm][]

> Me encuentro que al realizar un el _gem install_ del _em-winrm_ da un error al compilar, ya que instenta instalar [eventmachine][14]-1.0.0.beta3, al comprobar los repos, veo que la 1.0.0 ya no está en beta, la instalo con `gem install --no-rdoc --no-ri eventmachine`, y al intentar instalar de nuevo _em-winrm_ vuelve a dar el casque, claro es una dependencia directa, así que me voy al [GitHub]( https://github.com/schisamo/em-winrm ) de la gema, la descargo, cambio en _em-winrm.gemspec_ la dependecia de la beta3, y compilo e instalo:
>	kvm:~/veewee/em-winrm# bundle package
>	kvm:~/veewee/em-winrm# rake install


Definimos la plantilla para las máquinas virtuales: 
	kvm:~/.veewee# veewee kvm define 'veewee-precise64' 'ubuntu-12.04.1-server-amd64'
	The basebox 'veewee-precise64' has been succesfully created from the template 'ubuntu-12.04.1-server-amd64'
	You can now edit the definition files stored in definitions/veewee-precise64 or build the box with:
	veewee kvm build 'veewee-precise64'

Cambiamos parte de la definición: 
	kvm:~/.veewee/definitions/veewee-precise64# diff definition.rb.ini definition.rb
	5c5
	<   :disk_format => 'VDI',
	---
	>   :disk_format => 'QCOW2',
	26,27c26,27
	<   :ssh_user => "vagrant",
	<   :ssh_password => "vagrant",
	---
	>   :ssh_user => "operador",
	>   :ssh_password => "operador",

Añadimos y modificamos la configuración de instalación [preseed.cfg][15]: 
	kvm:~/veewee/definitions/veewee-precise64# diff preseed.cfg.ini preseed.cfg
	2c2
	< d-i debian-installer/locale string en_US.utf8
	---
	> d-i debian-installer/locale string es_ES.utf8
	4c4
	< d-i console-setup/layout string USA
	---
	> d-i console-setup/layout string Spanish
	9a10,16
	> # Add ip
	> d-i netcfg/disable_dhcp=true
	> d-i netcfg/get_ipaddress=172.16.0.95
	> d-i netcfg/get_netmask=255.255.255.0
	> d-i netcfg/get_gateway=172.16.0.1
	> d-i netcfg/get_nameservers=172.16.0.1
	> 
	55,58c62,65
	< d-i passwd/user-fullname string vagrant
	< d-i passwd/username string vagrant
	< d-i passwd/user-password password vagrant
	< d-i passwd/user-password-again password vagrant
	---
	> d-i passwd/user-fullname string operador
	> d-i passwd/username string operador
	> d-i passwd/user-password password operador
	> d-i passwd/user-password-again password operador


En esencia, cambiamos:
* Formato de la imagen.
* Usuario y Contraseña
* Leguaje
* IP.



[1]: http://blog.hendrikvolkmer.de/about/
