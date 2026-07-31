-- @description Create Region Markers from Video Track Items
-- @version 1.0
-- @author km1341
-- @about
--   Scans user-selected tracks for video items and creates Region Markers for each.
--   Video items are detected by source type (VIDEO) and file extension.
--   Items that overlap >=50% with existing region markers are skipped.

local function is_video(item)
  local take = reaper.GetActiveTake(item)
  if not take then return false end
  local source = reaper.GetMediaItemTake_Source(take)
  if not source then return false end

  local typebuf = string.rep(" ", 256)
  reaper.GetMediaSourceType(source, typebuf)
  local source_type = string.match(typebuf, "^(%w+)") or ""
  if source_type == "VIDEO" then return true end

  return false
end

local function get_existing_regions()
  local regions = {}
  local i = 0
  while true do
    local retval, isrgn, pos, rgnend = reaper.EnumProjectMarkers3(0, i)
    if retval == 0 then break end
    if isrgn then
      regions[#regions + 1] = { start = pos, end_ = rgnend }
    end
    i = i + 1
  end
  return regions
end

local function has_significant_overlap(item_start, item_end, regions)
  local item_dur = item_end - item_start
  if item_dur <= 0 then return false end
  for _, r in ipairs(regions) do
    local overlap_start = math.max(item_start, r.start)
    local overlap_end = math.min(item_end, r.end_)
    local overlap = overlap_end - overlap_start
    if overlap > 0 then
      local r_dur = r.end_ - r.start
      if overlap / item_dur >= 0.5 or overlap / r_dur >= 0.5 then
        return true
      end
    end
  end
  return false
end

local function main()
  local num_tracks = reaper.CountSelectedTracks(0)
  if num_tracks == 0 then
    reaper.ShowMessageBox("Please select at least one track.", "No Tracks Selected", 0)
    return
  end

  local existing_regions = get_existing_regions()

  reaper.Undo_BeginBlock2(0)

  local region_count = 0
  local video_count = 1

  for t = 0, num_tracks - 1 do
    local track = reaper.GetSelectedTrack(0, t)
    if track then
      local num_items = reaper.CountTrackMediaItems(track)
      for i = 0, num_items - 1 do
        local item = reaper.GetTrackMediaItem(track, i)
        if item and is_video(item) then
          local item_start = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
          local item_len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
          local item_end = item_start + item_len

          if not has_significant_overlap(item_start, item_end, existing_regions) then
            local take = reaper.GetActiveTake(item)
            local name = reaper.GetTakeName(take)
            if name == "" then
              name = string.format("Video_%03d", video_count)
            end
            video_count = video_count + 1

            reaper.AddProjectMarker2(0, true, item_start, item_end, name, -1, 0)
            region_count = region_count + 1
          end
        end
      end
    end
  end

  reaper.Undo_EndBlock2(0, "Create regions from video items", -1)

  if region_count == 0 then
    reaper.ShowMessageBox("No video items found on selected tracks.", "No Video Items", 0)
  end
end

main()
