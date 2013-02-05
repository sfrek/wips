Para poder probar el recién salido [Chef Server
11][http://www.opscode.com/blog/2013/02/04/chef-11-released/] he obtado por
usar [vagrant][], claro que [opscode][] pone en el
[README.md][https://github.com/opscode-cookbooks/chef-server#demo-chef-server-with-vagrant-and-berkshelf] 

## Testing

* Descargamos el repositorio:
```
figarcia@corelia:~/src$ git clone
git://github.com/opscode-cookbooks/chef-server.git
Cloning into 'chef-server'...
remote: Counting objects: 460, done.
remote: Compressing objects: 100% (240/240), done.
remote: Total 460 (delta 233), reused 407 (delta 188)
Receiving objects: 100% (460/460), 87.39 KiB | 134 KiB/s, done.
Resolving deltas: 100% (233/233), done.
figarcia@corelia:~/src$ cd chef-server
``` 
* Antes de lanzar el `bundle install`, y como hago uso de [rvm][] me creo un
  fichero _.rvmrc_ con un entorno cerrado:
  ```
  figarcia@corelia:~/src/chef-server$ cat .rvmrc
  ```
* Instalamos las _gemas_ necesarias:
```
figarcia@corelia:~/src/chef-server$ bundle install
Fetching gem metadata from http://rubygems.org/........
Fetching gem metadata from http://rubygems.org/..
Installing i18n (0.6.1) 
Installing multi_json (1.5.0) 
Installing activesupport (3.2.11) 
Installing builder (3.0.4) 
Installing activemodel (3.2.11) 
Installing addressable (2.3.2) 
Installing archive-tar-minitar (0.5.2) 
Installing erubis (2.7.0) 
Installing highline (1.6.15) 
Installing json (1.5.4) with native extensions 
Installing mixlib-log (1.4.1) 
Installing mixlib-authentication (1.3.0) 
Installing mixlib-cli (1.3.0) 
Installing mixlib-config (1.1.2) 
Installing mixlib-shellout (1.1.0) 
Installing net-ssh (2.2.2) 
Installing net-ssh-gateway (1.1.0) 
Installing net-ssh-multi (1.1) 
Installing ipaddress (0.8.0) 
Installing systemu (2.5.2) 
Installing yajl-ruby (1.1.0) with native extensions 
Installing ohai (6.16.0) 
Installing mime-types (1.20.1) 
Installing rest-client (1.6.7) 
Installing chef (11.0.0) 
Installing hashie (1.2.0) 
Installing chozo (0.4.2) 
Installing minitar (0.5.4) 
Installing facter (1.6.17) 
Installing timers (1.1.0) 
Installing celluloid (0.12.4) 
Installing multipart-post (1.1.5) 
Installing faraday (0.8.5) 
Installing net-http-persistent (2.8) 
Installing ridley (0.6.3) 
Installing solve (0.4.1) 
Installing thor (0.16.0) 
Installing ffi (1.3.1) with native extensions 
Installing childprocess (0.3.7) 
Installing log4r (1.1.10) 
Installing net-scp (1.0.4) 
Installing vagrant (1.0.6) 
Installing berkshelf (1.1.3) 
Installing coderay (1.0.8) 
Installing gherkin (2.11.5) with native extensions 
Installing gist (3.1.1) 
Installing nokogiri (1.5.6) with native extensions 
Installing method_source (0.7.1) 
Installing slop (2.4.4) 
Installing pry (0.9.8.4) 
Installing rak (1.4) 
Installing polyglot (0.3.3) 
Installing treetop (1.4.12) 
Installing foodcritic (1.7.0) 
Installing thor-foodcritic (0.2.0) 
Using bundler (1.2.0) 
Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem
is installed.
```
* Ahora ya estamos preparados para lanzar el _vagrant_:
```
figarcia@corelia:~/src/chef-server$ vagrant up
[default] Box opscode-ubuntu-12.04 was not found. Fetching box from specified
URL...
[vagrant] Downloading with Vagrant::Downloaders::HTTP...
[vagrant] Downloading box:
https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-ubuntu-12.04.box
[vagrant] Extracting box...
[vagrant] Verifying box...
[vagrant] Cleaning up downloaded box...
[default] Importing base box 'opscode-ubuntu-12.04'...
[default] The guest additions on this VM do not match the install version of
VirtualBox! This may cause things such as forwarded ports, shared
folders, and more to not work properly. If any of those things fail on
this machine, please update the guest additions and repackage the
box.

Guest Additions Version: 4.1.22
VirtualBox Version: 4.2.6
[default] Matching MAC address for NAT networking...
[default] Clearing any previously set forwarded ports...
[default] Forwarding ports...
[default] -- 22 => 2222 (adapter 1)
[Berkshelf] installing cookbooks...
[Berkshelf] Using chef-server (2.0.0) at path: '/home/figarcia/src/chef-server'
[Berkshelf] Installing git (2.2.0) from site:
'http://cookbooks.opscode.com/api/v1/cookbooks'
[Berkshelf] Installing dmg (1.1.0) from site:
'http://cookbooks.opscode.com/api/v1/cookbooks'
[Berkshelf] Installing build-essential (1.3.4) from site:
'http://cookbooks.opscode.com/api/v1/cookbooks'
[Berkshelf] Installing yum (2.1.0) from site:
'http://cookbooks.opscode.com/api/v1/cookbooks'
[Berkshelf] Installing windows (1.8.2) from site:
'http://cookbooks.opscode.com/api/v1/cookbooks'
[Berkshelf] Installing chef_handler (1.1.4) from site:
'http://cookbooks.opscode.com/api/v1/cookbooks'
[Berkshelf] Installing runit (0.16.2) from site:
'http://cookbooks.opscode.com/api/v1/cookbooks'
[default] Creating shared folders metadata...
[default] Clearing any previously set network interfaces...
[default] Preparing network interfaces based on configuration...
[default] Running any VM customizations...
[default] Booting VM...
[default] Waiting for VM to boot. This can take a few minutes.
[default] VM booted and ready for use!
[default] Configuring and enabling network interfaces...
[default] Setting host name...
[default] Mounting shared folders...
[default] -- v-root: /vagrant
[default] -- cache: /tmp/vagrant-cache
[default] -- v-csc-1: /tmp/vagrant-cache/chef-solo-1/cookbooks
[default] Running provisioner: Vagrant::Provisioners::ChefSolo...
[default] Generating chef JSON and uploading...
[default] Running chef-solo...
stdin: is not a tty
[2013-02-05T10:43:43+00:00] INFO: *** Chef 10.14.4 ***
[2013-02-05T10:43:44+00:00] INFO: Setting the run_list to
["recipe[chef-server::default]"] from JSON
[2013-02-05T10:43:44+00:00] INFO: Run List is [recipe[chef-server::default]]
[2013-02-05T10:43:44+00:00] INFO: Run List expands to [chef-server::default]
[2013-02-05T10:43:44+00:00] INFO: Starting Chef Run for chef-server-berkshelf
[2013-02-05T10:43:44+00:00] INFO: Running start handlers
[2013-02-05T10:43:44+00:00] INFO: Start handlers complete.
[2013-02-05T10:43:46+00:00] INFO: Omnitruck download-server request:
http://www.opscode.com/chef/download-server?p=ubuntu&pv=12.04&m=x86_64&v=latest&prerelease=false&nightlies=false
[2013-02-05T10:43:46+00:00] INFO: Downloading chef-server package from:
http://opscode-omnitruck-release.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.4-1.ubuntu.12.04_amd64.deb
[2013-02-05T10:43:46+00:00] INFO: Processing
remote_file[/tmp/vagrant-cache/chef-server_11.0.4-1.ubuntu.12.04_amd64.deb]
action create (chef-server::default line 40)
[2013-02-05T10:46:13+00:00] INFO:
remote_file[/tmp/vagrant-cache/chef-server_11.0.4-1.ubuntu.12.04_amd64.deb]
updated
[2013-02-05T10:46:13+00:00] INFO: Processing
package[chef-server_11.0.4-1.ubuntu.12.04_amd64.deb] action install
(chef-server::default line 51)
[2013-02-05T10:47:20+00:00] INFO: Processing directory[/etc/chef-server] action
create (chef-server::default line 63)
[2013-02-05T10:47:20+00:00] INFO: directory[/etc/chef-server] created directory
/etc/chef-server
[2013-02-05T10:47:20+00:00] INFO: directory[/etc/chef-server] owner changed to
0
[2013-02-05T10:47:20+00:00] INFO: directory[/etc/chef-server] group changed to
0
[2013-02-05T10:47:20+00:00] INFO: Processing
template[/etc/chef-server/chef-server.rb] action create (chef-server::default
line 71)
[2013-02-05T10:47:23+00:00] INFO: template[/etc/chef-server/chef-server.rb]
updated content
[2013-02-05T10:47:23+00:00] INFO: template[/etc/chef-server/chef-server.rb]
owner changed to 0
[2013-02-05T10:47:23+00:00] INFO: template[/etc/chef-server/chef-server.rb]
group changed to 0
[2013-02-05T10:47:23+00:00] INFO: template[/etc/chef-server/chef-server.rb]
sending run action to execute[reconfigure-chef-server] (immediate)
[2013-02-05T10:47:23+00:00] INFO: Processing execute[reconfigure-chef-server]
action run (chef-server::default line 80)
[2013-02-05T10:48:37+00:00] INFO: execute[reconfigure-chef-server] ran
successfully
[2013-02-05T10:48:37+00:00] INFO: Processing execute[reconfigure-chef-server]
action nothing (chef-server::default line 80)
[2013-02-05T10:48:37+00:00] INFO: Processing ruby_block[ensure node can resolve
API FQDN] action create (chef-server::default line 85)
[2013-02-05T10:48:37+00:00] INFO: Chef Run complete in 292.646946138 seconds
[2013-02-05T10:48:37+00:00] INFO: Running report handlers
[2013-02-05T10:48:37+00:00] INFO: Report handlers complete
```
* Comprobamos que está arriba y funcional:

```
figarcia@corelia:~/src/chef-server$ curl -k https://33.33.33.10/version
chef-server 11.0.4

Component               Installed Version   Version GUID                                   
-------------------------------------------------------------------------------------------
bookshelf               0.2.1
git:0a01f74ffd1313c4dc9bf0d236e03a871add4e01   
chef                    11.0.0
git:f1a0a51ee25bd1e8247880888f3d6af4750bbdb9   
chef-expander           11.0.0
git:14b11a96da1273b362f39ab11c411470688a8bd6   
chef-pedant             1.0.2
git:947bcefb4c59e0612286b6bc3ae746e85bd3a056   
chef-server-cookbooks   11.0.4              
chef-server-ctl         11.0.4              
chef-server-scripts     11.0.4              
chef-server-webui       11.0.1
git:30354f08d5e1f9f344dd9f21e8ac33ce8f1e9e9b   
chef-solr               11.0.0
git:a594a634acd468d59d3929a5289c18cc7421827e   
erchef                  1.2.5
git:90a36102a9420a540eae4db72a01aae1bb08e6e1   
nginx                   1.2.3
md5:0a986e60826d9e3b453dbefc36bf8f6c           
postgresql              9.2.1
md5:c0b4799ea9850eae3ead14f0a60e9418           
preparation             11.0.4              
rabbitmq                2.7.1
md5:34a5f9fb6f22e6681092443fcc80324f           
runit                   2.1.1
md5:8fa53ea8f71d88da9503f62793336bc3           
unicorn                 4.2.0               
version-manifest        11.0.4
```

En teoría ya está, ahora solo falta hacer uso de él, pero 
