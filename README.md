```
Dotaja123@HHHH
```
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

```
```
# Tulis kode MBR ke sektor paling depan HDD (Gagang Pintu)
# Ini AMAN, tidak akan menyentuh data 273GB di sda1
sudo dd if=/usr/lib/syslinux/mbr/mbr.bin of=/dev/sda

# Tulis Volume Boot Record ke sda2 (Kunci Kamar)
sudo syslinux -i /dev/sda2
persistent
```
```
sudo apt update
sudo apt install lxqt-admin lxqt-config lxqt-powermanagement

```
```
sudo add-apt-repository ppa:lutris-team/lutris
sudo apt update
sudo apt install lutris
```
```
echo -e "\e[1;36m[GHOST-COMMANDER] \e[0mStarting 1GB Disk Stress Test (RAM)..."
echo -ne '#####                     (33%)\r'
sleep 1
dd if=/dev/zero of=~/test_1gb.img bs=1G count=1 conv=fdatasync status=progress 2>&1 | \
while read line; do
    echo -e "\e[1;32m⚡ $line\e[0m"
done
echo -ne '#############             (66%)\r'
rm ~/test_1gb.img
echo -ne '#######################   (100%)\r'
echo -e "\n\e[1;35m[COMPLETE] \e[0mDisk RAM Speed Verified."
```
```
sudo apt update

sudo apt install openssh-server -y

sudo systemctl enable ssh

sudo systemctl start ssh

hostname -I
```
