#!/bin/bash
# Skrypt do generowania sekcji zasobów dla mtaserver.conf
# Użycie: ./generate-resources-config.sh > resources.txt

cd "$(dirname "$0")/server/mods/deathmatch/resources" || exit 1

echo "    <!-- ============================================================================ -->"
echo "    <!-- NITRORPG RESOURCES - Automatycznie wygenerowana lista zasobów              -->"
echo "    <!-- ============================================================================ -->"
echo ""

# Priorytetowe zasoby bazy danych
echo "    <!-- Baza danych - MUSZĄ startować pierwsze -->"
for res in "[Serwer]/nrpg_db" "[Serwer]/DB" "[Serwer]/DB2"; do
    if [ -d "$res" ] && [ -f "$res/meta.xml" ]; then
        echo "    <resource src=\"$res\" startup=\"1\" protected=\"1\"/>"
    fi
done

echo ""
echo "    <!-- Rdzeń systemu -->"
for res in "[Serwer]/nrpg_core" "[Serwer]/nrpg_lib"; do
    if [ -d "$res" ] && [ -f "$res/meta.xml" ]; then
        echo "    <resource src=\"$res\" startup=\"1\" protected=\"1\"/>"
    fi
done

echo ""
echo "    <!-- System logowania -->"
for res in "[Serwer]/nrpg_newlogin"; do
    if [ -d "$res" ] && [ -f "$res/meta.xml" ]; then
        echo "    <resource src=\"$res\" startup=\"1\" protected=\"1\"/>"
    fi
done

echo ""
echo "    <!-- Pozostałe zasoby NitroRPG -->"

# Znajdź wszystkie zasoby z meta.xml
find . -name "meta.xml" -type f | while read -r metafile; do
    dir=$(dirname "$metafile")
    dir=${dir#./}
    
    # Pomiń już dodane zasoby
    case "$dir" in
        "[Serwer]/nrpg_db"|"[Serwer]/DB"|"[Serwer]/DB2"|"[Serwer]/nrpg_core"|"[Serwer]/nrpg_lib"|"[Serwer]/nrpg_newlogin")
            continue
            ;;
    esac
    
    # Pomiń zasoby edytora i gamemodes (chyba że są potrzebne)
    case "$dir" in
        *"[editor]"*|*"[gamemodes]"*)
            echo "    <resource src=\"$dir\" startup=\"0\" protected=\"0\"/>"
            ;;
        *)
            echo "    <resource src=\"$dir\" startup=\"1\" protected=\"0\"/>"
            ;;
    esac
done | sort

echo ""
echo "    <!-- Domyślne zasoby MTA -->"
echo "    <resource src=\"resourcemanager\" startup=\"1\" protected=\"1\"/>"
echo "    <resource src=\"resourcebrowser\" startup=\"0\" protected=\"1\" default=\"true\"/>"

echo ""
