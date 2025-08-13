#!/bin/bash

# ================================================
# wipe_free_space.sh
#
# Fills up all available free space on the current
# partition with zeros to prevent file recovery.
# USE THIS ONLY IF YOU KNOW WHAT YOU'RE DOING.
#
# This script will:
# 1. Detect how much free space is available
# 2. Create a huge file (`.wipe_temp_zero_fill`) full of zeros
# 3. Automatically delete that file after the disk is full
#
# Expected behavior:
# - `dd` will stop with "No space left on device" — this means it worked
# - Your existing files will NOT be touched
# - Only free space is overwritten
#
# DISCLAIMER:
# This script is for educational purposes only.
# The author is not responsible for any damage,
# data loss, or unintended consequences.
# Always test in a safe environment (e.g., a VM).
#
# https://github.com/gauskxhaganth/crimsonspells
# ================================================

wipe_free_space() {
    echo "[*] Wiping free space in $(pwd)..."
      # Get available space (in KB), convert to MB
    avail_kb=$(df --output=avail . | tail -n1)
    avail_mb=$((avail_kb / 1024))
      # Write zeros to fill up the disk (expected to end with no space error)
    dd if=/dev/zero of=.wipe_temp_zero_fill bs=1M count=$avail_mb status=progress
      # Remove the temp file to free up the space again
    rm -f .wipe_temp_zero_fill
    echo "[✓] Done."
}

wipe_free_space
