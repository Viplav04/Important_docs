

echo "Get Kernel Source"

wget https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.82.tar.xz

echo "Get Kernel Patch"

wget https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.82-rt30.patch.xz

echo "Unpack Kernel Source"
xz -cd linux-4.19.82.tar.xz | tar xvf -

cd linux-4.19.82/

echo "Patching Kernel"

xzcat ../patch-4.19.82-rt30.patch.xz | patch -p1

echo "Install dependencies"

sudo apt-get install libncurses-dev
sudo apt-get install libssl-dev

cp /boot/config-$(uname -r) .config

echo "Make Menuconfig"

echo "Please Navigate to 'Processor type and features' ---> 'Preemption Model'"

echo "and choose 'Fully Preemptible Kernel'" 

make menuconfig

#####

make -j20

sudo make modules_install -j20
sudo make install -j20

sudo update-grub

#sudo reboot



