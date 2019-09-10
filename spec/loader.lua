local loader = {}

_G.EquipMe = {}
_G.EquipMe_NAME = "EquipMe"

_G.GetLocale = function() return "enUS" end

function loader.load(file)
  return assert(loadfile("src/" .. file))(_G.EquipMe_NAME, _G.EquipMe)
end

return loader
