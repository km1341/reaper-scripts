-- @description Render Regions via Region Render Matrix
-- @version 1.0
-- @author km1341
-- @about
--   Sets render bounds to project regions and opens the Render dialog.
--   In the dialog, set Source to "Region render matrix - via Master"
--   to render only the regions enabled in the matrix.

local function main()
  reaper.GetSetProjectInfo_String(0, "RENDER_BOUNDS", "5", true)
  reaper.Main_OnCommand(40015, 0)
end

main()
