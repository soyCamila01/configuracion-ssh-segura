# 🔐 configuracion_ssh_segura.sh

Automatiza la configuración segura de SSH en sistemas Debian/Ubuntu de forma rápida, clara y fiable. Este script instala y configura `openssh-server`, refuerza las directivas críticas del archivo `sshd_config`, valida el estado del servicio y proporciona una interfaz interactiva fácil de usar.

> 🛡️ Creado con cariño por **Camila** — para admins que quieren eficiencia con estilo.

---

## ✨ ¿Qué hace este script?

- ✅ Instala y habilita `openssh-server`
- ✅ Realiza copia de seguridad de `sshd_config`
- ✅ Refuerza las directivas:
  - `PasswordAuthentication no`
  - `PermitRootLogin no`
  - `ChallengeResponseAuthentication no`
- ✅ Añade las líneas si no existen
- ✅ Reinicia `ssh` y verifica su estado
- ✅ Incluye un modo diagnóstico (`--verificar`)
- ✅ Presenta un menú interactivo claro para el usuario

---

## 📋 Requisitos

- Debian o Ubuntu (cualquier versión reciente)
- Permisos de superusuario (`sudo`)

---

## 🚀 Instalación

1. Cloná o copiá este script:
   ```bash
   wget https://github.com/soyCamila01/configuracion-ssh-segura/raw/main/configuracion_ssh_segura.sh
   chmod +x configuracion_ssh_segura.sh
Ejecutalo con privilegios:

bash
sudo ./configuracion_ssh_segura.sh
🧪 Modo diagnóstico
Para ver la configuración actual sin modificar nada:

bash
sudo ./configuracion_ssh_segura.sh --verificar
📂 Archivos generados
/etc/ssh/sshd_config.bak → Copia de seguridad del archivo antes de aplicar cambios

🤝 Contribuciones
¡Se aceptan mejoras! Abrí un issue o enviá un pull request si querés aportar.

📜 Licencia
Este script está distribuido bajo la licencia MIT. Usalo, modificalo, compartilo.

✍️ Autora
Camila Admin de sistemas, defensora del acceso seguro.


—
