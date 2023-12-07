+++
title = "VPN sitio a sitio con WireGuard"
weight = 30
chapter = false
author = "Iván Piña Castillo"
tags = ["VPN", "WireGuard"]
description = "Documentación de mis tareas de VPN."
readingTime = true
hideComments = true
+++

## Enunciado

     Configura una VPN sitio a sitio usando WireGuard. Documenta el proceso adecuadamente.

En esta ocasión, estamos montando el mismo escenario que en el apartado B pero usando Wireguard para la conexión. Por lo tanto, he usado el mismo código del archivo 'Vagrantfile' para montar el entorno. Una vez hecho esto, necesitamos configurar correctamente las máquinas para que puedan establecer la conexión.

### Configuración de Wireguard en los clientes

Empezando por ambos clientes, es necesario modificar su ruta predeterminada:

En el cliente del escenario 1:
```bash
ip r del default

ip r add default via 172.30.0.10
```

En el cliente del escenario 2:
```bash
ip r del default

ip r add default via 172.20.0.10
```

### Configuración de Wireguard en el servidor

Una vez que hemos hecho esto, podemos pasar a las máquinas que actuarán como servidor y cliente de Wireguard.

En la máquina “Servidor1” del escenario 1 instalamos Wireguard:
```bash
apt install wireguard
```

A continuación activamos el bit de forwarding y hacemos esta configuración permanente:
```bash
echo 1 > /proc/sys/net/ipv4/ip_forward
```
```bash
nano /etc/sysctl.conf                                          

net.ipv4.ip_forward=1
```

Después, al igual que hicimos antes, tenemos que generar el par de claves:
```bash
cd /etc/wireguard
wg genkey | tee serverprivatekey | wg pubkey > serverpublickey
```
```bash
cat serverprivatekey
gJRR9JNcc+FL2/rNisGG1s8XioXV3Dsf8CJJeQ9hG2I=
```
![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/1.png)

```bash
cat serverpublickey
AbwKDDHYW0gqFz3eFem8icPsIujhKI5cQKj0ndA60hE=
```
![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/2.png)

Ahora ya podemos crear el fichero de configuración, que será muy parecido al que creamos en el apartado anterior:
```bash
nano wg0.conf

# Server config
[Interface]
Address = 10.99.99.1
PrivateKey = gJRR9JNcc+FL2/rNisGG1s8XioXV3Dsf8CJJeQ9hG2I= # Clave privada del servidor
ListenPort = 51820
```

En este momento, ya podemos probar a iniciar el servicio:
```bash
wg-quick up wg0
```
![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/3.png)

Podemos ver que el servicio se ha iniciado correctamente:
```bash
wg
```
![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/4.png)

Ahora debemos configurar la máquina “Servidor2” que actuará como cliente de Wireguard en el escenario 2. Así que, instalamos Wireguard en esa máquina:
```bash
apt install wireguard
```

Y activamos el bit de forwarding, haciéndolo permanente:
```bash
echo 1 > /proc/sys/net/ipv4/ip_forward
```
```bash
nano /etc/sysctl.conf                                          

net.ipv4.ip_forward=1
```

Generaremos el par de claves que usará esta máquina:
```bash
cd /etc/wireguard

wg genkey | tee clientprivatekey | wg pubkey > clientpublickey
```
```bash
cat clientprivatekey
cG/yhjjEESUFZtzIHTTsMDHRYDbE2pTrxMG/urTbEGE=
```
![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/5.png)

```bash
cat clientpublickey
UrnkB88Bj8keOto4bac+c/CaXhJQKCdg7Bj5+pAQDhU=
```
![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/6.png)

Y creamos el fichero de configuración que usará esta máquina tal y como hicimos en el aparatado anterior, creando también el bloque de “Peer”:
```bash
nano wg0.conf

[Interface]
Address = 10.99.99.2
PrivateKey = cG/yhjjEESUFZtzIHTTsMDHRYDbE2pTrxMG/urTbEGE= # Clave privada del cliente
ListenPort = 51820

[Peer]
PublicKey = AbwKDDHYW0gqFz3eFem8icPsIujhKI5cQKj0ndA60hE= # Clave pública del servidor
AllowedIPs = 0.0.0.0/0
Endpoint = 192.168.121.150:51820
```

Antes de activar este servicio, tenemos que añadir el correspondiente bloque “Peer” en el fichero de configuración del escenario 1:
```bash
nano wg0.conf

# Server config
[Interface]
Address = 10.99.99.1
PrivateKey = gJRR9JNcc+FL2/rNisGG1s8XioXV3Dsf8CJJeQ9hG2I= # Clave privada del servidor
ListenPort = 51820

# Cliente Escenario 2
[Peer]
Publickey = UrnkB88Bj8keOto4bac+c/CaXhJQKCdg7Bj5+pAQDhU= # Clave pública del cliente
AllowedIPs = 0.0.0.0/0
PersistentKeepAlive = 25
```

Ahora reiniciamos el servicio en la máquina “Servidor1” del escenario 1:
```bash
wg-quick down wg0

wg-quick up wg0
```
![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/7.png)

Ya podemos iniciar el servicio en el escenario 2:
```bash
wg-quick up wg0
```
![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/8.png)

Y podemos ver que se ha establecido la conexión:

![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/9.png)

### Pruebas de funcionamiento

Ahora ya podemos realizar las pruebas necesarias:

- Rutas en la máquina “Servidor1” del escenario 1:

![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/10.png)

- Ping y traceroute desde el cliente del escenario 1 al cliente del escenario 2:

![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/11.png)

- Rutas en la máquina “Servidor2” del escenario 2:

![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/12.png)

- Ping y traceroute desde el cliente del escenario 2 al cliente del escenario 1:

![Ejercicio 4](/img/ciberseguridad/vpn/vpnd/13.png)