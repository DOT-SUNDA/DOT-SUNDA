#!/bin/bash

# Warna ANSI
GREEN='\033[1;32m'
CYAN='\033[1;36m'
RED='\033[1;31m'
RESET='\033[0m'

# ASCII Art untuk "DOT"
DOT=(
    "██████╗   ██████╗ ████████╗"
    "██╔══██╗ ██╔═══██╗╚══██╔══╝"
    "██║  ██║ ██║   ██║   ██║   "
    "██║  ██║ ██║   ██║   ██║   "
    "██████╔╝ ╚██████╔╝   ██║   "
    "╚═════╝   ╚═════╝    ╚═╝   "
)

# Fungsi untuk membuat teks acak
random_text() {
    local chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()"
    for ((i = 0; i < $1; i++)); do
        echo -n "${chars:RANDOM%${#chars}:1}"
    done
    echo
}

# Fungsi untuk animasi "DOT" bergerak
animate_dot() {
    local cols=$(tput cols)   # Lebar terminal
    local rows=$(tput lines)  # Tinggi terminal
    local text_width=${#DOT[0]}
    local text_start=0
    local text_direction=1
    local delay=0.1

    while true; do
        clear

        # Menampilkan teks acak di atas "DOT"
        for ((i = 0; i < rows / 2 - 3; i++)); do
            echo -e "${CYAN}$(random_text $cols)${RESET}"
        done

        # Menampilkan "DOT" bergerak
        for line in "${DOT[@]}"; do
            printf "%${text_start}s" " "
            echo -e "${RED}${line}${RESET}"
        done

        # Menampilkan teks acak di bawah "DOT"
        for ((i = 0; i < rows / 2 - 3; i++)); do
            echo -e "${CYAN}$(random_text $cols)${RESET}"
        done

        # Memindahkan posisi "DOT" (kiri-kanan)
        text_start=$((text_start + text_direction))
        if ((text_start < 0 || text_start + text_width > cols)); then
            text_direction=$((text_direction * -1))
        fi

        sleep $delay
    done
}

# Menjalankan animasi
animate_dot
