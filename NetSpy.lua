

-- > By Newtomic#7889 /LegHat
-- Instuctions: Open the executers output window and run this script After that run whatever script you're trying to analyse
-- Note: This is Syn/Sw only (i won't update this)
-- This is mostly meant for just myself but if you do understand it feel free to tweek it.

local blockpost = false
local reversehook = false

local discordproxy, url = false,-- i'm lazy                                            

            "" -- enter Url


local savelogs = true

loadstring(game:HttpGet("https://gist.githubusercontent.com/AngryCat39/68aa677c65df093c2e8f84ebce712a09/raw/42a415067f2d0789be4307c45431ccd29ba25c68/gistfile1.txt"))()

local cf = clonefunction;

local requests = (syn or http).request;
local consoles = (printuiconsole or printconsole);

local redirect = {
	["request"] = request,
	["http_request"] = http_request
}

local format = cf(string.format);
local find = cf(string.find);
local gsub = cf(string.gsub);

local tstring = cf(tostring);

local t = cf(type);
local tf = cf(typeof);

local raw = cf(rawset);
local setmt = cf(setmetatable);
local gncm = cf(getnamecallmethod)

local a, b = xpcall(function()
    assert(requests and consoles, "Shit Exploit");
end, function()
    coroutine.wrap(function()
        if messagebox then
            messagebox("Your Executer does not support this script.", "bruh", 0);
        end
    end)()
    while true do end
end)

if getgenv()._Executed then return wconsole("Already Executed") end
if url == "" then discordproxy = false end;

local pconsole = cf(consoles);
local wconsole = cf(warnuiconsole or printconsole);

-- // file system
local Folder = "NetSpy"
local Folder_Path = Folder.."/".."NetSpy_Dump"
local File = Folder_Path.."/".."Log - "..game.JobId..".txt"

if not isfolder(Folder) then
    makefolder(Folder)
end

if not isfolder(Folder_Path) then
    makefolder(Folder_Path)
end

if not isfile(File) then
    writefile(File, "Console Output Log:\n")
end 

local function newprint(...)
    if savelogs == true then
        appendfile(File, tstring((...).."\n"))
    end
    return pconsole(...) 
end

local ncs = {"HttpGet", "HttpPost", "HttpGetAsync", "HttpPostAsync", "GetObjects"}
for i = 1, #ncs do ncs[ncs[i]] = true end

local nc = gncm()

local old; old = hookmetamethod(game, "__namecall", function(a, b, ...)
    local nc = gncm()
    if ncs[nc] then
        if (nc:sub(1, 7) == "HttpGet") then
            do
                newprint(format("Get: %s", tstring(b)))
            end
        elseif (nc:sub(1, 8) == "HttpPost") then
            local data = (...);
            do
                newprint(format("Post: %s", tstring(b)))
                newprint(format("Post (DATA): %s", tstring(data)))
            end
        elseif (nc == "GetObjects") then
            do
                newprint(format("Object: %s", tstring(b)))
            end
        end
    end
    return old(a, b, ...)
end)

setmt(_G,{__newindex = function(k,t,v)
    newprint("\n New index (_G): "..tstring(t).." | Value: "..tstring(v).. " | Type: "..tstring(tf(v)));
    raw(k,t,v)
end})

setmt(getrenv()._G,{__newindex = function(k,t,v)
    newprint("\n New index (getrenv()._G): "..tstring(t).." | Value: "..tstring(v).. " | Type: "..tstring(tf(v)));
    raw(k,t,v)
end})

setmt(shared,{__newindex = function(k,t,v)
    newprint("\n New index (shared): "..tstring(t).." | Value: "..tstring(v).. " | Type: "..tstring(tf(v)));
    raw(k,t,v)
end})

local function hook(req, ...)
    local Url = req.Url
    local Body = req.Body
    local Method = req.Method

    local Headers = req.Headers
    local Cookies = req.Cookies

    local tab1 = {
        ["Url"] = Url,
        ["Body"] = Body,
        ["Method"] = Method
    }

    for i, v in next, tab1 do
        if v then
            newprint(format([[
{
	["%s"] = "%s",
}
            ]], i, tstring(v)))
        else
            newprint(format([[
{
    ["%s"] = "%s",
}
            ]], i, "N/A"))
        end
    end
    newprint("Headers: ")

    if (t(Headers) == "table") then
        for i, v in next, Headers do
            if (t(v) == "table") then
                for i, v in next, v do
                    newprint(i .. ": " .. v)
                end
            else
                newprint(i .. ": " .. v)
            end
        end
    else
        newprint("N/A")
    end
    
    newprint("Cookies: ")

    if (t(Cookies) == "table") then
        for i, v in next, Cookies do
            if (t(v) == "table") then
                for i, v in next, v do
                    newprint(i .. ": " .. v)
                end
            else
                newprint("\n        - " .. i .. ": " .. v)
            end
        end
    else
        newprint("N/A")
	end
end

for _, v in next, redirect do
	if v then
		local old; old = hookfunction(v, function(req, ...)
			return requests(req, ...)
		end)
	end
end

local old; old = hookfunction(requests, function(req, ...)
    hook(req, ...)

    if blockpost == true then
        if req.Method then
            if find(req.Method, "POST") then
                return wconsole("Post request blocked.")
            end
        end
    end

    if discordproxy then
        if req.Url then
            if find(req.Url, "discord") and find(req.Url, "webhooks") then
                req.Url = url
            end 
        end 
    end

    return old(req, ...)
end)

local old; old = hookfunction(clonefunction, function(v1, v2)
    if reversehook == true then
        wconsole("Attempt to Clone function reversed")
        return old(v1, v1)
    else
        wconsole("clonefunction was used")
        return old(v1, v2)
    end
end)

local old; old = hookfunction(hookfunction, function(v1, v2)
    if reversehook == true then
        wconsole("Attempt to hook hookfunction reversed")
        return old(v1, v1)
    else
        wconsole("hookfunction was hooked")
        return old(v1, v2)
    end
end)

getgenv()._Executed = true
wconsole("\n listening...");
