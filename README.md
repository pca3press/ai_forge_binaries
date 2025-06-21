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
wget https://github.com/pca3press/ai_forge_binaries/releases/download/v1.0.0/chapter14_sim_v7_macos_arm64
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
Download all binaries for your system and run the included batch script:

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

## Benchmarking
Download all binaries for your system and run the included benchmarking script:

```bash
chmod +x chapter14_benchmark.sh
./chapter14_benchmark.sh 100000000
```
It will get your machine's information and generate a table, like this,

AMD Ryzen 9 3950X 16-Core Processor (x86_64 Linux), 32 cores, 62.8 GB, Python 3.10.12
| Program (100000000 simulations)  | Time (s)   | Speedup(x) |
|----------------------------------|------------|------------|
| chapter14_sim.py (x1000 est)     | 78916.000  | 1.00       |
| chapter14_sim_v0_linux_amd64     | 382.728    | 206.19     |
| chapter14_sim_v1_linux_amd64     | 111.430    | 708.21     |
| chapter14_sim_v2_linux_amd64     | 66.594     | 1185.03    |
| chapter14_sim_v3_linux_amd64     | 67.068     | 1176.66    |
| chapter14_sim_v4_linux_amd64     | 48.954     | 1612.04    |
| chapter14_sim_v5_linux_amd64     | 25.364     | 3111.34    |
| chapter14_sim_v6_linux_amd64     | 11.863     | 6652.28    |
| chapter14_sim_v7_linux_amd64     | 0.603      | 130872.31  |

Love to hear how the program perform on your machine, especially machines with high core numbers. 
Please report it here:


## 📜 License  
These binary files are distributed under the AI Forge Binary Distribution License v1.0.  
They are intended for personal benchmarking and evaluation by verified book owners only.  
See [LICENSE](./LICENSE) for full terms.


