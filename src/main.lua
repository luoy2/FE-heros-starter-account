init("0", 0)
setScreenScale(1536,2048)
-- com.nintendo.zaba
-- com.officialscheduler.mterminal
--ui 选择卡池, 选择服务器
require "spec"
require "utils"
require "main_flow"

id = createHUD()
_G.if_canceld_anima = true

function main()
	ret,results = showUI("ui.json")
	if ret==0 then	
		toast("您选择了取消，停止脚本运行")
		lua_exit()
	else
		_G.ios = 8
		_G.end_condition = tonumber(results['002'])+1
		_G.if_prologue = tonumber(results['001'])
		mSleep(1000)
		reset()
		return main_flow()
	end
end
	--reset()



main()
--[[
	closeApp("com.nintendo.zaba")
	closeApp("com.officialscheduler.mterminal")
	myRunAPP("com.officialscheduler.mterminal")
	wait_for_state(命令完成)
	inputText("su#ENTER#")
	wait_for_state(命令完成)
	inputText("alpine#ENTER#")
	delete()
	inputText("launchctl kickstart -k system/com.apple.cfprefsd.xpc.daemon#ENTER#")
	wait_for_state(命令完成)
	closeApp("com.officialscheduler.mterminal")
	--]]