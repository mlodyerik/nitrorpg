object = {}
attach = {}
controls = {"jump", "sprint", "crouch", "enter_exit", "enter_passenger"}

addCommandHandler("nosze-pomoc", function(player, cmd)
	if getElementData(player, "player:faction") == "SAFD" then
		outputChatBox("Ⓘ #FFFFFF/nosze - rozstawia nosze / usuwa nosze", player, 255, 255, 0, true)
		outputChatBox("Ⓘ #FFFFFF/nosze-ustaw [id] - ustawia gracza na noszach", player, 255, 255, 0, true)
		outputChatBox("Ⓘ #FFFFFF/nosze-zdejmij [id] - zdejmuje gracza z noszy", player, 255, 255, 0, true)
	else
		outputChatBox("✘ #FFFFFFNie jesteś na służbie SAMD!", player, 255, 0, 0,true)
	end
end)

function nosze(player, cmd)
	if getElementData(player, "player:faction") == "SAFD" then
		--if not getElementData(player,"mozenosze") then return triggerClientEvent(player, 'iyw_notifications:send', player, "error", "Nie jesteś w miejscu do tego przeznaczonym!") end
		if not getElementData(player,"nosze") then
			setElementData(player, "nosze", true)
			object[player] = Object(1997, 0, 0, 0)
			object[player]:attach(player, 0, 1.3, -1)
			object[player]:setCollisionsEnabled(false)
		else
			removeElementData(player, "nosze")
			if object[player] then
			destroyElement(object[player])
			end
		end
	else
		outputChatBox("✘ #FFFFFFNie jesteś na służbie SAFD!", player, 255, 0, 0,true)
	end
end
addCommandHandler("nosze", nosze)

function ustaw(player, cmd, target)
	if object[player] then
		if not attach[player] then
			local target = exports["pystories-core"]:findPlayer(player, target)
			if not target then
				outputChatBox("✘ #FFFFFFNie znaleziono podanego gracza.", player, 255, 0, 0,true)
				return
			end
			if not getElementData(player, "nosze") then outputChatBox("✘ #FFFFFFNie posiadasz rozłożonych noszy!", player, 255, 0, 0,true) return end
			if (player.position-Vector3(getElementPosition(target))).length < 5 then
				if not target.vehicle then
					target:attach(object[player], 0, -0.2, 2)
					attach[player] = target
						
					for _,control in ipairs(controls) do
						toggleControl(player, control, false)
					end
					local rotation = {getElementRotation(player)}
					target:setAnimation("CRACK", "crckidle4", -1, true, false)
					Timer(function() triggerClientEvent(target, "iyw_samd_stretcher:rotation", root, target, object[player],true) end, 500, 1)
				else
					outputChatBox("✘ #FFFFFFPodany gracz znajduje się w pojeździe, nie możesz wziąć go na nosze!", player, 255, 0, 0,true)
				end
			else
				outputChatBox("✘ #FFFFFFZnajdujesz się zbyt daleko od gracza, którego chcesz wziąć na nosze!", player, 255, 0, 0,true)
			end
		else
			outputChatBox("✘ #FFFFFFNa tych noszach już ktoś się znajduje!", player, 255, 0, 0,true)
		end
	else
		outputChatBox("✘ #FFFFFFNie posiadasz rozłożonych noszy!", player, 255, 0, 0,true)
	end
end
addCommandHandler("nosze-ustaw", ustaw)
function zdejmij(player, cmd, target)
	if object[player] then
		if attach[player] then
			for _,control in ipairs(controls) do
				toggleControl(player, control, true)
			end
			local target = exports["pystories-core"]:findPlayer(player, target)
			if not target then
				outputChatBox("✘ #FFFFFFNie znaleziono podanego gracza.", player, 255, 0, 0,true)
				return
			end
			target:detach(object[player])
			attach[player] = false
			triggerClientEvent(target, "iyw_samd_stretcher:deleteRotation", root)
		else
			outputChatBox("✘ #FFFFFFNa tych noszach nie znajduje się nikt!", player, 255, 0, 0,true)
		end
	else
		outputChatBox("✘ #FFFFFFNie posiadasz rozłożonych noszy!", player, 255, 0, 0,true)
	end
end
addCommandHandler("nosze-zdejmij",zdejmij)
addEventHandler("onPlayerQuit",root,function(_,_,_)
local player=source
	if object[player] then
		if attach[player] then
			attach[player]:detach(object[player])
			triggerClientEvent(attach[player], "iyw_samd_stretcher:deleteRotation", root)
			attach[player] = false
		end
		destroyElement(object[player])
	end
end)

function getTarget(player)
if not player then return end
if attach[player] then return attach[player] end
return false
end

function usun(player,target)
if not player then return end
if not target then return end
	if attach[player] then
			for _,control in ipairs(controls) do
				toggleControl(player, control, true)
			end
		target:detach(object[player])
		attach[player] = false
		triggerClientEvent(target, "iyw_samd_stretcher:deleteRotation", root)
	end
	if getElementData(player,"nosze") then
			removeElementData(player, "nosze")
			if object[player] then
			destroyElement(object[player])
			end
	end
end
