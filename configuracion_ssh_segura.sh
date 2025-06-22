
#!/bin/bash

# Script: configuracion_ssh_segura.sh
# Propósito: Configurar de forma segura el acceso SSH en Debian/Ubuntu
# Autora: Camila 💻☁️

echo "🔐 Iniciando configuración segura de SSH..."

# Verificar privilegios
if [ "$EUID" -ne 0 ]; then
  echo "🚫 Este script debe ejecutarse como root. Usa sudo."
  exit 1
fi

# Paso 1: Instalar y activar el servidor SSH
echo "📦 Verificando e instalando openssh-server..."
apt update && apt install -y openssh-server
echo "✅ Instalación completa."

echo "🚀 Habilitando y arrancando el servicio SSH..."
systemctl enable ssh
systemctl start ssh
echo "📡 Estado del servicio SSH:"
systemctl status ssh --no-pager

# Función para reforzar directivas clave
reforzar_linea() {
  local clave="$1"
  local archivo="/etc/ssh/sshd_config"

  if grep -Eq "^\s*(#\s*)?${clave}\b" "$archivo"; then
    sudo sed -i -E "s|^\s*(#\s*)?(${clave})\s+.*|\2 no|" "$archivo" \
      && echo "✅ ${clave} reforzado (modificado)"
  else
    echo -e "\n${clave} no" | sudo tee -a "$archivo" > /dev/null \
      && echo "✅ ${clave} reforzado (agregado)"
  fi

  if grep -Eq "^${clave} no" "$archivo"; then
    echo "🔒 Confirmado: ${clave} = no"
  else
    echo "⚠️ Falló el refuerzo de ${clave}"
  fi
}

# Aplicación completa de refuerzos
aplicar_refuerzos() {
  echo ""
  echo "📦 Generando respaldo de sshd_config..."
  sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak && echo "✅ Backup creado"

  echo ""
  echo "🚧 Aplicando refuerzos de seguridad:"
  reforzar_linea PasswordAuthentication
  reforzar_linea PermitRootLogin
  reforzar_linea ChallengeResponseAuthentication

  echo ""
  echo "🔄 Reiniciando servicio SSH para aplicar los cambios..."
  sudo systemctl restart ssh && echo "✅ SSH reiniciado correctamente" || echo "⚠️ No se pudo reiniciar el servicio SSH"

  echo ""
  echo "📋 Estado final del archivo:"
  grep -Ei '^\s*(PasswordAuthentication|PermitRootLogin|ChallengeResponseAuthentication)' /etc/ssh/sshd_config

  echo ""
  echo "🎉 Configuración segura completada. ¡Buen trabajo, Camila!"
}

# Verificación de configuración actual
verificar_estado() {
  echo ""
  echo "🔎 Verificando configuración actual de SSH..."
  grep -Ei '^\s*(PasswordAuthentication|PermitRootLogin|ChallengeResponseAuthentication)' /etc/ssh/sshd_config
  echo ""
  sudo systemctl is-active --quiet ssh \
    && echo "✅ SSH está corriendo" \
    || echo "❌ SSH no se está ejecutando"
}

# Menú principal
echo ""
echo "🔐 Configuración segura de SSH"
echo "¿Qué querés hacer?"
echo "1) Aplicar refuerzos"
echo "2) Verificar estado"
read -p "Seleccioná una opción: " opcion

case $opcion in
  1) aplicar_refuerzos ;;
  2) verificar_estado ;;
  *) echo "❌ Opción inválida. Ejecutá de nuevo el script." ;;
esac
