local Global = (getgenv and getgenv()) or shared
if game:GetService("Players").LocalPlayer.Character.Name ~= "GelatekReanimate" then
	error("Not Reanimated")
end
if game:FindFirstChildOfClass("TestService"):FindFirstChild("ScriptCheck") then
	error("Script Running")
end
local getsynasset = getsynasset or getcustomasset or function() warn("no getcustomasset/getsynasset") end
local Events = Global.TableOfEvents
Global.AntiScript()
local script = game:GetObjects('rbxassetid://8514282798')[1]
local Player = game:GetService("Players").LocalPlayer


local mouse = Player:GetMouse()
local Mouse = Player:GetMouse()
--BasicFunctions
local ins = Instance.new
local v3 = Vector3.new
local cf = CFrame.new
local angles = CFrame.Angles
local rad = math.rad
local huge = math.huge
local cos = math.cos
local sin = math.sin
local tan = math.tan
local abs = math.abs
local ray = Ray.new
local random = math.random
local ud = UDim.new
local ud2 = UDim2.new
local c3 = Color3.new
local rgb = Color3.fromRGB
local bc = BrickColor.new




--Services
local plrs = game:GetService("Players")
local tweens = game:GetService("TweenService")
local debrs = game:GetService("Debris")
local runservice = game:GetService("RunService")
--Variables
local plr = Player
local aadfs = Instance.new("Part", plr.Character)
aadfs.Name = "Anti"
aadfs.Transparency = 1 
aadfs.Anchored = true
local plrg = plr.PlayerGui
local char = plr.Character
local h = char.Head
local t = char.Torso
local ra = char["Right Arm"]
local la = char["Left Arm"]
local rl = char["Right Leg"]
local ll = char["Left Leg"]
local rut = char.HumanoidRootPart
local hum = char:FindFirstChildOfClass("Humanoid")
local nec = t.Neck
local rutj = rut.RootJoint
local rs = t["Right Shoulder"]
local ls = t["Left Shoulder"]
local rh = t["Right Hip"]
local lh = t["Left Hip"]

necc0,necc1=cf(0,t.Size.Y/2,0),cf(0,-h.Size.Y/2,0)
rutjc0,rutjc1=cf(0,0,0),cf(0,0,0)
rsc0,rsc1=cf(t.Size.X/2,t.Size.Y/4,0),cf(-ra.Size.X/2,ra.Size.Y/4,0)
lsc0,lsc1=cf(-t.Size.X/2,t.Size.Y/4,0),cf(la.Size.X/2,la.Size.Y/4,0)
rhc0,rhc1=cf(t.Size.X/4,-t.Size.Y/2,0),cf(0,rl.Size.Y/2,0)
lhc0,lhc1=cf(-t.Size.X/4,-t.Size.Y/2,0),cf(0,ll.Size.Y/2,0)

local muted = false
local using = false

local anim = "idle"
local asset = "rbxassetid://"

local change = 1
local sine = 0

local combo = 1

local timePos = 0
local staticTimePos = 0

local ws = 25
local jp = 65

--
local stepsounds = {
Grass = asset.."1201103066",
Sand = asset.."1436385526",
Plastic = asset.."1569994049",
Stone = asset.."507863857", --379398649
Wood = asset.."1201103959",
Pebble = asset.."1201103211",
Ice = asset.."265653271",
Glass = asset.."145180170",
Metal = asset.."379482691"
}

local directions = {In = Enum.EasingDirection.In,
    Out = Enum.EasingDirection.Out,
    InOut = Enum.EasingDirection.InOut
}

local styles = {Linear = Enum.EasingStyle.Linear,
    Back = Enum.EasingStyle.Back,
    Bounce = Enum.EasingStyle.Bounce,
    Sine = Enum.EasingStyle.Sine,
    Quad = Enum.EasingStyle.Quad,
    Elastic = Enum.EasingStyle.Elastic,
    Quart = Enum.EasingStyle.Quart,
    Quint = Enum.EasingStyle.Quint
}

local swings = {
	2490619022,
	2490619317
}

local stepped = runservice.Stepped

--Removing joints/Animations
if char:FindFirstChild("Animate") then
	char.Animate:Destroy()
end

if hum:FindFirstChildOfClass("Animator") then
	char.Humanoid.Animator:Destroy()
end

nec.Parent = nil
rutj.Parent = nil
rs.Parent = nil
ls.Parent = nil
rh.Parent = nil
lh.Parent = nil

--Joints
local nec = ins("Motor6D",t) nec.Name = "Neck" nec.Part0 = t nec.Part1 = h
local rutj = ins("Motor6D",rut) rutj.Name = "RootJoint" rutj.Part0 = t rutj.Part1 = rut
local rs = ins("Motor6D",t) rs.Name = "Right Shoulder" rs.Part0 = t rs.Part1 = ra
local ls = ins("Motor6D",t) ls.Name = "Left Shoulder" ls.Part0 = t ls.Part1 = la
local rh = ins("Motor6D",t) rh.Name = "Right Hip" rh.Part0 = t rh.Part1 = rl
local lh = ins("Motor6D",t) lh.Name = "Left Hip" lh.Part0 = t lh.Part1 = ll

--Setting CFrames
nec.C1 = necc1
nec.C0 = necc0
rs.C1 = rsc1
rs.C0 = rsc0
ls.C1 = lsc1
ls.C0 = lsc0
rh.C1 = rhc1
rh.C0 = rhc0
lh.C1 = lhc1
lh.C0 = lhc0
rutj.C1 = rutjc1
rutj.C0 = rutjc0

--Functions1
function createWeld(p1,p2,c0,c1)
	c0 = c0 or cf(0,0,0)
	c1 = c1 or cf(0,0,0)
	local weld = ins("Motor6D",p1)
	weld.Part0 = p1
	weld.Part1 = p2
	weld.C0 = c0
	weld.C1 = c1
	return weld
end

--Adds
local damageBil = script.UIs.SPDamageUI

local scythe = script.Models.Scythe
scythe.Parent = char

local handle = scythe.Handle
local blade = scythe.NeonBlade

local handleWeld = createWeld(ra,handle,cf(0,-1,0) * angles(rad(-90),rad(0),rad(0)))

local shadow = ins("Model",char)
shadow.Name = "Shadow"

local ff = ins("ForceField",char)
ff.Visible = false

local effects = ins("Model",char)
effects.Name = "Effects"

local theme = ins("Sound",t)
theme.Volume = 1.5
theme.SoundId = asset..1493059596
theme.Looped = true
theme:Play()

local static = ins("Sound",blade)
static.Volume = 1
static.SoundId = asset..1080752200
static.Looped = true
static:Play()

function createShadow(p,off,trans)
	if trans >1 then
		return
	end
	local pa = ins("Part",shadow)
	pa.Size = v3(.1*p.Size.x,.1*p.Size.y,.1*p.Size.z)
	pa.Material = "Plastic"
	pa.CanCollide = false
	pa.Locked = true
	pa.Color = c3(0,0,0)
	pa.Transparency = trans
	pa.Massless = true
	pa.Name = "Shadow"
	local mesh = ins("SpecialMesh",pa)
	mesh.Scale = v3(1.255,1.265/2,1.255) * 10
	mesh.Offset = v3(0,off,0)
	local weld = createWeld(p,pa,cf(0,0,0),cf(0,0,0))
	return pa
end

local off = .325*h.Size.y
for i = .325*h.Size.y,-.15*h.Size.y,-.0045*h.Size.y do
	local e = createShadow(h,off,1 - i*2.75)
	off = off -.0075*h.Size.y
end

local shaker = script.DistShaker:Clone()

--Functions2

function remove(instance,time)
	time = time or 0
	game:GetService("Debris"):AddItem(instance,time)
end

function swait()
	game:GetService("RunService").Stepped:Wait()
end

function rayc(spos,direc,ignore,dist)
    local rai = ray(spos,direc.Unit * dist)
    local rhit,rpos,rrot = workspace:FindPartOnRayWithIgnoreList(rai,ignore,false,false)
    return rhit,rpos,rrot
end

function sound(id,vol,pitch,parent,maxdist)
	local mdist = 30 or maxdist
	local newsound = Instance.new("Sound",parent)
	newsound.Volume = vol
	newsound.SoundId = "rbxassetid://"..id
	newsound.Pitch = pitch
	newsound:Play()
	coroutine.resume(coroutine.create(function()
		wait(.1)
		remove(newsound,newsound.TimeLength/newsound.Pitch)
	end))
	return newsound
end

function placesoundpart(rcf,id,vol,pitch,maxdist)
	pcall(function()
		local mdist = 30 or maxdist
		local spart = ins("Part",effects)
		spart.Anchored = true
		spart.CanCollide = false
		spart.Locked = true
		spart.Transparency = 1
		spart.CFrame = rcf
		local ssound = sound(id,vol,pitch,spart,mdist)
		remove(spart,ssound.TimeLength/ssound.Pitch)
	end)
end

local tlerp = function(part,tablee,leinght,easingstyle,easingdirec)
    local info = TweenInfo.new(
    leinght,
    easingstyle,
    easingdirec,
    0,
    false,
    0
    )
    local lerp = tweens:Create(part,info,tablee)
    lerp:Play()
end

local Effects = {
	Ring = function(pos,color,sSize,eSize,sTrans,eTrans,time,style)
		style = style or "Linear"
		local ring = script.Effects.Ring:Clone()
		ring.Size = sSize
		ring.Transparency = sTrans
		ring.CFrame = pos
		ring.Color = color
		ring.Parent = effects
		remove(ring,time)
		tlerp(ring,{Size = eSize,Transparency = eTrans},time,styles[style],directions.Out)
	end,
	SpinningRing = function(pos,color,rotation,sSize,eSize,sTrans,eTrans,time,style)
		style = style or "Linear"
		local ring = script.Effects.Ring:Clone()
		ring.Size = sSize
		ring.Transparency = sTrans
		ring.CFrame = pos
		ring.Color = color
		ring.Parent = effects
		remove(ring,time)
		tlerp(ring,{Size = eSize,Transparency = eTrans},time,styles[style],directions.Out)
		coroutine.wrap(function()
			repeat
				ring.CFrame = ring.CFrame * rotation
				wait(1/30)
			until not ring.Parent
		end)()
	end,
	Sphere = function(pos,color,sSize,eSize,sTrans,eTrans,time,style)
		style = style or "Linear"
		local sphere = ins("Part")
		sphere.Shape = "Ball"
		sphere.Size = v3(sSize,sSize,sSize)
		sphere.Transparency = sTrans
		sphere.CFrame = pos
		sphere.Color = color
		sphere.Parent = effects
		sphere.Anchored = true
		sphere.CanCollide = false
		sphere.Locked = true
		sphere.Material = "Neon"
		remove(sphere,time)
		tlerp(sphere,{Size = v3(eSize,eSize,eSize),Transparency = eTrans},time,styles[style],directions.Out)
		return sphere
	end,
	Beam = function(pos,color,sLength,eLength,sThickness,eThickness,sTrans,eTrans,time,style)
		style = style or "Linear"
		local sphere = ins("Part")
		sphere.Shape = "Block"
		sphere.Size = v3(sThickness,sLength,sThickness)
		sphere.Transparency = sTrans
		sphere.CFrame = pos
		sphere.Color = color
		sphere.Parent = effects
		sphere.Anchored = true
		sphere.CanCollide = false
		sphere.Locked = true
		sphere.Material = "Neon"
		ins("CylinderMesh",sphere)
		remove(sphere,time)
		tlerp(sphere,{Size = v3(eThickness,eLength,eThickness),Transparency = eTrans},time,styles[style],directions.Out)
	end,
	SpinningBlock = function(pos,color,sSize,eSize,sTrans,eTrans,cfRotation,time,style)
		style = style or "Linear"
		local part = ins("Part")
		part.Size = v3(sSize,sSize,sSize)
		part.Transparency = sTrans
		part.CFrame = pos
		part.Color = color
		part.Parent = effects
		part.Anchored = true
		part.CanCollide = false
		part.Locked = true
		part.Material = "Neon"
		remove(part,time)
		tlerp(part,{Size = v3(eSize,eSize,eSize),Transparency = eTrans},time,styles[style],directions.Out)
		coroutine.wrap(function()
			repeat
				part.CFrame = part.CFrame * cfRotation
				wait(1/30)
			until not part.Parent
		end)()
	end,
	CustomSphere = function(pos,endPos,color,sSize,eSize,sTrans,eTrans,time,style)
		style = style or "Linear"
		local sphere = ins("Part")
		sphere.Size = sSize
		sphere.Transparency = sTrans
		sphere.CFrame = pos
		sphere.Color = color
		sphere.Parent = effects
		sphere.Anchored = true
		sphere.CanCollide = false
		sphere.Locked = true
		sphere.Material = "Neon"
		
		local mesh = ins("SpecialMesh",sphere)
		mesh.MeshType = "Sphere"
		
		remove(sphere,time)
		tlerp(sphere,{Size = eSize,Transparency = eTrans,CFrame = endPos},time,styles[style],directions.Out)
	end,
	CustomSphereBoomerang = function(pos,endPos,color,sSize,eSize,sTrans,eTrans,time,style)
		style = style or "Linear"
		local sphere = ins("Part")
		sphere.Size = sSize
		sphere.Transparency = sTrans
		sphere.CFrame = pos
		sphere.Color = color
		sphere.Parent = effects
		sphere.Anchored = true
		sphere.CanCollide = false
		sphere.Locked = true
		sphere.Material = "Neon"
		
		local mesh = ins("SpecialMesh",sphere)
		mesh.MeshType = "Sphere"
		coroutine.wrap(function()
			remove(sphere,time)
			tlerp(sphere,{Transparency = eTrans},time * 1.25,styles[style],directions.Out)
			tlerp(sphere,{Size = eSize,CFrame = endPos},time/2,styles[style],directions.Out)
			wait(time/2)
			tlerp(sphere,{Size = sSize},time/2,styles[style],directions.Out)
		end)()
	end,
	CustomSphereBoomerangPlusPos = function(pos,endPos,color,sSize,eSize,sTrans,eTrans,time,style)
		style = style or "Linear"
		local sphere = ins("Part")
		sphere.Size = sSize
		sphere.Transparency = sTrans
		sphere.CFrame = pos
		sphere.Color = color
		sphere.Parent = effects
		sphere.Anchored = true
		sphere.CanCollide = false
		sphere.Locked = true
		sphere.Material = "Neon"
		
		local mesh = ins("SpecialMesh",sphere)
		mesh.MeshType = "Sphere"
		coroutine.wrap(function()
			remove(sphere,time)
			tlerp(sphere,{Transparency = eTrans},time * 1.25,styles[style],directions.Out)
			tlerp(sphere,{Size = eSize,CFrame = endPos},time/2,styles[style],directions.Out)
			wait(time/2)
			tlerp(sphere,{Size = sSize,CFrame = pos},time/2,styles[style],directions.Out)
		end)()
	end,
	Wind = function(pos,color,rotation,sSize,eSize,sTrans,eTrans,time,style)
		style = style or "Linear"
		local ring = script.Effects.Wind:Clone()
		ring.Size = sSize
		ring.Transparency = sTrans
		ring.CFrame = pos
		ring.Color = color
		ring.Parent = effects
		remove(ring,time)
		tlerp(ring,{Size = eSize,Transparency = eTrans},time,styles[style],directions.Out)
		coroutine.wrap(function()
			repeat
				ring.CFrame = ring.CFrame * angles(rad(0),rad(rotation),rad(0))
				wait(1/30)
			until not ring.Parent
		end)()
	end,
	CreateCamShake = function(part,maxDist,intensivity,time)
		maxDist = maxDist or 20
		intensivity = intensivity or 1
		time = time or .1
		
		local bool = ins("BoolValue",part)
		bool.Name = "Shaking"
		bool.Value = true
		
		local MaxDist = ins("NumberValue",bool)
		MaxDist.Name = "MaxDist"
		MaxDist.Value = maxDist
		
		local Intensivity = ins("NumberValue",bool)
		Intensivity.Name = "Intensivity"
		Intensivity.Value = intensivity
		
		remove(bool,time)
	end,
	SoundEffect = function(sound,effect)
		ins(effect.."SoundEffect",sound)
	end
}

function death(whom)
	
end

function showDamage(pos,text,time,animTime)
	coroutine.wrap(function()
		pos = pos or t.CFrame
		text = text or "NULL"
		time = time or 2
		animTime = animTime or .5
	
		local clon = damageBil:Clone()
		local backG = clon.MainFrame
		local tex = backG.Damage
		local dFrame = clon.DropsFrame
		local drop = dFrame.Drop
		local p = ins("Part")
		
		p.Locked = true
		p.Massless = true
		p.CanCollide = false
		p.Anchored = true
		p.Size = v3(0,0,0)
		p.Transparency = 1
		p.CFrame = cf(pos.Position) * cf(random(-25,25)/10,random(-25,25)/10,random(-25,25)/10)
		p.Parent = effects
		
		clon.Parent = p
		drop.Parent = nil
		drop.Visible = true
		
		tex.Text = text
		
		remove(p,time + (animTime * 2))
		
		coroutine.wrap(function()
			repeat
				if p.Parent ~= effects then
					remove(p)
				end
				local dClon = drop:Clone()
				local dropPos = random(0,100)/100
				local dropSize = random(5,15)/100
				local growTime = random(15,25)/100
				local fallTime = random(7,15)/100
				local fallDelay = random(7,15)/100
				
				dClon.Parent = dFrame
				dClon.Position = ud2(dropPos,0,0,0)
				dClon.Size = ud2(0,0,0,0)
				dClon.ImageTransparency = 1
				dClon.Visible = true
				
				coroutine.wrap(function()
					remove(dClon,growTime + fallTime + fallDelay)
					tlerp(dClon,{ImageTransparency = backG.BackgroundTransparency,Size = ud2(dropSize,0,dropSize,0)},growTime,styles.Sine,directions.Out)
					wait(growTime + fallDelay)
					tlerp(dClon,{ImageTransparency = 1,Size = ud2(dropSize/2,0,dropSize * 12.5,0)},fallTime,styles.Sine,directions.Out)
				end)()
				
				wait(random(5,15)/100)
			until not p.Parent
		end)()
		
		tlerp(backG,{BackgroundTransparency = .5},animTime,styles.Back,directions.In)
		tlerp(tex,{TextTransparency = 0,TextStrokeTransparency = 0},animTime,styles.Back,directions.In)
		
		wait(time)
		
		tlerp(backG,{BackgroundTransparency = 1},animTime,styles.Back,directions.In)
		tlerp(tex,{TextTransparency = 1,TextStrokeTransparency = 1},animTime,styles.Back,directions.In)
	end)()
end

function damage(humanoid,Damage,knockback,knockbackStartPoint,knockbackTime,knockDelay,damageSound)

end

function magDamage(pos,partSize,size,Damage,knockback,knockbackTime,knockDelay,damageSound)
	
end

function swing1()
	using = true
	local oldWS = ws
	local oldJP = jp
	ws = 4
	jp = 45
	local add = -.035
	local alpha = .5
	sound(swings[random(1,#swings)],2.5,random(60,80)/100,ra,1)
	for i = 0,1,.075 do
		nec.C0 = nec.C0:Lerp(necc0 * cf(0,0,0) * angles(rad(-5),rad(35),rad(0)),alpha)
		rutj.C0 = rutj.C0:Lerp(rutjc0 * cf(0,.1,-.1) * angles(rad(-5),rad(45),rad(-5)),alpha)
		rs.C0 = rs.C0:Lerp(rsc0 * cf(0,-.15,.25) * angles(rad(205),rad(25),rad(0)) * angles(rad(-5),rad(0),rad(15)),alpha)
		ls.C0 = ls.C0:Lerp(lsc0 * cf(.075,-.15,.15) * angles(rad(15),rad(-25),rad(-7.5)),alpha)
		rh.C0 = rh.C0:Lerp(rhc0 * cf(0,0,0) * angles(rad(2.5),rad(-5),rad(2.5)),alpha)
		lh.C0 = lh.C0:Lerp(lhc0 * cf(0,.05,-.05) * angles(rad(-20),rad(15),rad(-5)),alpha)
		handleWeld.C0 = handleWeld.C0:Lerp(cf(0,-1,0) * angles(rad(-75),rad(10),rad(0)),alpha)
		alpha = alpha + add
		swait()
	end
	alpha = .25
	add = .15
	for i = 0,1,.125 do
		local s = sound(566593606,1.5,random(85,115)/100,nil,2.5)
		s.TimePosition = .075
		magDamage(blade,false,10,random(15,25),random(20,40),.1,.35,s)
		nec.C0 = nec.C0:Lerp(necc0 * cf(0,0,0) * angles(rad(2.5),rad(-30),rad(0)),alpha)
		rutj.C0 = rutj.C0:Lerp(rutjc0 * cf(0,.125,.25) * angles(rad(5),rad(-45),rad(5)),alpha)
		rs.C0 = rs.C0:Lerp(rsc0 * cf(0,-.25,-.35) * angles(rad(35),rad(-50),rad(0)) * angles(rad(0),rad(0),rad(-7.5)),alpha)
		ls.C0 = ls.C0:Lerp(lsc0 * cf(.1,-.2,.1) * angles(rad(-15),rad(15),rad(-5)),alpha)
		rh.C0 = rh.C0:Lerp(rhc0 * cf(0,.05,-.05) * angles(rad(-12.5),rad(-10),rad(2.5)),alpha)
		lh.C0 = lh.C0:Lerp(lhc0 * cf(0,0,0) * angles(rad(5),rad(5),rad(2.5)),alpha)
		handleWeld.C0 = handleWeld.C0:Lerp(cf(0,-1,0) * angles(rad(-110),rad(20),rad(0)),alpha)
		alpha = alpha + add
		if alpha >1 then
			add = -math.abs(add)
		end
		swait()
	end
	ws = oldWS
	jp = oldJP
	using = false
end

function swing2()
	using = true
	local oldWS = ws
	local oldJP = jp
	ws = 4
	jp = 45
	local add = -.035
	local alpha = .5
	sound(swings[random(1,#swings)],2.5,random(60,80)/100,ra,1)
	for i = 0,1,.075 do
		nec.C0 = nec.C0:Lerp(necc0 * cf(0,0,0) * angles(rad(0),rad(-60),rad(0)),alpha)
		rutj.C0 = rutj.C0:Lerp(rutjc0 * cf(0,0,0) * angles(rad(2.5),rad(-60),rad(-7.5)),alpha)
		rs.C0 = rs.C0:Lerp(rsc0 * cf(0,0,-.5) * angles(rad(85),rad(95),rad(0)) * angles(rad(20),rad(0),rad(0)),alpha)
		ls.C0 = ls.C0:Lerp(lsc0 * cf(0,-.2,.15) * angles(rad(-10),rad(10),rad(-5)),alpha)
		rh.C0 = rh.C0:Lerp(rhc0 * cf(0,-.1,0) * angles(rad(-15),rad(-5),rad(-5)),alpha)
		lh.C0 = lh.C0:Lerp(lhc0 * cf(0,-.1,-.15) * angles(rad(20),rad(5),rad(-10)),alpha)
		handleWeld.C0 = handleWeld.C0:Lerp(cf(0,-1,0) * angles(rad(-85),rad(0),rad(0)),alpha)
		alpha = alpha + add
		swait()
	end
	alpha = .25
	add = .15
	for i = 0,1,.125 do
		local s = sound(566593606,1.5,random(85,115)/100,nil,2.5)
		s.TimePosition = .075
		magDamage(blade,false,10,random(15,25),random(20,40),.1,.35,s)
		nec.C0 = nec.C0:Lerp(necc0 * cf(0,0,0) * angles(rad(0),rad(75),rad(0)),alpha)
		rutj.C0 = rutj.C0:Lerp(rutjc0 * cf(0,0,0) * angles(rad(-2.5),rad(75),rad(0)),alpha)
		rs.C0 = rs.C0:Lerp(rsc0 * cf(0,0,-.35) * angles(rad(90),rad(85),rad(0)) * angles(rad(-105),rad(0),rad(0)),alpha)
		ls.C0 = ls.C0:Lerp(lsc0 * cf(0,-.25,.25) * angles(rad(25),rad(-35),rad(-7.5)),alpha)
		rh.C0 = rh.C0:Lerp(rhc0 * cf(0,0,0) * angles(rad(15),rad(-5),rad(1.5)),alpha)
		lh.C0 = lh.C0:Lerp(lhc0 * cf(0,0,0) * angles(rad(-15),rad(5),rad(-5)),alpha)
		handleWeld.C0 = handleWeld.C0:Lerp(cf(0,-1,0) * angles(rad(-120),rad(0),rad(0)),alpha)
		alpha = alpha + add
		if alpha >1 then
			add = -math.abs(add)
		end
		swait()
	end
	ws = oldWS
	jp = oldJP
	using = false
end

--[[
	local alpha = .35
	for i = 0,1,.025 do
		nec.C0 = nec.C0:Lerp(necc0 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),alpha)
		rutj.C0 = rutj.C0:Lerp(rutjc0 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),alpha)
		rs.C0 = rs.C0:Lerp(rsc0 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),alpha)
		ls.C0 = ls.C0:Lerp(lsc0 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),alpha)
		rh.C0 = rh.C0:Lerp(rhc0 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),alpha)
		lh.C0 = lh.C0:Lerp(lhc0 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),alpha)
		alpha = alpha -.025
		swait()
	end
function base()
	using = true
	local oldWS = ws
	local oldJP = jp
	ws = 0
	jp = 0
	
	ws = oldWS
	jp = oldJP
	using = false
end
--]]
local Bullet = Global.FlingPart
if Bullet and not Global.PartDisconnected then
	Global.PartDisconnected = true
	if Bullet:FindFirstChild("AntiRotate") then
		Bullet:FindFirstChild("AntiRotate"):Destroy()
	end
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
	local Rotation = CFrame.Angles(math.random(-360,360),math.random(-360,360),math.random(-360,360))
	local part
	table.insert(Global.TableOfEvents, game:GetService("RunService").Heartbeat:Connect(function()
		Rotation = CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
		if Bullet then
			Global.Flinging = true
			Bullet.RotVelocity = Vector3.new(0, 7500, 0)
			Bullet.CFrame = handle.CFrame * CFrame.new(0,4.5,0) * CFrame.Angles(0,math.rad(90),0) * Rotation
		end
	end))
end
local combos = {swing1,swing2}
local hat = char:FindFirstChild('Dark Matter Scythe')
if hat then
	for i, v in pairs(char.Shadow:GetChildren()) do
		if v:IsA("BasePart") then v.Transparency = 1 end
	end
	for i, v in pairs(char.Scythe:GetChildren()) do
		if v:IsA("BasePart") then v.Transparency = 1 end
	end
	hat.Handle.AccessoryWeld:Destroy() -- -45, 105, -15
	Global.AlignPart(hat.Handle,handle,Vector3.new(1.6, -2, 0),Vector3.new(-68, 105, -15))
end
table.insert(Events, mouse.KeyDown:Connect(function(key)
	if not using then
		
	end
	if key == "m" then
		muted = not muted
	end
end))

table.insert(Events, mouse.Button1Down:Connect(function()
	if not using then
		combos[combo]()
		combo = combo +1
		if combo > #combos then
			combo = 1
		end
	end
end))

table.insert(Events, stepped:Connect(function()
	sine = sine + change
	
	local verVel = rut.Velocity.y
	local horVel = (rut.Velocity * v3(1,0,1)).Magnitude

	local Ccf=rut.CFrame
	
	local dir = hum.MoveDirection
	
	if dir == v3(0,0,0) then
		dir = rut.Velocity/10
	end
	
	if theme.Parent ~= t then
		remove(theme)
		theme = ins("Sound",t)
		theme.Volume = 1.5
		theme.SoundId = asset..1493059596
		theme.Looped = true
		theme.TimePosition = timePos
		theme:Play()
	end
	
	if static.Parent ~= t then
		remove(static)
		static = ins("Sound",t)
		static.Volume = 1.5
		static.SoundId = asset..1080752200
		static.Looped = true
		static.TimePosition = staticTimePos
		static:Play()
	end
	
	if not muted then
		theme.Volume = 1.5
	else
		theme.Volume = 0
	end
	theme.SoundId = asset..1493059596
	theme.Looped = true
	theme:Resume()
	theme.Name = "Theme"
	
	static.Volume = .75
	static.SoundId = asset..1080752200
	static.Looped = true
	static:Resume()
	static.Name = "Static"
	
	timePos = theme.TimePosition
	staticTimePos = static.TimePosition

	local Walktest1 = dir * Ccf.LookVector
	local Walktest2 = dir * Ccf.RightVector

	local rotfb = Walktest1.X+Walktest1.Z
	local rotrl = Walktest2.X+Walktest2.Z
	
	if rotfb >1 then
		rotfb = 1
	elseif rotfb <-1 then
		rotfb = -1
	end
	
	if rotrl >1 then
		rotrl = 1
	elseif rotrl <-1 then
		rotrl = -1
	end
	
	hum.WalkSpeed = ws
	hum.JumpPower = jp
	
	local hit,pos,nId = rayc(rut.Position + v3(0,-rut.Size.y/2,0),v3(rut.Position.x,-10000,rut.Position.z),{char},3)
	
	if using then
		anim = "idle"
	end
	
	if anim == "idle" and hit then
		nec.C1 = nec.C1:Lerp(necc1 * cf(0,0,0) * angles(sin(sine/20) * rad(2.5),sin(sine/40) * rad(1),sin(sine/40) * rad(5)),.1)
		rutj.C1 = rutj.C1:Lerp(rutjc1 * cf(sin(sine/40)/15,sin(sine/20)/15,sin(sine/60)/15) * angles(sin(sine/20) * rad(2.5),sin(sine/80) * rad(5),sin(sine/40) * rad(2.5)),.1)
		rs.C1 = rs.C1:Lerp(rsc1 * cf(0,-sin(sine/20)/15,0) * angles(-sin(sine/20) * rad(1.5),sin(sine/80) * rad(5),sin(sine/40) * rad(1.5)),.1)
		ls.C1 = ls.C1:Lerp(lsc1 * cf(0,sin(sine/20)/15,0) * angles(-cos(sine/20) * rad(7.5),sin(sine/80) * rad(5),sin(sine/40) * rad(2.5)),.1)
		rh.C1 = rh.C1:Lerp(rhc1 * cf(0,(sin(sine/20)/15) + (sin(sine/40)/25),0) * angles((sin(sine/20) * rad(3.5)) + (sin(sine/80) * rad(2.5)),rad(0),sin(sine/40) * rad(5)),.1)
		lh.C1 = lh.C1:Lerp(lhc1 * cf(0,(sin(sine/20)/15) + (-sin(sine/40)/25),0) * angles((sin(sine/20) * rad(3.5)) - (sin(sine/80) * rad(2.5)),rad(0),sin(sine/40) * rad(5)),.1)
	elseif anim == "fall" and not hit then
		nec.C1 = nec.C1:Lerp(necc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
		rutj.C1 = rutj.C1:Lerp(rutjc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
		rs.C1 = rs.C1:Lerp(rsc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
		ls.C1 = ls.C1:Lerp(lsc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
		rh.C1 = rh.C1:Lerp(rhc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
		lh.C1 = lh.C1:Lerp(lhc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
	elseif anim == "jump" and not hit then
		nec.C1 = nec.C1:Lerp(necc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
		rutj.C1 = rutj.C1:Lerp(rutjc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
		rs.C1 = rs.C1:Lerp(rsc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
		ls.C1 = ls.C1:Lerp(lsc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
		rh.C1 = rh.C1:Lerp(rhc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
		lh.C1 = lh.C1:Lerp(lhc1 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.1)
	elseif anim == "walk" and hit then
		nec.C1 = nec.C1:Lerp(necc1 * cf(0,0,0) * angles(-sin(sine/1.75) * rad(1),sin(sine/3.5) * rad(3.5),sin(sine/3.5) * rad(2.5)) * angles(0,rotrl/1.5,0),.2)
		rutj.C1 = rutj.C1:Lerp(rutjc1 * cf(0,sin(sine/1.75)/7.5,0) * angles(sin(sine/1.75) * rad(5),sin(sine/3.5) * rad(5),rad(0)) * angles(-rotfb/7.5,0,-rotrl/6),.2)
		rs.C1 = rs.C1:Lerp(rsc1 * cf(0,sin(sine/1.75)/10,0) * angles(sin(sine/3.5) * rad(5) * rotfb,rad(0),rad(0)),.2)
		ls.C1 = ls.C1:Lerp(lsc1 * cf(0,-sin(sine/1.75)/10,-cos(sine/3.5)/10) * angles(sin(sine/3.5) * rad(65) * rotfb,sin(sine/1.75) * rad(7.5),sin(sine/1.75) * rad(1.5)),.2)
		rh.C1 = rh.C1:Lerp(rhc1 * cf(0,cos(sine/3.5)/5,-cos(sine/3.5)/3.5) * angles((sin(sine/3.5) * rad(60) + rad(7.5)) * rotfb,rad(0),sin(sine/3.5) * rad(45) * rotrl) * angles(rad(0),cos(sine/3.5) * rad(2.5),rad(0)),.2)
		lh.C1 = lh.C1:Lerp(lhc1 * cf(0,-cos(sine/3.5)/5,cos(sine/3.5)/3.5) * angles((-sin(sine/3.5) * rad(60) + rad(7.5)) * rotfb,rad(0),-sin(sine/3.5) * rad(45) * rotrl) * angles(rad(0),cos(sine/3.5) * rad(2.5),rad(0)),.2)
	end
	if not using then
		handleWeld.C0 = handleWeld.C0:Lerp(cf(0,-1,0) * angles(rad(-90),rad(0),rad(0)),.2)
		if horVel > 5 and verVel >-10 and verVel <10 then
			anim = "walk"
			change = .6
			nec.C0 = nec.C0:Lerp(necc0 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.2)
			rutj.C0 = rutj.C0:Lerp(rutjc0 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.2)
			rs.C0 = rs.C0:Lerp(rsc0 * cf(.15,-.75,-.25) * angles(rad(175),rad(65),rad(0)) * angles(rad(10),rad(0),rad(0)),.1)
			ls.C0 = ls.C0:Lerp(lsc0 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.2)
			rh.C0 = rh.C0:Lerp(rhc0 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.2)
			lh.C0 = lh.C0:Lerp(lhc0 * cf(0,0,0) * angles(rad(0),rad(0),rad(0)),.2)
		elseif verVel >10 then
			anim = "jump"
			change = 1
			nec.C0 = nec.C0:Lerp(necc0 * cf(0,0,0) * angles(rad(15),rad(0),rad(0)),.2)
			rutj.C0 = rutj.C0:Lerp(rutjc0 * cf(0,0,0) * angles(rad(-5),rad(0),rad(0)),.2)
			rs.C0 = rs.C0:Lerp(rsc0 * cf(.15,-.75,-.25) * angles(rad(175),rad(65),rad(0)) * angles(rad(10),rad(0),rad(0)),.1)
			ls.C0 = ls.C0:Lerp(lsc0 * cf(0,0,0) * angles(rad(145),rad(0),rad(-8)),.2)
			rh.C0 = rh.C0:Lerp(rhc0 * cf(0,.1,-.1) * angles(rad(-3.5),rad(0),rad(2)),.2)
			lh.C0 = lh.C0:Lerp(lhc0 * cf(0,.3,-.25) * angles(rad(-9),rad(0),rad(-3.5)),.2)
		elseif verVel <-10 then
			anim = "fall"
			change = 1
			nec.C0 = nec.C0:Lerp(necc0 * cf(0,0,0) * angles(rad(-5),rad(0),rad(0)),.2)
			rutj.C0 = rutj.C0:Lerp(rutjc0 * cf(0,0,0) * angles(rad(5),rad(0),rad(0)),.2)
			rs.C0 = rs.C0:Lerp(rsc0 * cf(.15,-.75,-.25) * angles(rad(175),rad(65),rad(0)) * angles(rad(10),rad(0),rad(0)),.1)
			ls.C0 = ls.C0:Lerp(lsc0 * cf(-.45,-.44,0) * angles(rad(6),rad(0),rad(-97.5)),.2)
			rh.C0 = rh.C0:Lerp(rhc0 * cf(0,.3,-.25) * angles(rad(-9),rad(0),rad(2)),.2)
			lh.C0 = lh.C0:Lerp(lhc0 * cf(0,.1,-.1) * angles(rad(-3.5),rad(0),rad(-3.5)),.2)
		elseif horVel < 5 and verVel >-10 and verVel <10 then
			anim = "idle"
			change = 1
			nec.C0 = nec.C0:Lerp(necc0 * cf(0,0,0) * angles(rad(-10),rad(0),rad(0)),.1)
			rutj.C0 = rutj.C0:Lerp(rutjc0 * cf(0,0,-.05) * angles(rad(-5),rad(0),rad(0)),.1)
			rs.C0 = rs.C0:Lerp(rsc0 * cf(.15,-.75,-.25) * angles(rad(175),rad(65),rad(0)) * angles(rad(10),rad(0),rad(0)),.1)
			ls.C0 = ls.C0:Lerp(lsc0 * cf(0,-.15,.1) * angles(rad(-6.5),rad(15),rad(-3.5)),.1)
			rh.C0 = rh.C0:Lerp(rhc0 * cf(0,0,0) * angles(rad(-5),rad(-5),rad(2.5)),.1)
			lh.C0 = lh.C0:Lerp(lhc0 * cf(0,0,0) * angles(rad(-5),rad(5),rad(-2.5)),.1)
		end
	end
end))
