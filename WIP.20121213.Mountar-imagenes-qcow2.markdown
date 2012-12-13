Montar imagenes qcow2
=====================

Editar/modificar archivos y/o cofiguraciones de una máquina virtual _[kvm][]+[qcow2][]_, para esto debemos montar el _disco duro_.

Para esto, lo primero que tenemos que comprobar es que nuestro sistema tenga el módulo [nbd][] cargado, `lsmod | grep nbd`, si no se tiene:

``` terminal
root@moya ~ # modprobe -v nbd
insmod /lib/modules/3.2.0-4-amd64/kernel/drivers/block/nbd.ko
```

Una vez tengamos dicho módulo, lo único que tenemos que hacer es convertir la imagen _[qcow2][]_ que queramos usar en un dispositivo de bloques, para ello usamos [qemu-nbd][]:

``` terminal
root@moya ~ # qemu-nbd -v /var/lib/libvirt/images/<imagen-qcow2>.img --connect=/dev/nbd0 &
```

Comprobamos las particiones y seleccionamos aquella que queramos montar:

``` terminal
root@moya ~ # fdisk -l /dev/nbd0

Disk /dev/nbd0: 10.7 GB, 10737418240 bytes
255 heads, 63 sectors/track, 1305 cylinders, total 20971520 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00044215

     Device Boot      Start         End      Blocks   Id  System
/dev/nbd0p1            2048     2000895      999424   82  Linux swap / Solaris
/dev/nbd0p2         2000896    20969471     9484288   83  Linux
```

``` terminal
```

[kvm]: http://www.linux-kvm.org/page/Main_Page
[qemu-nbd]: http://wiki.qemu.org/Features/Asynchronous_NBD

