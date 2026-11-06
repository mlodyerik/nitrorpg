local marker = createMarker(4603.51, 367.29, 5391.20, "cylinder", 1.2, 255, 255, 0, 55)
setElementDimension(marker, 0)
setElementInterior(marker, 0)
setElementData(marker, "marker:downtext", "WYPOSAŻENIE\nSAN ANDREAS POLICE DEPARTMENT")

addEvent("sapd:wyposazenie", true)
addEventHandler("sapd:wyposazenie", root, function(item)
		if item == "kamizelka" then
			setPedArmor(source, 100)
			giveWeapon(source, 23, 999)
			exports.nrpg_interface:showPlayerNotification(source, "Pomyślnie założyłeś(aś) Kamizelkę", "success")
		elseif item == "snajperka" then
			giveWeapon(source, 34, 999)
			exports.nrpg_interface:showPlayerNotification(source, "Pomyślnie odebrałeś(aś) Snajperkę", "success")
		elseif item == "m4" then
			giveWeapon(source, 31, 999)
			exports.nrpg_interface:showPlayerNotification(source, "Pomyślnie odebrałeś(aś) Karabin M4", "success")
		elseif item == "tazer" then
			giveWeapon(source, 23, 999)
			exports.nrpg_interface:showPlayerNotification(source, "Pomyślnie odebrałeś(aś) Tazer", "success")
		elseif item == "pałka" then
			giveWeapon(source, 3, 999)
			exports.nrpg_interface:showPlayerNotification(source, "Pomyślnie odebrałeś(aś) Pałkę Policyjną", "success")
		elseif item == "deagle" then
			giveWeapon(source, 24, 999)
			exports.nrpg_interface:showPlayerNotification(source, "Pomyślnie odebrałeś(aś) Suszarkę", "success")
		elseif item == "gaz" then
			giveWeapon(source, 17, 999)
			exports.nrpg_interface:showPlayerNotification(source, "Pomyślnie odebrałeś(aś) Gaz łzawiący", "success")
		elseif item == "strzelba" then
			giveWeapon(source, 25, 999)
			exports.nrpg_interface:showPlayerNotification(source, "Pomyślnie odebrałeś(aś) Strzelbę", "success")
		elseif item == "mp5" then
			giveWeapon(source, 29, 999)
			exports.nrpg_interface:showPlayerNotification(source, "Pomyślnie odebrałeś(aś) Karabin MP5", "success")
	end
end)