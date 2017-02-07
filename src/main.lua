init("0", 0)
-- com.nintendo.zaba
require "spec"
require "utils"

function tap_till_skip(end_state)
	local end_state = end_state or 跳过剧情
	local skip_x, skip_y = myFindColor(end_state)
	while skip_x == -1 do
		tap(780, 1402)
		mSleep(200)
		skip_x, skip_y = myFindColor(end_state)
	end
	tap(1324, 76)
end

function 召唤一次(x,y)
tap(x,y)
mSleep(500)
tap(783, 1832)
mSleep(1000)
tap_till_skip(重复召唤)
end

function myPressHomeKey()
	tap(1453, 1943)
	mSleep(500)
	tap(772, 1240)
	mSleep(500)
	tap(785, 1561)
	mSleep(500)
end

function reset()
	closeApp("com.nintendo.zaba");
	mSleep(2000)
	touchDown(0, 590, 1219)
	mSleep(2000)
	touchUp(0, 590, 1219)
	mSleep(500)
	tap(516, 1145)
	mSleep(500)
	tap(897, 1131)
	mSleep(500)
	myPressHomeKey()  --返回桌面
	tap(1298, 1905)
	mSleep(1500)
	tap(560, 732)
	sysLog('等待下载完成')
	wait_for_state(游戏下载完成)
	sysLog('游戏下载完成')
	runApp("com.nintendo.zaba")
end

function auto_combat()
toast("自动战斗")
state_transit(主设置, 设置1, 114, 1966)
state_transit(设置1, 确认自动战斗, 757, 1048)
tap(764, 1009)
end


function 一次战斗2()
tap(735, 680)
mSleep(500)
tap(763, 1182)  --fight!
tap_till_skip()
tap_till_skip()

wait_for_state(关闭三角)
tap(758, 1431)
auto_combat()
tap_till_skip(得到orb)
tap(771, 1243)
mSleep(500)
tap(770, 1401)
mSleep(500)
tap(770, 1401)
mSleep(500)
tap(770, 1401)
mSleep(500)
end

function 一次战斗3()
tap(735, 680)
mSleep(500)
tap(763, 1182)  --fight!
tap_till_skip()
auto_combat()
tap_till_skip()
tap_till_skip(得到orb)
tap(771, 1243)
mSleep(500)
tap(775, 1095)
mSleep(500)
tap(775, 1095)
mSleep(500)
tap(770, 1401)
mSleep(500)
tap(770, 1401)
mSleep(500)
end


function get_result()
	star_result = {}
	keepScreen(true)
	for pos = 1, 4, 1 do
		local five_star_x, five_star_y = findMultiColorInRegionFuzzy(0xfdf0a4,"2|0|0xfef2ac,4|0|0xfcf3af,6|0|0xc9b152,2|6|0xfcf2a9", 95, summon_result[pos][1], summon_result[pos][2], summon_result[pos][3], summon_result[pos][4])
		local four_star_x, four_star_y = findMultiColorInRegionFuzzy(0xc7d2d8,"-15|-5|0xe7ecef,-19|4|0x79929c,2|9|0xa2b5bd,12|-9|0xc9d4da",95, summon_result[pos][1], summon_result[pos][2], summon_result[pos][3], summon_result[pos][4])
		local three_star_x, three_star_y = findMultiColorInRegionFuzzy(0xab6743,"0|-9|0xb77f57,-7|-12|0xedc095,-4|2|0xd18e61,17|5|0x6a3f2c",95, summon_result[pos][1], summon_result[pos][2], summon_result[pos][3], summon_result[pos][4])
		if five_star_x > -1 then
			star_result[pos] = 5
		elseif four_star_x > -1 then
			star_result[pos] = 4
		elseif three_star_x > -1 then
			star_result[pos] = 3
		else
			star_result[pos] = 6
		end
	end
	printTable(star_result)
	keepScreen(false)
	return star_result
end


function main_flow()
	r = runApp("com.nintendo.zaba")
	mSleep(2 * 1000);  --等待程序响应
	if r == 0 then
	else
    toast("启动应用失败",3);
		runApp("com.nintendo.zaba")
	end
	wait_for_state(拒绝推送)
	mSleep(3000)
	toast('拒绝推送')
	state_transit(拒绝推送, select_country, 659, 1158)
	toast('选择地区')
	state_transit(select_country, 选好地区, 780, 590)
	toast('选好地区')
	state_transit(选好地区, 用户协议, 777, 1702)
	toast('用户协议')
	state_transit(用户协议, 稍后绑定, 762, 1362)
	state_transit(稍后绑定, 开始游戏, 761, 1520)
	state_transit(开始游戏, 开始下载, 778, 1591)
	state_transit(开始下载, 下载结束, 795, 1255)
	tap(786, 1161)
	mSleep(1000)
	tap_till_skip(跳过动画)
	state_transit(跳过动画, 确认名字, 766, 1011)
	state_transit(确认名字, 跳过剧情, 776, 1295, true)
	tap(1324, 76)
	mSleep(1000)
	wait_for_state(跳过剧情)
	tap(1324, 76)
	mSleep(1000)
	swip(279, 1179, 672, 1186)
	mSleep(1000)
	wait_for_state(跳过剧情)
	tap(1324, 76)
	mSleep(1000)
	swip(672, 1186, 1056, 990)
	tap_till_skip()


	mSleep(1000)
	wait_for_state(跳过剧情)
	tap(1324, 76)
	mSleep(1000)
	wait_for_state(跳过剧情)
	tap(1324, 76)
	mSleep(1000)
	wait_for_state(第二章)
	swip(275, 1369, 876, 1216)
	mSleep(500)
	tap_till_skip(主设置)
	state_transit(主设置, 设置1, 114, 1966)
	state_transit(设置1, 设置2, 763, 840)
	--点击设置

	--取消动画
	toast('取消动画')
	tap(1005, 1383)
	mSleep(500)
	tap(1005, 1383)
	mSleep(500)

	tap(1005, 1592)
	mSleep(500)
	tap(1005, 1592)
	mSleep(500)

	toast("退出设置")
	state_transit(设置2, 主设置, 233, 247)
	state_transit(主设置, 设置1, 114, 1966)
	toast("自动战斗")
	state_transit(设置1, 确认自动战斗, 757, 1048)
	tap(764, 1009)
	tap_till_skip()
	tap_till_skip()
	state_transit(得到orb, 开始下载, 771, 1243)
	state_transit(开始下载, {0xf1d0a4,"19|3|0xe4bb93,26|3|0xe3b892,52|-10|0x406276,39|33|0xc8476c,9|37|0xc9486b,-11|25|0xb1364f",95,186,372,279,457}, 795, 1255)
	mSleep(2000)
	--[[
	--打三场
	wait_for_state(作战章节)
	tap(735, 680)
	mSleep(500)
	tap(735, 680)
	mSleep(500)
	tap(763, 1182)  --fight!
	tap_till_skip()
	tap_till_skip()

	wait_for_state(关闭三角)
	tap(758, 1431)
	auto_combat()
	tap_till_skip()
	wait_for_state(得到orb)
	tap(771, 1243)
	mSleep(1000)
	tap(770, 1401)
	mSleep(1000)
	tap(770, 1401)
	mSleep(1000)
	tap(770, 1401)
	mSleep(1000)

	一次战斗2()
	一次战斗3()
	--]]
	sysLog('下载完成')
	--wait_for_state({0xf1d0a4,"19|3|0xe4bb93,26|3|0xe3b892,52|-10|0x406276,39|33|0xc8476c,9|37|0xc9486b,-11|25|0xb1364f",95,186,372,279,457})
	state_transit({0xf1d0a4,"19|3|0xe4bb93,26|3|0xe3b892,52|-10|0x406276,39|33|0xc8476c,9|37|0xc9486b,-11|25|0xb1364f",95,186,372,279,457}, 得到orb, 278, 1949, true)
	sysLog('得到球')
	wait_for_state(得到orb)
	tap(777, 1297)
	mSleep(1000)
	tap(777, 1297)
	mSleep(1000)
	tap(1095, 643)
	mSleep(1000)
	tap(1095, 643)
	mSleep(1000)
	tap(784, 609)
	mSleep(1000)
	tap(762, 1003)
	wait_for_state(收到物品)
	tap(785, 1111)
	mSleep(500)
	tap(244, 250)
	mSleep(1000)

	--开始召唤
	toast("开始召唤")
	tap(859, 1936)
	mSleep(500)
	tap(794, 1398)
	mSleep(1000)
	tap(1473, 1002)
	mSleep(1000)
	tap(743, 1721)
	mSleep(1000)
	tap(750, 1103)

	--召唤
	wait_for_state(开始召唤)

	for i = 1, 3, 1 do
		召唤一次(summon_list[i][1], summon_list[i][2])
		tap(952, 1841)
		wait_for_state(开始召唤)
	end
	召唤一次(summon_list[4][1],summon_list[4][2])
	--[[
	mSleep(500)
	tap(783, 1832)
	mSleep(1000)
	tap_till_skip({0x2c7d53,"17|0|0xffffff,36|1|0x2c7f53,56|0|0x0a1e32,73|-1|0x4a5967,93|-2|0x435362,112|-2|0xfcfcfc,162|-1|0xffffff,190|-2|0x2f7952,181|13|0x2b9658",95,652,1716,868,1789})
	--]]
	result_table = get_result()
	if result_table[1] <=4 and result_table[2] <= 4 and result_table[3] <= 4 and result_table[4] <= 4 then
		reset()
		return main_flow()
	end
	choice = dialogRet("英雄星级:"..result_table[1]..", "..result_table[2]..", "..result_table[3]..", "..result_table[4].."; 是否重刷?", "是", "否", "", 0);
	if choice == 0 then
		reset()
		return main_flow()
	end
end
main_flow()

