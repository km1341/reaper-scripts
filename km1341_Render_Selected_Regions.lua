-- @description Render Selected Regions
-- @version 1.0
-- @author km1341
-- @about
--   Opens the Render dialog configured for selected regions via master mix.
--   Select regions in the Region/Marker Manager before running.
--   Choose output format and parameters in the Render dialog.

local function main()
  reaper.Undo_BeginBlock2(0)

  reaper.GetSetProjectInfo_String(0, "RENDER_BOUNDS", "4", true)

  reaper.Main_OnCommand(41823, 0)

  reaper.Undo_EndBlock2(0, "Open render dialog for selected regions", -1)
end

main()
