local ranks = {
[1] = {"Tutor"},
[2] = {"S. Tutor"},
[3] = {"GM"},
[4] = {"CM"},
[5] = {"Admin"}
}
 
function onSay(cid, words, param, channel)
	local players = getPlayersOnline()
	local strings = {""}
	local i, position = 1, 1
	local added = false
 
	for _, pid in ipairs(players) do
		if(added) then
			if(i > (position * 7)) then
				strings[position] = strings[position] .. ","
				position = position + 1
				strings[position] = ""
			else
				strings[position] = i == 1 and "" or strings[position] .. ", "
			end
		end
 
		if getPlayerAccess(pid) == 0 then
			strings[position] = strings[position] .. getCreatureName(pid) .." ["..getPlayerLevel(pid).."]"
			i = i + 1
			added = true
		else
			added = false
		end
	end
 
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, (i - 1) .. " player(s) online:")
	for i, str in ipairs(strings) do
		if(str:sub(str:len()) ~= ",") then
			str = str .. "."
		end
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, str)
	end
 
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "-----------")
 
	local players2 = getPlayersOnline()
	local helpon = 0
	local rank = ""
	local str2 = ""
 
	for _, pid2 in ipairs(players2) do		
		if getPlayerAccess(pid2) > 0 then
			rank = ranks[getPlayerAccess(pid2)]
			str2 = str2 .. getCreatureName(pid2) .." ["..rank[1].."]  "
			helpon = helpon + 1
		end		
	end
	if helpon > 0 then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, (helpon) .. " support player(s) online:")
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, str2)
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "There are no support players currently online.")
	end
	return true
end