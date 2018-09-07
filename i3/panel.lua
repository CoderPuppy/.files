local uv = require 'luv'
local yajl = require 'yajl'
local ffi = require 'ffi'

print(yajl.to_string({
	version = 1;
	click_events = true;
}))
print('[')

local fg_icon = '#775759'
local fg_urgent = '#d17b49'
local function icon(icon)
	return { full_text = icon, color = fg_icon, separator = false, separator_block_width = 4 };
end

local function lpad(n, f, s)
	return f:rep(n - #s) .. s
end

local timed = {}
local timer_intvl = 10 * 1000
local timer = uv.new_timer()
uv.timer_start(timer, timer_intvl, timer_intvl, function()
	for i = 1, #timed do
		timed[i]()
	end
end)

local next_ticks = {}
local next_tick_h = uv.new_idle()
local function next_tick(fn)
	if #next_ticks == 0 then
		uv.idle_start(next_tick_h, function()
			local fns = next_ticks
			next_ticks = {}
			uv.idle_stop(next_tick_h)
			for i = 1, #fns do
				fns[i]()
			end
		end)
	end
	next_ticks[#next_ticks + 1] = fn
end

local comps = {}
local function add(comp)
	comps[comp.name] = comp
	comps[#comps + 1] = comp
	return comp
end
local output_scheded = false
local function sched_output()
	if output_scheded then return end
	output_scheded = true
	next_tick(function()
		output_scheded = false
		local res = {}
		for _, comp in ipairs(comps) do
			for _, part in ipairs(comp.output) do
				res[#res + 1] = part
			end
		end
		print(yajl.to_string(res) .. ',')
		io.flush()
	end)
end

do -- pianod
	local client = uv.new_tcp()
	local pianod = add {
		name = 'pianod';
		input = function(ev)
			if ev.instance == 'play' then
				uv.write(client, 'play\n')
			elseif ev.instance == 'pause' then
				uv.write(client, 'pause\n')
			elseif ev.instance == 'good' then
				uv.write(client, 'rate song 4\n')
			elseif ev.instance == 'neutral' then
				uv.write(client, 'rate song 3\n')
			elseif ev.instance == 'bad' then
				uv.write(client, 'rate song 2\n')
				uv.write(client, 'skip\n')
			end
		end;
		output = {};
	}
	uv.tcp_connect(client, '127.0.0.1', 4445, function(err)
		if err then
			uv.close(client)
			return
		end

		local state = {
			playing = false;
			stalled = false;
			song = nil;
			source = nil;
			playlist = nil;
		}
		local function update()
			local res = {
				{
					full_text = '';
					color = state.stalled and '#FF0000' or (state.playing and fg_urgent or fg_icon);
					name = 'pianod';
					instance = state.playing and 'pause' or 'play';
					separator = false;
					separator_block_width = 4;
				};
			}
			if state.song then
				res[#res + 1] = {
					full_text = (state.song.title or '') .. ' by ' .. (state.song.artist or '');
					separator = false;
					separator_block_width = 4;
				}
				res[#res + 1] = {
					full_text = state.song.rating == 'good' and '' or '';
					color = state.song.rating == 'good' and fg_urgent or fg_icon;
					separator = false;
					separator_block_width = 4;
					name = 'pianod';
					instance = state.song.rating == 'good' and 'neutral' or 'good';
				}
				res[#res + 1] = {
					full_text = '';
					color = fg_icon;
					name = 'pianod';
					instance = 'bad';
				}
			end
			pianod.output = res
			sched_output()
		end
		update()

		local buffer = ''
		uv.read_start(client, function(err, data)
			if err or not data then
				pianod.output = {}
				sched_output()
				uv.close(client)
				return
			end

			buffer = buffer .. data

			local pos = buffer:find('\n[^\n]*$')
			local parsing = buffer:sub(1, pos)
			buffer = buffer:sub(pos + 1)

			for code, data in parsing:gmatch('(%d+) ([^\n]*)\n') do
				code = tonumber(code)
				-- print(code, data)
				if code == 001 then
					state.playing = true
					state.stalled = false
					update()
				elseif code == 002 then
					state.playing = false
					state.stalled = false
					update()
				elseif code == 003 then
					state.stalled = true
					update()
				elseif code == 004 or code == 005 or code == 006 or code == 007 then
					state.playing = false
					state.stalled = false
					state.song = nil
					update()
				-- elseif code == 104 then
				-- 	state.playing = true
				-- 	state.stalled = false
				-- 	state.song = nil
				-- 	update()
				elseif code == 105 then
					state.song = nil
					update()
				elseif code == 011 then
					state.source = data:match('^SelectedSource: (.*)$')
					update()
				elseif code == 012 then
					state.playlist = data:match('^SelectedPlaylist: (.*)$')
					update()
				elseif code >= 111 and code <= 121 then
					if not state.song then state.song = {} end

					if code == 116 then
						state.song.rating = data:match('^Rating: ([^ ]+)')
					else
						local k, v = data:match('^([^:]+): (.*)$')
						state.song[k:gsub('(%l)(%u)', '%1_%2'):lower()] = v
						update()
					end
				end
			end
		end)
		
		uv.write(client, 'USER admin admin\n')
	end)
end

do --wifi
	ffi.cdef [[
		int iw_sockets_open();

		typedef int (*iw_enum_handler)(int	skfd, char *	ifname, char *	args[], int	count);
		void iw_enum_devices(int skfd, iw_enum_handler fn, char *args[], int count);

		struct	iw_param
		{
			int32_t		value;		/* The value of the parameter itself */
			uint8_t		fixed;		/* Hardware should not use auto select */
			uint8_t		disabled;	/* Disable the feature */
			uint16_t		flags;		/* Various specifc flags (if any) */
		};
		typedef struct wireless_config
		{
			char		name[16 + 1];	/* Wireless/protocol name */
			int		has_nwid;
			struct iw_param	nwid;			/* Network ID */
			int		has_freq;
			double	freq;			/* Frequency/channel */
			int		freq_flags;
			int		has_key;
			unsigned char	key[64];	/* Encoding key used */
			int		key_size;		/* Number of bytes */
			int		key_flags;		/* Various flags */
			int		has_essid;
			int		essid_on;
			char		essid[32 + 2];	/* ESSID (extended network) */
			int		essid_len;
			int		has_mode;
			int		mode;			/* Operation mode */
		} wireless_config;
		int iw_get_basic_config(int skfd, const char *ifname, wireless_config *info);
	]]
	local iw = ffi.load 'iw'

	local skfd = iw.iw_sockets_open()
	local ifname

	local wifi = add {
		name = 'wifi';
		input = function() end;
		output = {};
	}
	local basic = ffi.new('struct wireless_config')
	local function search_if()
		iw.iw_enum_devices(skfd, function(skfd, name, args, count)
			if not ifname and iw.iw_get_basic_config(skfd, name, basic) > -1 then
				ifname = ffi.string(name)
			end
			return 0
		end, nil, 0)
	end
	local function update()
		if not ifname then search_if() end
		if ifname then
			if iw.iw_get_basic_config(skfd, ifname, basic) == -1 then
				error('couldn\'t get data from: ' .. ffi.string(ifname))
			end
			wifi.output = {
				icon('');
				{ full_text = (basic.has_essid ~= 0) and ffi.string(basic.essid) or 'none' };
			}
			sched_output()
		end
	end
	update()
	timed[#timed + 1] = update
end

do -- battery
	local battery = add {
		name = 'battery';
		input = function() end;
		output = {};
	}

	local function update()
		local h = io.open('/sys/class/power_supply/BAT0/uevent', 'r')

		if h then
			local t = {}
			while true do
				local line = h:read('*l')
				if not line then break end
				local k, v = line:match('^POWER_SUPPLY_([^=]+)=(.*)$')
				t[k:lower()] = v
			end
			h:close()

			local amt = tonumber(t.energy_now) / tonumber(t.energy_full)

			local time, hours, minutes
			local rest
			if t.status == 'Discharging' then
				rest = tonumber(t.energy_now)
			elseif t.status == 'Charging' then
				rest = tonumber(t.energy_full) - tonumber(t.energy_now)
			end
			if rest and t.power_now and t.power_now ~= '0' then
				time = rest / tonumber(t.power_now)
				hours = math.floor(time)
				minutes = math.floor((time - hours) * 60)
			end

			local icon_
			if t.status ~= 'Discharging' then
				icon_ = ''
			elseif amt < 0.1 then
				icon_ = ''
			elseif amt < 0.4 then
				icon_ = ''
			elseif amt < 0.7 then
				icon_ = ''
			else
				icon_ = ''
			end

			local res = {
				icon(icon_);
				{ full_text = string.format('%d%%', math.floor(amt * 100 + 0.5)) };
			}
			if time then
				res[#res + 1] = { full_text = string.format('%d:%02d', hours, minutes) }
			end
			battery.output = res
		else
			battery.output = {}
		end
		sched_output()
	end
	update()

	local acpid_pipe = uv.new_pipe(false)
	uv.pipe_connect(acpid_pipe, '/var/run/acpid.socket', function(err)
		if err then error(err) end

		uv.read_start(acpid_pipe, function(err, data)
			if err then error(err) end

			update()
		end)
	end)

	timed[#timed + 1] = update
end

do -- date
	local date = add {
		name = 'date';
		input = function() end;
		output = {};
	}
	local function update()
		date.output = {
			icon('');
			{ full_text = os.date('%H:%M %b %d %a') };
		}
		sched_output()
	end
	update()
	timed[#timed + 1] = update
end

--[[
do -- fake date
	local fake_date = add {
		name = 'fake_date';
		input = function() end;
		output = {};
	}
	local function update()
		local min = tonumber(os.date('%M'))
		local hour = tonumber(os.date('%H'))
		local fake
		if min == 0 then
			fake = '00:' .. lpad(2, '0', tostring(hour))
		else
			hour = hour + 1
			if hour == 24 then
				hour = 0
			end
			fake = lpad(2, '0', tostring(60 - min)) .. ':' .. lpad(2, '0', tostring(hour))
		end
		fake_date.output = {
			icon('');
			{ full_text = fake .. os.date(' %b %d %a') };
		}
		sched_output()
	end
	update()
	timed[#timed + 1] = update
end --]]

do
	local tmp
	local stack = {}
	local obj_key
	-- TODO: betterify
	local events = {
		value = function(_, val)
			stack[#stack](val)
		end;
		open_array = function()
			if #stack == 0 then
				table.insert(stack, function(val)
					tmp = val
				end)
			else
				local arr = {}
				stack[#stack](arr)
				table.insert(stack, function(val)
					table.insert(arr, val)
				end)
			end
		end;
		open_object = function()
			local obj = {}
			stack[#stack](obj)
			table.insert(stack, function(val)
				obj[obj_key] = val
			end)
		end;
		object_key = function(_, val)
			obj_key = val
		end;
		close = function()
			stack[#stack] = nil
			if #stack == 1 then
				if tmp.name then
					comps[tmp.name].input(tmp)
				end
			end
		end;
	}

	local parser = yajl.parser { events = events }

	local stdin = uv.new_tty(0, true)
	uv.read_start(stdin, function(err, data)
		if err then error(err) end

		parser(data)
	end)
end

uv.run()
