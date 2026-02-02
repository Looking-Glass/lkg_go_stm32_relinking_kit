#!/bin/sh

# Tools setup script

echo "Make tools directory"
mkdir -p tools

echo "Change to tools directory"
cd tools || exit

# Partial failed installs leave these files which can cause issues during setup.
echo "Clean tmp files"
rm -rf /tmp/arduino-cli
rm -f /tmp/arduino-cli*

echo "Download and Install arduino-cli"
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh -s 0.16.0

echo "Install STM32duino 1.9.0"
# Use github archive for json file, as file was deleted in mainline.
# https://github.com/stm32duino/BoardManagerFiles/commit/6a4bcdedbbb3a3c860f61ce1a25042b4cb69bffc
bin/arduino-cli --additional-urls https://raw.githubusercontent.com/stm32duino/BoardManagerFiles/cf35bad1a4f1bc31d539cd86d0271cbe9d3d214a/STM32/package_stm_index.json core install STM32:stm32

exit 0
