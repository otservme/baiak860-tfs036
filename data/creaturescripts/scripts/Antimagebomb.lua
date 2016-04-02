local config = {
        max = 1,
        text = "Multi-Client or Magebomb is not allowed.",
        group_id = 1  -- it will only kick player whit that id (1=Players, 2=tutor, 3=seniortutors, 4=Gm's, 5=Cm's and 6=God's
}

local accepted_ip_list = ""  -- here put the Ip you whant to be allowed to use Mc/Magebomb..

local function antiMC(p)
	if (getCreatureName(p.pid) == "Account Manager") then return true end
        if #getPlayersByIp(getPlayerIp(p.pid)) >= p.max then
                doRemoveCreature(p.pid)
        end
        return TRUE
end

function onLogin(cid)
	if not(isPlayer(cid)) then return true end
	if (getCreatureName(cid) == "Account Manager") then return true end
	if(getConfigValue("antimulticlient")) then
        if getPlayerGroupId(cid) <= config.group_id then
                if isInArray(accepted_ip_list,getPlayerIp(cid)) == FALSE then
                        addEvent(antiMC, 1000, {pid = cid, max = config.max+1})
                        doPlayerSendTextMessage(cid, 19, config.text)
                	end
		end
        end
        return TRUE
end