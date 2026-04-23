# 网络配置 SOP — Gemini API + Clash 代理

## 症状

运行 `python3 driver.py` 时遇到：
```
[VLM] API Error: 400 FAILED_PRECONDITION. 
{'error': {'code': 400, 'message': 'User location is not supported for the API use.', 'status': 'FAILED_PRECONDITION'}}
```

这表示 Gemini API 检测到你的 IP 在受限地区（中国），请求被拒绝。

---

## 根本原因

Gemini API 要求通过国外代理访问。你有 **Clash Verge** VPN 配置，但代码需要指向正确的代理端口：

| 实例 | 端口 | 路径 | 状态 |
|------|------|------|------|
| **Clash Verge (当前活跃)** | **7897** | UI 可见，节点可选 | ✅ 用这个 |
| `/opt/clash` (旧实例) | 7890 | 后台运行，配置陈旧 | ❌ 不要用这个 |

**问题**：如果代码用了 7890，会走旧配置或直连，导致 API 被拒。

---

## 诊断：3 步确认现状

### Step 1: 检查 Clash Verge 当前端口

```bash
# 理想情况下：每次都是 7897
grep "mixed-port:" ~/.local/share/io.github.clash-verge-rev.clash-verge-rev/clash-verge.yaml
# 输出：mixed-port: 7897
```

### Step 2: 验证代理实际走向

```bash
# 测试你当前配置的代理
curl -s -x http://127.0.0.1:7897 https://api.ipify.org
# 输出：应该是海外 IP（如 208.214.194.170），NOT 中国 IP（如 119.237.242.5）
```

### Step 3: 检查代码指向的端口

```bash
grep "PROXY_URL" /home/leslie/Projects/VLM_LGP/core/vlm.py
# 应该输出：PROXY_URL = "http://127.0.0.1:7897"
```

---

## 快速修复（如果还有问题）

### 修复 #1：更新代码中的端口（临时）

```bash
cd /home/leslie/Projects/VLM_LGP/core

# 检查当前设置
grep PROXY_URL vlm.py

# 如果不是 7897，改为：
sed -i 's/PROXY_URL = "http:\/\/127.0.0.1:[0-9]*"/PROXY_URL = "http:\/\/127.0.0.1:7897"/' vlm.py

# 验证
grep PROXY_URL vlm.py
```

### 修复 #2：确认 Clash Verge 在运行

```bash
# 检查 Clash Verge 进程
ps aux | grep -i "clash-verge\|verge-mihomo"

# 如果看不到 verge-mihomo，说明 Clash Verge 没启动，启动它：
clash-verge  # 或通过 GUI 启动

# 等待 ~3 秒初始化，再测试：
sleep 3
curl -x http://127.0.0.1:7897 https://api.ipify.org
```

### 修复 #3：禁用冲突的 `/opt/clash` 实例（可选但推荐）

两个实例可能导致混乱，可以禁用旧的：

```bash
# 停止 /opt/clash
sudo systemctl disable clash-core  # 如果有这个服务
sudo pkill -f "/opt/clash/bin/mihomo"

# 确认只有 Clash Verge 运行
ps aux | grep mihomo
# 应该只看到：/usr/bin/verge-mihomo (来自 Clash Verge)
```

---

## 长期防护（推荐代码改进）

### 问题：硬编码端口不可靠

当前 `vlm.py` 硬编码 `PROXY_URL = "http://127.0.0.1:7897"`。

如果 Clash Verge 版本更新或配置改变，会再次失败。

### 解决：动态读取 Clash 配置（推荐）

见下面的 **代码改进方案**。

---

## 完整流程检查清单

运行前，**按顺序检查**：

```bash
# 1. Clash Verge 是否运行？
ps aux | grep "verge-mihomo" | grep -v grep && echo "✅ Running" || echo "❌ Not running"

# 2. 当前代理端口是什么？
grep "mixed-port:" ~/.local/share/io.github.clash-verge-rev.clash-verge-rev/clash-verge.yaml

# 3. 代理能否访问 Google？（验证 VPN 连接）
curl -s -x http://127.0.0.1:7897 "https://www.google.com" | head -c 200

# 4. 当前外网 IP 是否为海外？（验证代理生效）
curl -s -x http://127.0.0.1:7897 https://api.ipify.org

# 5. 代码中的代理配置是否正确？
grep "PROXY_URL" /home/leslie/Projects/VLM_LGP/core/vlm.py

# 如果全部通过 ✅，可以安全运行 python3 driver.py
```

---

## 常见问题

### Q: 每次启动 Clash Verge 后都要重新配置吗？

**A**: 不需要。代码中的 `PROXY_URL = "http://127.0.0.1:7897"` 是固定的（来自 Clash Verge 的标准端口）。

只要 Clash Verge 启动后自动监听 7897，代码就能用。

**但如果**你的 Clash Verge 配置改了（不太可能），会需要：

```bash
grep "mixed-port:" ~/.local/share/io.github.clash-verge-rev.clash-verge-rev/clash-verge.yaml
# 查看新端口，然后改 vlm.py
```

### Q: 为什么有两个 Clash 实例？

**A**: 
- `/opt/clash` 是系统级的旧配置（已过期，订阅失效）
- `Clash Verge` 是你手动安装的新应用，有更新的订阅

建议只用 Clash Verge，禁用 /opt/clash。

### Q: 改代理端口后还是 400 错误？

**A**: 可能是：

1. **Clash Verge 没启动** → `ps aux | grep verge-mihomo`
2. **VPN 订阅过期** → Clash Verge 中查看订阅状态（应该显示有效期）
3. **代理节点断连** → 在 Clash Verge UI 中检查节点的 ping 延迟（应该是绿色 ✅）
4. **代码中有 httpx 客户端配置错误** → 检查是否真的在用 httpx.Client(proxy=...)

---

## 下一步：代码动态配置（未来改进）

如果你觉得总是怕出错，可以让我改 `vlm.py` 为：

1. **自动读取 Clash 配置文件**，提取当前 `mixed-port`
2. **或从 Clash API 查询**当前绑定的端口
3. **日志显示**："Using proxy: http://127.0.0.1:7897"

这样就算配置改变，代码也能自适应。要我改吗？

---

## 关键文件位置

| 文件 | 用途 |
|------|------|
| `/home/leslie/Projects/VLM_LGP/core/vlm.py` | Gemini 客户端初始化，代理配置 |
| `~/.local/share/io.github.clash-verge-rev.clash-verge-rev/clash-verge.yaml` | Clash Verge 配置（混合端口、节点等） |
| `/opt/clash/runtime.yaml` | 旧 Clash 实例配置（建议禁用） |

---

## 联系与反馈

如果还遇到网络问题，请提供：

```bash
# 1. 输出当前代理配置
echo "=== VLM.PY PROXY ===" && grep PROXY_URL /home/leslie/Projects/VLM_LGP/core/vlm.py
echo "=== CLASH VERGE PORT ===" && grep mixed-port ~/.local/share/io.github.clash-verge-rev.clash-verge-rev/clash-verge.yaml
echo "=== CLASH RUNNING ===" && ps aux | grep -i "verge-mihomo\|clash-verge"
echo "=== IP TEST ===" && curl -s -x http://127.0.0.1:7897 https://api.ipify.org
```

然后分享输出结果。

