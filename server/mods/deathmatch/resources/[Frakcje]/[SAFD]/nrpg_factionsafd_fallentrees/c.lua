function niszczenie(loss,attacker)
	if attacker==localPlayer then
		hp=getElementData(source,"health")
		if hp then
			hp=hp-loss
			if hp>0 then
				setElementData(source,"health",hp)
			else
				triggerServerEvent("SAFD:Zniszczdrzewo",resourceRoot,source,localPlayer)
			end
		end
	end
end
addEventHandler("onClientObjectDamage",resourceRoot,niszczenie)