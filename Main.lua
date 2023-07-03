warn("please dont steall the hub source please kthx")
local CFN = CFrame.new
local CFA = CFrame.Angles
local Rad = math.rad
local Global = (getgenv and getgenv()) or shared
if not isfile and isfolder and writefile and (getsynasset or getcustomasset) then
    warn("Exploit will not run custom songs")
end
if isfile and isfolder and writefile and (getsynasset or getcustomasset) and (not isfolder("GelatekHub")) then
    local Bindable = Instance.new("BindableFunction")
    local function Copy(e)
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/packages/AudioPack.lua")
        )()
        Bindable:Destroy()
    end
    Bindable.OnInvoke = Copy
    game.StarterGui:SetCore(
        "SendNotification",
        {
            Title = "Audio Package (45 MB) ",
            Text = "Click here to download audio package for every script automatically, otherwise ignore",
            Duration = 10,
            Callback = Bindable,
            Button1 = "Download Data"
        }
    )
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/packages/FunctionPack.lua"))()

Global.GelatekHubConfig = {
	['Keep BodyParts'] = false,
	['Enable Collisions'] = false,
	['Bullet Enabled'] = false,
	['Animations'] = false,
	['DefinedHats'] = Global.CustomHats or {
        [1] = {"rbxassetid://13778226115", CFN(0,0,0), CFA(0,0,0), true},
        [2] = {'nil', CFN(0,0,0), CFA(0,0,0), false},

        [3] = {"rbxassetid://12344206675", CFN(0,0,0), CFA(Rad(-125),0,0), false},
        [4] = {"rbxassetid://12344207341", CFN(0,0,0), CFA(Rad(-125),0,0), false},

        [5] = {"http://www.roblox.com/asset/?id=11159284657", CFN(0,0,0), CFA(0,Rad(-90), Rad(90)), false},
        [6] = {"http://www.roblox.com/asset/?id=11263219250", CFN(0,0,0), CFA(0,Rad(-90), Rad(90)), false},
    }
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/lib/UILibrary.lua"))()
local Main = Library:Create("Gelatek Hub - RCD")
local UserInputService = game:GetService("UserInputService")
if UserInputService.TouchEnabled then
    game.StarterGui:SetCore(
        "SendNotification",
        {
            Title = "MOBILE USER ALERT! ",
            Text = "This hub was never really meant to support mobile executors for a reasons, check discord for info.",
            Duration = 5
        }
    )
end

local Home = Main:MakeTab("Home")
local Reanimate = Main:MakeTab("Reanimate")
local FreeScripts = Main:MakeTab("Free Scripts")
local HatScripts = Main:MakeTab("Hat Scripts")
local Animations = Main:MakeTab("Animations")
local Credits = Main:MakeTab("Credits")
local Hats = Main:MakeTab("Hats")
Home:MakeLabel("final update, will fix fling soon")
Home:MakeLabel("Hello! Thanks for using the hub.")
Home:MakeLabel("Current Version: 1.0.7")
Home:MakeButton(
    "Copy Discord Invite",
    function()
        setclipboard("https://discord.gg/fx5BszFmMY")
    end
)

local function BetterStopScript()
    StopScript()
    task.wait(0.25)
    StopScript()
end

Reanimate:MakeButton(
    "Reanimate",
    function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/lib/Reanimate.lua"))()
    end
)


Reanimate:MakeToggle(
    "Keep Body Parts",
    function(Bool)
        Global.GelatekHubConfig["Keep BodyParts"] = Bool
    end
)
Reanimate:MakeToggle(
    "Tool Fling",
    function(Bool)
        Global.GelatekHubConfig["Bullet Enabled"] = Bool
    end
)
Reanimate:MakeToggle(
    "Enable Collisions",
    function(Bool)
        Global.GelatekHubConfig["Enable Collisions"] = Bool
    end
)
Reanimate:MakeToggle(
    "Enable Base Anims",
    function(Bool)
        Global.GelatekHubConfig["Animations"] = Bool
    end
)
Reanimate:MakeLabel("To use custom hats, check #FAQ channel on the server.")
FreeScripts:MakeButton(" - [ Stop Script ] - ", BetterStopScript)
HatScripts:MakeButton(" - [ Stop Script ] - ", BetterStopScript)
Animations:MakeButton(" - [ Stop Animation ] - ", BetterStopScript)

do -- [[ Animations ]] --
    Animations:MakeTextBox(
        "Custom Anim",
        function(Text)
            PlayAnimation(Text)
        end
    )
    Animations:MakeButton(
        "Freestylin'",
        function()
            PlayAnimation(4432024917, "GelatekHub/Animations/Freestylin.mp3")
        end
    )
    Animations:MakeButton(
        "Floss",
        function()
            PlayAnimation(4812941481, "GelatekHub/Animations/Floss.mp3")
        end
    )
    Animations:MakeButton(
        "Smooth Moves",
        function()
            PlayAnimation(4900539662, "GelatekHub/Animations/Smooth Moves.mp3")
        end
    )
    Animations:MakeButton(
        "Aerostepping",
        function()
            PlayAnimation(4776588732, "GelatekHub/Animations/Aerostepping.mp3")
        end
    )
    Animations:MakeButton(
        "Electro Swing",
        function()
            PlayAnimation(3485013176, "GelatekHub/Animations/Electro Swing.mp3")
        end
    )
    Animations:MakeButton(
        "Minecraft Parrot",
        function()
            PlayAnimation(4300228160, "GelatekHub/Animations/Parrot.mp3")
        end
    )
    Animations:MakeButton(
        "CaramellDansen",
        function()
            PlayAnimation(6607554805, "GelatekHub/Animations/CaramellDansen.mp3")
        end
    )
    Animations:MakeButton(
        "Breakdown",
        function()
            PlayAnimation(4558409610, "GelatekHub/Animations/Breakdown.mp3")
        end
    )
    Animations:MakeButton(
        "Orange Justice",
        function()
            PlayAnimation(3262592866, "GelatekHub/Animations/Orange Justice.mp3")
        end
    )
    Animations:MakeButton(
        "Smug",
        function()
            PlayAnimation(3450125501, "GelatekHub/Animations/Smug.mp3")
        end
    )
    Animations:MakeButton(
        "Crabby",
        function()
            PlayAnimation(3643129020, "GelatekHub/Animations/Crabby.mp3")
        end
    )
    Animations:MakeButton(
        "Conga",
        function()
            PlayAnimation(4572096542, "GelatekHub/Animations/Conga.mp3")
        end
    )
    Animations:MakeButton(
        "Dream Feet",
        function()
            PlayAnimation(4300218011, "GelatekHub/Animations/Dream Feet.mp3")
        end
    )
    Animations:MakeButton(
        "Kazotsky Kick",
        function()
            PlayAnimation(4846209506)
        end
    )
    Animations:MakeButton(
        "Radical",
        function()
            PlayAnimation(4686555525)
        end
    )
    Animations:MakeButton(
        "Take The L",
        function()
            PlayAnimation(4827299133, "GelatekHub/Animations/Take The L.mp3")
        end
    )
    Animations:MakeButton(
        "Laughing",
        function()
            PlayAnimation(4846000379, "GelatekHub/Animations/Laughing.mp3")
        end
    )
    Animations:MakeButton(
        "Drip",
        function()
            PlayAnimation(4959380041, "GelatekHub/Animations/Drip.mp3")
        end
    )
    Animations:MakeButton(
        "Pushups",
        function()
            PlayAnimation(4966881089)
        end
    )
end

do -- [[ Scripts ]] --
    HatScripts:MakeButton(
        "Dual Ultima",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/DualUltima.lua")
            )()
        end
    )
    HatScripts:MakeButton(
        "The Hotline",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/TheHotline.lua")
            )()
        end
    )
    HatScripts:MakeButton(
        "Attack Rifle",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/AttackRifle.lua")
            )()
        end
    )
    HatScripts:MakeButton(
        "Carnage",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/TheCarnage.lua")
            )()
        end
    )
    HatScripts:MakeButton(
        "Neptunian V",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/NeptunianV.lua")
            )()
        end
    )
    HatScripts:MakeButton(
        "Zenith Battle Rifle-70",
        function()
            loadstring(
                game:HttpGet(
                    "https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/ZenithAttackRifle.lua"
                )
            )()
        end
    )
    HatScripts:MakeButton(
        "Chips",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/TheChips.lua")
            )()
        end
    )
    HatScripts:MakeButton(
        "Void Scythe",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/VoidScythe.lua")
            )()
        end
    )
    HatScripts:MakeButton(
        "Blue-Black Sniper",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/TheSniper.lua")
            )()
        end
    )
    HatScripts:MakeButton(
        "Banzai Bazooka",
        function()
            loadstring(
                game:HttpGet(
                    "https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/BanzaiBazooka.lua"
                )
            )()
        end
    )
    HatScripts:MakeButton(
        "Voodoo Doll",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/VoodooDoll.lua")
            )()
        end
    )
    HatScripts:MakeButton(
        "Quenox - use only 5 hats pls",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/Quenox.lua")
            )()
        end
    )
    HatScripts:MakeButton(
        "Goner",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/Goner.lua")
            )()
        end
    )

    FreeScripts:MakeButton(
        "Gale Fighter",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/GaleFighter.lua")
            )()
        end
    )
    FreeScripts:MakeButton(
        "Ender.",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/Ender.lua")
            )()
        end
    )
    FreeScripts:MakeButton(
        "Cadacus.",
        function()
            loadstring(
                game:HttpGet("https://raw.githubusercontent.com/toldblock/GelatekHub/main/src/scripts/Cadacus.lua")
            )()
        end
    )
end

do -- [[ Hats ]] --
    Hats:MakeButton(
        "Copy R6 Bullet Hat",
        function()
            setclipboard("48474313")
        end
    )
    Hats:MakeButton(
        "Copy R15 Bullet Hat",
        function()
            setclipboard("5973840187")
        end
    )
    Hats:MakeButton(
        "Copy Dual Ultima Hats",
        function()
            setclipboard("4524991457,4820152700")
        end
    )
    Hats:MakeButton(
        "Copy The Hotline Hat",
        function()
            setclipboard("4962455546")
        end
    )
    Hats:MakeButton(
        "Copy Attack Rifle Hat",
        function()
            setclipboard("6202087882")
        end
    )
    Hats:MakeButton(
        "Copy Carnage Hats",
        function()
            setclipboard("5134896593,5410674378")
        end
    )
    Hats:MakeButton(
        "Copy Neptunian V Hat",
        function()
            setclipboard("4506945409")
        end
    )
    Hats:MakeButton(
        "Copy Zenith Rifle Hats",
        function()
            setclipboard("4962510729,4962455546")
        end
    )
    Hats:MakeButton(
        "Copy Chips Hat",
        function()
            setclipboard("4964938812")
        end
    )
    Hats:MakeButton(
        "Copy Blue-Black Sniper Hat",
        function()
            setclipboard("5063578607")
        end
    )
    Hats:MakeButton(
        "Copy Void Scythe Hat",
        function()
            setclipboard("5414429551")
        end
    )
    Hats:MakeButton(
        "Copy Banzai Bazooka Hat",
        function()
            setclipboard("4466171123")
        end
    )
    Hats:MakeButton(
        "Copy Voodoo Doll Hats",
        function()
            setclipboard("7218265043,7170689370")
        end
    )
    Hats:MakeButton(
        "Copy Quenox Hats",
        function()
            setclipboard("4820152700,4794315940,4524991457,4315489767,4458601937,4506945409")
        end
    )
    Hats:MakeButton(
        "Copy Goner Hat",
        function()
            setclipboard("6869866014")
        end
    )
end

do -- [[ Credits ]] --
    Credits:MakeLabel("Gui: Gelatek")
    Credits:MakeLabel("Reanimate: Gelatek")
    Credits:MakeLabel("Anim ID Player: Gelatek / Derek")
    Credits:MakeLabel("Converts: Gelatek")
end

local null = Main:MakeTab(" ")
null:MakeTextBox(
    "funny",
    function(value)
        if value == "kylesweep" then
            local screengui = Instance.new("ScreenGui")
            screengui.Parent = game:GetService("CoreGui")
            local r = math.random
            local function MiniRandom()
                local ABC0, ABC1 = r(1, 8), r(1, 9)
                return "0." .. ABC0 .. ABC1
            end
            for i = 0, 45 do
                local image = Instance.new("ImageLabel", screengui)
                image.Position = UDim2.new(MiniRandom(), 0, 1, 0)
                image.Size = UDim2.new(0, 150, 0, 150)
                image.BackgroundTransparency = 1
                image.Image = "http://www.roblox.com/asset/?id=8300658383"
                image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                local function rotation(Object, Property)
                    local Tween =
                        game:GetService("TweenService"):Create(
                        Object,
                        TweenInfo.new(Property["Time"]),
                        {Rotation = Property["Rotation"]}
                    ):Play()
                    return Tween
                end
                rotation(
                    image,
                    {
                        ["Time"] = 1.5,
                        ["Rotation"] = math.random(-180, 180)
                    }
                )
                local function returning()
                    image:TweenPosition(
                        image.Position + UDim2.new(0, 0, 0.6, 0),
                        Enum.EasingDirection.In,
                        Enum.EasingStyle.Quad,
                        0.4
                    )
                end

                image:TweenPosition(
                    image.Position - UDim2.new(0, 0, 0.6, 0),
                    Enum.EasingDirection.InOut,
                    Enum.EasingStyle.Quad,
                    0.4,
                    false,
                    returning
                )
                task.wait(0.05)
            end
            task.wait(5)
            screengui:Destroy()
        end
        if value == "nullwarehub" then
            if isfile and isfolder and writefile and (getsynasset or getcustomasset) then
                local getsynasset = getsynasset or getcustomasset or function()
                        warn("no getcustomasset/getsynasset")
                    end
                if not isfile("nw.png") then
                    writefile(
                        "nw.png",
                        game:HttpGet("https://github.com/toldblock/GelatekHub/blob/main/image%5B1%5D.png?raw=true")
                    )
                end
                if not isfile("jp.mp3") then
                    writefile(
                        "jp.mp3",
                        game:HttpGet(
                            "https://github.com/Gelatekussy/GelatekHubSongs/blob/main/ttsMP3.com_VoiceText_2022-11-30_20%2016%2026.mp3?raw=true"
                        )
                    )
                end
                if not isfile("scream.mp3") then
                    writefile(
                        "scream.mp3",
                        game:HttpGet("https://github.com/Gelatekussy/GelatekHubSongs/blob/main/scream.mp3?raw=true")
                    )
                end

                local screengui = Instance.new("ScreenGui")
                screengui.Parent = game:GetService("CoreGui")

                local sound = Instance.new("Sound")
                sound.SoundId = getsynasset("jp.mp3")
                sound.Volume = 3
                sound:Play()
                sound.Parent = screengui

                task.spawn(
                    function()
                        task.wait(1.5)
                        sound.SoundId = getsynasset("scream.mp3")
                        sound.Volume = 10
                        sound:Play()
                    end
                )

                local image = Instance.new("ImageLabel", screengui)
                image.Position = UDim2.new(0.5, 0, 0.5, 0)
                image.AnchorPoint = Vector2.new(0.5, 0.5)
                image.Size = UDim2.new(0.2, 0, 0.2, 0)
                image.BackgroundTransparency = 1
                image.Image = getsynasset("nw.png")
                image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                task.wait(0.2)
                image:TweenSize(UDim2.new(1.5, 0, 1.5, 0))
                task.wait(5)
                screengui:Destroy()
            end
        end
    end
)
