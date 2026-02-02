# Get the path the Makefile is in
MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

OUTPUT_NAME=output
BIN_NAME=${OUTPUT_NAME}.bin
OUTPUT_DIR=output
BUILD_DIR=$(MAKEFILE_DIR)/build
LIBRARIES_DIR=$(MAKEFILE_DIR)/libraries

# Use local arduino cli installed with setup.sh
ARDUINO_CLI="../tools/bin/arduino-cli"
CONSOLE_LOG=console.log

# Define MCU EEPROM Size
# F103R8:64K - 2K for Virtual EEPROM
F103R8_SIZE=63488
# F103RB:128K - 2K for Virtual EEPROM
F103RB_SIZE=129024

# This function checks to see if the program will fit inside the target.
# A program may not be able to use all the available target flash as some
# may be reserved for a Bootloader or Virtual EEPROM.
# We reserve 2K at the end of the Flash for a virtual EEPROM,
# if program code overflows into virtual EEPROM, writting to the EEPROM will
# corrupt program code.
ENFORCESIZE = @(PROGRAMSIZE=`sed -n -E -e 's/^Sketch uses ([0-9]+).*/\1/p' $1` ; \
	if [ $2 -gt 0 ]; then \
	          if [ $$PROGRAMSIZE -gt $2 ] ; then \
	                  echo "ERROR: program exceeds size limit ($$PROGRAMSIZE > $2)" ; \
			  echo "" ; \
                          exit 1 ; \
	          else \
		          echo "Well done, it fits into target flash!" ; \
			  echo "" ; \
                  fi ; \
        fi  )

.PHONY: swd clean

# Build for Go
go: *.ino
	${ARDUINO_CLI} compile \
	--fqbn STM32:stm32:GenF1:pnum=Generic_F103RB,xserial=generic,xusb=FS,opt=osstd,rtlib=nano \
	--libraries $(LIBRARIES_DIR) \
	--output-dir=$(OUTPUT_DIR) \
	--build-path $(BUILD_DIR) \
	--build-property build.project_name=$(OUTPUT_NAME) \
	--build-property compiler.cpp.extra_flags="-DTARGET_GO -DHAL_PCD_MODULE_ENABLED" \
	--build-property compiler.c.extra_flags="-DTARGET_GO -DHAL_PCD_MODULE_ENABLED" \
	. > $(CONSOLE_LOG)
	cat $(CONSOLE_LOG)
	$(call ENFORCESIZE, $(CONSOLE_LOG), $(F103RB_SIZE))

# Program using ST-LINK
swd: $(OUTPUT_DIR)/$(BIN_NAME)
	st-flash --connect-under-reset write $(OUTPUT_DIR)/$(BIN_NAME) 0x08000000

clean:
	rm -rf $(OUTPUT_DIR)/$(BIN_NAME) $(BUILD_DIR) console.log log.txt
