OpenSSH ( _sshd_ ) en Windows
=============================

Como referencia he cogido [este][http://www.noah.org/ssh/cygwin-sshd.html]
post.

Lo primero que se necesita es tener instalado el [cygwin][1], este se descarga
de su [web][1] y a la hora de instalar la paquetería que queramos, no hay que
olvidar instalar [cygrunsrv][2] y [openssh][3].

Un vez instalado, se arranca el [cygwin][1] como administardor y realizamos:

```
ssh-host-config -y
ssh-host-config -c "CYGWIN=tty ntsec"
```

Esto pide una contraseña para _cyg_server_, yo puse un nemotécnico sencillo.

Para _arrancar_ el servicio:

```
cygrunsrv -S sshd
```

###### Firewall de Windows.

Yo tuve que tocar el _firewall_ de windows para poder acceder al puerto 22
desde fuera de la máquina.

##### Acceso

En caso de que tengas un _"windows"_ que arranca sin _"contraseña"_ de usuario,
lo suyo es añadir una clave pública `~/.ssh/authorized_keys`.

A disfrutar.

[1]: http://www.cygwin.com/
[2]: http://cygwin.wikia.com/wiki/Cygrunsrv
[3]: http://www.openssh.org/


