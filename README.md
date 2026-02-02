# Firmware Re-linking Kit for Looking Glass Go STM32

## Overview

This repository allows users to relink the firmware for **Looking Glass Go STM32** using their own modified versions of the LGPL-licensed libraries (such as the Arduino Core or standard Arduino libraries).

In compliance with the **GNU Lesser General Public License (LGPL)**, we provide the proprietary portions of our firmware as pre-compiled object files. This allows you to combine our application logic with your own compiled version of the open-source components.

## ⚠️ Disclaimer

**This process is intended for advanced users.**
Modifying the underlying libraries or the compilation process may result in a non-functional device. Looking Glass Factory provides these files to meet license obligations but cannot offer technical support for custom-linked firmwares. Proceed at your own risk.

## 📂 Repository Structure

```text
.
├── build.sh                              # Automated build script
├── lkg-stm32
│   ├── build_opt.h
│   ├── ci.h
│   ├── hal_msp.c
│   ├── libraries
│   │   ├── CircularBuffer                # CircularBuffer LGPL-3.0 Library
│   │   │   ├── CircularBuffer.cpp
│   │   │   ├── CircularBuffer.h
│   │   │   ├── Doxyfile
│   │   │   ├── keywords.txt
│   │   │   ├── library.properties
│   │   │   ├── LICENSE
│   │   │   └── README.md
│   │   └── LkgLib                        # Looking Glass Factory Proprietary Library
│   │       ├── library.properties
│   │       ├── LICENSE
│   │       └── src
│   │           ├── cortex-m3
│   │           │   └── LkgLib.a          # Looking Glass Factory Proprietary Library Archive
│   │           └── LkgLib.h              # Header file required for interfacing to Library
│   ├── lkg-stm32.ino
│   └── Makefile
├── README.md
└── setup.sh                              # Automated source installation (run once)
```

## 📋 Prerequisites

This has been tested on Ubuntu 22.04. The following packages are required.

```bash
sudo apt install curl
```
For hardware flashing, we recommend [stlink](https://github.com/stlink-org/stlink). Further instructions can be found [here](stlink.md).

## 🚀 Instructions

### Step 1: Install Dependencies

Setting up and embedded toolchain can be complicated. This process has been automated. Running 'setup.sh' the following will be installed.

- arduino-cli alpha Version: 0.16.0 Commit: c977a238 Date: 2021-02-15T09:30:01Z
- STM32:xpack-arm-none-eabi-gcc@9.2.1-1.1
- STM32:STM32Tools@1.4.0
- STM32:CMSIS@5.5.1
- STM32:stm32@1.9.0

```bash
setup.sh
```

### Step 2: Compilation

Running build.sh will compile a link the open source code and proprietary object file. The resulting binary can be found in lkg-stm32/output/go_stm32_v0.00_build-0.bin

```bash
build.sh
```

### Step 3: Flash the Binary

The binary can be flashed to the STM32 using an ST-Link Probe

```bash
cd lkg-stm32
make swd
```

### Step 4: Reverting
By default the firmware is created with a build number of '0'. Any '0' firmwares will not be overwritten when the device boots.

If you wish to restore the default STM32 firmware, you can erase the STM32, or flash a non '0' build number firmware. Upon next boot, the firmware will be automatically re-flashed by the device.

## ⚖️ License Information
This proprietary software makes use of LGPL libraries.

* **Proprietary Object Files (`lkg-stm32/libraries/LkgLib/src/cortex-m3/LkgLib.a`):**
  LkgLib.a  
  Copyright © 2025 Looking Glass Factory, Inc. All rights reserved. Unauthorized copying or distribution is strictly prohibited.  
  With the exceptions noted below, LkgLib.a is proprietary to Looking Glass Factory, Inc. and is provided under our software terms of use which can be found [here](https://lookingglassfactory.com/terms)

* **Open Source Library CircularBuffer (`lkg-stm32/libraries/CircularBuffer`):**
    This library is licensed under LGPL-3.0. See the respective licence [here](lkg-stm32/libraries/CircularBuffer/LICENSE) for further details. The source code can be found in this repository or can be downloaded from [here](https://github.com/rlogiacco/CircularBuffer).

* **Open Source Arduino Components:**
    The Arduino Core and associated libraries are licensed under the GNU LGPL, GNU GPL, or other open-source licenses. Source code for these components are available via the official Arduino repositories or can be downloaded locally during the 'setup.sh' process.
