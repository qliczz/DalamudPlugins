# 斯温的 Dalamud 插件主列表

游戏内（XIVLauncherCN / Dalamud）只需添加一个**自定义插件库链接**，即可安装这里列出的全部插件：

```
https://github.com/qliczz/DalamudPlugins/releases/latest/download/pluginmaster.json
```

## 当前收录

- **RaceKnight** —— 高度自定义的人物 / NPC 过滤插件
- **W.T.H.F.** —— 在小地图 / 大地图 / 游戏画面中高亮好友、队友与部队成员
- **Is that a crit？** —— 统计伤害、直暴运气、本队 DPS、技能时间轴与多目标数据
- **旋转教练** —— 分析实际技能序列、GCD 节奏、延迟与停顿
- **关键技能时间轴** —— 为妖星乱舞绝境战提供可编辑技能计划、提醒与自动校时
- **副坦克监控** —— 在原生焦点目标下监控另一名坦克，支持右键加入与点击选中

## 待游戏内验收的测试插件

- **斯温·渲染比例（RenderScale）** —— 25–400% 内部 3D 渲染比例，保留当前窗口与 HUD 尺寸，含实际尺寸读数、15 秒预览及恢复功能。
  此项标记为 `IsTestingExclusive`，仅面向测试安装。当前要求游戏使用 FSR，限定已核对的国服程序与结构库；游戏内画面、卸载恢复及 ReShade 兼容性尚未验收。
  [源码和说明](https://github.com/qliczz/RenderScale) · [独立测试包](https://github.com/qliczz/RenderScale/releases/tag/v0.1.0-test.1)。

## 如何添加（XIVLauncherCN）

1. 打开 XIVLauncherCN → 设置 → Dalamud 设置（或在游戏内输入 `/xlsettings`）。
2. 进入「实验性功能」→「自定义插件库（Custom Plugin Repositories）」→ 添加上面的链接。
3. 重启 Dalamud，插件商店里即可看到并一键安装全部插件。

> 本列表默认面向 XIVLauncherCN 环境，无需考虑国际服。

## 新增插件

在 `pluginmaster.json` 数组里追加一项（字段对齐现有插件），
重新发一个 Release（把 `pluginmaster.json` 作为 release 附件）即可生效。
