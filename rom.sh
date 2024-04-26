#!/bin/bash

# Modify ROM prefix
modify_rom_prefix() {
  echo "Performing renaming for ${device}..."
  cd device/lge/${device}
  find . -not -path "*/.*" -name "*.mk" -type f -exec sed -i "s/aosp/${rom}/g" {} +
  mv aosp_${device}.mk ${rom}_${device}.mk
  echo "Successfully renamed prefix to ${rom}"

  cd ./../../../
}

# Clone KernelSU submodule
init_ksu() {
  cd kernel/lge/sdm845
  git submodule init
  git submodule update
  cd ./../../../
}

device_choice=4
device_arr=("judyln" "judyp" "judypn")
rom=lineage

if [ "${device_choice}" == 4 ]; then
  for ((i = 0; i < ${#device_arr[@]}; i++)); do
    device="${device_arr[$i]}"
    modify_rom_prefix
  done
else
  modify_rom_prefix
fi
init_ksu

echo "Done!"
