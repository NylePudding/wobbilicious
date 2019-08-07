pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
tms = {}
ps = {}
speed = 2
f = 0

function _init()
	poke(0x5f2c,3)
	
	--setup treadmills
	add_tm(8,8,"d")
	add_tm(8,16,"d")
	add_tm(8,24,"d")
	add_tm(8,32,"d")
	add_tm(8,40,"d")
	add_tm(8,48,"r")
	add_tm(16,48,"r")
	add_tm(24,48,"r")
	add_tm(32,48,"r")
	add_tm(40,48,"r")
	add_tm(48,48,"u")
	add_tm(48,40,"u")
	add_tm(48,32,"u")
	add_tm(48,24,"u")
	add_tm(48,16,"u")
	add_tm(48,8,"l")
	add_tm(40,8,"l")
	add_tm(32,8,"l")
	add_tm(24,8,"l")
	add_tm(16,8,"l")
	
	add_p(8,24,2)
	
end

function _update()
	f+=1
	cls()
	move_ps()
end

function _draw()
	draw_tm()
	draw_ps()
end

function draw_tm()
	for i=1,#tms,1 do
		local tm = tms[i]
		if (f%(30/10) == 0) then
			tm.a+=1
			if tm.a > 4 then
				tm.a = 1
			end
		end
		spr(tm.f[tm.a],tm.x,tm.y)
	end
end


function add_tm(x,y,d)
	local tm = {}
	tm.x=x
	tm.y=y
	tm.d=d
	tm.a=1
	if d=="r" then
		tm.f={6,5,4,3}
	elseif d=="l" then
		tm.f={3,4,5,6}
	elseif d=="d" then
		tm.f={19,20,21,22}
	elseif d=="u" then
		tm.f={22,21,20,19}
	end
	tms[#tms+1]=tm
end

function draw_ps()
	for i=1,#ps,1 do
		local p = ps[i]
		spr(p.f,p.x,p.y)
	end
end

function add_p(x,y,f)
	local p = {}
	p.x = x
	p.y = y
	p.f = f
	p.m = "d"
	ps[#ps+1]=p
end

function move_ps()
	for i=1,#ps,1 do
		local p = ps[i]
		local col = tm_col(p.x,p.y)
		
		if col != -1 then
			p.m = col
		end
		
		
		if (f%(30/10) == 0) then
			if p.m == "u" then
				p.y -= 1
			elseif p.m == "d" then
				p.y += 1
			elseif p.m == "l" then
				p.x -= 1
			elseif p.m == "r" then
				p.x += 1
			end
		end
	end
end

function tm_col(x,y)
	for i=1,#tms,1 do
		local tm=tms[i]
		local n = 0
		if x >= tm.x and 
		   x < tm.x + 8 and
		   y >= tm.y and
		   y < tm.y +8 then
			n+=1
		end
		
		if x + 7 >= tm.x and 
		   x + 7 < tm.x + 8 and
		   y >= tm.y and
		   y < tm.y +8 then
			n+=1
		end
		
		if x >= tm.x and 
		   x < tm.x + 8 and
		   y + 7 >= tm.y and
		   y + 7 < tm.y +8 then
			n+=1
		end
		
		if x + 7 >= tm.x and 
		   x + 7 < tm.x + 8 and
		   y + 7 >= tm.y and
		   y + 7 < tm.y +8 then
			n+=1
		end
		
		if n == 4 then
			return tm.d
		end
		
	end
	return -1
end

__gfx__
000000000000000000000000111d111d11d111d11d111d11d111d111000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000011d111d11d111d11d111d111111d111d000000000000000000000000000000000000000000000000000000000000000000000000
007007000000000000000000111d111d11d111d11d111d11d111d111000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000011d111d11d111d11d111d111111d111d000000000000000000000000000000000000000000000000000000000000000000000000
000770000000000007777770111d111d11d111d11d111d11d111d111000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000007777777711d111d11d111d11d111d111111d111d000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000007777770111d111d11d111d11d111d11d111d111000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000011d111d11d111d11d111d111111d111d000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000d1d1d1d111111111111111111d1d1d1d000000000000000000666600006666000066660000000000000000000000000000000000
0000000000000000077777701d1d1d1dd1d1d1d11111111111111111000000000000000006222260069999600611116000000000000000000000000000000000
000000000000000077777777111111111d1d1d1dd1d1d1d11111111100000000000000000688886006aaaa6006cccc6000000000000000000000000000000000
00000000000000006777777611111111111111111d1d1d1dd1d1d1d100000000000000000688886006aaaa6006cccc6000000000000000000000000000000000
000000000000000076666667d1d1d1d111111111111111111d1d1d1d000000000000000006688660066aa660066cc66000000000000000000000000000000000
0000000000000000677777761d1d1d1dd1d1d1d11111111111111111000000000000000000666600006666000066660000000000000000000000000000000000
000000000000000076666667111111111d1d1d1dd1d1d1d111111111000000000000000000066000000660000006600000000000000000000000000000000000
00000000000000000777777011111111111111111d1d1d1dd1d1d1d1000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000088000000aa000000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000088880000aaaa0000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000088880000aaaa0000cccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000788887007aaaa7007cccc700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007788887777aaaa7777cccc770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000777777007777770077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000099000000bb000000220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000099990000bbbb00002222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000099990000bbbb00002222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000799997007bbbb70072222700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000007799997777bbbb77772222770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000777777007777770077777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
