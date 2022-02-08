--[[
	LIME CUTSCENE MANAGER (LIM)
	VERSION 0.0E

	MAIN MODULE

	ACEWARE ENTERTAINMENT 2022

	AUTHOR: MARCO VERRECCHIA (ITSACE)
	DATE CREATED: 06/02/2022 21:55PM GMT
	
	UNAUTHORIZED USE OF THIS CODE IS PROHIBITED.
]]--

local lim = {
	header = {
		name = "LIME CUTSCENE MANAGER";
		ver = "0.0E";
	}
};

--// GENERAL \\--

function lim.writeToOutput(msg, class)
	if class == "print" then
		print("[" .. script.Name .. "] " .. tostring(msg));
	elseif class == "warn" then
		warn("[" .. script.Name .. "] " .. tostring(msg));
	elseif class == "error" then
		error("[" .. script.Name .. "] " .. tostring(msg));
	elseif class ~= "print" and class ~= "warn" and class ~= "error" then
		error("Fatal Error: Class not Valid!");
	end
end
lim.writeToOutput(lim.header.name .. " " .. lim.header.ver .. " CURRENTLY RUNNING! CREATED BY ACEWARE ENTERTAINMENT EAD ,CO .LTD", "prinr")

--// CAMERA \\--

--// CAMERA MANIPULATION

function lim.setCameraMode(camera, enum_mode)
	--// VARIABLE DEBUG
	if not camera:IsA("Camera") then
		lim.writeToOutput("CAMERA OBJECT IS NOT CLASS CAMERA.", "error");
	end

	local try = 3;
	local ok, ng = pcall(function()
		camera.CameraType = enum_mode;
	end)
	if ok then
		print("pass!");
	elseif ng then
		warn("fail!");
	end
end

function lim.setCameraCFrame(camera, cfr_part)
	--// VARIABLE DEBUG
	if not camera:IsA("Camera") then
		lim.writeToOutput("CAMERA OBJECT IS NOT CLASS CAMERA.", "error");
	end 

	if not camera.CameraType == Enum.CameraType.Scriptable then
		lim.setCameraMode(workspace.CurrentCamera, Enum.CameraType.Scriptable);
	end
	camera.CFrame = cfr_part.CFrame;
end

function lim.tweenCamera(camera, cfr_part, enum_style, int, _waituntilcomplete)
	local tweenService = game:GetService("TweenService");
	local param = TweenInfo.new(
		tonumber(int),
		enum_style
	)
	if not camera:IsA("Camera") then
		lim.writeToOutput("CAMERA OBJECT IS NOT CLASS CAMERA.", "error");
	end 
	if not camera.CameraType == Enum.CameraType.Scriptable then
		lim.setCameraMode(workspace.CurrentCamera, Enum.CameraType.Scriptable);
	end
	local tween = tweenService:Create(camera, param, {CFrame = cfr_part.CFrame}):Play();
	if _waituntilcomplete == true then
		tween.Completed:Wait();
	end
end

--// FIELD OF VIEW (FOV)

function lim.setFieldOfView(camera, int_fov)
	if not camera:IsA("Camera") then
		lim.writeToOutput("CAMERA OBJECT IS NOT CLASS CAMERA.", "error");
	end 
	camera.FieldOfView = tonumber(int_fov);
end

function lim.tweenFieldOfView(camera, int_fov, int, _waituntilcomplete)
	local tweenService = game:GetService("TweenService");
	local tween = tweenService:Create(camera, TweenInfo.new(int, Enum.EasingStyle.Linear), {FieldOfView = int_fov}):Play();
	if _waituntilcomplete == true then
		tween.Completed:Wait();
	end
end

--// EFFECTS \\--

--// LIGHTING

function lim.addBlur()
	local blur = Instance.new("BlurEffect", game:GetService("Lighting"));
	blur.Name = "LIMEASSET_" .. string.upper(blur.ClassName);
	blur.Size = 30;
end

function lim.tweenBlur(blur, bool)
	if blur ~= nil then
		if bool == true then
			tweenService:Create(blur, TweenInfo.new(1, Enum.EasingStyle.Linear), {Size = 30}):Play();
		elseif bool == false then
			tweenService:Create(blur, TweenInfo.new(1, Enum.EasingStyle.Linear), {Size = 0}):Play();
		elseif bool ~= true and bool ~= false then
			lim.writeToOutput("'bool' ARG IS INVALID.", "error");
		end
	else
		local blur = Instance.new("BlurEffect", game:GetService("Lighting"));
		blur.Name = "LIMEASSET_" .. string.upper(blur.ClassName);
		blur.Size = 0;
	end
end

return lim;