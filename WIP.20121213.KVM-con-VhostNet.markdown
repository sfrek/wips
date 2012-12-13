Mejora de Redimiento en _KVM_ con _VhostNet_
============================================

[kvm][] [VhostNet][]

* Activar el modulo _vhost_net_:

```
root@moya ~ # modprobe -v vhost_net
insmod /lib/modules/3.2.0-4-amd64/kernel/drivers/net/macvlan.ko 
insmod /lib/modules/3.2.0-4-amd64/kernel/drivers/net/macvtap.ko 
insmod /lib/modules/3.2.0-4-amd64/kernel/drivers/vhost/vhost_net.ko 
```

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
