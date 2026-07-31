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

## License

[MIT](LICENSE)
