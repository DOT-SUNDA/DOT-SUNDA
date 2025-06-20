#!/bin/bash

# Warna
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
RESET='\033[0m'

# ASCII Art untuk "DOT"
DOT=(
    "██████╗  ██████╗ ████████╗"
    "██╔══██╗██╔═══██╗╚══██╔══╝"
    "██████╔╝██║   ██║   ██║   "
    "██╔═══╝ ██║   ██║   ██║   "
    "██║     ╚██████╔╝   ██║   "
    "╚═╝      ╚═════╝    ╚═╝   "
)

# Fungsi untuk menampilkan huruf besar "DOT" dengan animasi
animate_dot() {
    local delay=0.1
    while true; do
        for color in "${RED}" "${GREEN}" "${BLUE}"; do
            clear
            for line in "${DOT[@]}"; do
                echo -e "${color}${line}${RESET}"
            done
            sleep $delay
        done
    done
}

# Menjalankan animasi
clear
echo -e "${BLUE}Memulai animasi DOT dalam ukuran besar...${RESET}"
sleep 1
animate_dot
