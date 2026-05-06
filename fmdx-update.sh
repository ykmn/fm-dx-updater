#!/usr/bin/env bash
# ------------------------------------------------------------------
# FM-DX Webserver + Plugins Installer / Updater
# v1.0.0 2026-05-06 Initial release
# ------------------------------------------------------------------

# ====================== USER CONFIGURATION ======================

# Select preferred language: en / ru / fr / de
LANGUAGE="en"
# folders and version
PROJECT_ROOT="$HOME/fm-dx-webserver"
SRC_ROOT="$PROJECT_ROOT/plugins-dist"
DST_ROOT="$PROJECT_ROOT/plugins"
VERSION="1.0.0"

MAIN_REPO="https://github.com/NoobishSVK/fm-dx-webserver"

# Plugins list: add/remove repositories
PLUGINS=(
    "https://github.com/Highpoint2000/webserver-scanner"
    "https://github.com/Highpoint2000/Autotune"
    "https://github.com/Highpoint2000/AutoMemory"
    "https://github.com/Highpoint2000/PeakMeter"
    "https://github.com/Highpoint2000/webserver-logger"
    "https://github.com/Highpoint2000/webserver-station-logos"
    "https://github.com/Highpoint2000/webserver-time"
    "https://github.com/AmateurAudioDude/FM-DX-Webserver-Plugin-Spectrum-Graph"
    "https://github.com/AmateurAudioDude/FM-DX-Webserver-Plugin-Button-Presets"
    "https://github.com/AmateurAudioDude/FM-DX-Webserver-Plugin-S-Meter"
    "https://github.com/AmateurAudioDude/FM-DX-Webserver-Plugin-Inactivity-Monitor"
    "https://github.com/LucasGallone/RDSExpert-Plugin"
    "https://github.com/NoobishSVK/fm-dx-webserver-plugin-weather"
    "https://github.com/noobishsvk/fm-dx-webserver-plugin-themes"
    "https://github.com/mrwish7/webserver-audio-recorder"
)

# ====================== LANGUAGE TRANSLATIONS ======================
if [[ "$LANGUAGE" == "ru" ]]; then
    MSG_TITLE="=== FM-DX Webserver + Plugins Installer v0.9.1 ==="
    MSG_MAIN_CHECK="🔄 Проверка основного проекта..."
    MSG_MAIN_UPDATED="   ✅ Основной проект обновлён"
    MSG_MAIN_UPTODATE="   ✓ Основной проект уже актуален"
    MSG_MAIN_CLONING="   📥 Клонирование основного проекта..."
    MSG_MAIN_CLONED="   ✅ Основной проект установлен"
    MSG_MAIN_ERROR="   ❌ Ошибка клонирования основного проекта"
    MSG_PLUGINS_SECTION="=== Обновление плагинов ==="
    MSG_PLUGIN_CHECK="   🔄"
    MSG_PLUGIN_CLONING="   📥"
    MSG_PLUGIN_UPDATED="📥 Обновлён"
    MSG_PLUGIN_UPTODATE="✓ Актуален"
    MSG_PLUGIN_CLONED="✅ Клонирован"
    MSG_PLUGIN_ERROR="⚠️ Ошибка"
    MSG_INSTALLING="      🔄 Копирование файлов плагина..."
    MSG_NO_JS="      ⚠️ .js файл не найден"
    MSG_COPY_FOLDER="      📁 Копируем: "
    MSG_RESTART="🔄 Были обновления → Перезапускаем FM-DX Webserver..."
    MSG_RESTART_OK="✅ Сервис перезапущен"
    MSG_RESTART_FAIL="⚠️ Ошибка запуска сервиса"
    MSG_ALL_DONE="✓ Всё уже актуально"
    MSG_FINAL="🎉 Готово!"

elif [[ "$LANGUAGE" == "fr" ]]; then
    MSG_TITLE="=== FM-DX Webserver + Plugins Installer v0.9.1 ==="
    MSG_MAIN_CHECK="🔄 Vérification du projet principal..."
    MSG_MAIN_UPDATED="   ✅ Projet principal mis à jour"
    MSG_MAIN_UPTODATE="   ✓ Projet principal à jour"
    MSG_MAIN_CLONING="   📥 Clonage du projet principal..."
    MSG_MAIN_CLONED="   ✅ Projet principal installé"
    MSG_MAIN_ERROR="   ❌ Échec du clonage du projet principal"
    MSG_PLUGINS_SECTION="=== Mise à jour des plugins ==="
    MSG_PLUGIN_CHECK="   🔄"
    MSG_PLUGIN_CLONING="   📥"
    MSG_PLUGIN_UPDATED="📥 Mis à jour"
    MSG_PLUGIN_UPTODATE="✓ À jour"
    MSG_PLUGIN_CLONED="✅ Cloné"
    MSG_PLUGIN_ERROR="⚠️ Erreur"
    MSG_INSTALLING="      🔄 Installation des fichiers du plugin..."
    MSG_NO_JS="      ⚠️ Fichier .js non trouvé"
    MSG_COPY_FOLDER="      📁 Copie du dossier : "
    MSG_RESTART="🔄 Mises à jour détectées → Redémarrage de FM-DX Webserver..."
    MSG_RESTART_OK="✅ Service redémarré"
    MSG_RESTART_FAIL="⚠️ Échec du redémarrage du service"
    MSG_ALL_DONE="✓ Tout est à jour"
    MSG_FINAL="🎉 Terminé!"

elif [[ "$LANGUAGE" == "de" ]]; then
    MSG_TITLE="=== FM-DX Webserver + Plugins Installer v0.9.1 ==="
    MSG_MAIN_CHECK="🔄 Überprüfung des Hauptprojekts..."
    MSG_MAIN_UPDATED="   ✅ Hauptprojekt aktualisiert"
    MSG_MAIN_UPTODATE="   ✓ Hauptprojekt ist aktuell"
    MSG_MAIN_CLONING="   📥 Klonen des Hauptprojekts..."
    MSG_MAIN_CLONED="   ✅ Hauptprojekt installiert"
    MSG_MAIN_ERROR="   ❌ Fehler beim Klonen des Hauptprojekts"
    MSG_PLUGINS_SECTION="=== Plugins aktualisieren ==="
    MSG_PLUGIN_CHECK="   🔄"
    MSG_PLUGIN_CLONING="   📥"
    MSG_PLUGIN_UPDATED="📥 Aktualisiert"
    MSG_PLUGIN_UPTODATE="✓ Aktuell"
    MSG_PLUGIN_CLONED="✅ Geklont"
    MSG_PLUGIN_ERROR="⚠️ Fehler"
    MSG_INSTALLING="      🔄 Plugin-Dateien werden kopiert..."
    MSG_NO_JS="      ⚠️ .js-Datei nicht gefunden"
    MSG_COPY_FOLDER="      📁 Kopiere Ordner: "
    MSG_RESTART="🔄 Updates erkannt → Starte FM-DX Webserver neu..."
    MSG_RESTART_OK="✅ Service neu gestartet"
    MSG_RESTART_FAIL="⚠️ Fehler beim Neustart des Services"
    MSG_ALL_DONE="✓ Alles ist aktuell"
    MSG_FINAL="🎉 Fertig!"

else
    # English (default)
    MSG_TITLE="=== FM-DX Webserver + Plugins Installer v0.9.1 ==="
    MSG_MAIN_CHECK="🔄 Checking main project..."
    MSG_MAIN_UPDATED="   ✅ Main project updated"
    MSG_MAIN_UPTODATE="   ✓ Main project is up to date"
    MSG_MAIN_CLONING="   📥 Cloning main project..."
    MSG_MAIN_CLONED="   ✅ Main project installed"
    MSG_MAIN_ERROR="   ❌ Failed to clone main project"
    MSG_PLUGINS_SECTION="=== Updating plugins ==="
    MSG_PLUGIN_CHECK="   🔄"
    MSG_PLUGIN_CLONING="   📥"
    MSG_PLUGIN_UPDATED="📥 Updated"
    MSG_PLUGIN_UPTODATE="✓ Up to date"
    MSG_PLUGIN_CLONED="✅ Cloned"
    MSG_PLUGIN_ERROR="⚠️ Error"
    MSG_INSTALLING="      🔄 Installing plugin files..."
    MSG_NO_JS="      ⚠️ .js file not found"
    MSG_COPY_FOLDER="      📁 Copying: "
    MSG_RESTART="🔄 Updates detected → Restarting FM-DX Webserver..."
    MSG_RESTART_OK="✅ Service restarted"
    MSG_RESTART_FAIL="⚠️ Failed to restart service"
    MSG_ALL_DONE="✓ Everything is up to date"
    MSG_FINAL="🎉 Done!"
fi

# ====================== INIT ======================
any_update=false
echo "$MSG_TITLE"

# ====================== Install/update fm-dx-webserver repository ======================
echo "$MSG_MAIN_CHECK"

if [[ -d "$PROJECT_ROOT/.git" ]]; then
    cd "$PROJECT_ROOT"
    OLD_COMMIT=$(git rev-parse HEAD 2>/dev/null || echo "none")
    if git pull --ff-only --quiet; then
        NEW_COMMIT=$(git rev-parse HEAD)
        if [[ "$OLD_COMMIT" != "$NEW_COMMIT" ]]; then
            any_update=true
            echo "$MSG_MAIN_UPDATED"
        else
            echo "$MSG_MAIN_UPTODATE"
        fi
    else
        echo "   ⚠️ Pull error"
    fi
else
    echo "$MSG_MAIN_CLONING"
    cd "$HOME"
    if git clone --quiet "$MAIN_REPO" fm-dx-webserver; then
        any_update=true
        echo "$MSG_MAIN_CLONED"
    else
        echo "$MSG_MAIN_ERROR"
        exit 1
    fi
fi

# ====================== Install/update plugins repositories ======================
mkdir -p "$SRC_ROOT" "$DST_ROOT"
echo -e "\n$MSG_PLUGINS_SECTION"

for url in "${PLUGINS[@]}"; do
    repo_dir="${url##*/}"
    repo_dir="${repo_dir%.git}"
    target_path="$SRC_ROOT/$repo_dir"

    updated=false

    if [[ -d "$target_path/.git" ]]; then
        echo -n "$MSG_PLUGIN_CHECK $repo_dir → "
        OLD_COMMIT=$(git -C "$target_path" rev-parse HEAD 2>/dev/null || echo "none")
        
        if git -C "$target_path" pull --ff-only --quiet; then
            NEW_COMMIT=$(git -C "$target_path" rev-parse HEAD)
            if [[ "$OLD_COMMIT" != "$NEW_COMMIT" ]]; then
                updated=true
                echo "$MSG_PLUGIN_UPDATED"
            else
                echo "$MSG_PLUGIN_UPTODATE"
            fi
        else
            echo "$MSG_PLUGIN_ERROR"
        fi
    else
        echo -n "$MSG_PLUGIN_CLONING $repo_dir → "
        if git clone --quiet "$url" "$target_path"; then
            updated=true
            echo "$MSG_PLUGIN_CLONED"
        else
            echo "$MSG_PLUGIN_ERROR"
        fi
    fi

    if [[ "$updated" == false ]]; then
        continue
    fi

    any_update=true
    echo "$MSG_INSTALLING"

    js_file=$(find "$target_path" -type f -name "*.js" 2>/dev/null | 
              awk '{print gsub("/", "/"), $0}' | sort -n | head -n 1 | cut -d' ' -f2-)

    if [[ -z "$js_file" ]]; then
        echo "$MSG_NO_JS"
        continue
    fi

    parent_dir=$(dirname "$js_file")

    cp -f "$js_file" "$DST_ROOT/"

    for folder in "$parent_dir"/*/ ; do
        if [[ -d "$folder" ]]; then
            folder_name=$(basename "$folder")
            [[ "$folder_name" == "." || "$folder_name" == ".." || 
               "$folder_name" == ".git" || "$folder_name" == "plugins" ]] && continue

            echo "${MSG_COPY_FOLDER}$folder_name/"
            rm -rf "$DST_ROOT/$folder_name"
            cp -rT "$folder" "$DST_ROOT/$folder_name" 2>/dev/null || true
        fi
    done
done

# ====================== Service restart ======================
echo
if [[ "$any_update" == true ]]; then
    echo "$MSG_RESTART"
    sudo systemctl restart fm-dx-webserver.service
    if systemctl is-active --quiet fm-dx-webserver.service; then
        echo "$MSG_RESTART_OK"
    else
        echo "$MSG_RESTART_FAIL"
    fi
else
    echo "$MSG_ALL_DONE"
fi

echo -e "\n$MSG_FINAL (v$VERSION)"
