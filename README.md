# 🧠 AI Forge – Binary Releases

This repository hosts precompiled binaries from *The AI Forge* by Jianxian Wu, optimized for benchmarking and experimentation.

Each binary corresponds to a specific version or technique covered in Chapter 14 of the book. You can download and run them individually to experience the performance difference between naïve Python-like code and fully optimized PCA³-style C implementations.

---

## 📥 Download Binaries

Binaries are available for two platforms:

- 🖥 macOS ARM64 (Apple Silicon): `*_macos_arm64`
- 💻 Linux x86_64 (AMD64): `*_linux_amd64`

Visit the [Releases](https://github.com/pca3press/ai_forge_binaries/releases) page and download the specific version(s) you’d like to try.

---
## 🐍 How to Run the Python Version

If you’d like to compare performance with the baseline Python version:

```bash
python3 chapter14_sim.py 1000000
```
This runs the simulator for 1,000,000 games using the original object-oriented Python implementation.

## 🚀 How to Run a Binary

1. **Download** a binary matching your system, e.g.:

```bash
   wget https://github.com/pca3press/ai_forge_binaries/releases/download/CH14-v1.0/chapter14_sim_v7_macos_arm64
   ```
2. Make it executable:

```bash
chmod +x chapter14_sim_v7_macos_arm64
```

3. Run it with a number of simulated games:

```bash
./chapter14_sim_v7_macos_arm64 1000000
```

You can repeat this with other versions (e.g., v0, v1, v7, ilp, bbl) to compare performance.

 
## Batch Execution Script
Download and run the included batch script:
```bash
chmod +x chapter14_run.sh
./chapter14_run.sh 100000000
```

Inside the script, choose your platform by setting one of these lines at the top:

```bash
ARCH="macos_arm64"
# ARCH="linux_amd64"
```
The script will automatically run all available simulation versions for that platform.

🧪 SHA-256 Verification
Each file's SHA-256 hash is shown in the release. You can verify manually:

```bash
shasum -a 256 chapter14_sim_v7_macos_arm64
```


## 📜 License  
These binary files are distributed under the AI Forge Binary Distribution License v1.0.  
They are intended for personal benchmarking and evaluation by verified book owners only.  
See [LICENSE](./LICENSE) for full terms.


