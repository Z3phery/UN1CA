# ReSukiSU
# https://github.com/ReSukiSU/ReSukiSU
LOG "- Downloading ReSukiSU app"
DOWNLOAD_FILE "https://github.com/ReSukiSU/ReSukiSU/releases/download/v4.2.0-rc2/ReSukiSU_v4.2.0-rc2_35144-arm64-v8a-release.apk" \
    "$WORK_DIR/system/system/preload/ReSukiSU/ReSukiSU.apk"

while IFS= read -r i; do
    i="${i//$WORK_DIR\/system\//}"

    if [ -d "$WORK_DIR/system/$i" ]; then
        SET_METADATA "system" "$i" 0 0 755 "u:object_r:system_file:s0"
    else
        SET_METADATA "system" "$i" 0 0 644 "u:object_r:system_file:s0"
    fi

    if [[ "$i" == *".apk" ]] && \
            ! grep -q "$i" "$WORK_DIR/system/system/etc/vpl_apks_count_list.txt"; then
        LOG "- Adding \"$i\" to /system/system/etc/vpl_apks_count_list.txt"
        EVAL "echo \"$i\" >> \"$WORK_DIR/system/system/etc/vpl_apks_count_list.txt\""
    fi
done <<< "$(find "$WORK_DIR/system/system/preload")"
