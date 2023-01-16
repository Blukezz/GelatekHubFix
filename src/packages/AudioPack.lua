if not isfolder("GelatekHub") then
	makefolder("GelatekHub")
end

if not isfolder("GelatekHub/Animations") then
	makefolder("GelatekHub/Animations")
end

if not isfolder("GelatekHub/Scripts") then
	makefolder("GelatekHub/Scripts")
end
local HowMuch = 25
task.spawn(function()
	warn("Downloading.")
	task.wait(0.2)
	warn("Downloading..")
	task.wait(0.2)
	warn("Downloading...")
end)
if not isfile("GelatekHub/Scripts/GaleFighter.mp3") then
	writefile("GelatekHub/Scripts/GaleFighter.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/GaleFighter.mp3?raw=true"))
	warn("GaleFighter Downloaded! 1/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Scripts/TheHotline.mp3") then
	writefile("GelatekHub/Scripts/TheHotline.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/TheHotline.mp3?raw=true"))
	warn("TheHotline Downloaded! 2/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Scripts/AttackRifle.mp3") then
	writefile("GelatekHub/Scripts/AttackRifle.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/AttackRifle.mp3?raw=true"))
	warn("AttackRifle / NMI Downloaded! 3/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Scripts/DualUltima.mp3") then
	writefile("GelatekHub/Scripts/DualUltima.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/DualUltima.mp3?raw=true"))
	warn("DualUltima / MIDNIGHT Downloaded! 4/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Scripts/NeptunianV.mp3") then
	writefile("GelatekHub/Scripts/NeptunianV.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/NeptunianV.mp3?raw=true"))
	warn("NeptunianV Downloaded! 5/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Scripts/Ender.mp3") then
	writefile("GelatekHub/Scripts/Ender.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Ender.mp3?raw=true"))
	warn("Ender Downloaded! 6/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Scripts/Chips.mp3") then
	writefile("GelatekHub/Scripts/Chips.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Chips.mp3?raw=true"))
	warn("Chips Downloaded! 7/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Scripts/BanzaiBazooka.mp3") then
	writefile("GelatekHub/Scripts/BanzaiBazooka.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/BanzaiBazooka.mp3?raw=true"))
	warn("BanzaiBazooka Downloaded! 8/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Scripts/AbyssEye.mp3") then
	writefile("GelatekHub/Scripts/AbyssEye.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/AbyssEye.mp3?raw=true"))
	warn("AbyssEye Downloaded! 9/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Scripts/VoodooDoll.mp3") then
	writefile("GelatekHub/Scripts/VoodooDoll.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/VoodooDoll.mp3?raw=true"))
	warn("VoodooDoll Downloaded! 10/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Freestylin.mp3") then
	writefile("GelatekHub/Animations/Freestylin.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Freestylin.mp3?raw=true"))
	warn("Freestylin Downloaded! 11/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/CaramellDansen.mp3") then
	writefile("GelatekHub/Animations/CaramellDansen.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/CaramellDansen.mp3?raw=true"))
	warn("CaramellDansen Downloaded! 12/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Parrot.mp3") then
	writefile("GelatekHub/Animations/Parrot.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Parrot.mp3?raw=true"))
	warn("Parrot Downloaded! 13/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Floss.mp3") then
	writefile("GelatekHub/Animations/Floss.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Floss.mp3?raw=true"))
	warn("Floss Downloaded! 14/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Smooth Moves.mp3") then
	writefile("GelatekHub/Animations/Smooth Moves.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Smooth%20Moves.mp3?raw=true"))
	warn("Smooth Moves Downloaded! 15/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Electro Swing.mp3") then
	writefile("GelatekHub/Animations/Electro Swing.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Electro%20Swing.mp3?raw=true"))
	warn("Electro Swing Downloaded! 16/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Smug.mp3") then
	writefile("GelatekHub/Animations/Smug.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Smug.mp3?raw=true"))
	warn("Smug Downloaded! 17/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Aerostepping.mp3") then
	writefile("GelatekHub/Animations/Aerostepping.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Aerostepping.mp3?raw=true"))
	warn("Aerostepping Downloaded! 18/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Orange Justice.mp3") then
	writefile("GelatekHub/Animations/Orange Justice.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Orange%20Justice.mp3?raw=true"))
	warn("Orange Justice Downloaded! 19/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Breakdown.mp3") then
	writefile("GelatekHub/Animations/Breakdown.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Breakdown.mp3?raw=true"))
	warn("Breakdown Downloaded! 20/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Crabby.mp3") then
	writefile("GelatekHub/Animations/Crabby.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Crabby.mp3?raw=true"))
	warn("Crabby Downloaded! 21/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Drip.mp3") then
	writefile("GelatekHub/Animations/Drip.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Drip.mp3?raw=true"))
	warn("Drip Downloaded! 22/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Laughing.mp3") then
	writefile("GelatekHub/Animations/Laughing.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Laughing.mp3?raw=true"))
	warn("Laughing Downloaded! 23/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Animations/Take The L.mp3") then
	writefile("GelatekHub/Animations/Take The L.mp3", game:HttpGet("https://github.com/Gelatekussy/GelatekHubSongs/blob/main/Take%20The%20L.mp3?raw=true"))
	warn("Take The L Downloaded! 24/"..tostring(HowMuch))
end

if not isfile("GelatekHub/Scripts/Carnage.mp3") then
	writefile("GelatekHub/Scripts/Carnage.mp3", game:HttpGet("https://github.com/StrokeThePea/GelatekHubSongs/blob/main/Carnage.mp3?raw=true"))
	warn("[i_forgot_carnage_song_name_help] Downloaded! 25/"..tostring(HowMuch))
end

game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Notification",
	Text = "Songs Have been downloaded. Enjoy!",
	Duration = 3
})
