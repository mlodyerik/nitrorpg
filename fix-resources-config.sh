#!/bin/bash

# Kolory dla czytelności
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}==================================================================${NC}"
echo -e "${GREEN}NITRORPG - Naprawa konfiguracji zasobów${NC}"
echo -e "${GREEN}==================================================================${NC}"

CONF_FILE="/projects/sandbox/nitrorpg/server/mods/deathmatch/mtaserver.conf"
BACKUP_FILE="/projects/sandbox/nitrorpg/server/mods/deathmatch/mtaserver.conf.backup.$(date +%Y%m%d_%H%M%S)"
RESOURCES_DIR="/projects/sandbox/nitrorpg/server/mods/deathmatch/resources"

# Backup
echo -e "\n${YELLOW}1. Tworzenie kopii zapasowej...${NC}"
cp "$CONF_FILE" "$BACKUP_FILE"
echo -e "${GREEN}✓ Kopia zapasowa: $BACKUP_FILE${NC}"

# Znajdź wszystkie rzeczywiste zasoby
echo -e "\n${YELLOW}2. Skanowanie zasobów...${NC}"
declare -A RESOURCES

# Znajdź foldery z meta.xml
while IFS= read -r meta_path; do
    resource_dir=$(dirname "$meta_path")
    resource_name=$(basename "$resource_dir")
    resource_path="${resource_dir#$RESOURCES_DIR/}"
    RESOURCES["$resource_name"]="$resource_path"
done < <(find "$RESOURCES_DIR" -name "meta.xml" -type f)

echo -e "${GREEN}✓ Znaleziono ${#RESOURCES[@]} zasobów z meta.xml${NC}"

# Buduj nową sekcję zasobów
echo -e "\n${YELLOW}3. Generowanie nowej konfiguracji...${NC}"

# Wyciągnij część konfiguracji PRZED zasobami
sed -n '1,/<!-- ============================================================================ -->/p' "$CONF_FILE" > "$CONF_FILE.new"

# Dodaj nową sekcję zasobów
cat >> "$CONF_FILE.new" << 'HEADER'
<!-- NITRORPG RESOURCES - ZASOBY SERWEROWE                                       -->
<!-- Kolejność uruchamiania jest krytyczna!                                      -->
<!-- ============================================================================ -->

<!-- ====================== PODSTAWOWE ZASOBY ====================== -->

HEADER

# Dodaj zasoby w odpowiedniej kolejności

# 1. Bazy danych
echo "    <!-- Bazy danych -->" >> "$CONF_FILE.new"
for res in "nrpg_db" "DB" "DB2"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"1\"/>" >> "$CONF_FILE.new"
    fi
done

# 2. Core system
echo -e "\n    <!-- Rdzeń systemu -->" >> "$CONF_FILE.new"
for res in "nrpg_core" "nrpg_lib"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"1\"/>" >> "$CONF_FILE.new"
    fi
done

# 3. Login
echo -e "\n    <!-- System logowania -->" >> "$CONF_FILE.new"
if [[ -n "${RESOURCES[nrpg_newlogin]}" ]]; then
    echo "    <resource src=\"${RESOURCES[nrpg_newlogin]}\" startup=\"1\" protected=\"1\"/>" >> "$CONF_FILE.new"
fi

# 4. Interface
echo -e "\n    <!-- Interfejs użytkownika -->" >> "$CONF_FILE.new"
for res in "nrpg_interface" "nrpg_hud" "nrpg_dashboard" "nrpg_scoreboard"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 5. Pojazdy
echo -e "\n    <!-- Systemy pojazdów -->" >> "$CONF_FILE.new"
for res in "nrpg_vehicles" "nrpg_speedo" "nrpg_licznik" "nrpg_carsell" "nrpg_salon" "nrpg_storevehicle" "nrpg_syrenki" "nrpg_handlings" "nrpg_carTint" "nrpg_carTrunk" "nrpg_vehicleAddons" "nrpg_clearcars"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 6. Gracze
echo -e "\n    <!-- Systemy gracza -->" >> "$CONF_FILE.new"
for res in "nrpg_levels" "nrpg_userpanel" "nrpg_anims" "nrpg_clothes" "nrpg_przebieralnia" "nrpg_nametags" "nrpg_avatars"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 7. Ekonomia
echo -e "\n    <!-- Systemy ekonomiczne -->" >> "$CONF_FILE.new"
for res in "nrpg_atms" "nrpg_24shop" "nrpg_trade"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 8. Nieruchomości
echo -e "\n    <!-- Systemy nieruchomości -->" >> "$CONF_FILE.new"
for res in "nrpg_houseSystem" "nrpg_houseBuilder"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 9. Urzędy
echo -e "\n    <!-- Systemy urzędu -->" >> "$CONF_FILE.new"
for res in "nrpg_urzad" "nrpg_license"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 10. Mechanik
echo -e "\n    <!-- Systemy mechaniczne -->" >> "$CONF_FILE.new"
for res in "nrpg_mechanic" "nrpg_wulkanizacja" "nrpg_zlomowisko"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 11. Stacje
echo -e "\n    <!-- Systemy stacji -->" >> "$CONF_FILE.new"
for res in "nrpg_stations" "nrpg_charger"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 12. Tuning
echo -e "\n    <!-- Systemy tuningu -->" >> "$CONF_FILE.new"
for res in "nrpg_neons" "nrpg_paintjobs" "nrpg_components" "nrpg_tuning"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 13. GPS/Mapa
echo -e "\n    <!-- Systemy GPS i mapy -->" >> "$CONF_FILE.new"
for res in "gps" "nrpg_radar" "nrpg_radarArea" "nrpg_markers"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 14. Interakcja
echo -e "\n    <!-- Systemy interakcji -->" >> "$CONF_FILE.new"
for res in "nrpg_interakcja" "nrpg_buttons" "nrpg_interiors" "nrpg_cuboid"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 15. Frakcje - znajdź wszystkie zasoby frakcyjne
echo -e "\n    <!-- Frakcje -->" >> "$CONF_FILE.new"
for res_path in "${RESOURCES[@]}"; do
    if [[ "$res_path" == *"[Frakcje]"* ]] || [[ "$res_path" == *"nrpg_faction"* ]]; then
        echo "    <resource src=\"$res_path\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 16. Organizacje
echo -e "\n    <!-- Organizacje -->" >> "$CONF_FILE.new"
for res_path in "${RESOURCES[@]}"; do
    if [[ "$res_path" == *"[Organizacje]"* ]] || [[ "$res_path" == *"nrpg_org_"* ]]; then
        echo "    <resource src=\"$res_path\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 17. Prace
echo -e "\n    <!-- Prace -->" >> "$CONF_FILE.new"
for res_path in "${RESOURCES[@]}"; do
    if [[ "$res_path" == *"[Prace]"* ]] || [[ "$res_path" == *"nrpg_job"* ]]; then
        echo "    <resource src=\"$res_path\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 18. Chat
echo -e "\n    <!-- Systemy czatu i komunikacji -->" >> "$CONF_FILE.new"
for res in "nrpg_chatInfo" "nrpg_clearChat" "nrpg_3dtext" "nrpg_editbox"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 19. Multimedia
echo -e "\n    <!-- Systemy multimedia -->" >> "$CONF_FILE.new"
for res in "nrpg_newstereo" "nrpg_radio" "nrpg_voice"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 20. Rozrywka
echo -e "\n    <!-- Systemy rozrywki -->" >> "$CONF_FILE.new"
for res in "nrpg_ruleta" "nrpg_prezent" "nrpg_prezenty" "nrpg_premiumads"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 21. Admin
echo -e "\n    <!-- Systemy administracji -->" >> "$CONF_FILE.new"
for res in "nrpg_admin" "nrpg_adminPanel" "nrpg_helppanel" "nrpg_whitelist" "nrpg_public" "nrpg_getpos" "nrpg_op" "acpanel" "admin" "admin2" "runcode"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 22. Bezpieczeństwo
echo -e "\n    <!-- Systemy bezpieczeństwa -->" >> "$CONF_FILE.new"
for res in "nrpg_antycheat" "nrpg_antysyrenkiFBI" "nrpg_antywybuchcpn"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 23. Discord
echo -e "\n    <!-- Discord Integration -->" >> "$CONF_FILE.new"
for res in "discord" "discord-events" "nrpg_discord" "nrpg_dcconnect"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 24. Systemy dodatkowe
echo -e "\n    <!-- Systemy dodatkowe -->" >> "$CONF_FILE.new"
for res in "nrpg_weather" "nrpg_snow" "nrpg_fog" "nrpg_fotoradary" "nrpg_playerblips" "nrpg_abs_system" "nrpg_customseats" "nrpg_deletevmax" "nrpg_dryer" "nrpg_firstpearson" "nrpg_glue" "nrpg_ogranicznik" "nrpg_object_preview" "nrpg_peds" "nrpg_reload" "nrpg_style" "nrpg_variants" "nrpg_autostart"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 25. Boty i DM
echo -e "\n    <!-- Boty i Deathmatch -->" >> "$CONF_FILE.new"
for res in "slothbot" "nrpg_bots" "nrpg_strefaDM"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 26. Mapy
echo -e "\n    <!-- Mapy -->" >> "$CONF_FILE.new"
for res_path in "${RESOURCES[@]}"; do
    if [[ "$res_path" == *"[Mapy]"* ]] || [[ "$res_path" == *"map_"* ]]; then
        echo "    <resource src=\"$res_path\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 27. Modele
echo -e "\n    <!-- Modele -->" >> "$CONF_FILE.new"
for res_path in "${RESOURCES[@]}"; do
    if [[ "$res_path" == *"[Modele]"* ]] || [[ "$res_path" == *"mod_"* ]]; then
        echo "    <resource src=\"$res_path\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 28. Shadery
echo -e "\n    <!-- Shadery -->" >> "$CONF_FILE.new"
for res_path in "${RESOURCES[@]}"; do
    if [[ "$res_path" == *"[Shaders]"* ]] || [[ "$res_path" == *"shader_"* ]]; then
        echo "    <resource src=\"$res_path\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 29. Community
echo -e "\n    <!-- Community -->" >> "$CONF_FILE.new"
for res_path in "${RESOURCES[@]}"; do
    if [[ "$res_path" == *"[community]"* ]]; then
        echo "    <resource src=\"$res_path\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# 30. Web Admin
echo -e "\n    <!-- Web Admin -->" >> "$CONF_FILE.new"
for res in "webadmin" "ipb"; do
    if [[ -n "${RESOURCES[$res]}" ]]; then
        echo "    <resource src=\"${RESOURCES[$res]}\" startup=\"1\" protected=\"0\"/>" >> "$CONF_FILE.new"
    fi
done

# Dodaj zamknięcie sekcji
echo -e "\n</config>" >> "$CONF_FILE.new"

# Zastąp stary plik
echo -e "\n${YELLOW}4. Zastępowanie konfiguracji...${NC}"
mv "$CONF_FILE.new" "$CONF_FILE"

echo -e "${GREEN}✓ Konfiguracja zaktualizowana!${NC}"

# Statystyki
TOTAL_RESOURCES=$(grep -c "<resource src=" "$CONF_FILE")
echo -e "\n${GREEN}==================================================================${NC}"
echo -e "${GREEN}PODSUMOWANIE:${NC}"
echo -e "${GREEN}  - Zasoby w konfiguracji: $TOTAL_RESOURCES${NC}"
echo -e "${GREEN}  - Kopia zapasowa: $(basename $BACKUP_FILE)${NC}"
echo -e "${GREEN}==================================================================${NC}"
