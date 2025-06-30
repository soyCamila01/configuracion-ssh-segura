---

🔐 Configuración Segura de SSH

Este repositorio documenta los pasos para reforzar la seguridad de un servidor SSH en Linux. Incluye configuraciones para desactivar accesos inseguros, habilitar autenticación con llaves y buenas prácticas para proteger el servicio SSH.


---

⚠️ Advertencia importante

Antes de modificar /etc/ssh/sshd_config, haz un respaldo del archivo original. Un error en la configuración podría bloquear tu acceso remoto al servidor.

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

Si algo falla, puedes restaurar el backup con:

sudo mv /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
sudo systemctl restart ssh


---

🛠️ Configuración del servidor SSH

Edita el archivo de configuración:

sudo nano /etc/ssh/sshd_config

Agrega o modifica las siguientes líneas para mejorar la seguridad:

# Evita que el usuario root inicie sesión directamente por SSH
PermitRootLogin no

# Desactiva la autenticación por contraseña
PasswordAuthentication no

# Habilita la autenticación por clave pública
PubkeyAuthentication yes

# Restringe el acceso SSH solo a usuarios permitidos
AllowUsers tu_usuario

📌 ¿Por qué estos parámetros?

✅ PermitRootLogin no
Evita ataques dirigidos directamente a la cuenta root, obligando a iniciar sesión con un usuario normal y luego usar sudo.

✅ PasswordAuthentication no
Desactiva contraseñas para que solo sea posible autenticarse con llaves SSH, reduciendo significativamente el riesgo de ataques de fuerza bruta.

✅ PubkeyAuthentication yes
Habilita la autenticación mediante clave pública/privada.

✅ AllowUsers
Limita el acceso SSH exclusivamente a las cuentas listadas, reduciendo la superficie de ataque.

Guarda el archivo y reinicia SSH:

sudo systemctl restart ssh


---

🔑 Generar llaves SSH en el cliente

En tu equipo local (cliente), crea un par de llaves RSA de 4096 bits:

ssh-keygen -t rsa -b 4096 -C "tu_email@example.com"

Cuando se te pregunte por la ubicación del archivo, puedes presionar ENTER para usar el directorio por defecto: ~/.ssh/id_rsa.

Luego, copia tu clave pública al servidor:

ssh-copy-id tu_usuario@ip_del_servidor

Esto añadirá automáticamente tu clave al archivo ~/.ssh/authorized_keys en el servidor.


---

📂 Permisos correctos de las llaves

Asegúrate de tener los permisos adecuados en tu máquina cliente:

chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

🔎 Explicación:

El directorio ~/.ssh debe ser accesible solo por el propietario.

La clave privada id_rsa nunca debe ser leída por otros usuarios.

La clave pública puede tener permisos más abiertos.



---

⚙️ Configuración del cliente SSH (~/.ssh/config)

Opcionalmente, puedes configurar un acceso más sencillo creando o editando ~/.ssh/config:

Host mi_servidor
    HostName ip_del_servidor
    User tu_usuario
    Port 22
    IdentityFile ~/.ssh/id_rsa

Esto te permitirá conectarte con:

ssh mi_servidor


---

🔄 Cambiar el puerto SSH (opcional)

Para añadir una capa de ofuscación y reducir escaneos automáticos, puedes cambiar el puerto en /etc/ssh/sshd_config:

Port 2222

Recuerda abrir el nuevo puerto en tu firewall y cerrar el 22.

> ⚠️ Nota: Cambiar el puerto ayuda a evitar bots automatizados, pero no reemplaza otras medidas de seguridad como llaves SSH, Fail2Ban o un firewall.




---

✅ Cómo probar la configuración

1. Abre una nueva terminal sin cerrar la actual, así evitarás perder acceso si algo sale mal.


2. Conéctate con:

ssh mi_servidor


3. Intenta iniciar sesión sin usar tu llave SSH (por ejemplo, desde otra máquina sin la clave) y verifica que falle si PasswordAuthentication está desactivado.


4. Revisa los registros del servidor para detectar intentos fallidos o errores:

sudo tail -f /var/log/auth.log




---

🔒 Recomendaciones adicionales

✅ Configura un firewall como UFW o firewalld para permitir solo el puerto SSH que uses.
✅ Considera instalar Fail2Ban para bloquear direcciones IP con demasiados intentos fallidos.
✅ Mantén tu sistema y OpenSSH actualizados.


---

🙌 Autor

Creado y documentado por Camila❤️
