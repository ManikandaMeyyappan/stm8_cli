# Target microcontroller and programmer settings
MCU      = stm8s003k3
PROGRAMMER = stlink
FLASH_EXE  = ~/stm8flash/stm8flash.exe


# Source file and output name
TARGET   = main
SRC      = $(TARGET).c


# Compiler settings
CC       = sdcc
CFLAGS   = -mstm8


# Default target: just compile the code
all: $(TARGET).ihx


$(TARGET).ihx: $(SRC)
	$(CC) $(CFLAGS) $(SRC)


# Flash the compiled firmware and automatically reset the MCU
flash: $(TARGET).ihx
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -w $(TARGET).ihx
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -R


# Erase the flash memory (overwrites the 8KB flash area with 0x00)
erase:
	dd if=/dev/zero of=blank.bin bs=1024 count=8 2>/dev/null
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -w blank.bin
	rm -f blank.bin

# Read and display the EEPROM / Data memory area
# (STM8S003K3 has 640 bytes of EEPROM starting at 0x4000)
read_eeprom:
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -r eeprom_dump.bin -s eeprom


# Read and display the Option Bytes (configures hardware features)
read_options:
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -r opt_dump.bin -s opt


# Run this ONLY if your chip becomes write-protected/locked up
unlock:
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -u


# Reset the MCU manually without flashing
reset:
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -R


# Clean up all compiler generated artifacts safely
clean:
	rm -f *.asm *.ihx *.lk *.map *.rel *.rst *.sym *.cdb *.lst eeprom_dump.bin opt_dump.bin


.PHONY: all flash erase read_eeprom read_options reset clean
