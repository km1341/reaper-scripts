-- @description Create Region Markers from Selected Items
-- @version 1.0
-- @author km1341
-- @about
--   Creates Region Markers from user-selected media items.
--   If multiple items are selected, a single region is created spanning
--   from the earliest item start to the latest item end.

local function main()
  local num_items = reaper.CountSelectedMediaItems(0)
  if num_items == 0 then
    reaper.ShowMessageBox("Please select at least one media item.", "No Items Selected", 0)
    return
  end

  reaper.Undo_BeginBlock2(0)

  local earliest_start = math.huge
  local latest_end = -math.huge
  local region_name = ""

  for i = 0, num_items - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    if item then
      local pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
      local len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
      local item_end = pos + len

      if pos < earliest_start then earliest_start = pos end
      if item_end > latest_end then latest_end = item_end end

      if i == 0 then
        local take = reaper.GetActiveTake(item)
        if take then
          region_name = reaper.GetTakeName(take)
        end
      end
    end
  end

  if region_name == "" then
    region_name = "Region"
  end

  reaper.AddProjectMarker2(0, true, earliest_start, latest_end, region_name, -1, 0)

  reaper.Undo_EndBlock2(0, "Create region from selected items", -1)
end

main()
