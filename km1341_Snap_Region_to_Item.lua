-- @description Snap Region Markers to Selected Item
-- @version 1.0
-- @author km1341
-- @about
--   Adjusts all region markers that overlap with the selected media item
--   to match the item's start and end positions.

local function main()
  local num_items = reaper.CountSelectedMediaItems(0)
  if num_items == 0 then
    reaper.ShowMessageBox("Please select a media item.", "No Item Selected", 0)
    return
  end

  local item = reaper.GetSelectedMediaItem(0, 0)
  local item_start = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
  local item_len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
  local item_end = item_start + item_len

  reaper.Undo_BeginBlock2(0)

  local adjusted = 0
  local i = 0
  while true do
    local retval, isrgn, pos, rgnend, name, idx, color = reaper.EnumProjectMarkers3(0, i)
    if retval == 0 then break end
    if isrgn then
      if pos < item_end and rgnend > item_start then
        reaper.SetProjectMarker4(0, idx, true, item_start, item_end, name, idx, color)
        adjusted = adjusted + 1
      end
    end
    i = i + 1
  end

  reaper.Undo_EndBlock2(0, "Snap region markers to selected item", -1)

  if adjusted == 0 then
    reaper.ShowMessageBox("No region markers overlap with the selected item.", "No Regions Found", 0)
  end
end

main()
