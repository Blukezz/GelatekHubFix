-- krypton reanimate: originated from https://github.com/toldblock/Krypton/edit/main/src/reanimation.luam
-- edited to support gelatek hub
-- this version is badly coded bcause it had to support all gelatek hub shit, please consideer looking at the original
local Global = (getgenv and getgenv()) or getfenv(0)
local CFN = CFrame.new
local CFA = CFrame.Angles
local Rad = math.rad
 -- -gh 11449687315,11449703382,11263254795,11159410305,12693942963

local IsPartOwned = isnetworkowner or function(a) return a.ReceiveAge == 0 end
local SetHiddenProp = sethiddenproperty or function(a,b,c) pcall(function() a[b]=c end) end

if Global.KryptonReanimateLoaded then
	return
end

if not Global.GelatekHubConfig then 
	Global.GelatekHubConfig = {} 
end

Global.PartDisconnected = false
Global.Flinging = false
Global.RealChar = nil
Global.FlingPart = nil
if not Global.TableOfEvents then Global.TableOfEvents = {} end

local Cos = math.cos
local Sin = math.sin
local Random = math.random

local Clock = os.clock

local V3N = Vector3.new
local CF0 = CFN(0,0,0)

local TInsert = table.insert
local TRemove = table.remove
local TFind = table.find

local Wait = task.wait
local Delay = task.delay
local Spawn = task.defer

local IN = Instance.new
local Handles, Events = {}, {}
local ReanimSettings = Global.GelatekHubConfig

-- locals
local IsAlive = true

local Workspace = game:FindFirstChildOfClass("Workspace")
local RunService = game:FindFirstChildOfClass("RunService")
local Players = game:FindFirstChildOfClass("Players")
local InsertService = game:FindFirstChildOfClass("InsertService")
local Stats = game:FindFirstChildOfClass("Stats")
local TestService = game:FindFirstChildOfClass("TestService")
local Ping = Stats.Network.ServerStatsItem["Data Ping"]
local Camera = Workspace.CurrentCamera
local Physics = settings().Physics

local LocalPlayer = Players.LocalPlayer
local RealRig = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
Physics.AllowSleep = false
Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
SetHiddenProp(RealRig:FindFirstChildOfClass("Humanoid"), "InternalBodyScale", V3N(1/0, 1/0, 1/0))

Global.RealChar = RealRig
local FakeHats;
local RealRigDescendants = RealRig:GetDescendants()
local FakeHum, FakeHead, FakeRoot, FakeTorso, FakeRightArm, FakeLeftArm, FakeRightLeg, FakeLeftLeg, FakeRigDescendants
local FakeRig = IN("Model"); do
	local function CI(ClassName, Info) local Inst = IN(ClassName) for i, v in pairs(Info) do Inst[i]=v end return Inst end
	FakeHead = CI("Part", {Name = "Head", Size = V3N(2, 1, 1), Transparency = 1, Parent = FakeRig});
	FakeRoot = CI("Part", {Name = "HumanoidRootPart", Size = V3N(2, 2, 1), Transparency = 1, Parent = FakeRig})
	FakeTorso = CI("Part", {Name = "Torso", Size = V3N(2, 2, 1), Transparency = 1, Parent = FakeRig})
	FakeRightArm = CI("Part", {Name = "Right Arm", Size = V3N(1, 2, 1), Transparency = 1, Parent = FakeRig})
	FakeLeftArm = CI("Part", {Name = "Left Arm", Size = V3N(1, 2, 1), Transparency = 1, Parent = FakeRig})
	FakeRightLeg = CI("Part", {Name = "Right Leg", Size = V3N(1, 2, 1), Transparency = 1, Parent = FakeRig})
	FakeLeftLeg = CI("Part", {Name = "Left Leg", Size = V3N(1, 2, 1),Transparency = 1, Parent = FakeRig})
	FakeHum = CI("Humanoid", {DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None, Parent = FakeRig})
	CI("Motor6D", {Name = "Neck", Part0 = FakeTorso, Part1 = FakeHead, C0 = CFN(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0), C1 = CFN(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0), Parent = FakeTorso})
	CI("Motor6D", {Name = "RootJoint", Part0 = FakeRoot, Part1 = FakeTorso, C0 = CFN(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0), C1 = CFN(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0), Parent = FakeRoot})
	CI("Motor6D", {Name = "Right Shoulder", Part0 = FakeTorso, Part1 = FakeRightArm, C0 = CFN(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0), C1 = CFN(-0.5, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0), Parent = FakeTorso})
	CI("Motor6D", {Name = "Left Shoulder", Part0 = FakeTorso, Part1 = FakeLeftArm, C0 = CFN(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFN(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), Parent = FakeTorso})
	CI("Motor6D", {Name = "Right Hip", Part0 = FakeTorso, Part1 = FakeRightLeg, C0 = CFN(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0), C1 = CFN(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0), Parent = FakeTorso})
	CI("Motor6D", {Name = "Left Hip", Part0 = FakeTorso, Part1 = FakeLeftLeg, C0 = CFN(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), C1 = CFN(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), Parent = FakeTorso})
	CI("Animator", {Parent = FakeHum}); CI("HumanoidDescription", {Parent = FakeHum}); CI("SpecialMesh", {Scale = V3N(1,1,1)*1.25, Parent = FakeHead})
	CI("Script", {Name = "Health", Parent = FakeRig}); CI("LocalScript", {Name = "Animate", Parent = FakeRig})
	CI("Decal", {Name = "face", Texture = "rbxasset://textures/face.png", Transparency = 1, Parent = FakeHead})
	IN("Shirt", FakeRig) IN("Pants", FakeRig) IN("ShirtGraphic", FakeRig)
	CI("Attachment", {Name = "FaceCenterAttachment", Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeHead})
	CI("Attachment", {Name = "FaceFrontAttachment", Position = V3N(0,0,-0.6), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeHead})
	CI("Attachment", {Name = "HairAttachment", Position = V3N(0,0.6,0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeHead})
	CI("Attachment", {Name = "HatAttachment", Position = V3N(0,0.6,0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeHead})
	CI("Attachment", {Name = "RootAttachment", Position = V3N(0,0.6,0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeRoot})
	CI("Attachment", {Name = "RightGripAttachment", Position = V3N(0,-1,0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeRightArm})
	CI("Attachment", {Name = "RightShoulderAttachment", Position = V3N(0,1,0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeRightArm})
	CI("Attachment", {Name = "LeftGripAttachment", Position = V3N(0,-1,0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeLeftArm})
	CI("Attachment", {Name = "LeftShoulderAttachment", Position = V3N(0,1,0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeLeftArm})
	CI("Attachment", {Name = "RightFootAttachment", Position = V3N(0,-1,0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeRightLeg})
	CI("Attachment", {Name = "LeftFootAttachment", Position = V3N(0,-1,0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeLeftLeg})
	CI("Attachment", {Name = "BodyBackAttachment", Position = V3N(0,0,0.5), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeTorso})
	CI("Attachment", {Name = "BodyFrontAttachment", Position = V3N(0,0,-0.5), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeTorso})
	CI("Attachment", {Name = "LeftCollarAttachment", Position = V3N(-1, 1, 0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeTorso})
	CI("Attachment", {Name = "NeckAttachment", Position = V3N(0, 1, 0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeTorso})
	CI("Attachment", {Name = "RightCollarAttachment", Position = V3N(1, 1, 0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeTorso})
	CI("Attachment", {Name = "WaistBackAttachment", Position = V3N(0, -1, 0.5), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeTorso})
	CI("Attachment", {Name = "WaistCenterAttachment", Position = V3N(0, -1, 0), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeTorso})
	CI("Attachment", {Name = "WaistFrontAttachment", Position = V3N(0, -1, -0.5), Axis = V3N(1,0,0), SecondaryAxis = V3N(0,1,0), Parent = FakeTorso})
	FakeHats = CI("Folder", {Name = "FakeHats", Parent = TestService})
	FakeRig.PrimaryPart = FakeHead; FakeRig.Name = "GelatekReanimate"; FakeRig.Parent = Workspace; FakeRigDescendants = FakeRig:GetDescendants(); FakeRig:MoveTo(RealRig.PrimaryPart.Position + V3N(0, 5, 0))
end

do -- [[ hat renaming (compactability) syndicat/mizt
	local HatsNames = {}
	for Index, Accessory in pairs(RealRigDescendants) do
		if Accessory:IsA("Accessory") then
			if HatsNames[Accessory.Name] then
				if HatsNames[Accessory.Name] == "Unknown" then
					HatsNames[Accessory.Name] = {}
				end
				TInsert(HatsNames[Accessory.Name], Accessory)
			else
				HatsNames[Accessory.Name] = "Unknown"
			end	
		end
	end
	for Index, Tables in pairs(HatsNames) do
		if typeof(Tables) == "table" then
			local Number = 1
			for Index2, Names in ipairs(Tables) do
				Names.Name = Names.Name .. Number
				Number = Number + 1
			end		
		end
	end
end

local function ReWeldHats(Handle)
	local FakeAccessory = Handle.Parent:Clone()
	local Handle = FakeAccessory:FindFirstChild("Handle")
	local Attachment = Handle:FindFirstChildOfClass("Attachment")
	if Handle:FindFirstChildOfClass("Weld") then
		Handle:FindFirstChildOfClass("Weld"):Destroy()
	end
	
	Handle.Transparency = 1
	local Weld = IN("Weld")
	Weld.Name = "AccessoryWeld"
	Weld.Part0 = Handle

	if Attachment then
		Weld.C0 = Attachment.CFrame
		Weld.C1 = FakeRig:FindFirstChild(tostring(Attachment), true).CFrame
		Weld.Part1 = FakeRig:FindFirstChild(tostring(Attachment), true).Parent
	else
		Weld.Part1 = FakeRig:FindFirstChild("Head", 20)
		Weld.C1 = CFN(0, FakeRig:FindFirstChild("Head", 20).Size.Y / 2, 0) * FakeAccessory.AttachmentPoint:Inverse()
	end
	Weld.Parent = Handle
	FakeAccessory.Parent = FakeRig 
	return FakeAccessory
end

local function GetHandle(AccessoryID, Check)
	for _, Handle in pairs(Handles) do
		local Mesh = Handle:FindFirstChildOfClass("SpecialMesh") or Handle
		local PropertyName = Check and "MeshId" or pcall(function() Mesh["TextureID"] = Mesh["TextureID"] end) and "TextureID" or "TextureId"
		if (Mesh[PropertyName] == AccessoryID) or (Mesh[PropertyName] == "rbxassetid://"..AccessoryID) then
			TRemove(Handles, TFind(Handles, Handle))
			FakeRig:FindFirstChild(Handle.Parent.Name):Destroy()
			return Handle
		end
	end
end

local function CFrameTo(Part0, Part1, Offset)
	if Part0 and Part1 and IsPartOwned(Part0) then
		Part0.AssemblyAngularVelocity = V3N(0, 2*Cos(Clock()*19), 0)
		Part0.AssemblyLinearVelocity = V3N(Part1.AssemblyLinearVelocity.X * (Part0.Mass * 5), 25.06 + Random(20,60)/Random(8,15), Part1.AssemblyLinearVelocity.Z * (Part0.Mass * 5))
		Part0.CFrame = Part1.CFrame * (typeof(Offset) == "CFrame" and Offset or CF0) * CFN(0, Random(1,2)/200, 0)
	end
end

local function ClearUpData()
	for _, Signal in pairs(Events) do
		Signal:Disconnect()
	end
	
	for _, GlobalSignal in pairs(Global.TableOfEvents) do
		GlobalSignal:Disconnect()
	end
	
	Global.Stopped = true
	FakeHats:Destroy()
	Global.FlingPart = nil
	Global.RealChar = nil
	
	if TestService:FindFirstChild("ScriptCheck") then
		TestService:FindFirstChild("ScriptCheck"):Destroy()
	end

	Global.KryptonReanimateLoaded = nil
	IsAlive = false
	Delay(0.25, function()
		Global.Stopped = false
	end)
	Global.Flinging = false
end

for _, Part in pairs(RealRigDescendants) do
	if Part:IsA("BasePart") then
		Delay(WaitTime, function() Part.Massless = false end)
		Part.Anchored = false
	elseif Part:IsA("Accessory") then
		local Handle = Part:FindFirstChild("Handle") or Part:FindFirstChildOfClass("BasePart")
		local NewHat = ReWeldHats(Handle)
		local CachedHat = NewHat:Clone()
		
		CachedHat.Parent = FakeHats
		TInsert(Handles, Handle)
	elseif Part:IsA("LocalScript") then
		Part.Disabled = true
	end
end

--e
local WaitTime = Players.RespawnTime + Ping:GetValue()/750
local FlingPart; Spawn(function() if ReanimSettings['Bullet Enabled'] then
	local Backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
	local Tool = RealRig:FindFirstChildOfClass("Tool")
	if Tool then
		Tool.Parent = RealRig
		FlingPart = Tool:WaitForChild("Handle")
		FlingPart.Transparency = 0.8
		Global.FlingPart = FlingPart
		if Backpack then
			Backpack:ClearAllChildren()
		end
		task.delay(WaitTime, function()
			FlingPart.Massless = true
		end)
	else
		print("Equip tool pls")		
	end
end end)

local LoadPoint = RealRig.PrimaryPart.CFrame * CFN(0,8,0)
local Platform; if not ReanimSettings['Keep BodyParts'] then -- fix this tmr, then i can beta release the reanimate
	Platform = IN("Part")
	Platform.Size = V3N(25, 0.5, 25)
	Platform.Position = V3N(32500, 0, 5000)
	Platform.Anchored = true
	Platform.Parent = Workspace
	RealRig:MoveTo(Platform.Position + V3N(0, 10, 0))
	FakeRig:MoveTo(RealRig.PrimaryPart.Position + V3N(0, 5, 0))
end

LocalPlayer.Character = nil
LocalPlayer.Character = FakeRig

FakeHum.WalkSpeed = 0
Global.KryptonReanimateLoaded = true
Wait(WaitTime); RealRig:BreakJoints()

Spawn(function()
	local FakeHandles = {}
	local FakeRigParts = {FakeHead, FakeRoot, FakeTorso, FakeRightArm, FakeLeftArm, FakeRightLeg, FakeLeftLeg}
	local DesiredHats = Global.GelatekHubConfig.DefinedHats or {
        [1] = {'rbxassetid://6963024829', CFN(0,0,0), CFA(0,0,0), true},
        [2] = {'nil', CFN(0,0,0), CFA(0,0,0), false},

        [3] = {'rbxassetid://11449388499', CFN(0,0,0), CFA(Rad(-125), 0, 0), true},
        [4] = {'rbxassetid://11449386931', CFN(0,0,0), CFA(Rad(-125), 0, 0), true},
        [5] = {'rbxassetid://11159370334', CFN(0,0.1,0), CFA(0, Rad(-90), Rad(90)), true},
        [6] = {'rbxassetid://11263221350', CFN(0,-0.05,0), CFA(0, Rad(-90), Rad(90)), true},
	}
	
	local T1 = GetHandle(DesiredHats[1][1], DesiredHats[1][4]); local T1_CF = DesiredHats[1][2] * DesiredHats[1][3]
	local T2 = GetHandle(DesiredHats[2][1], DesiredHats[2][4]); local T2_CF = DesiredHats[2][2] * DesiredHats[2][3]
	local RA = GetHandle(DesiredHats[3][1], DesiredHats[3][4]); local RA_CF = DesiredHats[3][2] * DesiredHats[3][3]
	local LA = GetHandle(DesiredHats[4][1], DesiredHats[4][4]); local LA_CF = DesiredHats[4][2] * DesiredHats[4][3]
	local RL = GetHandle(DesiredHats[5][1], DesiredHats[5][4]); local RL_CF = DesiredHats[5][2] * DesiredHats[5][3]
	local LL = GetHandle(DesiredHats[6][1], DesiredHats[6][4]); local LL_CF = DesiredHats[6][2] * DesiredHats[6][3]
	
	for i = 1,#Handles do -- myworld optimization (he told me to do this) (fake)
		local Handle = Handles[i]
		if Handle then
			local FakeHandle = FakeRig:FindFirstChild(Handle.Parent.Name) and FakeRig[Handle.Parent.Name]:FindFirstChild("Handle")
			if FakeHandle then
				TInsert(FakeHandles, FakeHandle)
			end
		end
	end
	
	TInsert(Events, RunService.PostSimulation:Connect(function()
		CFrameTo(T1, FakeTorso, T1_CF)
		CFrameTo(T2, FakeTorso, T2_CF)
		CFrameTo(RA, FakeRightArm, RA_CF)
		CFrameTo(LA, FakeLeftArm, LA_CF)
		CFrameTo(RL, FakeRightLeg, RL_CF)
		CFrameTo(LL, FakeLeftLeg, LL_CF)
		for i = 1,#Handles do 
			local Handle, FakeHandle = Handles[i], FakeHandles[i]			
			if Handle and FakeHandle then
				CFrameTo(Handle, FakeHandle, CF0)
			end
		end
		
		if FlingPart and FakeRoot then
			if not Global.Flinging or not Global.PartDisconnected then
				CFrameTo(FlingPart, FakeRoot, CFN(0, -20, 0))
			end
			if not Global.KryptonReanimateLoaded then
				FlingPart.Velocity = V3N(0, 0, 0)
			end
		end
		
		if FakeRoot and FakeRoot.Velocity.Magnitude <= 2 then
			FakeRoot.CFrame = FakeRoot.CFrame * CFN(0.01 * Cos(Clock()*19), 0, 0)
		end
	end))
	
	TInsert(Events, RunService.PreSimulation:Connect(function()
		if not ReanimSettings['Enable Collisions'] then
			for _,v in pairs(FakeRigParts) do
				v.CanCollide = false
				v.CanQuery = false
				v.CanTouch = false
			end
		end
		if FlingPart then
			FlingPart.CanCollide = false
			FlingPart.CanQuery = false
			FlingPart.CanTouch = false
		end
		
		SetHiddenProp(LocalPlayer, "MaximumSimulationRadius", 9999)
		SetHiddenProp(LocalPlayer, "MaximumSimulationRadius", LocalPlayer.MaximumSimulationRadius)
	end))
end)

local Parent = RealRig.Parent; TInsert(Events, RealRig:GetPropertyChangedSignal("Parent"):Connect(function()
	Parent = RealRig.Parent
	if Parent == nil then
		ClearUpData()
		FakeRig:Destroy()
	end
end))

FakeHum.Died:Once(function()
	ClearUpData()
	LocalPlayer.Character = RealRig
	RealRig.Parent = Workspace
	FakeRig:Destroy()
end)

if Platform then
	Wait(3)
	Platform:Destroy()
	FakeRoot.CFrame = LoadPoint
	FakeRoot.CFrame = LoadPoint
end

FakeRoot.Anchored = false
Camera.CameraSubject = FakeHum

FakeHum:ChangeState(2)
FakeHum:ChangeState(7)
RealRig.Parent = FakeRig

Spawn(function() if ReanimSettings.Animations then 
	local AnimateScript = IN("LocalScript")
	AnimateScript.Name = "Animate"
	AnimateScript.Parent = FakeRig
	local Toggled = (AnimateScript and AnimateScript.Parent) and AnimateScript.Enabled or false
	local RightShoulder = FakeTorso:FindFirstChild("Right Shoulder")
	local LeftShoulder = FakeTorso:FindFirstChild("Left Shoulder")
	local RightHip = FakeTorso:FindFirstChild("Right Hip")
	local LeftHip = FakeTorso:FindFirstChild("Left Hip")
	local Neck = FakeTorso:FindFirstChild("Neck")
	local animator = FakeHum:FindFirstChildOfClass("Animator")

	local pose = "Standing"
	local currentAnim = ""
	local currentAnimInstance = nil
	local currentAnimTrack = nil
	local currentAnimKeyframeHandler = nil
	local currentAnimSpeed = 1.0
	local toolAnimName = ""
	local toolAnimTrack = nil
	local toolAnimInstance = nil
	local currentToolAnimKeyframeHandler = nil
	local lastTick = 0
	local toolAnim = "None"
	local toolAnimTime = 0
	local jumpAnimTime = 0
	local jumpAnimDuration = 0.3
	local toolTransitionTime = 0.1
	local fallTransitionTime = 0.3
	local jumpMaxLimbVelocity = 0.75
	local time = 0
	local animTable = {}
	local dances = {"dance1", "dance2", "dance3"}
	local emoteNames = { wave = false, point = false, dance1 = true, dance2 = true, dance3 = true, laugh = false, cheer = false}
	local animNames = { 
		idle = 	{ { id = "http://www.roblox.com/asset/?id=180435571", weight = 9 }, { id = "http://www.roblox.com/asset/?id=180435792", weight = 1 } },
		walk = 	{ { id = "http://www.roblox.com/asset/?id=180426354", weight = 10 } }, 
		run = 	{ { id = "run.xml", weight = 10 } }, 
		jump = 	{ { id = "http://www.roblox.com/asset/?id=125750702", weight = 10 } }, 
		fall = 	{ { id = "http://www.roblox.com/asset/?id=180436148", weight = 10 } }, 
		climb = { { id = "http://www.roblox.com/asset/?id=180436334", weight = 10 } }, 
		sit = 	{ { id = "http://www.roblox.com/asset/?id=178130996", weight = 10 } },	
		toolnone = { { id = "http://www.roblox.com/asset/?id=182393478", weight = 10 } },
		toolslash = { { id = "http://www.roblox.com/asset/?id=129967390", weight = 10 } },
		toollunge = { { id = "http://www.roblox.com/asset/?id=129967478", weight = 10 } },
		wave = { { id = "http://www.roblox.com/asset/?id=128777973", weight = 10 } },
		point = { { id = "http://www.roblox.com/asset/?id=128853357", weight = 10 } },
		dance1 = { { id = "http://www.roblox.com/asset/?id=182435998", weight = 10 }, { id = "http://www.roblox.com/asset/?id=182491037", weight = 10 }, { id = "http://www.roblox.com/asset/?id=182491065", weight = 10 } },
		dance2 = { { id = "http://www.roblox.com/asset/?id=182436842", weight = 10 }, { id = "http://www.roblox.com/asset/?id=182491248", weight = 10 }, { id = "http://www.roblox.com/asset/?id=182491277", weight = 10 } },
		dance3 = { { id = "http://www.roblox.com/asset/?id=182436935", weight = 10 }, { id = "http://www.roblox.com/asset/?id=182491368", weight = 10 }, { id = "http://www.roblox.com/asset/?id=182491423", weight = 10 } },
		laugh = { { id = "http://www.roblox.com/asset/?id=129423131", weight = 10 } },
		cheer = { { id = "http://www.roblox.com/asset/?id=129423030", weight = 10 } },
	}

	local function conFakeRigAnimationSet(name, fileList)
		if (animTable[name] ~= nil) then
			for _, connection in pairs(animTable[name].connections) do
				connection:disconnect()
			end
		end
		animTable[name] = {}
		animTable[name].count = 0
		animTable[name].totalWeight = 0	
		animTable[name].connections = {}
		local config = script:FindFirstChild(name)
		if (config ~= nil) then
			TInsert(animTable[name].connections, config.ChildAdded:connect(function(child) conFakeRigAnimationSet(name, fileList) end))
			TInsert(animTable[name].connections, config.ChildRemoved:connect(function(child) conFakeRigAnimationSet(name, fileList) end))
			local idx = 1
			for _, childPart in pairs(config:GetChildren()) do
				if (childPart:IsA("Animation")) then
					TInsert(animTable[name].connections, childPart.Changed:connect(function(property) conFakeRigAnimationSet(name, fileList) end))
					animTable[name][idx] = {}
					animTable[name][idx].anim = childPart
					local weightObject = childPart:FindFirstChild("Weight")
					if (weightObject == nil) then
						animTable[name][idx].weight = 1
					else
						animTable[name][idx].weight = weightObject.Value
					end
					animTable[name].count = animTable[name].count + 1
					animTable[name].totalWeight = animTable[name].totalWeight + animTable[name][idx].weight
					idx = idx + 1
				end
			end
		end
		if (animTable[name].count <= 0) then
			for idx, anim in pairs(fileList) do
				animTable[name][idx] = {}
				animTable[name][idx].anim = Instance.new("Animation")
				animTable[name][idx].anim.Name = name
				animTable[name][idx].anim.AnimationId = anim.id
				animTable[name][idx].weight = anim.weight
				animTable[name].count = animTable[name].count + 1
				animTable[name].totalWeight = animTable[name].totalWeight + anim.weight
			end
		end
	end

	if animator then
		local animTracks = animator:GetPlayingAnimationTracks()
		for i,track in ipairs(animTracks) do
			track:Stop(0); track:Destroy()
		end
	end

	for name, fileList in pairs(animNames) do 
		conFakeRigAnimationSet(name, fileList)
	end	

	local function stopAllAnimations()
		local oldAnim = currentAnim
		if (emoteNames[oldAnim] ~= nil and emoteNames[oldAnim] == false) then
			oldAnim = "idle"
		end
		currentAnim, currentAnimInstance = "", nil
		if (currentAnimKeyframeHandler ~= nil) then
			currentAnimKeyframeHandler:disconnect()
		end

		if (currentAnimTrack ~= nil) then
			currentAnimTrack:Stop()
			currentAnimTrack:Destroy()
			currentAnimTrack = nil
		end
		return oldAnim
	end

	local function setAnimationSpeed(speed)
		if speed ~= currentAnimSpeed then
			currentAnimSpeed = speed
			currentAnimTrack:AdjustSpeed(currentAnimSpeed)
		end
	end
	local playAnimation = function() end -- fix
	local toolKeyFrameReachedFunc = function() end -- fix
	
	local function keyFrameReachedFunc(frameName)
		if (frameName == "End") then
			local repeatAnim = currentAnim
			if (emoteNames[repeatAnim] ~= nil and emoteNames[repeatAnim] == false) then
				repeatAnim = "idle"
			end

			local animSpeed = currentAnimSpeed
			playAnimation(repeatAnim, 0.0, FakeHum)
			setAnimationSpeed(animSpeed)
		end
	end

	playAnimation = function(animName, transitionTime, humanoid) 
		local roll = Random(1, animTable[animName].totalWeight) 
		local origRoll = roll
		local idx = 1
		while (roll > animTable[animName][idx].weight) do
			roll = roll - animTable[animName][idx].weight
			idx = idx + 1
		end
		local anim = animTable[animName][idx].anim
		if (anim ~= currentAnimInstance) then
			if (currentAnimTrack ~= nil) then
				currentAnimTrack:Stop(transitionTime)
				currentAnimTrack:Destroy()
			end
			currentAnimSpeed = 1.0
			currentAnimTrack = humanoid:LoadAnimation(anim)
			currentAnimTrack.Priority = Enum.AnimationPriority.Core

			currentAnimTrack:Play(transitionTime)
			currentAnim = animName
			currentAnimInstance = anim

			if (currentAnimKeyframeHandler ~= nil) then
				currentAnimKeyframeHandler:disconnect()
			end
			currentAnimKeyframeHandler = currentAnimTrack.KeyframeReached:connect(keyFrameReachedFunc)
		end
	end
	
	local function playToolAnimation(animName, transitionTime, humanoid, priority)	 
		local roll = Random(1, animTable[animName].totalWeight) 
		local origRoll = roll
		local idx = 1
		while (roll > animTable[animName][idx].weight) do
			roll = roll - animTable[animName][idx].weight
			idx = idx + 1
		end
		local anim = animTable[animName][idx].anim
		if (toolAnimInstance ~= anim) then
			if (toolAnimTrack ~= nil) then
				toolAnimTrack:Stop()
				toolAnimTrack:Destroy()
				transitionTime = 0
			end

			toolAnimTrack = humanoid:LoadAnimation(anim)
			if priority then
				toolAnimTrack.Priority = priority
			end

			toolAnimTrack:Play(transitionTime)
			toolAnimName = animName
			toolAnimInstance = anim

			currentToolAnimKeyframeHandler = toolAnimTrack.KeyframeReached:connect(toolKeyFrameReachedFunc)
		end
	end
	
	toolKeyFrameReachedFunc = function(frameName)
		pcall(function() 
			if (frameName == "End") then playToolAnimation(toolAnimName, 0.0, FakeHum) end 
		end)
	end


	local function stopToolAnimations()
		local oldAnim = toolAnimName
		if (currentToolAnimKeyframeHandler ~= nil) then
			currentToolAnimKeyframeHandler:disconnect()
		end
		toolAnimName = ""
		toolAnimInstance = nil
		if (toolAnimTrack ~= nil) then
			toolAnimTrack:Stop()
			toolAnimTrack:Destroy()
			toolAnimTrack = nil
		end
		return oldAnim
	end

	local function onDied() if Toggled then pose = "Dead" end end
	local function onGettingUp() if Toggled then pose = "GettingUp" end end
	local function onFallingDown() if Toggled then	pose = "FallingDown" end end
	local function onSeated() if Toggled then pose = "Seated" end end
	local function onPlatformStanding() if Toggled then pose = "PlatformStanding" end end
	local function onRunning(speed)
		if Toggled  then
			if speed > 0.01 then
				playAnimation("walk", 0.1, FakeHum) pose = "Running"
				if currentAnimInstance and currentAnimInstance.AnimationId == "http://www.roblox.com/asset/?id=180426354" then
					setAnimationSpeed(speed / 14.5)
				end
			else
				if emoteNames[currentAnim] == nil then playAnimation("idle", 0.1, FakeHum) pose = "Standing" end
			end
		end
	end

	local function onJumping()
		if Toggled then 
			playAnimation("jump", 0.1, FakeHum)
			jumpAnimTime = jumpAnimDuration
			pose = "Jumping"
		end
	end

	local function onClimbing(speed)
		if Toggled then
			playAnimation("climb", 0.1, FakeHum) setAnimationSpeed(speed / 12.0) pose = "Climbing"
		end
	end

	local function onFreeFall()
		if Toggled then
			if (jumpAnimTime <= 0) then playAnimation("fall", fallTransitionTime, FakeHum) end
			pose = "FreeFall"
		end
	end

	local function onSwimming(speed)
		if Toggled then pose = speed >= 0 and "Running" or "Standing" end
	end

	local function getTool()
		for _, kid in ipairs(FakeRig:GetChildren()) do
			if kid.className == "Tool" then return kid end
		end; return nil
	end

	local function getToolAnim(tool)
		for _, c in ipairs(tool:GetChildren()) do
			if c.Name == "toolanim" and c.className == "StringValue" then
				return c
			end
		end
		return nil
	end

	local function animateTool()
		if Toggled then
			if (toolAnim == "None") then
				playToolAnimation("toolnone", toolTransitionTime, FakeHum, Enum.AnimationPriority.Idle) return
			end
			if (toolAnim == "Slash") then
				playToolAnimation("toolslash", 0, FakeHum, Enum.AnimationPriority.Action) return
			end
			if (toolAnim == "Lunge") then
				playToolAnimation("toollunge", 0, FakeHum, Enum.AnimationPriority.Action) return
			end
		end
	end

	local function moveSit()
		RightShoulder.MaxVelocity = 0.15
		LeftShoulder.MaxVelocity = 0.15
		RightShoulder:SetDesiredAngle(3.14 /2)
		LeftShoulder:SetDesiredAngle(-3.14 /2)
		RightHip:SetDesiredAngle(3.14 /2)
		LeftHip:SetDesiredAngle(-3.14 /2)
	end

	local function move(time)
		local amplitude = 1
		local frequency = 1
		local deltaTime = time - lastTick
		lastTick = time

		local climbFudge = 0
		local setAngles = false

		if (jumpAnimTime > 0) then
			jumpAnimTime = jumpAnimTime - deltaTime
		end

		if (pose == "FreeFall" and jumpAnimTime <= 0) then
			playAnimation("fall", fallTransitionTime, FakeHum)
		elseif (pose == "Seated") then
			playAnimation("sit", 0.5, FakeHum)
			return
		elseif (pose == "Running") then
			playAnimation("walk", 0.1, FakeHum)
		elseif (pose == "Dead" or pose == "GettingUp" or pose == "FallingDown" or pose == "Seated" or pose == "PlatformStanding") then
			stopAllAnimations()
			amplitude = 0.1
			frequency = 1
			setAngles = true
		end

		if (setAngles) then
			local desiredAngle = amplitude * Sin(time * frequency)
			RightShoulder:SetDesiredAngle(desiredAngle + climbFudge)
			LeftShoulder:SetDesiredAngle(desiredAngle - climbFudge)
			RightHip:SetDesiredAngle(-desiredAngle)
			LeftHip:SetDesiredAngle(-desiredAngle)
		end
		local tool = getTool()
		if tool and tool:FindFirstChild("Handle") then
			local animStringValueObject = getToolAnim(tool)
			if animStringValueObject then
				toolAnim = animStringValueObject.Value
				animStringValueObject.Parent = nil
				toolAnimTime = time + .3
			end
			if time > toolAnimTime then
				toolAnimTime = 0
				toolAnim = "None"
			end
			animateTool()		
		else
			stopToolAnimations()
			toolAnim = "None"
			toolAnimInstance = nil
			toolAnimTime = 0
		end
	end

	FakeHum.Died:connect(onDied)
	FakeHum.Running:connect(onRunning)
	FakeHum.Jumping:connect(onJumping)
	FakeHum.Climbing:connect(onClimbing)
	FakeHum.GettingUp:connect(onGettingUp)
	FakeHum.FreeFalling:connect(onFreeFall)
	FakeHum.FallingDown:connect(onFallingDown)
	FakeHum.Seated:connect(onSeated)
	FakeHum.PlatformStanding:connect(onPlatformStanding)
	FakeHum.Swimming:connect(onSwimming)

	local StringSub = string.sub
	TInsert(Events, LocalPlayer.Chatted:Connect(function(msg)
		local emote = ""
		if msg == "/e dance" then
			emote = dances[Random(1, #dances)]
		elseif (StringSub(msg, 1, 3) == "/e ") then
			emote = StringSub(msg, 4)
		elseif (StringSub(msg, 1, 7) == "/emote ") then
			emote = StringSub(msg, 8)
		end
		if (pose == "Standing" and emoteNames[emote] ~= nil) then
			playAnimation(emote, 0.1, FakeHum)
		end
	end))
	playAnimation("idle", 0.1, FakeHum)
	pose = "Standing"

	while IsAlive do
		Toggled = (AnimateScript and AnimateScript.Parent) and AnimateScript.Enabled or false
		time = Wait(0.1)
		move(time)
	end
end end) 

FakeHum.WalkSpeed = 16
warn("Loaded!, Reanimated in: ".. tostring((not ReanimSettings['Keep BodyParts'] and 3 or 0) + WaitTime + 0.1).."s. Made by gelatek / Discord: @usedtampons")
-- players respawn time + delay + wait + 0.125 (script execution delay),
