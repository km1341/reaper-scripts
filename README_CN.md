# km1341's REAPER 脚本

[English](README.md)

一套 REAPER Lua 工作流自动化脚本，通过 [ReaPack](https://reapack.com/) 分发。

## 安装

### 通过 ReaPack（推荐）

1. 打开 REAPER → 扩展 → ReaPack → 管理仓库
2. 点击 **添加新仓库**
3. 粘贴以下 URL：

```
https://raw.githubusercontent.com/km1341/reaper-scripts/main/index.xml
```

4. 点击 **确定**，然后浏览包列表查找并安装脚本。

### 手动安装

将 `.lua` 文件复制到 REAPER Scripts 文件夹：

- **Windows**：`%APPDATA%\REAPER\Scripts\`
- **macOS**：`~/Library/Application Support/REAPER/Scripts/`

然后通过 **操作 → 显示操作列表 → 加载...** 加载

## 脚本

### 从视频轨道项目创建区域标记

**文件**：`km1341_Video_Items_to_Regions.lua`

扫描用户选中的轨道，为每个视频项创建区域标记。

**特性**：
- 仅扫描用户选中的轨道
- 通过源类型 (VIDEO) 检测视频项
- 使用 Take 名称作为区域标签（无名称时回退到 `Video_001`、`Video_002`...）
- 去重：跳过与已有区域标记重叠超过 50% 的项
- 所有操作包裹在单个撤销块中

**使用方法**：
1. 选中包含视频项的轨道（点击轨道名称/编号；Ctrl/Cmd 多选）
2. 从操作列表中运行脚本
3. 为每个视频项创建区域标记

---

### 从选中项目创建区域标记

**文件**：`km1341_Selected_Items_to_Regions.lua`

根据用户在排列视图中选中的媒体项（事件块）创建区域标记。适用于**任何项目类型**——音频、MIDI、视频等。

**特性**：
- 适用于任何选中的媒体项类型（音频、MIDI、视频等）
- 若选中多个项目，则创建一个从最早起始到最晚结束的单一区域标记
- 使用第一个选中项的 Take 名称作为区域标签（回退到 `Region`）
- 所有操作包裹在单个撤销块中

**使用方法**：
1. 在排列视图中选中媒体项（点击选中；Ctrl/Cmd 多选）
2. 从操作列表中运行脚本
3. 创建一个覆盖选中项时间范围的区域标记

## 提示

- 在 **标记/区域管理器**（`Alt+M`）中查看所有区域
- 所有操作均支持**撤销**（`Ctrl+Z` / `Cmd+Z`）

## 许可

[MIT](LICENSE)
