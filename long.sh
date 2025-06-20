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

# Efek teks acak seperti hacker
random_text() {
    local chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()"
    for ((i = 0; i < $1; i++)); do
        echo -n "${chars:RANDOM%${#chars}:1}"
    done
    echo
}

# Fungsi animasi "DOT"
animate_dot() {
    local delay=0.05
    local cols=$(tput cols) # Lebar terminal
    local rows=$(tput lines) # Tinggi terminal

    while true; do
        clear
        # Menampilkan teks acak di atas dan bawah
        for ((i = 0; i < rows / 2 - 4; i++)); do
            echo -e "${CYAN}$(random_text $cols)${RESET}"
        done

        # Menampilkan ASCII Art DOT dengan warna berkedip
        for line in "${DOT[@]}"; do
            echo -e "${RED}${line}${RESET}"
            sleep $delay
        done

        for ((i = 0; i < rows / 2 - 4; i++)); do
            echo -e "${CYAN}$(random_text $cols)${RESET}"
        done

        sleep $delay
    done
}

# Jalankan animasi
animate_dot
