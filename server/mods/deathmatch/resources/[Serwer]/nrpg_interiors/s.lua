addEvent("warpInterior", true)
addEventHandler("warpInterior", root, function(x,y,z,dim,int,nazwa)
	if nazwa == "Kopalnia" then
		if exports["nrpg_admin"]:getAdmin(source, 5) then

		else
			toggleControl(source,"fire",false)
			toggleControl(source,"aim_weapon",false)
		end
	end
	setElementPosition(source, x, y, z)
	setElementDimension(source, dim)
	setElementInterior(source, int)
end)