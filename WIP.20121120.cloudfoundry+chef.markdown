Instalación Cloudfoundry con Chef
=================================

Error:
	[Tue, 20 Nov 2012 13:35:27 +0100] ERROR: NoMethodError:undefined method `default_action' for #<Class:0x7f9aa32024d0>
	/var/cache/chef/cookbooks/cloudfoundry/resources/source.rb:21:in `class_from_file'

En la [Documentación](http://wiki.opscode.com/display/chef/Lightweight+Resources+and+Providers+(LWRP) 'Wiki de Chef') encuentro:
	Default Action
		As of version 0.10.10 specifying a default_action can be done using default_action :action:
			actions :create, :destroy
 			default_action :create
	
	The above code will create a valid resource with no default action on versions prior to 0.10.10.

Y en el nodo:
	root@lucid-controller:~# chef-client --version
	Chef: 0.9.18

### Problema

No había puesto el repositorio correcto, estába:
	root@lucid-controller:~# cat /etc/apt/sources.list.d/opscode.list 
	deb http://apt.opscode.com lucid main

Y hay que poner:
	deb http://apt.opscode.com lucid-0.10 main

Ahora un `apt-get update && apt-get -y dist-upgrade`y a correr.

## Lo más pro

*Crear un cookbook*  que inserte el repositorio de _opscode_ `http://apt.opscode.com`:
	deb http://apt.opscode.com $(lsb_release -sc)-0.10 main

La versión *0.1.0*.
{% codeblock recipes/default lang:ruby %}
chef_version = "0.10"
chef_distribution = "#{node["lsb"]["codename"]}-#{chef_version}"

# add the opscode repository
apt_repository "opscode" do
        uri "http://apt.opscode.com"
        distribution chef_distribution
        components ["main"]
end
{% endcodeblock %}
{% codeblock metadata.rb lang:ruby %}
maintainer       "Abadasoft"
maintainer_email "frekofefe@gmail.com"
license          "All rights reserved"
description      "Installs/Configures opscode-repository"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

depends 'apt'
{% endcodeblock %}

Esto se puede mejorar mucho, mucho, mucho ... y se hará.
