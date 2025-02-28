#!/bin/bash

# Konfigurasi
RAW_FILE="dotaja"  # Ubah path sesuai lokasi file RAW
TARGET_DISK="/dev/vda"            # Sesuaikan dengan disk utama VPS

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

# Menampilkan disk sebelum overwrite
echo "[INFO] Disk sebelum proses:"
lsblk

# Menghentikan layanan dan masuk ke mode rescue
echo "[INFO] Menghentikan layanan yang berjalan..."
systemctl isolate rescue.target

# Tunggu beberapa detik agar mode rescue aktif
sleep 5

# Menulis file RAW ke disk utama
echo "[INFO] Memulai proses overwrite OS lama..."
dd if="$RAW_FILE" of="$TARGET_DISK" bs=4M status=progress
sync

# Selesai, reboot VPS
echo "[INFO] Proses selesai. Rebooting..."
sleep 3
reboot -f
