# chapter14_run.sh

# Copyright (c) 2025 Jianxian Wu
# This source code is licensed under the AI Forge Source Code License v1.0.
# Use permitted only by verified owners of *The AI Forge* book.
# See the LICENSE file or visit pca3press.com/license for details.

#!/bin/bash
# Usage: ./chapter14_run.sh [NUM_GAMES]
NUM_GAMES=${1:-100}

# Choose target architecture suffix — uncomment the one you're using
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

for prog in "${PROGS[@]}"; do
    echo "▶️ ./$prog $NUM_GAMES"
    ./$prog $NUM_GAMES
done

./chapter14_ilp_${ARCH}
./chapter14_bbl_${ARCH}

python3 chapter14_sim.py 1000000
