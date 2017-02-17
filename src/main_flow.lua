function auto_combat()
  toast("自动战斗")
  state_transit(主设置, 设置1, 114, 1966)
  state_transit(设置1, 确认自动战斗, 757, 1048)
  tap(764, 1009)
end


function get_result()
  local star_result = {}
	local five_count = 0
  keepScreen(true)
  for pos = 1, 5, 1 do
    local five_star_x, five_star_y = findMultiColorInRegionFuzzy(0xfdf0a4,"2|0|0xfef2ac,4|0|0xfcf3af,6|0|0xc9b152,2|6|0xfcf2a9", 95, summon_result[pos][1], summon_result[pos][2], summon_result[pos][3], summon_result[pos][4])
    local four_star_x, four_star_y = findMultiColorInRegionFuzzy(0xc7d2d8,"-15|-5|0xe7ecef,-19|4|0x79929c,2|9|0xa2b5bd,12|-9|0xc9d4da",95, summon_result[pos][1], summon_result[pos][2], summon_result[pos][3], summon_result[pos][4])
    local three_star_x, three_star_y = findMultiColorInRegionFuzzy(0xab6743,"0|-9|0xb77f57,-7|-12|0xedc095,-4|2|0xd18e61,17|5|0x6a3f2c",95, summon_result[pos][1], summon_result[pos][2], summon_result[pos][3], summon_result[pos][4])
    if five_star_x > -1 then
      star_result[pos] = 5
			five_count = five_count + 1
    elseif four_star_x > -1 then
      star_result[pos] = 4
    elseif three_star_x > -1 then
      star_result[pos] = 3
    else
      star_result[pos] = 0
    end
  end
  printTable(star_result)
  keepScreen(false)
  return star_result, five_count
end


function 召唤一次(x,y)
	tap(x,y)
	mSleep(500)
	tap(783, 1832)
	mSleep(1000)
	tap_till_skip(重复召唤)
end


function link_account(inputText)
	myScreenShot()
	snapshot("1.png", 0,0,1444,2044); --全屏截图（分辨率1080*1920）
	state_transit(召唤结束, 游戏评价, 766, 1760)
	mSleep(1000)
	tap(768, 1169)
	mSleep(500)
	tap(1236, 1947)
	mSleep(1500)
	tap(770, 854)
	wait_for_state({0x92d6a9,"16|1|0x97d9ae,38|-2|0x8ad0a3,54|-2|0x8ad0a3",95,723,1257,787,1275})
	tap(780, 1221)
end


function reset()
	mark = createHUD()
	hideHUD(id)
	myCloseAPP("com.nintendo.zaba")
	myCloseAPP("com.officialscheduler.mterminal")
	myRunAPP("com.officialscheduler.mterminal")
	wait_for_state(命令完成)
	local x, y = myFindColor(命令完成)
	showHUD(mark,"等待脚本删除存档.",30,"0xff000000","0xff2deb33",0,0,0,1534,y-5)      --显示HUD内容
	inputText("su#ENTER#")
	wait_for_state(命令完成)
	inputText("alpine#ENTER#")
	wait_for_state(命令完成)
	x, y = myFindColor(命令完成)
	showHUD(mark,"等待脚本删除存档..",30,"0xff000000","0xff2deb33",0,0,0,1534,y-5)
	inputText('cd /var/mobile/Containers/Data/Application/ && rm "$(find . -name com.nintendo.zaba.plist -type f)"#ENTER#')
	wait_for_state(命令完成)
	x, y = myFindColor(命令完成)
	showHUD(mark,"等待脚本删除存档...",30,"0xff000000","0xff2deb33",0,0,0,1534,y-5)
	inputText("launchctl kickstart -k system/com.apple.cfprefsd.xpc.daemon#ENTER#")
	wait_for_state(命令完成)
	x, y = myFindColor(命令完成)
	showHUD(mark,"等待脚本删除存档....",30,"0xff000000","0xff2deb33",0,0,0,1534,y-5)
	myCloseAPP("com.officialscheduler.mterminal")
	mSleep(1000)
	hideHUD(mark)
	id = createHUD()
end


function main_flow()
	myRunAPP("com.nintendo.zaba")
  my_toast(id, '选择地区')
	keepScreen(true)
	local x_1, y_1 = myFindColor(开始游戏)
	local x_2, y_2 = myFindColor(select_country)
	keepScreen(false)
	while x_1 == -1 and x_2 == -1 do
		mSleep(200)
			keepScreen(true)
			x_1, y_1 = myFindColor(开始游戏)
			x_2, y_2 = myFindColor(select_country)
			keepScreen(false)
	end
	if x_1 > -1 then
		reset()
		return main_flow()
	end
  state_transit(select_country, 选好地区, 780, 590)
  my_toast(id, '选好地区')
  state_transit(选好地区, 用户协议, 777, 1702)
  my_toast(id, '用户协议')
  state_transit(用户协议, 稍后绑定, 762, 1362)
	my_toast(id, '稍后绑定')
  state_transit(稍后绑定, 开始游戏, 761, 1520)
	x_1, y_1 = myFindColor(开始下载)
	x_2, y_2 = myFindColor(下载结束)
	keepScreen(false)
	while x_1 == -1 and x_2 == -1 do
			tap(778, 1591)
			mSleep(500)
			keepScreen(true)
			x_1, y_1 = myFindColor(开始下载)
			x_2, y_2 = myFindColor(下载结束)
			keepScreen(false)
	end
	if x_1 > -1 then
		my_toast(id, '开始下载')
  		state_transit(开始下载, 下载结束, 795, 1255)
	else
		my_toast(id, '下载结束')
	end
  tap(786, 1161)
  mSleep(1000)
  tap_till_skip(跳过动画)
	my_toast(id, '跳过动画')
  state_transit(跳过动画, 确认名字, 766, 1011)
	my_toast(id, '确认名字')
  state_transit(确认名字, 跳过剧情, 776, 1295, true)
  tap(1324, 76)
  mSleep(1000)
	my_toast(id, '跳过剧情')
  wait_for_state(跳过剧情)
  tap(1324, 76)
  mSleep(1000)
	my_toast(id, '第一次滑动')
  swip(279, 1179, 672, 1186)
  mSleep(1000)
  tap_till_skip(第一章滑动)
	my_toast(id, '第二次滑动')
  mSleep(1000)
  swip(672, 1186, 1056, 990)
  tap_till_skip(第二章)
	my_toast(id, '第三次滑动')
  swip(275, 1369, 876, 1216)
  mSleep(500)
  tap_till_skip(主设置)
  if _G.if_canceld_anima then
  		my_toast(id, '检测是否关闭动画')
	  state_transit(主设置, 设置1, 114, 1966)
	  state_transit(设置1, 设置2, 763, 840)
	  --点击设置
	  
	  --取消动画
	  my_toast(id, '取消动画')
	  tap_till_skip(关闭动画1, 1005, 1383, 800)
	  tap_till_skip(关闭动画2, 1005, 1592, 800)

	  
	  my_toast(id, "退出设置")
	  state_transit(设置2, 主设置, 233, 247)
	  _G.if_canceld_anima = false
	end
  state_transit(主设置, 设置1, 114, 1966)
  my_toast(id, "自动战斗")
  state_transit(设置1, 确认自动战斗, 757, 1048)
  tap(764, 1009)
  tap_till_skip(得到orb)
	my_toast(id, "得到orb")
  state_transit(得到orb, 开始下载, 771, 1243)


	tap(795, 1255)
	my_toast(id, "正在下载")
	wait_for_state(故事模式抬头)
  my_toast(id, '下载完成')
	
	if _G.if_prologue == 0 then
		state_transit(prologue, prologue_part_1, 783, 683, true)
		my_toast(id, '开始刷3个球')
		wait_for_state(章节感叹号)
		local if_fight_x, if_fight_y = myFindColor(章节感叹号)
		for i = 1, 2, 1 do
			my_toast(id, '开始第'..i..'次战斗')
			if if_fight_x > -1 then
				tap(if_fight_x+373, if_fight_y + 143)
				mSleep(500)
				tap(763, 1190)
				tap_till_skip(主设置)
				auto_combat()
				tap_till_skip(得到orb)
				wait_for_leaving_state(得到orb, {true, 771, 1243})
				mSleep(500)
				tap_till_skip(故事模式抬头, nil, nil, 1000)
				wait_for_state(章节感叹号)
				if_fight_x, if_fight_y = myFindColor(章节感叹号)
			end
		end
		
		my_toast(id, '开始第3次战斗')
		tap(if_fight_x+373, if_fight_y + 143)
		mSleep(500)
		tap(763, 1190)
		tap_till_skip(主设置)
		auto_combat()
		tap_till_skip(得到orb)
		wait_for_leaving_state(得到orb, {true, 771, 1243})
		my_toast(id, '3次战斗已完成')
		tap_close_till_stop(故事模式抬头, nil, nil, 1000)
	end

  state_transit(故事模式退出, 得到orb, 278, 1949, true)
  my_toast(id, '得到奖励')
  wait_for_state(得到orb)
	tap_till_skip(邮件未读, 761, 1290)
	tap_till_skip(接受邮件, 1033, 602)
	tap_till_skip(收到物品, 756, 995)
	tap_till_skip(顶点退出, 762, 1101, 500)
	tap(244, 250)
	mSleep(1000)
  
  --开始召唤
  my_toast(id, "开始召唤")
  tap(859, 1936)
	tap_close_till_stop(初始召唤, nil, nil, 1000)
	tap(1473, 1002)
  mSleep(1000)
  tap(743, 1721)
	wait_for_state(Redeem)
  tap(750, 1103)
	wait_for_state(开始召唤)
	if _G.if_prologue == 0 then
		for i = 1, 4, 1 do
			my_toast(id, '召唤第'..i..'次')
			召唤一次(summon_list[i][1], summon_list[i][2])
			tap(952, 1841)
			wait_for_state(开始召唤)
		end
			my_toast(id, '召唤第5次')
			tap(summon_list[5][1],summon_list[5][2])
			mSleep(500)
			tap(783, 1832)
			mSleep(1000)
			tap_till_skip(召唤结束)
	else
		for i = 1, 3, 1 do
			my_toast(id, '召唤第'..i..'次')
			召唤一次(summon_list[i][1], summon_list[i][2])
			tap(952, 1841)
			wait_for_state(开始召唤)
		end
		my_toast(id, '召唤第4次')
		召唤一次(summon_list[4][1],summon_list[4][2])
	end
	result_table, five_star_count = get_result()
  if five_star_count < _G.end_condition then
    reset()
    return main_flow()
  else 
		if _G.if_prologue == 0 then
			choice = dialogRet("英雄星级:"..result_table[1]..", "..result_table[2]..", "..result_table[3]..", "..result_table[4]..", "..result_table[5].."; 是否重刷?", "是", "否", "", 0);
		else
			choice = dialogRet("英雄星级:"..result_table[1]..", "..result_table[2]..", "..result_table[3]..", "..result_table[4].."; 是否重刷?", "是", "否", "", 0);
		end
		if choice == 0 then
			reset()
			return main_flow()
		end
	end
end

