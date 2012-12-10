PASSWORDS
---------

mysql:
	root
	sistemas

rabbitmq +password for the 'chef' AMQP user in the RabbitMQ vhost "/chef":+:
	root@lucid-nats:~# openssl rand -hex 10
	a138ed0249ef1a7b9152

> > pass: `a138ed0249ef1a7b9152`

password for the 'admin' user in the Chef Server WebUI:
	passwordchefwebui

##### Usuario admin para _knife_ en el chef-server

{% codeblock creación del usuario %}
root@chefserver:~# adduser chefadmin
Adding user `chefadmin' ...
Adding new group `chefadmin' (1001) ...
Adding new user `chefadmin' (1001) with group `chefadmin' ...
Creating home directory `/home/chefadmin' ...
Copying files from `/etc/skel' ...
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
Changing the user information for chefadmin
Enter the new value, or press ENTER for the default
	Full Name []: 
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n] Y
{% endclodeblock %}

Contraseña:
	root@lucid-nats:~# openssl rand -base64 20
	SyrvZGConqN8CGHk8vjgpjHB6h8=

	
**knife**: creación de administrador:

* configuración:
{% codeblock %}
root@chefserver:~# su -l chefadmin 
chefadmin@chefserver:~$ mkdir ~/.chef
root@chefserver:~# cp /etc/chef/validation.pem /etc/chef/webui.pem /home/chefadmin/.chef/
root@chefserver:~# chown -R chefadmin.chefadmin /home/chefadmin/.chef/
root@chefserver:~# su -l chefadmin 
chefadmin@chefserver:~$ knife configure -i
WARNING: No knife configuration file found
Where should I put the config file? [/home/chefadmin/.chef/knife.rb] 
Please enter the chef server URL: [http://chefserver.(null):4000] http://10.100.200.249:4000
Please enter a clientname for the new client: [operador] chef-admin
Please enter the existing admin clientname: [chef-webui] 
Please enter the location of the existing admin client's private key: [/etc/chef/webui.pem] /home/chefadmin/.chef/webui.pem
Please enter the validation clientname: [chef-validator] 
Please enter the location of the validation key: [/etc/chef/validation.pem] /home/chefadmin/.chef/validation.pem
Please enter the path to a chef repository (or leave blank): 
Creating initial API user...
Created client[chef-admin]
Configuration file written to /home/chefadmin/.chef/knife.rb
{% endcodeblock %}

* Prueba:
	chefadmin@chefserver:~$ knife client list
		  chef-admin
		  chef-validator
		  chef-webui


## Recordmos:

### snorby:

{% codeblock %}
operador@chefserver:~/snorby$ rvm-shell 
Using /home/operador/.rvm/gems/ruby-1.9.3-p194
Running /home/operador/.rvm/hooks/after_use
Running /home/operador/.rvm/hooks/after_cd
operador@chefserver:~/snorby$ RAILS_ENV="production" bundle exec script/rails server
{% endcodeblock %}
