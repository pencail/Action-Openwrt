#!/usr/bin/env python3
# 📊 解析 patchlog.txt 统计补丁应用情况

import sys
from collections import defaultdict

class PatchLogReport:
    def __init__(self, path):
        self.path = path
        self.patched = []
        self.skipped = []
        self.missing = []

    def parse(self):
        with open(self.path, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.strip()
                if '[PATCHED]' in line:
                    self.patched.append(line.split()[-1])
                elif '[SKIPPED]' in line:
                    self.skipped.append(line.split()[-1])
                elif '[MISSING]' in line:
                    self.missing.append(line.split()[-1])

    def group_by_folder(self, files):
        grouped = defaultdict(list)
        for f in files:
            folder = f.split('/')[0]
            grouped[folder].append(f)
        return grouped

    def display(self):
        print("📊 补丁日志统计")
        print(f"✅ 已应用: {len(self.patched)}")
        print(f"⚠️ 跳过: {len(self.skipped)}")
        print(f"🚫 缺失: {len(self.missing)}\n")

        grouped = self.group_by_folder(self.patched)
        for folder, items in grouped.items():
            print(f"📂 {folder}/")
            for f in items:
                print(f"   └─ {f}")

if __name__ == "__main__":
    file_path = sys.argv[1] if len(sys.argv) > 1 else "patchlog.txt"
    report = PatchLogReport(file_path)
    report.parse()
    report.display()