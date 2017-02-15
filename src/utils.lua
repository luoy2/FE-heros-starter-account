-- 作者yluo37
-- 时间: 2016-12-28



function myFindColor(input_table)
	if input_table == nil then
		return -1, -1
	else
		local x, y = findMultiColorInRegionFuzzy(input_table[1], input_table[2], input_table[3], input_table[4], input_table[5], input_table[6], input_table[7])
		return x, y
	end
end

function toast_screensize()
  width,height = getScreenSize()
  if (width == 960 and height== 640 )or (width==640 and height==960 ) 		then--4
    device_type="4"
  elseif (width == 640 and height== 1136 )or (width==1136 and height==640 ) 		then--5
    device_type="5"
  elseif(width==750 and height==1334 )or (width==1334 and height==750 ) 		then--6
    device_type="6"
  elseif(width==1242 and height==2208 )or (width==2208 and height==1242) 	then--6p
    device_type="6p"
  elseif(width==1024 and height==768 )or (width==768 and height==1024 ) 		then--2
    device_type="ipad2"
  elseif(width==2048 and height==1536 )or (width==1536 and height==2048 ) 	then--4
    device_type="ipad4"
  else
    toast("暂不支持此设备,sorry~") --暂不支持此设备
    lua_exit()
  end
  toast(device_type)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function printTable(t)
for key,value in pairs(t) do sysLog(key..': '..value) end
end


function my_toast(id, my_string)
  --showHUD(id, my_string ,50,"0xffffffff",'hud2.png',0,100,95,600,78)    
	showHUD(id, my_string ,35,"0xffffffff",'hud.png',0,100,95,600,78)    
end




function my_exist(lock)
  if lock == true then
    lockDevice()
    lua_exit()
  else
    lua_exit();
  end
end




function sleepRandomLag(default)
  lag = math.random(default-100,default+100)
  mSleep(lag)
end

-- 格式化输出
function sysLogFmt(fmt, ...)
  sysLog(string.format(fmt, ...))
end

-- 任意输出
function sysLogLst(...)
  local msg = ''
  for k,v in pairs({...}) do
    msg = string.format('%s %s ', msg, tostring(v))
  end
  sysLog(msg)
end

function tap(x, y)
  math.randomseed(tostring(os.time()):reverse():sub(1, 6))  --设置随机数种子
  local index = math.random(1,5)
  local rand_x = x + math.random(-2,2)
  local rand_y = y + math.random(-2,2)
  touchDown(index,rand_x, rand_y)
  mSleep(math.random(60,80))                --某些特殊情况需要增大延迟才能模拟点击效果
  touchUp(index, rand_x, rand_y)
	--sysLog(lag_x)
end

-- 模拟滑动操作，从点(x1, y1)划到到(x2, y2)
function swip(x1,y1,x2,y2)
  local step, x, y, index = 20, x1 , y1, 0
  touchDown(index, x, y)
  
  local function move(from, to) 
    if from > to then
      do 
        return -1 * step 
      end
    else 
      return step 
    end 
  end
  
  while (math.abs(x-x2) >= step) or (math.abs(y-y2) >= step) do
    if math.abs(x-x2) >= step then x = x + move(x1,x2) end
    if math.abs(y-y2) >= step then y = y + move(y1,y2) end
    touchMove(index, x, y)
    mSleep(20)
  end
  
  touchMove(index, x2, y2)
  mSleep(30)
  touchUp(index, x2, y2)
end
function my_swip_2(x1, y1, x2, y2, sleep1, sleep2, step)
		local new = pos:new(x1, y1)
		local move = {x=x2, y=y2}
		local step = step or 10
		local sleep1 = sleep1 or 200
		local sleep2 = sleep2 or 40
		new:touchMoveTo(move,step,sleep1,sleep2)
end

function my_swip(x1, y1, x2, y2, speed)
	local new = pos:new(x1, y1)
	local move = {x=x2, y=y2}
	local step = 28
	local sleep1,sleep2 = 500,20
	new:touchMoveTo(move,step,sleep1,sleep2)
end

--分割@字符串函数
function str_split(input_str)
  output_table = {}
  for word in string.gmatch(input_str, '([^@]+)') do
    table.insert(output_table,tonumber(word))
  end
  return output_table
end

-- 多点颜色对比，格式为{{x,y,color},{x,y,color}...} 
function cmpColor(array, s, isKeepScreen)
  s = s or 90
  s = math.floor(0xff * (100 - s) * 0.01)
  isKeepScreen = isKeepScreen or false
  
  local lockscreen = function(flag)
    if isKeepScreen == true then
      keepScreen(flag)
    end
  end
  
  lockscreen(true)
  for i = 1, #array do
    local lr,lg,lb = getColorRGB(array[i][1], array[i][2])
    local rgb = array[i][3]
    
    local r = math.floor(rgb/0x10000)
    local g = math.floor(rgb%0x10000/0x100)
    local b = math.floor(rgb%0x100)
    
    if math.abs(lr-r) > s or math.abs(lg-g) > s or math.abs(lb-b) > s then
      lockscreen(false)
      return false
    end
  end
  
  lockscreen(false)
  return true
end


--switch function, used for switch cases
function switch(t)
  t.case = function (self,x)
    local f=self[x] or self.default
    if f then
      if type(f)=="function" then
        f(x,self)
      else
        error("case "..tostring(x).." not a function")
      end
    end
  end
  return t
end




--[[
a = switch {
  [1] = function (x) print(x,10) end,
  [2] = function (x) print(x,20) end,
  default = function (x) print(x,0) end,
}

input:
a:case(2)  -- ie. call case 2 
a:case(9)

output:
2	20
9	0
--]]


function getKeysSortedByValue(tbl, sortFunction)
  local keys = {}
  for key in pairs(tbl) do
    table.insert(keys, key)
  end
  table.sort(keys, function(a, b)
  return sortFunction(tbl[a], tbl[b])
end)

return keys
end




ColorCheck = {}
function ColorCheck:new_ColorCheckSystem(rigion,point_tab,n,p)
	local o = {};
	setmetatable(o,self); self.__index = self;
	
	local function get_ColorCheckF(rigion,point_tab,n,p)
		local p = p or 1
		local n = n or 5 --5
		local tab = {}
		local point_tab = point_tab
		if not point_tab then
			local x1,y1,x2,y2 = rigion[1][1], rigion[1][2],rigion[2][1], rigion[2][2]
			point_tab = {}
			local math_random = math.random
			for i = 1, n do
				table.insert(point_tab,{math_random(x1,x2),math_random(y1,y2)})
			end
		end
		for k, v in ipairs(point_tab) do
			local x, y = point_tab[k][1], point_tab[k][2]
			table.insert(tab,{x-p,y-p,x+p,y+p,getColor(x,y)})
		end
		action = function()
			keepScreen(true) 
			for i = 1,#tab do 
				local x,y = findColorInRegionFuzzy(tab[i][5],95,tab[i][1],tab[i][2],tab[i][3],tab[i][4]) 
				if x == -1 then keepScreen(false) return false end 
			end; keepScreen(false)
			return true
		end
		return action
	end
	
	o.ColorCheckF = get_ColorCheckF(rigion,point_tab,n,p)
	o.re_check = function() return get_ColorCheckF(rigion,point_tab,n,p) end
	
	function o:DelayCheck(t)
		if not self.reTime then self.reTime = os.time() end
		local t0 = os.time() - self.reTime
		if t0 > t then
			self.reTime = os.time()
			return true
		end
	end

	function o:ColorCheck_TF()
		local ColorCheckF = self.ColorCheckF
		if ColorCheckF() then 
			return true
		else 
			self.ColorCheckF = self.re_check()
			return false
		end
	end
	local o_ = {}
	setmetatable(o_,o); o.__index = o;
	return o_;
end



function wait_for_state(input_table, limit_seconds)
	local limit_seconds = limit_seconds or 99999999999
	local qTime = mTime()
	local wait_x, wait_y = myFindColor(input_table)
	while (mTime() - qTime) <= limit_seconds do
		mSleep(100)
		--sysLog(mTime() - qTime)
		wait_x, wait_y = myFindColor(input_table)
		if wait_x ~= -1 then
			return true
		end
	end
	return false
end

function wait_for_leaving_state(input_table, tap_table)
	local tap_table = tap_table or {false}
	local wait_x, wait_y = myFindColor(input_table)
	--sysLog(wait_x)
	while wait_x > -1 do
		if tap_table[1] then
			tap(tap_table[2], tap_table[3])
		end
		keepScreen(false)
		--sysLog(wait_x)
		mSleep(100)
		wait_x, wait_y = myFindColor(input_table)
	end
end


function state_transit(state_1, state_2, x, y, if_tap)
	local if_tap = if_tap or false
	--sysLog(tostring(if_tap))
	wait_for_state(state_1)
	tap(x, y)
	mSleep(500)
	if if_tap then
		sysLog('need tap to transit state')
		local state_2x, state_2y = myFindColor(state_2)
		sysLog(state_2x)
		while state_2x == -1 do
			sysLog('taping')
			tap(x, y)
			mSleep(1000)
			state_2x, state_2y = myFindColor(state_2)
		end
	end
	wait_for_state(state_2)
end






function waiting_clock(wait_time)
	local qTime = mTime()
	local time_passed = mTime() - qTime
	local need_wait = (wait_time - time_passed)/1000
	local output_s = string.format("%.2d:%.2d:%.2d", need_wait/(60*60), need_wait/60%60, need_wait%60)
	while time_passed <= wait_time do
		my_toast(id, '需要等待'..output_s)
		mSleep(1000)
		time_passed = mTime() - qTime
		need_wait = (wait_time - time_passed)/1000
		output_s = string.format("%.2d:%.2d:%.2d", need_wait/(60*60), need_wait/60%60, need_wait%60)
	end
end


function tap_till_skip(end_state, tap_x, tap_y, lag)
	local tap_x = tap_x or 780
	local tap_y = tap_y or 1402
	local lag = lag or 300
  local end_state = end_state or 跳过剧情
	keepScreen(true)
  local skip_x, skip_y = myFindColor(end_state)
	local skip_x_2, skip_y_2 = myFindColor(跳过剧情)
	keepScreen(false)
  while skip_x == -1 do
    tap(tap_x, tap_y)
    mSleep(lag)
		if skip_x_2 > -1 then
			tap(1324, 76)
		end
		keepScreen(true)
    skip_x, skip_y = myFindColor(end_state)
		skip_x_2, skip_y_2 = myFindColor(跳过剧情)
		keepScreen(false)
  end
end

function myPressHomeKey()
	mSleep(1000)
	tap(1453, 1943)
  mSleep(1000)
  tap(772, 1240)
  mSleep(1000)
  tap(785, 1561)
  mSleep(1000)
end




function myScreenShot()
  tap(1453, 1943)
  mSleep(500)
  tap(978, 909)
  mSleep(500)
  tap(903, 1232)
  mSleep(500)
  tap(1016, 1109)
end


