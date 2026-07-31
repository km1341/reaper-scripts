-- @description Create Region Markers from Items
-- @version 1.0
-- @author km1341
-- @about
--   Creates a Region Marker for each user-selected media item.
--   Works with any item type -- audio, MIDI, video, etc.

local function main()
  local num_items = reaper.CountSelectedMediaItems(0)
  if num_items == 0 then
    reaper.ShowMessageBox("Please select at least one media item.", "No Items Selected", 0)
    return
  end

  reaper.Undo_BeginBlock2(0)

  local region_count = 1

  for i = 0, num_items - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    if item then
      local pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
      local len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
      local item_end = pos + len

      local take = reaper.GetActiveTake(item)
      local name = ""
      if take then
        name = reaper.GetTakeName(take)
      end
      if name == "" then
        name = string.format("Region_%03d", region_count)
      end

      reaper.AddProjectMarker2(0, true, pos, item_end, name, -1, 0)
      region_count = region_count + 1
    end
  end

  reaper.Undo_EndBlock2(0, "Create regions from items", -1)
end

main()
