# 🔐 Configuración SSH Segura para GitHub

Este tutorial te guía paso a paso para generar, proteger y usar una clave SSH segura para autenticarte con GitHub desde tu terminal, sin necesidad de ingresar usuario y contraseña cada vez que haces git push, pull, o clone.

---

## 🧠 ¿Qué es SSH?

SSH (Secure Shell) es un protocolo que permite la comunicación segura entre tu ordenador y servidores o servicios remotos, como GitHub. Usar claves SSH es más seguro que autenticarte con usuario y contraseña.

---

## ✨ 1. Generar una clave SSH segura

Usaremos el algoritmo recomendado: *Ed25519*, que es más moderno, rápido y seguro que RSA.

```bash
ssh-keygen -t ed25519 -C "tu_correo@example.com"

Escribí una frase de seguridad cuando te la pida. No la dejes en blanco.


> 💡 Tip: usá una frase fácil de recordar pero difícil de adivinar.




---

🔑 2. Agregar la clave SSH al agente

Iniciá el agente SSH:

eval "$(ssh-agent -s)"

Agregá tu clave privada:

ssh-add ~/.ssh/id_ed25519

> En macOS:
Usá este comando para integrarla al llavero:
ssh-add --apple-use-keychain ~/.ssh/id_ed25519




---

⚙ 3. Configurar ~/.ssh/config (opcional pero recomendado)

Esto evita que tengas que especificar la clave cada vez.

nano ~/.ssh/config

Pegá esto dentro del archivo:

Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  AddKeysToAgent yes
  UseKeychain yes

> Guardá con Ctrl + O, luego Enter, y salí con Ctrl + X.




---

🔒 4. Ajustar permisos de las claves

Esto asegura que nadie más pueda leer tu clave privada:

chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub


---

📤 5. Añadir la clave pública a GitHub

Mostrá la clave pública en tu terminal:

cat ~/.ssh/id_ed25519.pub

Copiala (toda en una sola línea) y pegala en:

👉 https://github.com/settings/keys

Clic en "New SSH key"

Ponele un título (por ejemplo: Mi portátil)

Pegá la clave y guardá



---

✅ 6. Verificar conexión con GitHub

Probá si todo funciona:

ssh -T git@github.com

Si todo va bien, verás un mensaje como:

Hi soyCamila01! You've successfully authenticated, but GitHub does not provide shell access.


---

🚫 (Opcional) Reforzar seguridad en servidores remotos

⚠ Solo si administrás un servidor (por ejemplo con Ubuntu):

Desactivá el acceso por contraseña y obligá el uso de claves:

sudo nano /etc/ssh/sshd_config

Buscá o añadí estas líneas:

PasswordAuthentication no
PubkeyAuthentication yes

Guardá y reiniciá el servicio SSH:

sudo systemctl restart sshd

> ⚠ Asegurate de que la clave funcione antes de desactivar la contraseña, o podrías perder el acceso.




---

📌 Recursos útiles

🔗 Documentación oficial de GitHub (SSH)

🔐 SSH Keygen explicada

📁 GitHub > SSH and GPG Keys



---

💻 Autora

Hecho con ❤ por @soyCamila01
Comparte, mejora o sugerí cambios si encontrás algo útil para agregar ✨

---
