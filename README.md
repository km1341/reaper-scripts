# km1341's REAPER Scripts

A collection of REAPER Lua scripts for workflow automation, distributed via [ReaPack](https://reapack.com/).

## Installation

### Via ReaPack (Recommended)

1. Open REAPER → Extensions → ReaPack → Manage repositories
2. Click **Add new repository**
3. Paste the following URL:

```
https://raw.githubusercontent.com/km1341/reaper-scripts/main/index.xml
```

4. Click **OK**, then browse packages to find and install the scripts.

### Manual Installation

Copy the `.lua` files to your REAPER Scripts folder:

- **Windows**: `%APPDATA%\REAPER\Scripts\`
- **macOS**: `~/Library/Application Support/REAPER/Scripts/`

Then load via **Actions → Show action list → Load...**

## Scripts

### Create Region Markers from Video Track Items

**File**: `km1341_Video_Items_to_Regions.lua`

Scans user-selected tracks for video items and creates Region Markers for each.

**Features**:
- Only scans tracks that the user has selected
- Detects video items by source type (VIDEO)
- Uses Take name as Region label (falls back to `Video_001`, `Video_002`...)
- Deduplication: skips items already covered by existing Region Markers (>=50% overlap)
- All operations wrapped in a single undo block

**Usage**:
1. Select the track(s) containing your video items (click track name/number; Ctrl/Cmd for multi-select)
2. Run the script from the Action List
3. Region Markers are created for each video item

---

### Create Region Markers from Selected Items

**File**: `km1341_Selected_Items_to_Regions.lua`

Creates Region Markers from user-selected media items (event blocks) in the arrange view. Works with **any item type** -- audio, MIDI, video, etc.

**Features**:
- Works with any selected media item type (audio, MIDI, video, etc.)
- If multiple items are selected, a single Region Marker is created spanning from the earliest item start to the latest item end
- Uses Take name of the first selected item as Region label (falls back to `Region`)
- All operations wrapped in a single undo block

**Usage**:
1. Select the media item(s) in the arrange view (click to select; Ctrl/Cmd for multi-select)
2. Run the script from the Action List
3. A Region Marker is created covering the time range of the selected items

## Tips

- View all regions in **Marker/Region Manager** (`Alt+M`)
- All operations support **Undo** (`Ctrl+Z` / `Cmd+Z`)

---

## 中文说明

### 从视频轨道项目创建区域标记

**文件**: `km1341_Video_Items_to_Regions.lua`

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

**文件**: `km1341_Selected_Items_to_Regions.lua`

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

### 提示

- 在 **标记/区域管理器** (`Alt+M`) 中查看所有区域
- 所有操作均支持**撤销** (`Ctrl+Z` / `Cmd+Z`)

## License

[MIT](LICENSE)
