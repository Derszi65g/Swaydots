#!/bin/bash

# --- Configuración ---
CURRENT_WALLPAPER_LINK="$HOME/.config/current_wallpaper_symlink"
ROFI_LAUNCHER_THEME="$HOME/.config/rofi/sway/themes/launcher.rasi"

# --- Lógica Principal ---
if [ -f "$CURRENT_WALLPAPER_LINK" ] && [ -r "$CURRENT_WALLPAPER_LINK" ]; then
    IMAGE_PATH_RESOLVED=$(readlink -f "$CURRENT_WALLPAPER_LINK") # Obtener ruta real por si acaso
    
    echo "Usando wallpaper (ruta resuelta): $IMAGE_PATH_RESOLVED para el fondo de Rofi." >&2
    
    # Ejecutar Rofi, intentando primero sin el scaler 'cover'
    rofi -show drun \
         -theme "$ROFI_LAUNCHER_THEME" \
         -theme-str "configuration { show-icons: true; } inputbar { background-image: url(\"$IMAGE_PATH_RESOLVED\",width ); }"
         # He añadido show-icons por si ayuda a Rofi a tratar mejor las imágenes
         # y he quitado la coma y 'cover' temporalmente.
else
    echo "Advertencia: No se pudo encontrar el wallpaper en '$CURRENT_WALLPAPER_LINK' o no es legible." >&2
    echo "Lanzando Rofi sin imagen de fondo personalizada en inputbar." >&2
    rofi -show drun -theme "$ROFI_LAUNCHER_THEME"
fi
