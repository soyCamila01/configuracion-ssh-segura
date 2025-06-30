---

🔐 Configuración Segura de SSH

Este repositorio documenta los pasos para fortalecer la seguridad de un servidor SSH en Linux. Incluye configuraciones para desactivar accesos inseguros, habilitar autenticación mediante llaves y buenas prácticas para proteger el servicio SSH.


---

⚠️ Advertencia

Antes de realizar cualquier cambio, haz un backup de tu archivo de configuración actual:

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

Si la nueva configuración falla, podrás restaurarla con:

sudo mv /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
sudo systemctl restart ssh


---

🛠️ Configuración del Servidor SSH

Edita el archivo /etc/ssh/sshd_config con privilegios de superusuario:

sudo nano /etc/ssh/sshd_config

Asegúrate de tener estas líneas (o agrégalas/modifícalas):

# Deshabilita el acceso como root para prevenir ataques directos
PermitRootLogin no

# Obliga al uso de llaves SSH, deshabilitando contraseñas
PasswordAuthentication no

# Habilita la autenticación por clave pública
PubkeyAuthentication yes

# Limita el acceso a usuarios específicos
AllowUsers tu_usuario

🔎 Contexto rápido:

PermitRootLogin no: Evita que atacantes prueben contraseñas directamente sobre root.

PasswordAuthentication no: Reduce el riesgo de ataques de fuerza bruta sobre contraseñas.

AllowUsers: Minimiza el riesgo al restringir las cuentas permitidas.


Guarda y cierra el archivo, luego reinicia el servicio SSH para aplicar cambios:

sudo systemctl restart ssh


---

🔑 Generación de llaves SSH en el cliente

En tu máquina cliente (desde donde te conectarás al servidor):

1. Genera un par de llaves:



ssh-keygen -t rsa -b 4096 -C "tu_email@example.com"

2. Copia tu clave pública al servidor:



ssh-copy-id tu_usuario@ip_del_servidor

Esto agregará tu clave al archivo ~/.ssh/authorized_keys del servidor.


---

📂 Permisos correctos en el cliente

Asegúrate de que los archivos tengan los permisos adecuados:

chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub


---

⚙️ Configuración de cliente SSH (~/.ssh/config)

Para evitar repetir parámetros al conectarte, crea (o edita) ~/.ssh/config:

Host mi_servidor
    HostName ip_del_servidor
    User tu_usuario
    Port 22
    IdentityFile ~/.ssh/id_rsa

Con esto, podrás conectarte simplemente con:

ssh mi_servidor


---

🔄 Cambio del puerto SSH (opcional)

En /etc/ssh/sshd_config, puedes cambiar el puerto por uno no estándar para reducir intentos automáticos de ataque:

Port 2222

> ❗ Nota: Esto es solo una medida de ofuscación. No reemplaza una buena configuración de autenticación ni otras prácticas de seguridad.




---

✅ Pruebas de verificación

Después de aplicar los cambios, prueba:

Conectarte con tu llave:

ssh mi_servidor

Intentar un login con password (debería fallar si PasswordAuthentication no está activo).

Revisar los logs del servidor para errores:

sudo tail -f /var/log/auth.log



---

📌 Notas finales

Esta guía fue probada en sistemas basados en Debian/Ubuntu. En otras distribuciones, la ubicación del archivo de configuración puede variar.

Recuerda configurar un firewall para limitar los intentos de acceso, y considera herramientas como Fail2Ban para proteger aún más tu servidor SSH.



---

🙌 Autor

Creado y documentado por Camila ❤️

---
