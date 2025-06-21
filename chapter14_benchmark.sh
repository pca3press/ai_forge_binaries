# chapter14_benchmark.sh

# Copyright (c) 2025 Jianxian Wu
# This source code is licensed under the AI Forge Source Code License v1.0.
# Use permitted only by verified owners of *The AI Forge* book.
# See the LICENSE file or visit pca3press.com/license for details.

#!/bin/bash
# Usage: ./chapter14_benchmark.sh [NUM_GAMES]

REPEAT=${REPEAT:-3}
NUM_GAMES=${1:-100}
NUM_GAMES_1000th=$((NUM_GAMES / 1000))
NUM_GAMES_1000th=$((NUM_GAMES_1000th > 0 ? NUM_GAMES_1000th : 1))  # Ensure at least 1 game

if ! command -v bc &>/dev/null; then
    echo "❌ Error: 'bc' is not installed."
    echo "💡 Please install it by running: sudo apt install bc"
    exit 1
fi

extract_time_from_output() {
    echo "$1" | grep -Eo 'in ([0-9]+\.[0-9]+) (sec|seconds?)' | grep -Eo '[0-9]+\.[0-9]+'
}

ARCH="macos_arm64"   
# ARCH="linux_amd64"

PROGS=(
    "chapter14_sim_v0_${ARCH}"
    "chapter14_sim_v1_${ARCH}"
    "chapter14_sim_v2_${ARCH}"
    "chapter14_sim_v3_${ARCH}"
    "chapter14_sim_v4_${ARCH}"
    "chapter14_sim_v5_${ARCH}"
    "chapter14_sim_v6_${ARCH}"
    "chapter14_sim_v7_${ARCH}"
)

# Gather system info
CPU_ARCH=$(uname -m)
OS=$(uname -s)
CORES=$(getconf _NPROCESSORS_ONLN)
MEM=$(awk '/MemTotal/ {printf "%.1f GB", $2/1024/1024}' /proc/meminfo 2>/dev/null || sysctl -n hw.memsize | awk '{printf "%.1f GB", $1/1024/1024/1024}')
MODEL=$(sysctl -n machdep.cpu.brand_string 2>/dev/null || lscpu | grep "Model name" | awk -F: '{print $2}' | sed 's/^ *//')
PYTHON=$(which python3)
PYTHON_VERSION=$($PYTHON -c 'import platform; print(platform.python_version())')

SYS_LINE="$MODEL ($CPU_ARCH $OS), $CORES cores, $MEM, Python $PYTHON_VERSION"
echo "$SYS_LINE"

# Header for results table
printf "| %-32s | %-10s | %-10s |\n" "Program ($NUM_GAMES simulations)" "Time (s)" "Speedup(x)"
echo "|----------------------------------|------------|------------|"

PY_SPEEDUP="1.00"  # Default speedup baseline

# Run Python version on fewer games and extrapolate
if command -v python3 >/dev/null; then
    PY_OUTPUT=$(python3 chapter14_sim.py $NUM_GAMES_1000th)
    RAW=$(extract_time_from_output "$PY_OUTPUT")
    if [[ $RAW =~ ^[0-9]+\.[0-9]+$ ]]; then
        PY_TIME=$(echo "$RAW * 1000" | bc -l)
        PY_TIME_FMT=$(printf "%.3f" "$PY_TIME")
        printf "| %-32s | %-10s | %-10s |\n" "chapter14_sim.py (x1000 est)" "$PY_TIME_FMT" "$PY_SPEEDUP"
    else
        printf "| %-32s | %-10s | %-10s |\n" "chapter14_sim.py (x1000 est)" "Error" "-"
        PY_TIME=""
    fi
else
    printf "| %-32s | %-10s | %-10s |\n" "chapter14_sim.py (x1000 est)" "Not Found" "-"
    PY_TIME=""
fi

for prog in "${PROGS[@]}"; do
    if [[ -x $prog ]]; then
        BEST_TIME=""
        for ((i=1; i<=REPEAT; i++)); do
            OUTPUT=$("./$prog" "$NUM_GAMES")
            RAW=$(extract_time_from_output "$OUTPUT")
            if [[ $RAW =~ ^[0-9]+\.[0-9]+$ ]]; then
                if [[ -z $BEST_TIME || $(echo "$RAW < $BEST_TIME" | bc -l) -eq 1 ]]; then
                    BEST_TIME=$RAW
                fi
            fi
        done

        if [[ -n $BEST_TIME && -n $PY_TIME ]]; then
            SPEEDUP=$(echo "$PY_TIME / $BEST_TIME" | bc -l)
            SPEEDUP_FMT=$(printf "%.2f" "$SPEEDUP")
            printf "| %-32s | %-10s | %-10s |\n" "$prog" "$BEST_TIME" "$SPEEDUP_FMT"
        elif [[ -n $BEST_TIME ]]; then
            printf "| %-32s | %-10s | %-10s |\n" "$prog" "$BEST_TIME" "-"  # no python baseline
        else
            printf "| %-32s | %-10s | %-10s |\n" "$prog" "Error" "-"
        fi
    else
        printf "| %-32s | %-10s | %-10s |\n" "$prog" "Not Found" "-"
    fi
done




