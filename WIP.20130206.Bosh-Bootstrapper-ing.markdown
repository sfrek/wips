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


[bosh-bootstrap]: https://github.com/StarkAndWayne/bosh-bootstrap#readme
[fog]: https://github.com/fog/fog#readme
[kvm]: http://www.linux-kvm.org/page/Main_Page
