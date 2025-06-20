#!/bin/bash

# Warna ANSI
GREEN='\033[1;32m'
CYAN='\033[1;36m'
RED='\033[1;31m'
MAGENTA='\033[1;35m'
RESET='\033[0m'

# ASCII Art untuk "DOT"
DOT_BASE=(
    "██████╗   ██████╗ ████████╗"
    "██╔══██╗ ██╔═══██╗╚══██╔══╝"
    "██║  ██║ ██║   ██║   ██║   "
    "██║  ██║ ██║   ██║   ██║   "
    "██████╔╝ ╚██████╔╝   ██║   "
    "╚═════╝   ╚═════╝    ╚═╝   "
)

# Fungsi untuk membuat teks glitch
apply_glitch() {
    local line="$1"
    local chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()█▓▒░"
    local result=""
    for ((i = 0; i < ${#line}; i++)); do
        if ((RANDOM % 10 < 2)); then
            # Ganti karakter dengan acak
            result+="${chars:RANDOM%${#chars}:1}"
        else
            result+="${line:i:1}"
        fi
    done
    echo "$result"
}

# Fungsi untuk membuat teks acak sepanjang terminal
random_line() {
    local cols=$(tput cols)
    local chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()"
    echo "$(random_text $cols)"
}

# Fungsi untuk membuat baris acak
random_text() {
    local cols=$(tput cols)
    local chars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()"
    for ((i = 0; i < cols; i++)); do
        echo -n "${chars:RANDOM%${#chars}:1}"
    done
    echo
}

# Fungsi animasi "DOT" bergerak dengan efek glitch
animate_dot() {
    local cols=$(tput cols)   # Lebar terminal
    local rows=$(tput lines)  # Tinggi terminal
    local text_width=${#DOT_BASE[0]}
    local text_start=0
    local text_direction=1
    local delay=0.1

    while true; do
        clear

        # Menampilkan teks acak di atas layar
        for ((i = 0; i < rows / 2 - 4; i++)); do
            echo -e "${CYAN}$(random_line)${RESET}"
        done

        # Menampilkan "DOT" bergerak dengan efek glitch
        for line in "${DOT_BASE[@]}"; do
            # Teks acak di kiri
            printf "${CYAN}$(random_text $((text_start)))${RESET}"
            # ASCII Art dengan efek glitch
            printf "${RED}$(apply_glitch "$line")${RESET}"
            # Teks acak di kanan
            printf "${CYAN}$(random_text $((cols - text_start - text_width)))${RESET}\n"
        done

        # Menampilkan teks acak di bawah layar
        for ((i = 0; i < rows / 2 - 4; i++)); do
            echo -e "${CYAN}$(random_line)${RESET}"
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
