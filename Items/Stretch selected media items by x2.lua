-- @description Stretch selected media items by x2
-- @author AEHAZE Scripts
-- @version 1.0.0
-- @about
--   This script doubles the length of the selected item and halves its playback speed.
--   Pitch is preserved if "Preserve Pitch" is enabled in Item Propertie

reaper.Undo_BeginBlock()

local item = reaper.GetSelectedMediaItem(0, 0)

if item then
  local take = reaper.GetActiveTake(item)
  if take then
    -- Get current values
    local current_rate = reaper.GetMediaItemTakeInfo_Value(take, "D_PLAYRATE")
    local current_len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
    
    -- Calculate new values (0.5 rate = 2x length)
    local new_rate = current_rate * 0.5
    local new_len = current_len * 2
    
    -- Apply changes
    reaper.SetMediaItemTakeInfo_Value(take, "D_PLAYRATE", new_rate)
    reaper.SetMediaItemInfo_Value(item, "D_LENGTH", new_len)
    
    reaper.UpdateArrange()
  end
end

reaper.Undo_EndBlock("Stretch Item to Double Length", -1)
