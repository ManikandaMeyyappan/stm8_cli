# Target microcontroller and programmer settings
MCU        = stm8s003k3
PROGRAMMER = stlink
FLASH_EXE  = ~/stm8flash/stm8flash.exe

# Project settings
TARGET     = main
SRC        = $(TARGET).c
BUILD_DIR  = build

# Compiler settings
CC         = sdcc
CFLAGS     = -mstm8

# Output file inside build directory
OUT        = $(BUILD_DIR)/$(TARGET)

# Default target
all: $(OUT).ihx

# Create build directory automatically
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile
$(OUT).ihx: $(SRC) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $(OUT).ihx $(SRC)

# Flash firmware
flash: $(OUT).ihx
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -w $(OUT).ihx
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -R

# Erase flash memory
erase:
	dd if=/dev/zero of=$(BUILD_DIR)/blank.bin bs=1024 count=8 2>/dev/null
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -w $(BUILD_DIR)/blank.bin
	rm -f $(BUILD_DIR)/blank.bin

# Read EEPROM
read_eeprom:
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -r $(BUILD_DIR)/eeprom_dump.bin -s eeprom

# Read option bytes
read_options:
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -r $(BUILD_DIR)/opt_dump.bin -s opt

# Unlock MCU
unlock:
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -u

# Reset MCU
reset:
	$(FLASH_EXE) -c $(PROGRAMMER) -p $(MCU) -R

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all flash erase read_eeprom read_options unlock reset clean


