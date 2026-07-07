# 斯温的 Dalamud 插件主列表

游戏内（XIVLauncherCN / Dalamud）只需添加一个**自定义插件库链接**，即可安装这里列出的全部插件：

```
https://github.com/qliczz/DalamudPlugins/releases/latest/download/pluginmaster.json
```

## 当前收录

- **RaceKnight** —— 高度自定义的人物 / NPC 过滤插件
- **NEVERMOVE** —— 在小地图 / 大地图 / 游戏画面中高亮好友、队友与部队成员

## 如何添加（XIVLauncherCN）

1. 打开 XIVLauncherCN → 设置 → Dalamud 设置（或在游戏内输入 `/xlsettings`）。
2. 进入「实验性功能」→「自定义插件库（Custom Plugin Repositories）」→ 添加上面的链接。
3. 重启 Dalamud，插件商店里即可看到并一键安装全部插件。

> 本列表默认面向 XIVLauncherCN 环境，无需考虑国际服。

## 新增插件

在 `pluginmaster.json` 数组里追加一项（字段对齐 RaceKnight / NEVERMOVE），
重新发一个 Release（把 `pluginmaster.json` 作为 release 附件）即可生效。
