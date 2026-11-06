--[[

    @author: TheNoobisty <thenoobisty@gmail.com>
    @resource: nrpg_login
    @description: Login Panel
    @file: c_login.lua

    @info: Zakazuje się używania bądź edycji kodu bez zgody autora w przeciwnym razie sprawa zostanie skierowana do sądu.

]]--

login = {

    lib = exports.nrpg_lib,
    isLogin = false,
    saveLogin = false,
    fastLogin = "nie",
    song = nil,
    actualUI = "main",
    totalProfiles = 0,
    background = dxCreateTexture("img/background.jpg"),
    user = dxCreateTexture("img/user.png"),
    password = dxCreateTexture("img/password.png"),
    logo = dxCreateTexture(":nrpg_interface/img/logo.png"),
    check_empty = dxCreateTexture("img/checkbox_empty.png"),
    checkbox = dxCreateTexture("img/checkbox_clicked.png"),
    online = dxCreateTexture("img/online.png"),
    email = dxCreateTexture("img/email.png"),
    spawnpoint = dxCreateTexture("img/spawnpoint.png"),
    theShadow = dxCreateTexture("img/shadow.png"),
    regulaminAccept = false,
    


}

local screenW, screenH = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local zoom = exports.nrpg_interface:getInterfaceZoom()
local loginPos = {x=0, y=0, w=math.floor(450/zoom), h=math.floor(600/zoom)}
shader = dxCreateShader('libs/masked.fx')
loginPos.x = screenW-loginPos.w-math.floor(742/zoom)
loginPos.y = screenH/2-loginPos.h+math.floor(300/zoom)
renderTarget = dxCreateRenderTarget(math.floor(595/zoom), math.floor(388/zoom), true)


login.interface = {

    loginBackground = login.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(40, 40, 40, 255)),
    loginBackground2 = login.lib:dgsCreateRoundRect({{15,false},{15,false},{15,false},{15,false}},tocolor(255, 175, 0, 255)),
    spawnButton = login.lib:dgsCreateRoundRect({{8,false},{8,false},{8,false},{8,false}},tocolor(25, 25, 25, 255)),
    spawnButton2 = login.lib:dgsCreateRoundRect({{18,false},{18,false},{18,false},{18,false}},tocolor(25, 25, 25, 255)),
    podgladBackground = login.lib:dgsCreateRoundRect({{0,false},{0,false},{18,false},{18,false}},tocolor(25, 25, 25, 255)),
    spawnButton3 = login.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 175, 0, 255)),
    spawnButton4 = login.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(100, 100, 100, 255)),
    loginButton = login.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(0, 144, 255, 155)),
    registerButton = login.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(0, 255, 0, 155)),
    backButton = login.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 0, 0, 155)),
    startRegisterButton = login.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 175, 0, 155)),
    greyButton = login.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(100, 100, 100, 155)),
    normalButton = login.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(255, 255, 0, 155)),
    premiumButton = login.lib:dgsCreateRoundRect({{5,false},{5,false},{5,false},{5,false}},tocolor(0, 144, 255, 155)),
    scrollRectangle = login.lib:dgsCreateRoundRect({{4,false},{4,false},{4,false},{4,false}},tocolor(255, 175, 0, 255)),

}

login.spawns = {

    {'Spawn Los Santos', 0, {1721.98, -1706.17, 13.50}},

    {'Ostatnia pozycja', 1, {0, 0, 15}},

}

camera = {

    actualCamera = nil,
    cameraPos = {0, 0, 15},
    block = false,

}
k = 1
n = 8
m = 8
iconAlpha = 0

local sm = {}
sm.moov = 0

local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end

local start
local animTime
local tempPos = {{},{}}
local tempPos2 = {{},{}}

local function camRender()
	local now = getTickCount()
	if (sm.moov == 1) then
		local x1, y1, z1 = interpolateBetween(tempPos[1][1], tempPos[1][2], tempPos[1][3], tempPos2[1][1], tempPos2[1][2], tempPos2[1][3], (now-start)/animTime, "InOutQuad")
		local x2,y2,z2 = interpolateBetween(tempPos[2][1], tempPos[2][2], tempPos[2][3], tempPos2[2][1], tempPos2[2][2], tempPos2[2][3], (now-start)/animTime, "InOutQuad")
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	else

        setCameraMatrix(camera.cameraPos[1],camera.cameraPos[2],camera.cameraPos[3]+150,camera.cameraPos[1],camera.cameraPos[2],-1000)
		removeEventHandler("onClientRender",root,camRender)
		fadeCamera(true)
        camera.block = false
	end
end

function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1) then
		killTimer(timer1)
		killTimer(timer2)
		removeEventHandler("onClientRender",root,camRender)
		fadeCamera(true)
	end
	fadeCamera(true)
	sm.moov = 1
	timer1 = setTimer(removeCamHandler,time,1)
	timer2 = setTimer(fadeCamera, time-1000, 1, false) -- 
	start = getTickCount()
	animTime = time
	tempPos[1] = {x1,y1,z1}
	tempPos[2] = {x1t,y1t,z1t}
	tempPos2[1] = {x2,y2,z2}
	tempPos2[2] = {x2t,y2t,z2t}
	addEventHandler("onClientRender",root,camRender)
	return true
end

login.renderLogin = function()
    local x, y, w, h = loginPos.x, loginPos.y, math.floor(100/zoom), math.floor(50/zoom)
    dxDrawImage(0, 0, screenW, screenH, login.background, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawRectangle(0, 0, screenW, screenH, tocolor(0, 0, 0, 75), false)

    sounds = {

        rectangle = 0,
        rectangle2 = 0,
        rectangle3 = 0,

    }
    local soundFFT = getSoundFFTData ( login.song, 2048, 1024 )
    local soundFFT2 = getSoundFFTData ( login.song, 2048, 512 )
    local soundFFT3 = getSoundFFTData ( login.song, 2048, 256 )
	if ( soundFFT ) then
        for i = 0, 175 do
            sounds.rectangle = sounds.rectangle + math.sqrt ( soundFFT[i] ) * 3
        end
        dxDrawRectangle((screenW-loginPos.w-math.floor(742/zoom))-math.floor(702/zoom), (screenH/2-loginPos.h+math.floor(300/zoom))+math.floor(825/zoom), math.floor(35/zoom), math.floor(-2/zoom)-sounds.rectangle, tocolor(255, 255, 255, 255), false)
    end

    if ( soundFFT2 ) then
        for i = 0, 155 do
            sounds.rectangle2 = sounds.rectangle2 + math.sqrt ( soundFFT[i] ) * 2
        end
        dxDrawRectangle((screenW-loginPos.w-math.floor(742/zoom))-math.floor(665/zoom), (screenH/2-loginPos.h+math.floor(300/zoom))+math.floor(825/zoom), math.floor(35/zoom), math.floor(-2/zoom)-sounds.rectangle2, tocolor(255, 255, 255, 255), false)
    end

    if ( soundFFT3 ) then
        for i = 0, 255 do
            sounds.rectangle3 = sounds.rectangle3 + math.sqrt ( soundFFT[i] ) * 3
        end
        dxDrawRectangle((screenW-loginPos.w-math.floor(742/zoom))-math.floor(628/zoom), (screenH/2-loginPos.h+math.floor(300/zoom))+math.floor(825/zoom), math.floor(35/zoom), math.floor(-2/zoom)-sounds.rectangle3, tocolor(255, 255, 255, 255), false)
    end
    

    dxDrawText("Aktualnie odtwarzane", (screenW-loginPos.w-math.floor(742/zoom))-math.floor(575/zoom), (screenH/2-loginPos.h+math.floor(300/zoom))+math.floor(790/zoom), math.floor(300/zoom), math.floor(50/zoom), tocolor(255, 175, 0, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, true, false)
    dxDrawText("Lana Del Rey - Summertime Sadness", (screenW-loginPos.w-math.floor(742/zoom))-math.floor(575/zoom), (screenH/2-loginPos.h+math.floor(300/zoom))+math.floor(810/zoom), math.floor(300/zoom), math.floor(50/zoom), tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)

    if login.actualUI == "ban" then
    dxDrawImage(loginPos.x, loginPos.y, loginPos.w, loginPos.h, login.interface.loginBackground2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(loginPos.x+math.floor(2/zoom), loginPos.y+math.floor(2/zoom), loginPos.w-math.floor(3/zoom), loginPos.h-math.floor(3/zoom), login.interface.loginBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(loginPos.x+math.floor(75/zoom), loginPos.y+math.floor(25/zoom), math.floor(345/zoom), math.floor(100/zoom), login.logo, 0, 0, 0, tocolor(255, 255, 255, 255), false)

    dxDrawText("Zostałeś zbanowany/a!", x+math.floor(355/zoom), y+math.floor(165/zoom), x+w, y+h, tocolor(255, 55, 55, 200), 1, exports.nrpg_interface:getGUIFont('money15'), "center", "top", false, false, false, true, false)

    local banData = getElementData(localPlayer, "player:banInfo")

    if string.len(banData.powod) > 1 then
        banReason = banData.powod
    else
        banReason = "Brak"
    end
    dxDrawText("SID: #ff9900"..banData.sid.."#ffffff\nNick: #ff9900"..banData.nadany.."#ffffff\nSerial: #ff9900"..banData.serial.."#ffffff\n\nNadawca: #ff9900"..banData.nadawca.."#ffffff\nDługość bana: #ff9900"..banData.czas.."#ffffff\nPowód bana: #ff9900"..(banReason or "Brak"), x+math.floor(355/zoom), y+math.floor(200/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)
    exports["nrpg_buttons"]:dxCreateButton("Wyjdź z serwera", loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(330/zoom), math.floor(200/zoom), math.floor(35/zoom), 1, {200, 55, 55})

    dxDrawText("Jeśli uważasz, że kara nie jest słuszna możesz\nzaapelować na naszym #389cffdiscordzie", x+math.floor(355/zoom), y+math.floor(485/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)
    exports["nrpg_buttons"]:dxCreateButton("Skopiuj link do discorda", loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(530/zoom), math.floor(200/zoom), math.floor(35/zoom), 2, {25, 144, 255})

    elseif login.actualUI == "main" then
    dxDrawImage(loginPos.x, loginPos.y, loginPos.w, loginPos.h, login.interface.loginBackground2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(loginPos.x+math.floor(2/zoom), loginPos.y+math.floor(2/zoom), loginPos.w-math.floor(3/zoom), loginPos.h-math.floor(3/zoom), login.interface.loginBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    
    dxDrawImage(loginPos.x+math.floor(75/zoom), loginPos.y+math.floor(25/zoom), math.floor(345/zoom), math.floor(100/zoom), login.logo, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Witaj #ffaf00"..getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", "").."#ffffff na NitroRPG!", x+math.floor(355/zoom), y+math.floor(265/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)

    
    exports["nrpg_buttons"]:dxCreateButton("Wejdź do gry", loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(310/zoom), math.floor(200/zoom), math.floor(40/zoom), 1, {55, 155, 55})
    exports["nrpg_buttons"]:dxCreateButton("Zarejestruj się", loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(355/zoom), math.floor(200/zoom), math.floor(40/zoom), 2, {25, 175, 255})


    dxDrawImage(loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(440/zoom), math.floor(25/zoom), math.floor(25/zoom), login.check_empty, 0, 0, 0, tocolor(255, 255, 255, 200), false)

    if login.saveLogin == true then
        dxDrawImage(loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(440/zoom), math.floor(25/zoom), math.floor(25/zoom), login.checkbox, 0, 0, 0, tocolor(255, 255, 255, 200), false)
    end
    dxDrawText("Zapamiętaj moje dane", x+math.floor(55/zoom), y+math.floor(445/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, false, false)


    dxDrawImage(loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(470/zoom), math.floor(25/zoom), math.floor(25/zoom), login.check_empty, 0, 0, 0, tocolor(255, 255, 255, 200), false)

    if login.fastLogin == "tak" then
        dxDrawImage(loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(470/zoom), math.floor(25/zoom), math.floor(25/zoom), login.checkbox, 0, 0, 0, tocolor(255, 255, 255, 200), false)
    end
    dxDrawText("Użyj szybkiego logowania", x+math.floor(55/zoom), y+math.floor(475/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, false, false)

    dxDrawImage(loginPos.x+math.floor(210/zoom), loginPos.y+math.floor(563/zoom), math.floor(22/zoom), math.floor(22/zoom), login.online, 0, 0, 0, tocolor(255, 175, 0, 255), false)
    dxDrawText("GRACZE", x+math.floor(355/zoom), y+math.floor(540/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money14'), "center", "top", false, false, false, false, false)
    dxDrawText((#getElementsByType("player")), x+math.floor(233/zoom), y+math.floor(565/zoom), x+w, y+h, tocolor(255, 175, 0, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, false, false)
    elseif login.actualUI == "register" then
    dxDrawImage(loginPos.x, loginPos.y, loginPos.w, loginPos.h, login.interface.loginBackground2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawImage(loginPos.x+math.floor(2/zoom), loginPos.y+math.floor(2/zoom), loginPos.w-math.floor(3/zoom), loginPos.h-math.floor(3/zoom), login.interface.loginBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
    
    dxDrawImage(loginPos.x+math.floor(75/zoom), loginPos.y+math.floor(25/zoom), math.floor(345/zoom), math.floor(100/zoom), login.logo, 0, 0, 0, tocolor(255, 255, 255, 255), false)

    if login.isMouseIn(loginPos.x+math.floor(155/zoom), loginPos.y+math.floor(365/zoom), math.floor(135/zoom), math.floor(25/zoom)) then
        regulaminAlpha = 155
    else
        regulaminAlpha = 200
    end
    dxDrawImage(loginPos.x+math.floor(155/zoom), loginPos.y+math.floor(365/zoom), math.floor(25/zoom), math.floor(25/zoom), login.check_empty, 0, 0, 0, tocolor(255, 255, 255, regulaminAlpha), false)

    if login.regulaminAccept == true then
        dxDrawImage(loginPos.x+math.floor(155/zoom), loginPos.y+math.floor(365/zoom), math.floor(25/zoom), math.floor(25/zoom), login.checkbox, 0, 0, 0, tocolor(255, 255, 255, regulaminAlpha), false)
    end

    dxDrawText("Akceptuje #ffaf00regulamin", x+math.floor(185/zoom), y+math.floor(371/zoom), x+w, y+h, tocolor(255, 255, 255, regulaminAlpha), 1, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)

    exports["nrpg_buttons"]:dxCreateButton("Zarejestruj", loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(410/zoom), math.floor(200/zoom), math.floor(40/zoom), 1, {255, 175, 25})
    exports["nrpg_buttons"]:dxCreateButton("Cofnij", loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(455/zoom), math.floor(200/zoom), math.floor(40/zoom), 2, {200, 55, 55})

    dxDrawImage(loginPos.x+math.floor(210/zoom), loginPos.y+math.floor(563/zoom), math.floor(22/zoom), math.floor(22/zoom), login.online, 0, 0, 0, tocolor(255, 175, 0, 255), false)
    dxDrawText("GRACZE", x+math.floor(355/zoom), y+math.floor(540/zoom), x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money14'), "center", "top", false, false, false, false, false)
    dxDrawText((#getElementsByType("player")), x+math.floor(233/zoom), y+math.floor(565/zoom), x+w, y+h, tocolor(255, 175, 0, 200), 1, exports.nrpg_interface:getGUIFont('money12'), "left", "top", false, false, false, false, false)
    elseif login.actualUI == "spawn" then
        dxDrawImage(loginPos.x-math.floor(275/zoom), loginPos.y, loginPos.w+math.floor(550/zoom), loginPos.h, login.interface.loginBackground2, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(loginPos.x-math.floor(275/zoom)+math.floor(2/zoom), loginPos.y+math.floor(2/zoom), loginPos.w+math.floor(550/zoom)-math.floor(3/zoom), loginPos.h-math.floor(3/zoom), login.interface.loginBackground, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(loginPos.x+math.floor(75/zoom), loginPos.y+math.floor(25/zoom), math.floor(325/zoom), math.floor(100/zoom), login.logo, 0, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawImage(loginPos.x+math.floor(100/zoom), loginPos.y+math.floor(165/zoom), math.floor(595/zoom), math.floor(388/zoom), login.interface.spawnButton2, 0, 0, 0, tocolor(255, 175, 0, 255), false)

         
        dxUpdateScreenSource( myScreenSource )
        dxSetRenderTarget(renderTarget, true)
            if myScreenSource then
                dxDrawImage(0, 0, math.floor(595/zoom), math.floor(388/zoom), myScreenSource )
            end
        dxSetRenderTarget()
        dxSetShaderValue(shader, 'sPicTexture', renderTarget)
        dxSetShaderValue(shader, 'sMaskTexture', login.theShadow)
        dxSetShaderValue(shader, 'gUVScale', 1, 1)

        dxDrawImage(loginPos.x+math.floor(100/zoom), loginPos.y+math.floor(165/zoom), math.floor(595/zoom), math.floor(388/zoom), shader, 0, 0, 0, tocolor(255, 255, 255, 255), false)
        

        dxDrawImage(loginPos.x+math.floor(100/zoom), loginPos.y+math.floor(500/zoom), math.floor(595/zoom), math.floor(55/zoom), login.interface.podgladBackground, 0, 0, 0, tocolor(255, 255, 255, 235), false)

        
        dxDrawText("Podgląd", x+math.floor(685/zoom), y+math.floor(505/zoom), x+w, y+h, tocolor(255, 175, 0, 225), 1, exports.nrpg_interface:getGUIFont('money14'), "center", "top", false, false, false, true, false)
        dxDrawText(camera.actualCamera or "Brak", x+math.floor(685/zoom), y+math.floor(530/zoom), x+w, y+h, tocolor(255, 255, 255, 225), 1, exports.nrpg_interface:getGUIFont('money10'), "center", "top", false, false, false, true, false)

        xx = 0
        for i,v in ipairs(login.spawns) do
            if i >= k and i <= n then 
                xx = (xx+1)
                offset = math.floor(50/zoom)*(xx-1)

                if camera.actualCamera == v[1] then
                    dxDrawImage(loginPos.x-math.floor(240/zoom), loginPos.y+math.floor(165/zoom)+offset, math.floor(300/zoom), math.floor(45/zoom), login.interface.spawnButton, 0, 0, 0, tocolor(255, 175, 0, 225), false)
                else
                    dxDrawImage(loginPos.x-math.floor(240/zoom), loginPos.y+math.floor(165/zoom)+offset, math.floor(300/zoom), math.floor(45/zoom), login.interface.spawnButton, 0, 0, 0, tocolor(255, 175, 0, 125), false)
                end
            

            
                if login.isMouseIn(loginPos.x-math.floor(230/zoom), loginPos.y+math.floor(175/zoom)+offset, math.floor(25/zoom), math.floor(25/zoom)) then
                    dxDrawImage(loginPos.x-math.floor(230/zoom), loginPos.y+math.floor(175/zoom)+offset, math.floor(25/zoom), math.floor(25/zoom), login.spawnpoint, 0, 0, 0, tocolor(255, 175, 0, 200), false)
                    dxDrawText("Zespawnuj tutaj", x-math.floor(195/zoom), y+math.floor(178/zoom)+offset, x+w, y+h, tocolor(255, 175, 0, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)
                else
                    dxDrawImage(loginPos.x-math.floor(230/zoom), loginPos.y+math.floor(175/zoom)+offset, math.floor(25/zoom), math.floor(25/zoom), login.spawnpoint, 0, 0, 0, tocolor(255, 175, 0, 255), false)
                    dxDrawText(v[1], x-math.floor(195/zoom), y+math.floor(178/zoom)+offset, x+w, y+h, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont('money10'), "left", "top", false, false, false, true, false)
                end

                if camera.block == true then
                    dxDrawImage(loginPos.x+math.floor(0/zoom), loginPos.y+math.floor(176/zoom)+offset, math.floor(50/zoom), math.floor(22/zoom), login.interface.spawnButton4, 0, 0, 0, tocolor(255, 175, 0, 155), false)
                else
                    if login.isMouseIn(loginPos.x+math.floor(0/zoom), loginPos.y+math.floor(176/zoom)+offset, math.floor(50/zoom), math.floor(22/zoom)) then
                        dxDrawImage(loginPos.x+math.floor(0/zoom), loginPos.y+math.floor(176/zoom)+offset, math.floor(50/zoom), math.floor(22/zoom), login.interface.spawnButton3, 0, 0, 0, tocolor(255, 175, 0, 125), false)
                    else
                        dxDrawImage(loginPos.x+math.floor(0/zoom), loginPos.y+math.floor(176/zoom)+offset, math.floor(50/zoom), math.floor(22/zoom), login.interface.spawnButton3, 0, 0, 0, tocolor(255, 175, 0, 155), false)
                    end
                end
            
                dxDrawText("Podgląd", x+math.floor(5/zoom), y+math.floor(180/zoom)+offset, x+w, y+h, tocolor(255, 255, 255, 255), 0.91, exports.nrpg_interface:getGUIFont('money9'), "left", "top", false, false, false, true, false)
            end
        end
        drawScrollbar(login.spawns, loginPos.x+math.floor(68/zoom), loginPos.y+math.floor(165/zoom), math.floor(388/zoom), math.floor(45/zoom), m, k)
    end
end

login.buttonTypes = {

    ['login'] = login.interface.loginButton,
    ['register'] = login.interface.registerButton,
    ['back'] = login.interface.backButton,
    ['startreg'] = login.interface.startRegisterButton,
    ['grey'] = login.interface.greyButton,
    ['premiumSpawn'] = login.interface.premiumButton,
    ['normalSpawn'] = login.interface.normalButton,

}

onbutton = {}

login.drawButton = function(x, y, x2, y2, type, text, text2)
    if getKeyState("mouse1") == true then
        alphaAdd = 25
    else
        alphaAdd = 0
    end

    if login.isMouseIn(x, y, x2, y2) then
        dxDrawImage(x, y, x2, y2, login.buttonTypes[type], 0, 0, 0, tocolor(255, 255, 255, 175+alphaAdd), false)
        onbutton[x] = true
    else
        dxDrawImage(x, y, x2, y2, login.buttonTypes[type], 0, 0, 0, tocolor(255, 255, 255, 155), false)
        onbutton[x] = false
    end

    if text then
        if text2 and onbutton[x] then
            dxDrawText(utf8.upper(text).."\n#599BFF"..utf8.upper(text2).."", x+2, y+2, x2+x, y2+y, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "center", "center", false, true, false, true)
        else
            dxDrawText(utf8.upper(text), x+2, y+2, x2+x, y2+y, tocolor(255, 255, 255, 200), 1, exports.nrpg_interface:getGUIFont("money9"), "center", "center", false, true)
        end
    end
end

login.dxDrawLinedRectangle = function( x, y, width, height, color, _width, postGUI )
    _width = _width or 1
    dxDrawLine ( x, y, x+width, y, color, _width, postGUI ) -- Top
    dxDrawLine ( x, y, x, y+height, color, _width, postGUI ) -- Left
    dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI ) -- Bottom
    return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI ) -- Right
end


login.clickLogin = function(button, state)
    if button == "left" and state == "up" and login.isLogin == true then
        if login.isMouseIn(loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(355/zoom), math.floor(200/zoom), math.floor(40/zoom)) and login.actualUI == "main" then
            login.switchLoginWindow("register")
        elseif login.isMouseIn(loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(455/zoom), math.floor(200/zoom), math.floor(40/zoom)) and login.actualUI == "register" then
            login.switchLoginWindow("main")
            login.rememberLoad()
        elseif login.isMouseIn(loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(330/zoom), math.floor(200/zoom), math.floor(35/zoom)) and login.actualUI == "ban" then
            triggerServerEvent("quitServerBan", localPlayer, localPlayer)
        elseif login.isMouseIn(loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(530/zoom), math.floor(200/zoom), math.floor(35/zoom)) and login.actualUI ==  "ban" then
            setClipboard("https://discord.gg/cRDF5qGgNS")
            exports.nrpg_interface:showPlayerNotification("Skopiowano link do discorda serwerowego", "info", 6000, "Discord serwerowy")
        elseif login.isMouseIn(loginPos.x+math.floor(155/zoom), loginPos.y+math.floor(365/zoom), math.floor(25/zoom), math.floor(25/zoom)) and login.actualUI == "register" then
            if login.regulaminAccept == true then
                login.regulaminAccept = false
            else
                login.regulaminAccept = true
            end
        elseif login.isMouseIn(loginPos.x+math.floor(185/zoom), loginPos.y+math.floor(365/zoom), math.floor(105/zoom), math.floor(25/zoom)) and login.actualUI == "register" then
            exports.nrpg_interface:showPlayerNotification("Skopiowano link do regulaminu", "info")
                setClipboard("https://nitro-rpg.xaa.pl/index.php?/topic/9-regulamin/&tab=comments#comment-9")
        elseif login.isMouseIn(loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(410/zoom), math.floor(200/zoom), math.floor(40/zoom)) and login.actualUI == "register" then
            if login.totalProfiles == 5 or login.totalProfiles >= 5 then
                exports.nrpg_interface:showPlayerNotification("Osiągasz limit kont (5 kont).", "error")
            else
                if login.regulaminAccept == false then
                    return exports.nrpg_interface:showPlayerNotification("Aby się zarejestrować akceptuj regulamin", "error")
                end
                local plr = {}
                plr.login = exports['nrpg_interface']:getCustomEditboxText('register:nick')
                plr.pass = exports['nrpg_interface']:getCustomEditboxText('register:haslo')
                plr.pass2 = exports['nrpg_interface']:getCustomEditboxText('register:haslo2')
                plr.email = exports['nrpg_interface']:getCustomEditboxText('register:email')

                if checkString(plr.login) == false then
                    return exports.nrpg_interface:showPlayerNotification("Login zawiera nieprawidłowe znaki", "error")
                end

                if string.len(plr.login) < 3 then
                    return exports.nrpg_interface:showPlayerNotification("Login powinien zawierać conajmniej 3 znaki", "error")
                end
                
                if string.len(plr.login) > 20 then
                    return exports.nrpg_interface:showPlayerNotification("Login powinien zawierać maksymalnie 20 znaków", "error")
                end

                if string.len(plr.pass) < 4 then
                    return exports.nrpg_interface:showPlayerNotification("Hasło powinno zawierać conajmniej 4 znaki", "error")
                end
                
                if string.len(plr.pass) > 15 then
                    return exports.nrpg_interface:showPlayerNotification("Hasło powinno zawierać maksymalnie 15 znaków", "error")
                end

                if plr.pass ~= plr.pass2 then
                    return exports.nrpg_interface:showPlayerNotification("Hasła nie są takie same", "error")
                end

                if string.len(plr.email) < 5 then
                    return exports.nrpg_interface:showPlayerNotification("Email powinien zawierać conajmniej 5 znaków", "error")
                end
                
                if string.len(plr.email) > 30 then
                    return exports.nrpg_interface:showPlayerNotification("Email powinien zawierać maksymalnie 30 znaków", "error")
                end

                triggerServerEvent("registerAccount", localPlayer, plr.login, plr.pass, plr.email)
            end
        elseif login.isMouseIn(loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(440/zoom), math.floor(25/zoom), math.floor(25/zoom)) and login.actualUI == "main" then
            if login.saveLogin == true then
                login.saveLogin = false
            else
                login.saveLogin = true
            end
        elseif login.isMouseIn(loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(470/zoom), math.floor(25/zoom), math.floor(25/zoom)) and login.actualUI == "main" then
            if login.fastLogin == "tak" then
                login.fastLogin = "nie"
            else
                login.fastLogin = "tak"
            end
        elseif login.isMouseIn(loginPos.x+math.floor(125/zoom), loginPos.y+math.floor(310/zoom), math.floor(200/zoom), math.floor(40/zoom)) and login.actualUI == "main" then
            local loginNickname = exports['nrpg_interface']:getCustomEditboxText('login:nick')
            local loginPassword = exports['nrpg_interface']:getCustomEditboxText('login:haslo')

            if string.len(loginNickname) < 3 then
                return exports.nrpg_interface:showPlayerNotification("Uzupełnij dane!", "error")
            end

            if string.len(loginPassword) < 3 then
                return exports.nrpg_interface:showPlayerNotification("Uzupełnij dane!", "error")
            end
            
            login.rememberSave()
            triggerServerEvent("loginAccount", localPlayer, loginNickname, loginPassword)
        elseif login.actualUI == "spawn" then

            xx = 0
            for i,v in ipairs(login.spawns) do
                if i >= k and i <= n then 
                xx = (xx+1)
                offset = math.floor(50/zoom)*(xx-1)

                if login.isMouseIn(loginPos.x+math.floor(0/zoom), loginPos.y+math.floor(176/zoom)+offset, math.floor(50/zoom), math.floor(22/zoom)) then
                    if camera.actualCamera ~= v[1] and camera.block == false then
                        camera.actualCamera = v[1]
                        camera.block = true

                        if v[1] == "Spawn organizacji" or v[1] == "Ostatnia pozycja" then
                            if v[1] == "Spawn organizacji" then
                                pos = getElementData(localPlayer, "organizacja:spawn")
                            else
                                pos = getElementData(localPlayer, "ostatnia:pozycja")
                            end
                            smoothMoveCamera(camera.cameraPos[1], camera.cameraPos[2], camera.cameraPos[3]+150, camera.cameraPos[1], camera.cameraPos[2], -1000, pos[1], pos[2], pos[3]+150, pos[1], pos[2], -1000, 3500)
                            camera.cameraPos = {pos[1], pos[2], pos[3]}
                        else
                            smoothMoveCamera(camera.cameraPos[1], camera.cameraPos[2], camera.cameraPos[3]+150, camera.cameraPos[1], camera.cameraPos[2], -1000, v[3][1], v[3][2], v[3][3]+150, v[3][1], v[3][2], -1000, 3500)
                            camera.cameraPos = {v[3][1], v[3][2], v[3][3]}
                        end        
                    end
                elseif login.isMouseIn(loginPos.x-math.floor(230/zoom), loginPos.y+math.floor(175/zoom)+offset, math.floor(25/zoom), math.floor(25/zoom)) then
                    if v[2] == 1 and not getElementData(localPlayer, "player:premiumplus") then return exports.nrpg_interface:showPlayerNotification("Nie posiadasz konta premium+", "error") end
                    if v[1] == "Ostatnia pozycja" then
                        local pos = getElementData(localPlayer, "ostatnia:pozycja")
                        if not pos then setElementData(localPlayer, "player:spawn", {-2678.18, -5.42, 6.13}) return end
                        setElementData(localPlayer,"player:spawn", {pos[1], pos[2], pos[3], pos[4], pos[5]})
                    elseif v[1] == "Spawn organizacji" then
                        local pos = getElementData(localPlayer, "organizacja:spawn")
                        if not pos then setElementData(localPlayer, "player:spawn", {-2678.18, -5.42, 6.13}) return end
                        setElementData(localPlayer,"player:spawn", {pos[1], pos[2], pos[3], pos[4], pos[5]})
                    else
                        setElementData(localPlayer,"player:spawn", {v[3][1], v[3][2], v[3][3]})
                    end
                    login.spawnPlayer()
                end
                end
            end
        end
    end
end

login.spawnPlayer = function()
    if login.song then
        stopSound(login.song)
    end

    removeEventHandler("onClientRender", root, login.renderLogin)
    removeEventHandler("onClientClick", root, login.clickLogin)
    login.isLogin = false
    setElementData(localPlayer, "notshowhud", false)
    showCursor(false)
    showChat(true)
    showPlayerHudComponent("all", false)
    showPlayerHudComponent("crosshair", true)
    setElementData(localPlayer, 'player:sid', (getElementData(localPlayer, 'new:sid') or 0))
	setElementData(localPlayer, 'new:sid', false)
    resetFarClipDistance(  )

    for i,v in ipairs(getElementsByType("texture", resourceRoot)) do
        if isElement(v) then
            destroyElement(v)
        end
    end

    triggerServerEvent("core:spawnPlayer", localPlayer)
end

login.loginResult = function()
    exports['nrpg_interface']:destroyCustomEditbox('login:nick')
    exports['nrpg_interface']:destroyCustomEditbox('login:haslo')
    exports['nrpg_interface']:destroyCustomEditbox('register:nick')
    exports['nrpg_interface']:destroyCustomEditbox('register:haslo')
    exports['nrpg_interface']:destroyCustomEditbox('register:haslo2')
    exports['nrpg_interface']:destroyCustomEditbox('register:email')

    if login.fastLogin == "tak" then
        setElementData(localPlayer, "player:spawn", {1721.98, -1706.17, 13.50})
        login.spawnPlayer()
    else
        createAnimation(loginPos.y, 2000/zoom, 'Linear', 500, function(value) loginPos.y = value end)
        myScreenSource = dxCreateScreenSource(screenW, screenH)
        setElementInterior(localPlayer, 0)
        setElementDimension(localPlayer, 0)
        setCameraMatrix(1721.98, -1706.17, 150, 1721.98, -1706.17, 0)
        camera.actualCamera = "Spawn Los Santos"
        camera.cameraPos = {1721.98, -1706.17, 0}
        setFarClipDistance(5000)


        setTimer(function()
            createAnimation(loginPos.y, (screenH/2-loginPos.h+math.floor(300/zoom)), 'Linear', 750, function(value) loginPos.y = value end)
            login.actualUI = "spawn"
    
            if getElementData(localPlayer, "organizacja:spawn") then
                table.insert(login.spawns, {'Spawn organizacji', 0, {0, 0, 15}})
            end
        end, 550, 1)
    end
end
addEvent("loginResult", true)
addEventHandler("loginResult", resourceRoot, login.loginResult)


login.banResult = function(plr, state)
    if state == true then
    login.openLogin()
    exports['nrpg_interface']:destroyCustomEditbox('login:nick')
    exports['nrpg_interface']:destroyCustomEditbox('login:haslo')
    exports['nrpg_interface']:destroyCustomEditbox('register:nick')
    exports['nrpg_interface']:destroyCustomEditbox('register:haslo')
    exports['nrpg_interface']:destroyCustomEditbox('register:haslo2')
    exports['nrpg_interface']:destroyCustomEditbox('register:email')

    login.actualUI = "ban"
    else
        login.openLogin()
    end
end
addEvent("loginBanResult", true)
addEventHandler("loginBanResult", resourceRoot, login.banResult)

login.switchLoginWindow = function(type)
    exports['nrpg_interface']:destroyCustomEditbox('login:nick')
    exports['nrpg_interface']:destroyCustomEditbox('login:haslo')
    exports['nrpg_interface']:destroyCustomEditbox('register:nick')
    exports['nrpg_interface']:destroyCustomEditbox('register:haslo')
    exports['nrpg_interface']:destroyCustomEditbox('register:haslo2')
    exports['nrpg_interface']:destroyCustomEditbox('register:email')

    if type == "main" then
        login.nickBox = exports['nrpg_interface']:createCustomEditbox('login:nick', 'Nick', loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(150/zoom), math.floor(400/zoom), math.floor(45/zoom), false, "", false, {25, 25, 25}, login.user)
        login.passBox = exports['nrpg_interface']:createCustomEditbox('login:haslo', 'Hasło', loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(200/zoom), math.floor(400/zoom), math.floor(45/zoom), true, "", false, {25, 25, 25}, login.password)
        login.actualUI = "main"
    elseif type == "register" then
        login.registerBoxNick = exports['nrpg_interface']:createCustomEditbox('register:nick', 'Nick', loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(150/zoom), math.floor(400/zoom), math.floor(45/zoom), false, "", false, {25, 25, 25}, login.user)
        login.registerBoxPass = exports['nrpg_interface']:createCustomEditbox('register:haslo', 'Hasło', loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(200/zoom), math.floor(400/zoom), math.floor(45/zoom), true, "", false, {25, 25, 25}, login.password)
        login.registerBoxPass2 = exports['nrpg_interface']:createCustomEditbox('register:haslo2', 'Powtórz hasło', loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(250/zoom), math.floor(400/zoom), math.floor(45/zoom), true, "", false, {25, 25, 25}, login.password)
        login.registerBoxEmail = exports['nrpg_interface']:createCustomEditbox('register:email', 'Adres e-mail', loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(300/zoom), math.floor(400/zoom), math.floor(45/zoom), false, "", false, {25, 25, 25}, login.email)
        login.actualUI = "register"
    end
end 

addEventHandler("onClientResourceStop", resourceRoot, function()
    exports['nrpg_interface']:destroyCustomEditbox('login:nick')
    exports['nrpg_interface']:destroyCustomEditbox('login:haslo')

    exports['nrpg_interface']:destroyCustomEditbox('register:nick')
    exports['nrpg_interface']:destroyCustomEditbox('register:haslo')
    exports['nrpg_interface']:destroyCustomEditbox('register:haslo2')
    exports['nrpg_interface']:destroyCustomEditbox('register:email')

    for i,v in ipairs(getElementsByType("texture", resourceRoot)) do
        if isElement(v) then
            destroyElement(v)
        end
    end
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
    if not getElementData(localPlayer, "player:sid") then
        triggerServerEvent("loginCheckBan", localPlayer, localPlayer)
    end
end)

login.rememberLoad = function()
    local xml = xmlLoadFile("loginCache.xml")
    if not xml then return end
        
    local xmlNode2 = xmlFindChild(xml, "loginNickname", 0)
    local xmlNode = xmlFindChild(xml, "loginPassword", 0)
    local loggingPassword = xmlNodeGetValue(xmlNode)
    local loginNickname = xmlNodeGetValue(xmlNode2)

    
    if loggingPassword or loginNickname then 
        exports['nrpg_interface']:customEditboxSetText("login:nick", tostring(loginNickname))
    	exports['nrpg_interface']:customEditboxSetText("login:haslo", tostring(loggingPassword))
        login.saveLogin = true
    end
end

login.rememberSave = function()
    local xml = xmlCreateFile("loginCache.xml", "auth")
    if not xml then return end
    local login = exports['nrpg_interface']:getCustomEditboxText('login:nick')
    local pass = exports['nrpg_interface']:getCustomEditboxText('login:haslo')
    xmlNodeSetValue(xmlCreateChild(xml, "loginNickname"), login)
    xmlNodeSetValue(xmlCreateChild(xml, "loginPassword"), pass)
    
    xmlSaveFile(xml)
end

bindKey("mouse_wheel_up", "both", function()
    if login.isMouseIn(loginPos.x-math.floor(240/zoom), loginPos.y+math.floor(165/zoom), math.floor(320/zoom), math.floor(388/zoom)) and login.isLogin == true then
        scrollUp()
    end
end)

bindKey("mouse_wheel_down", "both", function()
    if login.isMouseIn(loginPos.x-math.floor(240/zoom), loginPos.y+math.floor(165/zoom), math.floor(320/zoom), math.floor(388/zoom)) and login.isLogin == true then
        scrollDown()
    end
end)


function scrollDown()
    if n >= #login.spawns then return end
    k = k+1
    n = n+1
end

function scrollUp()
    if n == m then return end
    k = k-1
    n = n-1
end

function checkString(text)
    if string.find(text, "%c") or string.find(text, "%p") or string.find(text, "%s") or string.find(text, "%z") then
      return false
    else
      return true
    end
end

login.isMouseIn = function(psx, psy, pssx, pssy, abx, aby)
    if not isCursorShowing() then return end

    cx,cy=getCursorPosition()
    cx,cy=cx*sx,cy*sy
    if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
        return true,cx,cy
    else
        return false
    end
end

function drawScrollbar(table, x, y, height, barheight, m_, k_)
    dxDrawImage(x, y, 8, height, login.interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 55), false)

	if #table > m_ then
    	local scrollbarHeight = height/#table

   		if k_ == 1 then 
        	scrollbarPos = y
    	elseif k_ > 1 then 
        	scrollbarPos = ((k_)*scrollbarHeight)+y
    	end

    	if #table <= m_ then 
        	scrollbarHeight = height
    	end

		dxDrawImage(x, scrollbarPos, 8, scrollbarHeight*(m_-1), login.interface.scrollRectangle, 0, 0, 0, tocolor(255, 255, 255, 125), false)
	end
end

login.openLogin = function()
    if getElementData(localPlayer, "player:sid") then return end
    addEventHandler("onClientRender", root, login.renderLogin)
    addEventHandler("onClientClick", root, login.clickLogin)

    setElementData(localPlayer, "notshowhud", true)
    showCursor(true)
    showChat(false)

    login.actualUI = "main"

    login.song = playSound("music/music.mp3", true)
    setSoundVolume(login.song, 0.1)
    login.isLogin = true
    if login.actualUI == "main" then
        login.nickBox = exports['nrpg_interface']:createCustomEditbox('login:nick', 'Nick', loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(150/zoom), math.floor(400/zoom), math.floor(45/zoom), false, "", false, {25, 25, 25}, login.user)
        login.passBox = exports['nrpg_interface']:createCustomEditbox('login:haslo', 'Hasło', loginPos.x+math.floor(25/zoom), loginPos.y+math.floor(200/zoom), math.floor(400/zoom), math.floor(45/zoom), true, "", false, {25, 25, 25}, login.password)
    end

    setTimer( function()
        login.rememberLoad()
    end, 1000, 1)
end
addEvent("openLoginPanel", true)
addEventHandler("openLoginPanel", root, login.openLogin)