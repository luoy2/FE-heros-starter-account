init("0", 0)
setScreenScale(1536,2048)
-- com.nintendo.zaba
--ui 选择卡池, 选择服务器
require "spec"
require "utils"
require "main_flow"

id = createHUD()

function main()
	ret,results = showUI("ui.json")
	if ret==0 then	
		toast("您选择了取消，停止脚本运行")
		lua_exit()
	else
		_G.ios = 8
		_G.ios = _G.ios + tonumber(results['001'])
		_G.end_condition = tonumber(results['002'])+1
		reset()
		return main_flow()
	end
end

main()

--[[
local if_fight_x, if_fight_y = myFindColor(章节感叹号)
for i = 1, 5, 1 do
	if if_fight_x > -1 then
		tap(if_fight_x+373, if_fight_y + 143)
		mSleep(500)
		tap(763, 1190)
		tap_till_skip(主设置)
		auto_combat()
		tap_till_skip(得到orb)
		tap(771, 1243)
		mSleep(500)
		tap_till_skip(故事模式抬头, nil, nil, 1000)
		if_fight_x, if_fight_y = myFindColor(章节感叹号)
	end
end
--]]
