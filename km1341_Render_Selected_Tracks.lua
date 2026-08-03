-- @description Render Selected Tracks via Master (All Regions)
-- @version 1.0
-- @author km1341
-- @about
--   Renders all project regions through the master bus, but only selected tracks
--   pass through master. Disables master/parent send for non-selected tracks,
--   sets render bounds to project regions, then opens the Render dialog.
--   Use Undo to restore original master sends after rendering.

local function main()
  local sel_count = reaper.CountSelectedTracks(0)
  if sel_count == 0 then
    reaper.ShowMessageBox("Please select at least one track to render.", "No Tracks Selected", 0)
    return
  end

  local selected = {}
  for i = 0, sel_count - 1 do
    local tr = reaper.GetSelectedTrack(0, i)
    if tr then selected[tr] = true end
  end

  reaper.Undo_BeginBlock2(0)

  local tr_count = reaper.CountTracks(0)
  for i = 0, tr_count - 1 do
    local tr = reaper.GetTrack(0, i)
    if tr then
      reaper.SetMediaTrackInfo_Value(tr, "B_MAINSEND", selected[tr] and 1 or 0)
    end
  end

  reaper.GetSetProjectInfo_String(0, "RENDER_BOUNDS", "5", true)

  reaper.Undo_EndBlock2(0, "Render selected tracks via master", -1)

  reaper.Main_OnCommand(40015, 0)
end

main()
