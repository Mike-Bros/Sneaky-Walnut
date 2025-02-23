#!/bin/bash

# Start the timer
start_time=$(date +%s)

# Set the mods directory relative to the script's execution location
MODS_DIR="./mods"

# Ensure the mods directory exists
mkdir -p "$MODS_DIR"

# Clear the mods directory before downloading new files
echo "Clearing the mods directory..."
rm -rf "$MODS_DIR"/*

# Define the list of mods with their download URLs and filenames
declare -A mods
mods=(
    ["cristellib-1.1.5-fabric.jar"]="https://cdn.modrinth.com/data/cl223EMc/versions/tBnivdbu/cristellib-1.1.5-fabric.jar"
    ["bclib-3.0.14.jar"]="https://cdn.modrinth.com/data/BgNRHReB/versions/TPC86Pyz/bclib-3.0.14.jar"
    ["Towns-and-Towers-1.12-FabricForge.jar"]="https://cdn.modrinth.com/data/DjLobEOy/versions/7ZwnSrVW/Towns-and-Towers-1.12-Fabric%2BForge.jar"
    ["better-end-4.0.11.jar"]="https://cdn.modrinth.com/data/gc8OEnCC/versions/7QwyTILr/better-end-4.0.11.jar"
    ["automobility-0.4.2-1.20.1-fabric.jar"]="https://cdn.modrinth.com/data/rqIsPf9F/versions/G97BY8OB/automobility-0.4.2%2B1.20.1-fabric.jar"
    ["sleep-v.2.1.2.jar"]="https://cdn.modrinth.com/data/WTzuSu8P/versions/R5tblQON/sleep-v.2.1.2.jar"
    ["resourcefullib-fabric-1.20.1-2.1.29.jar"]="https://cdn.modrinth.com/data/G1hIVOrD/versions/UOdaYbhh/resourcefullib-fabric-1.20.1-2.1.29.jar"
    ["athena-fabric-1.20.1-3.1.2.jar"]="https://cdn.modrinth.com/data/b1ZV3DIJ/versions/mXJWSwbJ/athena-fabric-1.20.1-3.1.2.jar"
    ["chipped-fabric-1.20.1-3.0.7.jar"]="https://cdn.modrinth.com/data/BAscRYKm/versions/pwyEaKDs/chipped-fabric-1.20.1-3.0.7.jar"
    ["trowel-1.3.0-1.20.jar"]="https://cdn.modrinth.com/data/o8YrbYfv/versions/ZkkpGUSH/trowel-1.3.0-1.20.jar"
    ["createdeco-2.0.2-1.20.1-fabric.jar"]="https://cdn.modrinth.com/data/sMvUb4Rb/versions/GsxgfeNu/createdeco-2.0.2-1.20.1-fabric.jar"
    ["bellsandwhistles-0.4.5-1.20.1-fabric.jar"]="https://cdn.modrinth.com/data/gJ5afkVv/versions/m0GUubvz/bellsandwhistles-0.4.5%2B1.20.1-FABRIC.jar"
    ["trade-cycling-fabric-1.20.1-1.0.17.jar"]="https://cdn.modrinth.com/data/qpPoAL6m/versions/kkpp7peL/trade-cycling-fabric-1.20.1-1.0.17.jar"
    ["mcw-stairs-1.0.1-1.20.1fabric.jar"]="https://cdn.modrinth.com/data/iP3wH1ha/versions/XNlrOt9m/mcw-stairs-1.0.1-1.20.1fabric.jar"
    ["mcw-paintings-1.0.5-1.20.1fabric.jar"]="https://cdn.modrinth.com/data/okE6QVAY/versions/CwHvP3Pz/mcw-paintings-1.0.5-1.20.1fabric.jar"
    ["mcw-lights-1.1.1-mc1.20.1fabric.jar"]="https://cdn.modrinth.com/data/w4an97C2/versions/D8iZj41A/mcw-lights-1.1.1-mc1.20.1fabric.jar"
    ["mcw-paths-1.0.5-1.20.1fabric.jar"]="https://cdn.modrinth.com/data/VRLhWB91/versions/vusBu5Up/mcw-paths-1.0.5-1.20.1fabric.jar"
    ["mcw-trapdoors-1.1.4-mc1.20.1fabric.jar"]="https://cdn.modrinth.com/data/n2fvCDlM/versions/6FBIUQpW/mcw-trapdoors-1.1.4-mc1.20.1fabric.jar"
    ["mcw-roofs-2.3.1-mc1.20.1fabric.jar"]="https://cdn.modrinth.com/data/B8jaH3P1/versions/EOjhPmTj/mcw-roofs-2.3.1-mc1.20.1fabric.jar"
    ["mcw-bridges-3.0.0-mc1.20.1fabric.jar"]="https://cdn.modrinth.com/data/GURcjz8O/versions/RmsMXs3r/mcw-bridges-3.0.0-mc1.20.1fabric.jar"
    ["mcw-doors-1.1.2-mc1.20.1fabric.jar"]="https://cdn.modrinth.com/data/kNxa8z3e/versions/HU3H8NiB/mcw-doors-1.1.2-mc1.20.1fabric.jar"
    ["mcw-windows-2.3.0-mc1.20.1fabric.jar"]="https://cdn.modrinth.com/data/C7I0BCni/versions/88sYNcv4/mcw-windows-2.3.0-mc1.20.1fabric.jar"
    ["mcw-furniture-3.3.0-mc1.20.1fabric.jar"]="https://cdn.modrinth.com/data/dtWC90iB/versions/7aTbV3Sq/mcw-furniture-3.3.0-mc1.20.1fabric.jar"
    ["mcw-fences-1.1.2-mc1.20.1fabric.jar"]="https://cdn.modrinth.com/data/GmwLse2I/versions/NxAYnOkJ/mcw-fences-1.1.2-mc1.20.1fabric.jar"
    ["DiagonalWalls-v8.0.4-1.20.1-Fabric.jar"]="https://cdn.modrinth.com/data/FQgc8dib/versions/uAsQHTvk/DiagonalWalls-v8.0.4-1.20.1-Fabric.jar"
    ["DiagonalWindows-v8.1.5-1.20.1-Fabric.jar"]="https://cdn.modrinth.com/data/oOi0CKes/versions/mwIl45jn/DiagonalWindows-v8.1.5-1.20.1-Fabric.jar"
    ["DiagonalFences-v8.1.5-1.20.1-Fabric.jar"]="https://cdn.modrinth.com/data/IKARgflD/versions/eJNY2Ah4/DiagonalFences-v8.1.5-1.20.1-Fabric.jar"
    ["create_ultimate_factory-1.9.0-fabric-1.20.1.jar"]="https://cdn.modrinth.com/data/N9QToVpw/versions/ilaQZdXE/create_ultimate_factory-1.9.0-fabric-1.20.1.jar"
    ["create-deepslate-processing-2.0.1-fabric-1.20.1.jar"]="https://cdn.modrinth.com/data/eV1eX9u6/versions/RsTFIBzU/create_deepslate_processing-2.0.1%2Bfabric-1.20.1.jar"
    ["antientitygrief-1.0.6-1.20.jar"]="https://cdn.modrinth.com/data/Q8G7ff3j/versions/ifATPmO0/antientitygrief-1.0.6-1.20.jar"
    ["architectury-9.2.14-fabric.jar"]="https://cdn.modrinth.com/data/lhGA9TYQ/versions/WbL7MStR/architectury-9.2.14-fabric.jar"
    ["automaticdoors-1.20.1-4.9.jar"]="https://cdn.modrinth.com/data/PGBgocFc/versions/ZbVN9hr6/automaticdoors-1.20.1-4.9.jar"
    ["bluemap-5.3.jar"]="https://cdn.modrinth.com/data/swbUV1cr/versions/lHRktt6S/BlueMap-5.3-fabric-1.20.jar"
    ["calcmod-1.3.0.jar"]="https://cdn.modrinth.com/data/XoHTb2Ap/versions/Ma4inj0t/calcmod-fabric-1.20-1.3.0.jar"
    ["cardinal-components-api-5.2.3.jar"]="https://cdn.modrinth.com/data/K01OU20C/versions/Ielhod3p/cardinal-components-api-5.2.3.jar"
    ["chunky-1.3.146.jar"]="https://cdn.modrinth.com/data/fALzjamp/versions/NHWYq9at/Chunky-1.3.146.jar"
    ["collective-1.20.1-7.91.jar"]="https://cdn.modrinth.com/data/e0M1UDsY/versions/kRVILcx8/collective-1.20.1-7.91.jar"
    ["compacthelpcommand-1.20.1-2.7.jar"]="https://cdn.modrinth.com/data/XdiGl7ZL/versions/5WqQwFiT/compacthelpcommand-1.20.1-2.7.jar"
    ["create-fabric-0.5.1.jar"]="https://cdn.modrinth.com/data/Xbc0uyRg/versions/7Ub71nPb/create-fabric-0.5.1-j-build.1631%2Bmc1.20.1.jar"
    ["CreateNumismatics-1.0.11fabric-mc1.20.1.jar"]="https://cdn.modrinth.com/data/Jdbbtt0i/versions/vnV7qp9x/CreateNumismatics-1.0.11%2Bfabric-mc1.20.1.jar"
    ["create_enchantment_industry-1.2.16.jar"]="https://cdn.modrinth.com/data/AEZO385x/versions/SI0RzkGk/create_enchantment_industry-1.2.16.jar"
    ["create_power_loader-1.5.3-mc1.20.1-fabric.jar"]="https://cdn.modrinth.com/data/E9MuZ1zB/versions/fHsTW7eS/create_power_loader-1.5.3-mc1.20.1-fabric.jar"
    ["createcontraptionterminals-fabric-1.20-1.1.0.jar"]="https://cdn.modrinth.com/data/gOPAFzp0/versions/TymTJZew/createcontraptionterminals-fabric-1.20-1.1.0.jar"
    ["creategoggles-1.20.1-0.5.6.jar"]="https://cdn.modrinth.com/data/L1RT5SJc/versions/tOvw9ccm/creategoggles-1.20.1-0.5.6-%5BFABRIC%5D.jar"
    ["createoreexcavation-fabric-1.20-1.5.4.jar"]="https://cdn.modrinth.com/data/ResbpANg/versions/O48L7huv/createoreexcavation-fabric-1.20-1.5.4.jar"
    ["Create_Steam_Rails-1.6.9fabric-mc1.20.1.jar"]="https://cdn.modrinth.com/data/ZzjhlDgM/versions/VFhdqLko/Steam_Rails-1.6.9%2Bfabric-mc1.20.1.jar"
    ["create-man-of-many-planes-1.0.jar"]="https://cdn.modrinth.com/data/F4Rdk2PX/versions/XUkRA6F4/create-man-of-many-planes-1.0.jar"
    ["Crystal-Clear-2.1-Beta-fabric.jar"]="https://cdn.modrinth.com/data/h7QgiH72/versions/jCoGpP8a/Crystal-Clear-2.1-Beta-fabric.jar"
    ["create_dreams_desires-0.1d.jar"]="https://cdn.modrinth.com/data/JmybsfWs/versions/Knv9sBsR/create_dd-0.1d.jar"
    ["doors-closed-1.0.0-1.19.4.jar"]="https://cdn.modrinth.com/data/L49j7sQG/versions/fdAdmwpI/doors-closed-1.0.0%2B1.19.4.jar"
    ["essential-commands-0.35.3.jar"]="https://cdn.modrinth.com/data/6VdDUivB/versions/rzMal9h2/essential_commands-0.35.3-mc1.20.1.jar"
    ["fabric-api-0.92.3.jar"]="https://cdn.modrinth.com/data/P7dR8mSH/versions/SKPWumQf/fabric-api-0.92.3%2B1.20.1.jar"
    ["fabric-carpet-1.20-1.4.112+v230608.jar"]="https://cdn.modrinth.com/data/TQTTVgYE/versions/K0Wj117C/fabric-carpet-1.20-1.4.112%2Bv230608.jar"
    ["fabric-language-kotlin-1.13.1kotlin.2.1.10.jar"]="https://cdn.modrinth.com/data/Ha28R6CL/versions/476dzMG5/fabric-language-kotlin-1.13.1%2Bkotlin.2.1.10.jar"
    ["FarmersDelight-1.20.1-2.3.0refabricated.jar"]="https://cdn.modrinth.com/data/7vxePowz/versions/ZnoPlYRz/FarmersDelight-1.20.1-2.3.0%2Brefabricated.jar"
    ["friendsandfoes-fabric-mc1.20.1-3.0.7.jar"]="https://cdn.modrinth.com/data/POQ2i9zu/versions/90ZDpSw0/friendsandfoes-fabric-mc1.20.1-3.0.7.jar"
    ["immersive_aircraft-1.1.8-1.20.1-fabric.jar"]="https://cdn.modrinth.com/data/x3HZvrj6/versions/ExqueSy3/immersive_aircraft-1.1.8%2B1.20.1-fabric.jar"
    ["jei-1.20.1-fabric-15.20.0.106.jar"]="https://cdn.modrinth.com/data/u6dRKJwZ/versions/KcsHvRrB/jei-1.20.1-fabric-15.20.0.106.jar"
    ["journeymap-5.10.3.jar"]="https://cdn.modrinth.com/data/lfHFW1mp/versions/ThfZM7jC/journeymap-1.20.1-5.10.3-fabric.jar"
    ["LeavesBeGone-v8.0.0-1.20.1-Fabric.jar"]="https://cdn.modrinth.com/data/AVq17PqV/versions/I6xyij66/LeavesBeGone-v8.0.0-1.20.1-Fabric.jar"
    ["ledger-1.2.8.jar"]="https://cdn.modrinth.com/data/LVN9ygNV/versions/pOxgWfwI/ledger-1.2.8.jar"
    ["man_of_many_planes-0.2.0-1.20.1-fabric.jar"]="https://cdn.modrinth.com/data/9qdTHi0q/versions/BiO2Uv4J/man_of_many_planes-0.2.0%2B1.20.1-fabric.jar"
    ["modmenu-7.2.2.jar"]="https://cdn.modrinth.com/data/mOgUt4GM/versions/lEkperf6/modmenu-7.2.2.jar"
    ["Patchouli-1.20.1-81-FABRIC1.jar"]="https://cdn.modrinth.com/data/nU0bVIaL/versions/tzz6fEoj/Patchouli-1.20.1-81-FABRIC.jar"
    ["PuzzlesLib-v8.1.25-1.20.1-Fabric.jar"]="https://cdn.modrinth.com/data/QAGBst4M/versions/qjSRRf2B/PuzzlesLib-v8.1.25-1.20.1-Fabric.jar"
    ["sliceanddice-fabric-3.3.1.jar"]="https://cdn.modrinth.com/data/GmjmRQ0A/versions/EzpVcwYV/sliceanddice-fabric-3.3.1.jar"
    ["styled-chat-2.2.4-1.20.1.jar"]="https://cdn.modrinth.com/data/doqSKB0e/versions/pwr7uYCH/styled-chat-2.2.4%2B1.20.1.jar"
    ["styled-player-list-3.1.1.jar"]="https://cdn.modrinth.com/data/DQIfKUHf/versions/4FqvobxB/styledplayerlist-3.1.1%2B1.20.1.jar"
    ["toms_storage_fabric-1.20-1.7.0.jar"]="https://cdn.modrinth.com/data/XZNI4Cpy/versions/V3qjjiMa/toms_storage_fabric-1.20-1.7.0.jar"
    ["veinmining-fabric-1.5.0-1.20.1.jar"]="https://cdn.modrinth.com/data/bRAPbNyF/versions/PFFXEfYV/veinmining-fabric-1.5.0%2B1.20.1.jar"
    ["villagerinabucket-1.20.1-1.4.1.jar"]="https://cdn.modrinth.com/data/IAvnm8Mq/versions/NgPQR1RC/villagerinabucket-1.20.1-1.4.1.jar"
    ["villagernames-1.20.1-8.2.jar"]="https://cdn.modrinth.com/data/gqRXDo8B/versions/hvhPwZZ6/villagernames-1.20.1-8.2.jar"
    ["worldedit-mod-7.2.15.jar"]="https://www.curseforge.com/api/v1/mods/225608/files/4586218/download"
    ["youritemsaresafe-1.20.1-4.7.jar"]="https://cdn.modrinth.com/data/lL35xmSR/versions/oSpCGLVY/youritemsaresafe-1.20.1-4.7.jar"
    ["sophisticatedcore-1.20.1-1.0.8.1.119.jar"]="https://cdn.modrinth.com/data/9jxwkYQL/versions/KrzdxAak/sophisticatedcore-1.20.1-1.0.8.1.119.jar"
    ["sophisticatedbackpacks-1.20.1-3.21.2.1.81.jar"]="https://cdn.modrinth.com/data/ouNrBQtq/versions/g7vm5J1t/sophisticatedbackpacks-1.20.1-3.21.2.1.81.jar"
)

# Array to store failed downloads
failed_downloads=()

# Function to download mods with error handling, timing, and file size reporting
download_mod() {
    file="$1"
    url="$2"

    echo "Downloading $file..."
    mod_start_time=$(date +%s)  # Capture start time for this mod

    if curl -L --fail --silent --show-error -o "$MODS_DIR/$file" "$url"; then
        mod_end_time=$(date +%s)  # Capture end time for this mod
        mod_elapsed_time=$((mod_end_time - mod_start_time))

        # Get file size in human-readable format
        file_size=$(du -h "$MODS_DIR/$file" | cut -f1)

        echo "✅ Finished (${mod_elapsed_time}s, ${file_size}): $MODS_DIR/$file"
    else
        echo "❌ Failed to download: $file from $url"
        failed_downloads+=("$file")
    fi
}

# Start downloads in parallel
for file in "${!mods[@]}"; do
    download_mod "$file" "${mods[$file]}" &
done

# Wait for all downloads to finish
wait

# End the timer
end_time=$(date +%s)

# Calculate elapsed time
elapsed_time=$((end_time - start_time))
minutes=$((elapsed_time / 60))
seconds=$((elapsed_time % 60))

# Report failed downloads
if [ ${#failed_downloads[@]} -ne 0 ]; then
    echo -e "\n⚠️ Some mods failed to download:"
    for failed in "${failed_downloads[@]}"; do
        echo "   - $failed"
    done
    echo -e "\n⏳ Total execution time: ${minutes}m ${seconds}s"
    exit 1  # Return non-zero exit status to indicate failure
else
    echo -e "\n🎉 All mods downloaded successfully into $MODS_DIR!"
    echo -e "⏳ Total execution time: ${minutes}m ${seconds}s"
fi

java -Xmx20G -jar fabric-server-mc.1.20.1-loader.0.16.10-launcher.1.0.1.jar nogui