🔐 Configuración SSH Segura para GitHub

Guía completa para configurar una clave SSH segura con GitHub. Autentícate desde la terminal sin necesidad de ingresar usuario y contraseña en cada git push, pull o clone. ¡Sigue estos pasos y tendrás una configuración robusta en minutos!

🧠 ¿Qué es SSH?

SSH (Secure Shell) es un protocolo criptográfico que garantiza una comunicación segura entre tu computadora y servidores remotos como GitHub. Usar claves SSH es más seguro y práctico que la autenticación por contraseña.


🚀 Pasos para configurar SSH

1. Generar una clave SSH segura

Usa el algoritmo Ed25519, recomendado por ser más seguro, compacto y eficiente que RSA:

ssh-keygen -t ed25519 -C "tu_correo@example.com"


Instrucciones:

Reemplaza tu_correo@example.com con el correo asociado a tu cuenta de GitHub.



Cuando se te pida, ingresa una frase de seguridad fuerte. No la dejes en blanco.



Acepta la ubicación predeterminada (~/.ssh/id_ed25519) presionando Enter.



💡 Tip: Usa una frase de seguridad única y memorable, como una oración corta. Evita contraseñas obvias. ⚠ Nota: Si tu sistema no soporta Ed25519 (muy raro), usa RSA con ssh-keygen -t rsa -b 4096 -C "tu_correo@example.com".



2. Iniciar el agente SSH y agregar la clave

Inicia el agente SSH para gestionar tus claves:

eval "$(ssh-agent -s)"

Agrega tu clave privada al agente:

ssh-add ~/.ssh/id_ed25519


En macOS (para integrar con el llavero y evitar repetir la frase de seguridad):

ssh-add --apple-use-keychain ~/.ssh/id_ed25519



⚠ Solución a errores comunes:


Si recibes Could not open a connection to your authentication agent, verifica que el agente esté corriendo con eval "$(ssh-agent -s)".



Si el comando ssh-add falla, asegúrate de que el archivo ~/.ssh/id_ed25519 existe.



3. Configurar el archivo ~/.ssh/config (recomendado)

Simplifica la conexión automática con GitHub creando un archivo de configuración:

nano ~/.ssh/config

Pega el siguiente contenido:

Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  AddKeysToAgent yes
  UseKeychain yes


Instrucciones:


Guarda con Ctrl + O, presiona Enter, y sal con Ctrl + X.



Si el archivo ~/.ssh/config no existe, este comando lo creará.



💡 Beneficio: Esta configuración asegura que GitHub use la clave correcta automáticamente. 🍎 Nota para macOS: UseKeychain yes permite que el llavero almacene la frase de seguridad.



4. Proteger los permisos de las claves

Asegura que solo tú puedas acceder a tus claves:

chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub


Por qué: El archivo privado (id_ed25519) debe ser de solo lectura para el propietario, mientras que el público (id_ed25519.pub) puede ser legible por otros.



⚠ Verifica: Usa ls -l ~/.ssh/ para confirmar que los permisos sean correctos (-rw------- para el privado, -rw-r--r-- para el público).



5. Añadir la clave pública a GitHub

Muestra tu clave pública:

cat ~/.ssh/id_ed25519.pub

Copia la salida (debe empezar con ssh-ed25519 y terminar con tu correo).

Luego, añádela a GitHub:



Ve a github.com/settings/keys.



Haz clic en New SSH key o Add SSH key.



Asigna un título descriptivo (ej. "Mi portátil - 2025").



Pega la clave en el campo "Key" (asegúrate de que esté en una sola línea).



Haz clic en Add SSH key y autentícate si es necesario.



⚠ Error común: No copies espacios o caracteres adicionales. La clave debe ser exacta.



6. Verificar la conexión con GitHub

Prueba la autenticación:

ssh -T git@github.com

Si todo está correcto, verás:

Hi <tu_usuario>! You've successfully authenticated, but GitHub does not provide shell access.



⚠ Solución a errores:





"Permission denied (publickey)": Verifica que la clave pública esté correctamente añadida en GitHub y que el archivo ~/.ssh/config esté configurado.



"Agent refused operation": Asegúrate de que la clave esté agregada al agente con ssh-add.



🔒 (Opcional) Reforzar seguridad en servidores remotos

Si administras un servidor (ej. Ubuntu), puedes deshabilitar la autenticación por contraseña para mayor seguridad:





Edita el archivo de configuración SSH:

sudo nano /etc/ssh/sshd_config





Asegúrate de que incluya:

PasswordAuthentication no
PubkeyAuthentication yes





Guarda (Ctrl + O, Enter, Ctrl + X) y reinicia el servicio SSH:

sudo systemctl restart sshd



⚠ Precaución: Antes de desactivar la autenticación por contraseña, verifica que puedes conectarte al servidor con tu clave SSH. De lo contrario, podrías perder el acceso.



🛠️ Resolución de problemas





Clave no funciona: Asegúrate de que la clave pública en GitHub coincide exactamente con ~/.ssh/id_ed25519.pub.



Errores de permisos: Revisa los permisos con ls -l ~/.ssh/ y corrige con chmod si es necesario.



Git sigue pidiendo contraseña: Verifica que estás usando la URL SSH del repositorio (git@github.com:usuario/repo.git) y no HTTPS.



Problemas en Windows: Usa Git Bash o WSL2 y asegúrate de que el agente SSH esté corriendo.



📌 Recursos útiles





🔗 Documentación oficial de GitHub sobre SSH



🔐 Guía de ssh-keygen (OpenSSH)



📁 Administrar claves SSH en GitHub



💻 Autora

Hecho con ❤️ por @soyCamila01
🌟 ¡Comparte esta guía, sugiere mejoras o abre un issue si encuentras algo que perfeccionar! 🚀
