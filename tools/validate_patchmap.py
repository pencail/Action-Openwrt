#!/usr/bin/env python3
# 📋 验证 patchmap.yml 的结构与内容

import yaml
import sys

class PatchMapValidator:
    def __init__(self, path):
        self.path = path
        self.data = None

    def load(self):
        with open(self.path, 'r', encoding='utf-8') as f:
            self.data = yaml.safe_load(f)
        if not isinstance(self.data, dict) or 'patches' not in self.data:
            raise ValueError("patchmap.yml 缺少 'patches' 列表字段")

    def validate_entry(self, entry, idx):
        required = ['path', 'name', 'enabled', 'comment']
        missing = [k for k in required if k not in entry]
        if missing:
            print(f"❌ 补丁项 #{idx} 缺少字段：{', '.join(missing)}")
            return False
        return True

    def display(self):
        print("📋 PatchMap 清单")
        for i, entry in enumerate(self.data['patches'], 1):
            if not self.validate_entry(entry, i): continue
            status = "✅启用" if entry['enabled'] else "🚫禁用"
            tags = ", ".join(entry.get('tags', [])) or "无"
            print(f"{i:02d}. {status} - {entry['name']}")
            print(f"    路径: {entry['path']}")
            print(f"    标签: {tags}")
            print(f"    注释: {entry['comment']}\n")

if __name__ == "__main__":
    file_path = sys.argv[1] if len(sys.argv) > 1 else "patchmap.yml"
    validator = PatchMapValidator(file_path)
    validator.load()
    validator.display()