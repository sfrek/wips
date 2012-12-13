Mejora de Redimiento en _KVM_ con _VhostNet_
============================================

[kvm][] [VhostNet[]

* Activar el modulo _vhost_net_:

* Configurar la máquina virtual, a través de `virsh edit`:

```XML
<interface type='network'>
...
  <model type='virtio'/>
  <driver name='vhost'/>
...
</interface>
```

[kvm]: http://www.linux-kvm.org/page/Main_Page
[VhostNet]: http://www.linux-kvm.org/page/VhostNet
