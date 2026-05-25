# STM8 CLI Development Setup

Bare-metal STM8S003K3 development using:

- MSYS2 UCRT64
- SDCC
- stm8flash
- ST-Link

---

## 1. Install MSYS2

Download and install MSYS2 package.

Official website:

https://www.msys2.org/

---

## 2. Update MSYS2

Run:

```bash
pacman -Syu
```

Close terminal if required.

---

## 3. Open UCRT64 Terminal

Open:

```text
MSYS2 UCRT64
```

Run as administrator.

Then update remaining packages:

```bash
pacman -Su
```

---

## 4. Install Required Packages

Install toolchain:

```bash
pacman -S mingw-w64-ucrt-x86_64-toolchain
```

Install libusb:

```bash
pacman -S mingw-w64-ucrt-x86_64-libusb
```

Install SDCC:

```bash
pacman -S mingw-w64-ucrt-x86_64-sdcc
```

Install unzip:

```bash
pacman -S unzip
```

---

## 5. Download and Build stm8flash
Create workspace:

```bash
mkdir stm8
```

Download stm8flash:

```bash
curl -L https://github.com/vdudouyt/stm8flash/archive/refs/heads/master.zip -o stm8flash.zip

Extract:

```bash
unzip stm8flash.zip
```

Go into directory:

```bash
cd stm8flash-master/
```

Build stm8flash:

```bash
make
```
Copy executable:

```bash
cp stm8flash.exe /ucrt64/bin/
```

---

## 6. Install Zadig Driver

Install Zadig.

Replace ST-Link driver:

```text
```

---

## 7. Create STM8 Project

Create project:

```bash
mkdir blink
cd blink/
```

Check STM8 connection:

```bash
stm8flash -c stlink -p stm8s003k3
```

Create source file:

```bash
nano main.c
```

Compile:

```bash
sdcc -mstm8 main.c
```

Flash firmware:

```bash
stm8flash -c stlink -p stm8s003k3 -w main.ihx
```

LED should blink.

---

## 8. Using Makefile

Create Makefile:

```bash
nano Makefile
```

Clean build:

```bash
make clean
```

Compile project:

```bash
make
```

Flash project:

```bash
make flash
```usbstor -> winusb

```
cd stm8/

