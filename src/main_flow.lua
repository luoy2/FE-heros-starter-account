
function reset()
	closeApp("com.nintendo.zaba")
  delete_game()
  my_toast(id, '准备下载游戏')
  tap(1298, 1905)
  wait_for_state(游戏可以下载)
  tap(560, 732)
  sysLog('等待下载完成')
  my_toast(id, '正在下载游戏')
  wait_for_state(游戏下载完成)
  my_toast(id, '游戏下载完成')
  sysLog('游戏下载完成')
	mSleep(1000)
	runApp("com.nintendo.zaba")
end


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



function main_flow()
	if _G.ios > 8 then
		my_toast(id, '拒绝推送')
		state_transit(拒绝推送, select_country, 659, 1158, true)
	end
  my_toast(id, '选择地区')
  state_transit(select_country, 选好地区, 780, 590)
  my_toast(id, '选好地区')
  state_transit(选好地区, 用户协议, 777, 1702)
  my_toast(id, '用户协议')
  state_transit(用户协议, 稍后绑定, 762, 1362)
	my_toast(id, '稍后绑定')
  state_transit(稍后绑定, 开始游戏, 761, 1520)
	my_toast(id, '开始游戏')
  state_transit(开始游戏, 开始下载, 778, 1591)
	my_toast(id, '开始下载')
  state_transit(开始下载, 下载结束, 795, 1255)
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
  state_transit(主设置, 设置1, 114, 1966)
  state_transit(设置1, 设置2, 763, 840)
  --点击设置
  
  --取消动画
  my_toast(id, '取消动画')
  tap(1005, 1383)
  mSleep(500)
  tap(1005, 1383)
  mSleep(500)
  
  tap(1005, 1592)
  mSleep(500)
  tap(1005, 1592)
  mSleep(500)
  
  my_toast(id, "退出设置")
  state_transit(设置2, 主设置, 233, 247)
  state_transit(主设置, 设置1, 114, 1966)
  my_toast(id, "自动战斗")
  state_transit(设置1, 确认自动战斗, 757, 1048)
  tap(764, 1009)
  tap_till_skip(得到orb)
	my_toast(id, "得到orb")
  state_transit(得到orb, 开始下载, 771, 1243)
	tap(795, 1255)
	my_toast(id, "正在下载")
	mSleep(60000)
	wait_for_state(故事模式抬头)
  my_toast(id, '下载完成')
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
			tap(771, 1243)
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
	tap(771, 1243)
	mSleep(500)
	my_toast(id, '3次战斗已完成')
	tap(765, 1101)				--解锁新章节
	mSleep(1000)
	tap(765, 1101)

	tap_till_skip(故事模式抬头, nil, nil, 1000)


  state_transit(故事模式退出, 得到orb, 278, 1949, true)
  my_toast(id, '得到奖励')
  wait_for_state(得到orb)
	tap_till_skip(邮件未读, 761, 1290)
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
  my_toast(id, "开始召唤")
  tap(859, 1936)
  mSleep(500)
  tap(794, 1398)
  mSleep(1000)
  tap(1473, 1002)
  mSleep(1000)
  tap(743, 1721)
  mSleep(1000)
  tap(750, 1103)
	wait_for_state(开始召唤)
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
	result_table, five_star_count = get_result()
	result_table = get_result()
  if five_star_count < _G.end_condition then
    reset()
    return main_flow()
  else 
		--link_account()
				--[[
		lockDevice()
		lua_exit()
		--]]
		choice = dialogRet("英雄星级:"..result_table[1]..", "..result_table[2]..", "..result_table[3]..", "..result_table[4]..", "..result_table[5].."; 是否重刷?", "是", "否", "", 0);
		if choice == 0 then
			reset()
			return main_flow()
		end
	end
end


function delete_game()
  my_toast(id, '正在寻找游戏位置')
  local game_x, game_y = myFindColor(游戏图标)
  sysLog(game_x..","..game_y)
  if game_x > -1 then
    my_toast(id, '找到游戏位置')
    touchDown(0, game_x, game_y)
    mSleep(2000)
    touchUp(0, game_x, game_y)
    mSleep(1000)
    tap(game_x-77, game_y-70)
    mSleep(1000)
		wait_for_state({0xc6ddeb,"15|5|0xc7deeb,34|4|0xc6ddeb",95,596,1083,662,1108})
    if _G.ios == 10 then
      tap(897, 1131)
    else
      tap(631, 1130)
			if _G.ios == 8 then
				mSleep(500)
				tap(631, 1130)
			end
    end
    mSleep(500)
    myPressHomeKey()  --返回桌面
  else
    my_toast(id, '未找到游戏图标!请于5秒内切换到游戏图标页面')
    mSleep(1000)
    my_toast(id, '未找到游戏图标!请于4秒内切换到游戏图标页面')
    mSleep(1000)
    my_toast(id, '未找到游戏图标!请于3秒内切换到游戏图标页面')
    mSleep(1000)
    my_toast(id, '未找到游戏图标!请于2秒内切换到游戏图标页面')
    mSleep(1000)
    my_toast(id, '未找到游戏图标!请于1秒内切换到游戏图标页面')
    mSleep(1000)
    return delete_game()
  end
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