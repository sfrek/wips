Quiero hacer una prueba de concepto de [bosh-bootstrap][], voy a usar como _entorno de despliegue_ máquinas virtuales en [kvm][].

### Entorno

Para crear el entorno, lo primero que he hecho en asignar a unsuario permisos para poder conectarse al [hypervisor][] en cuestión.

```
root@debvirt:~# usermod -G kvm,libvirt deployer 
root@debvirt:~# id deployer 
uid=1000(deployer) gid=1000(deployer) grupos=1000(deployer),107(kvm),106(libvirt)
```

Como [bosh-bootstrap][] hace uso de [fog][],  configuro _~/fog_ para que haga uso de [kvm][].

``` ruby
:default:
   :libvirt_uri: qemu:///system
```

Haciendo uso de un [entorno rvm][] aislado, instalamos a través de `gem install`

```
deployer@debvirt:~$ gem install bosh-bootstrap ruby-libvirt
```
Comprobamos la conexión al [hypervisor][]

``` ruby
deployer@debvirt:~$ fog
  Welcome to fog interactive!
    :default provides Libvirt
    >> Compute[:libvirt]
    #<Fog::Compute::Libvirt::Real:9352480 @uri=#<Fog::Compute::LibvirtUtil::URI:0x000000011d5a00 @parsed_uri=#<URI::Generic:0x000000011d4df8 URL:qemu:/system>, @uri="qemu:///system"> @ip_command=nil @client=#<Libvirt::Connect:0x000000019465c8>>
```

[bosh-bootstrap]: https://github.com/StarkAndWayne/bosh-bootstrap#readme
[fog]: https://github.com/fog/fog#readme
[kvm]: http://www.linux-kvm.org/page/Main_Page
[hypervisor]: http://en.wikipedia.org/wiki/Hypervisor
[entorno rvm]: http://sfrek.github.com/blog/2013/02/06/entornos-com-rvm/
