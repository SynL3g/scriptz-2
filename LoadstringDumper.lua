
-- Saves everything passed through loadstring to your workspace folder
-- Note: this can lag pretty bad

local Folder = "LoadstringDump"
local Folder_Path = Folder.."/".."Data"

if not isfolder(Folder) then
    makefolder(Folder)
end


if not isfolder(Folder_Path) then
    makefolder(Folder_Path)
end

local old; old = hookfunction(loadstring, function(...)

    writefile(
            
    Folder_Path.."/".."Log - "..string.gsub(tostring(math.random(1, 1e9) / os.time()), "[%s%p]", "")..".txt",

    (...)
)
    return old(...)
end)
