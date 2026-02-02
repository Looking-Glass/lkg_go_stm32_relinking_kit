# Stlink Installation

## Install necessary dependencies:
```bash
sudo apt-get install build-essential libusb-1.0-0-dev git cmake
```
## Clone the repository:
```bash
git clone https://github.com/stlink-org/stlink.git
cd stlink

# Optional (recommended commit)
git checkout 8de2b4dcfa8d0bc5215af720ece34c093d596a81
```
## Compile and install:
```bash
make
sudo make install
```

## Post-Installation Steps (udev Rules)
To run st-flash without needing sudo every time, you must set up udev rules
```bash
# Navigate to the udev rules directory in the cloned source
cd stlink/config/udev/rules.d 
# or check the parent directory if the structure is different

sudo cp *.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger
```
