#!/bin/bash

# Konfigurasi
RAW_FILE="dotaja"  # Path ke file RAW Windows
TARGET_DISK="/dev/vda"            # Disk utama (sesuaikan dengan sistem Anda)
PARTITION_NUMBER=3                # Nomor partisi untuk Windows (misalnya /dev/vda3)
PARTITION_SIZE="20G"              # Ukuran partisi Windows (sesuaikan dengan kebutuhan)
UBUNTU_PARTITION="/dev/vda2"      # Partisi Ubuntu yang akan dikecilkan

# Pastikan script dijalankan sebagai root
if [[ $EUID -ne 0 ]]; then
   echo "Script ini harus dijalankan sebagai root" 
   exit 1
fi

# Cek apakah file RAW ada
echo "[INFO] Memeriksa keberadaan file RAW..."
if [ ! -f "$RAW_FILE" ]; then
    echo "[ERROR] File RAW tidak ditemukan: $RAW_FILE"
    exit 1
fi

# Cek ukuran file RAW
RAW_SIZE=$(stat -c%s "$RAW_FILE")
if [ "$RAW_SIZE" -gt $(( 20 * 1024 * 1024 * 1024 )) ]; then  # 20GB dalam bytes
    echo "[ERROR] Ukuran file RAW lebih besar dari partisi yang akan dibuat."
    exit 1
fi

# Mengecilkan partisi Ubuntu untuk membuat ruang kosong
echo "[INFO] Mengecilkan partisi Ubuntu..."
e2fsck -f "$UBUNTU_PARTITION"  # Memeriksa partisi Ubuntu
resize2fs "$UBUNTU_PARTITION" 30G  # Mengecilkan filesystem ke 30GB
parted "$TARGET_DISK" resizepart 2 30GB  # Mengecilkan partisi ke 30GB

# Membuat partisi baru untuk Windows
echo "[INFO] Membuat partisi baru untuk Windows..."
parted -s "$TARGET_DISK" mkpart primary ntfs 30GB 50GB

# Format partisi sebagai NTFS
echo "[INFO] Memformat partisi sebagai NTFS..."
mkfs.ntfs -f "${TARGET_DISK}${PARTITION_NUMBER}"

# Menulis file RAW ke partisi baru
echo "[INFO] Menulis file RAW Windows ke partisi..."
dd if="$RAW_FILE" of="${TARGET_DISK}${PARTITION_NUMBER}" bs=4M status=progress
sync

# Mengatur GRUB untuk boot ke Windows secara default
echo "[INFO] Mengatur GRUB untuk boot ke Windows secara default..."
GRUB_WINDOWS_ENTRY=$(grep -i "windows" /boot/grub/grub.cfg | grep -oP 'menuentry \K[^"]+' | head -n 1)
if [ -z "$GRUB_WINDOWS_ENTRY" ]; then
    echo "[ERROR] Entri Windows tidak ditemukan di GRUB."
    exit 1
fi

# Update GRUB configuration
sed -i "s/^GRUB_DEFAULT=.*/GRUB_DEFAULT=\"$GRUB_WINDOWS_ENTRY\"/" /etc/default/grub
update-grub

# Selesai, reboot sistem
echo "[INFO] Proses selesai. Rebooting ke Windows..."
sleep 3
reboot
