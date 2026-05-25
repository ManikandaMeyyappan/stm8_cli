# STM8 CLI Development Setup

Bare-metal STM8S003K3 development using:

***STM8S003k3 value line discovery board***


- MSYS2 UCRT64
- SDCC
- stm8flash
- ST-Link

---

## 1. Install and update MSYS2

Download and install MSYS2 package.

Official website:

https://www.msys2.org/

Run:

```bash
pacman -Syu
```

Close terminal if required.

---

## 2. Open UCRT64 Terminal

Open and Run as administrator.
Then update remaining packages:

```bash
pacman -Su
```

---

## 3. Install Required Packages

Install toolchain, libusb, sdcc and unzip:

```bash
pacman -S mingw-w64-ucrt-x86_64-toolchain
pacman -S mingw-w64-ucrt-x86_64-libusb
pacman -S mingw-w64-ucrt-x86_64-sdcc
pacman -S unzip
```

---

## 4. Download and Build stm8flash
Create workspace, download, extract and build stm8flash:

```bash
mkdir stm8
curl -L https://github.com/vdudouyt/stm8flash/archive/refs/heads/master.zip -o stm8flash.zip
unzip stm8flash.zip
cd stm8flash-master/
make
cp stm8flash.exe /ucrt64/bin/
```

---

## 5. Install Zadig Driver

Install Zadig.

Replace ST-Link driver: Replace USBSTOR with WinUSB

---

## 6. Create STM8 Project

Create project, check connection, create source file, compile and flash :

```bash
mkdir blink
cd blink/
stm8flash -c stlink -p stm8s003k3
nano main.c
sdcc -mstm8 main.c
stm8flash -c stlink -p stm8s003k3 -w main.ihx
```

Onboard LED should blink.

---
## 7. Or else you can Clone repository, build and flash the project :

```bash
git clone https://github.com/ManikandaMeyyappan/stm8_cli.git
make clean
make 
make flash
```
