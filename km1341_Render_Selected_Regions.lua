-- @description Render Selected Regions
-- @version 1.1
-- @author km1341
-- @about
--   Opens the Render dialog for rendering selected regions via master mix.
--   Select regions in the Region/Marker Manager before running.
--   In the Render dialog, set Bounds to "Selected regions" and configure output format.

local function main()
  reaper.Main_OnCommand(40015, 0)
end

main()
