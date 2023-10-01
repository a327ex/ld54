-- [yue]: ..\main.yue
require('anchor') -- 1
init = function() -- 4
	main:init({ -- 6
		title = 'M8B1674-00D4', -- 6
		theme = 'twitter_emoji', -- 6
		web = true, -- 6
		w = 480, -- 6
		h = 480, -- 6
		sx = 2, -- 6
		sy = 2 -- 6
	}) -- 6
	bg, bg2, game, fg, ui = layer(), layer(), layer(), layer() -- 7
	font = font('assets/monogram.ttf', 16, 'mono') -- 8
	grid_marker_color = colors.bg[0]:color_clone() -- 10
	grid_marker_color.a = 0.08 -- 11
	grid_pointer_ok_color = colors.green[0]:color_clone() -- 12
	grid_pointer_ok_color.a = 0.32 -- 13
	grid_pointer_not_ok_color = colors.red[0]:color_clone() -- 14
	grid_pointer_not_ok_color.a = 0.32 -- 15
	grid_solid_color = colors.bg[0]:color_clone() -- 16
	grid_solid_color.a = 0.64 -- 17
	player_score = 0 -- 19
	player_counter = 0 -- 20
	round_started = false -- 21
	main:observer_condition((function() -- 24
		return player_counter >= 25 -- 24
	end), (function() -- 24
		reset_grid() -- 25
		game_over = true -- 26
		round_started = false -- 27
		set_text(2, 4, 'GAME OVER') -- 28
		set_text(2, 5, "SCORE:" .. tostring(player_score)) -- 29
		return set_text(2, 6, 'left click to restart') -- 30
	end)) -- 24
	objects = container() -- 33
	main:physics_world_set_collision_tags({ -- 34
		'cell', -- 34
		'generation_collider' -- 34
	}) -- 34
	main:physics_world_disable_collision_between('cell', { -- 35
		'cell', -- 35
		'generation_collider' -- 35
	}) -- 35
	main:physics_world_enable_trigger_between('cell', { -- 36
		'generation_collider' -- 36
	}) -- 36
	shapes = { -- 41
		short_t = { -- 42
			{ -- 42
				{ -- 42
					0, -- 42
					0 -- 42
				}, -- 42
				{ -- 42
					0, -- 42
					-1 -- 42
				}, -- 42
				{ -- 42
					0, -- 42
					1 -- 42
				}, -- 42
				{ -- 42
					1, -- 42
					0 -- 42
				} -- 42
			}, -- 42
			{ -- 43
				{ -- 43
					0, -- 43
					0 -- 43
				}, -- 43
				{ -- 43
					-1, -- 43
					0 -- 43
				}, -- 43
				{ -- 43
					1, -- 43
					0 -- 43
				}, -- 43
				{ -- 43
					0, -- 43
					1 -- 43
				} -- 43
			}, -- 43
			{ -- 44
				{ -- 44
					0, -- 44
					0 -- 44
				}, -- 44
				{ -- 44
					0, -- 44
					-1 -- 44
				}, -- 44
				{ -- 44
					0, -- 44
					1 -- 44
				}, -- 44
				{ -- 44
					-1, -- 44
					0 -- 44
				} -- 44
			}, -- 44
			{ -- 45
				{ -- 45
					0, -- 45
					0 -- 45
				}, -- 45
				{ -- 45
					-1, -- 45
					0 -- 45
				}, -- 45
				{ -- 45
					1, -- 45
					0 -- 45
				}, -- 45
				{ -- 45
					0, -- 45
					-1 -- 45
				} -- 45
			} -- 45
		}, -- 41
		long_t = { -- 48
			{ -- 48
				{ -- 48
					0, -- 48
					0 -- 48
				}, -- 48
				{ -- 48
					0, -- 48
					-1 -- 48
				}, -- 48
				{ -- 48
					0, -- 48
					1 -- 48
				}, -- 48
				{ -- 48
					1, -- 48
					0 -- 48
				}, -- 48
				{ -- 48
					2, -- 48
					0 -- 48
				} -- 48
			}, -- 48
			{ -- 49
				{ -- 49
					0, -- 49
					0 -- 49
				}, -- 49
				{ -- 49
					-1, -- 49
					0 -- 49
				}, -- 49
				{ -- 49
					1, -- 49
					0 -- 49
				}, -- 49
				{ -- 49
					0, -- 49
					1 -- 49
				}, -- 49
				{ -- 49
					0, -- 49
					2 -- 49
				} -- 49
			}, -- 49
			{ -- 50
				{ -- 50
					0, -- 50
					0 -- 50
				}, -- 50
				{ -- 50
					0, -- 50
					-1 -- 50
				}, -- 50
				{ -- 50
					0, -- 50
					1 -- 50
				}, -- 50
				{ -- 50
					-1, -- 50
					0 -- 50
				}, -- 50
				{ -- 50
					-2, -- 50
					0 -- 50
				} -- 50
			}, -- 50
			{ -- 51
				{ -- 51
					0, -- 51
					0 -- 51
				}, -- 51
				{ -- 51
					-1, -- 51
					0 -- 51
				}, -- 51
				{ -- 51
					1, -- 51
					0 -- 51
				}, -- 51
				{ -- 51
					0, -- 51
					-1 -- 51
				}, -- 51
				{ -- 51
					0, -- 51
					-2 -- 51
				} -- 51
			} -- 51
		}, -- 47
		short_i = { -- 54
			{ -- 54
				{ -- 54
					0, -- 54
					0 -- 54
				}, -- 54
				{ -- 54
					1, -- 54
					0 -- 54
				}, -- 54
				{ -- 54
					2, -- 54
					0 -- 54
				} -- 54
			}, -- 54
			{ -- 55
				{ -- 55
					0, -- 55
					0 -- 55
				}, -- 55
				{ -- 55
					0, -- 55
					1 -- 55
				}, -- 55
				{ -- 55
					0, -- 55
					2 -- 55
				} -- 55
			}, -- 55
			{ -- 56
				{ -- 56
					0, -- 56
					0 -- 56
				}, -- 56
				{ -- 56
					-1, -- 56
					0 -- 56
				}, -- 56
				{ -- 56
					-2, -- 56
					0 -- 56
				} -- 56
			}, -- 56
			{ -- 57
				{ -- 57
					0, -- 57
					0 -- 57
				}, -- 57
				{ -- 57
					0, -- 57
					-1 -- 57
				}, -- 57
				{ -- 57
					0, -- 57
					-2 -- 57
				} -- 57
			} -- 57
		}, -- 53
		long_i = { -- 60
			{ -- 60
				{ -- 60
					0, -- 60
					0 -- 60
				}, -- 60
				{ -- 60
					1, -- 60
					0 -- 60
				}, -- 60
				{ -- 60
					2, -- 60
					0 -- 60
				}, -- 60
				{ -- 60
					3, -- 60
					0 -- 60
				} -- 60
			}, -- 60
			{ -- 61
				{ -- 61
					0, -- 61
					0 -- 61
				}, -- 61
				{ -- 61
					0, -- 61
					1 -- 61
				}, -- 61
				{ -- 61
					0, -- 61
					2 -- 61
				}, -- 61
				{ -- 61
					0, -- 61
					3 -- 61
				} -- 61
			}, -- 61
			{ -- 62
				{ -- 62
					0, -- 62
					0 -- 62
				}, -- 62
				{ -- 62
					-1, -- 62
					0 -- 62
				}, -- 62
				{ -- 62
					-2, -- 62
					0 -- 62
				}, -- 62
				{ -- 62
					-3, -- 62
					0 -- 62
				} -- 62
			}, -- 62
			{ -- 63
				{ -- 63
					0, -- 63
					0 -- 63
				}, -- 63
				{ -- 63
					0, -- 63
					-1 -- 63
				}, -- 63
				{ -- 63
					0, -- 63
					-2 -- 63
				}, -- 63
				{ -- 63
					0, -- 63
					-3 -- 63
				} -- 63
			} -- 63
		}, -- 59
		short_t = { -- 66
			{ -- 66
				{ -- 66
					0, -- 66
					0 -- 66
				}, -- 66
				{ -- 66
					0, -- 66
					-1 -- 66
				}, -- 66
				{ -- 66
					0, -- 66
					1 -- 66
				}, -- 66
				{ -- 66
					1, -- 66
					0 -- 66
				} -- 66
			}, -- 66
			{ -- 67
				{ -- 67
					0, -- 67
					0 -- 67
				}, -- 67
				{ -- 67
					-1, -- 67
					0 -- 67
				}, -- 67
				{ -- 67
					1, -- 67
					0 -- 67
				}, -- 67
				{ -- 67
					0, -- 67
					1 -- 67
				} -- 67
			}, -- 67
			{ -- 68
				{ -- 68
					0, -- 68
					0 -- 68
				}, -- 68
				{ -- 68
					0, -- 68
					-1 -- 68
				}, -- 68
				{ -- 68
					0, -- 68
					1 -- 68
				}, -- 68
				{ -- 68
					-1, -- 68
					0 -- 68
				} -- 68
			}, -- 68
			{ -- 69
				{ -- 69
					0, -- 69
					0 -- 69
				}, -- 69
				{ -- 69
					-1, -- 69
					0 -- 69
				}, -- 69
				{ -- 69
					1, -- 69
					0 -- 69
				}, -- 69
				{ -- 69
					0, -- 69
					-1 -- 69
				} -- 69
			} -- 69
		} -- 65
	} -- 40
	main_grid = grid(24, 24, 0) -- 74
	cell_w, cell_h = main.w / main_grid.w, main.h / main_grid.h -- 75
	for i = 1, main_grid.w do -- 76
		for j = 1, main_grid.h do -- 77
			main_grid:grid_set(i, j, cell(i, j)) -- 78
		end -- 78
	end -- 78
	return generate_arena() -- 79
end -- 4
get_next_pointer_shape = function() -- 81
	local shapes = { -- 82
		'short_t', -- 82
		'long_t', -- 82
		'short_i', -- 82
		'long_i' -- 82
	} -- 82
end -- 81
update = function(dt) -- 85
	if main:input_is_pressed('f11') then -- 86
		love.event.restart() -- 86
	end -- 86
	if round_started then -- 87
		player_counter = player_counter + 0.75 * dt -- 88
		set_bottom_counter(player_counter) -- 89
	end -- 87
	if main:input_is_pressed('2') then -- 90
		pointer_shape_rotation = pointer_shape_rotation + 1 -- 91
		if pointer_shape_rotation == 5 then -- 92
			pointer_shape_rotation = 1 -- 92
		end -- 92
	end -- 90
	for i = 2, main_grid.w - 1 do -- 95
		for j = 2, main_grid.h - 1 do -- 96
			local cell = main_grid:grid_get(i, j) -- 97
			cell.pointer_cell_ok = false -- 98
			cell.pointer_cell_not_ok = false -- 99
		end -- 99
	end -- 99
	local x, y = math.ceil(main.pointer.x / cell_w), math.ceil(main.pointer.y / cell_h) -- 102
	local any_cell_not_ok = false -- 103
	local current_cells = { } -- 104
	if pointer_shape and round_started then -- 105
		local shape = shapes[pointer_shape][pointer_shape_rotation] -- 106
		if does_shape_fit(x, y, shape) then -- 107
			for _index_0 = 1, #shape do -- 108
				local offset = shape[_index_0] -- 108
				do -- 109
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 109
					if cell then -- 109
						if cell.interactable_cell then -- 110
							current_cells[#current_cells + 1] = cell -- 111
							cell.pointer_cell_ok = true -- 112
						end -- 110
					end -- 109
				end -- 109
			end -- 112
		else -- 114
			any_cell_not_ok = true -- 114
			for _index_0 = 1, #shape do -- 115
				local offset = shape[_index_0] -- 115
				do -- 116
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 116
					if cell then -- 116
						if cell.interactable_cell then -- 117
							current_cells[#current_cells + 1] = cell -- 118
							cell.pointer_cell_not_ok = true -- 119
						end -- 117
					end -- 116
				end -- 116
			end -- 119
		end -- 107
	end -- 105
	if main:input_is_pressed('1') and not any_cell_not_ok and round_started then -- 123
		for _index_0 = 1, #current_cells do -- 124
			local cell = current_cells[_index_0] -- 124
			if cell.interactable_cell and cell.arena_cell then -- 125
				cell.pointer_cell_ok = false -- 126
				cell.pointer_cell_not_ok = false -- 127
				cell.solid_cell = true -- 128
			end -- 125
		end -- 128
		pointer_shape = 'short_t' -- 130
		if not does_shape_fit_arena(shapes[pointer_shape]) then -- 131
			local added_score = get_solid_cell_count() -- 132
			player_score = player_score + added_score -- 133
			player_counter = 0 -- 134
			set_bottom_counter(player_counter) -- 135
			reset_grid() -- 136
			generate_arena(added_score) -- 137
		end -- 131
	end -- 123
	if main:input_is_pressed('1') and game_over then -- 139
		reset_grid() -- 140
		player_score = 0 -- 142
		player_counter = 0 -- 143
		round_started = false -- 144
		game_over = false -- 145
		generate_arena() -- 146
	end -- 139
	bg:rectangle(0.5 * main.w, 0.5 * main.h, main.w, main.h, 0, 0, colors.fg[0]) -- 149
	bg2:set_blend_mode('replace') -- 150
	for i = 2, main_grid.w do -- 151
		for j = 2, main_grid.h do -- 152
			x, y = (i - 1) * cell_w, (j - 1) * cell_h -- 153
			local w, h = 5, 5 -- 154
			bg2:line(x - w / 2, y, x + w / 2, y, grid_marker_color, 1) -- 155
			bg2:line(x, y - h / 2, x, y + h / 2, grid_marker_color, 1) -- 156
		end -- 156
	end -- 156
	bg2:set_blend_mode() -- 157
	main_grid:grid_for_each((function(v, i, j) -- 160
		return v:update(dt) -- 160
	end)) -- 160
	objects:container_update(dt) -- 161
	return objects:container_remove_dead() -- 162
end -- 85
set_text = function(x, y, text) -- 166
	for i = 1, utf8.len(text) do -- 167
		do -- 168
			local cell = main_grid:grid_get(x + i, y) -- 168
			if cell then -- 168
				cell.word_cell = utf8.sub(text, i, i) -- 169
			end -- 168
		end -- 168
	end -- 169
end -- 166
reset_grid = function() -- 172
	for x = 2, main_grid.w do -- 173
		for y = 2, main_grid.h do -- 174
			do -- 175
				local cell = main_grid:grid_get(x, y) -- 175
				if cell then -- 175
					reset_cell(cell) -- 176
				end -- 175
			end -- 175
		end -- 176
	end -- 176
end -- 172
set_bottom_counter = function(value) -- 180
	for i = 1, main_grid.w do -- 181
		local cell = main_grid:grid_get(i, main_grid.h) -- 182
		cell.counter_cell = nil -- 183
	end -- 183
	for i = 1, math.floor(value) do -- 184
		local cell = main_grid:grid_get(i, main_grid.h) -- 185
		if value <= 16 then -- 186
			cell.counter_cell = 'normal' -- 187
		elseif value > 16 and value <= 20 then -- 188
			cell.counter_cell = 'warning' -- 189
		elseif value > 20 and value <= 25 then -- 190
			cell.counter_cell = 'danger' -- 191
		end -- 186
	end -- 191
end -- 180
set_top_text = function(text) -- 194
	for i = 1, main_grid.w do -- 195
		local cell = main_grid:grid_get(i, 1) -- 196
		cell.word_cell = '' -- 197
	end -- 197
	for i = 1, utf8.len(text) do -- 198
		local cell = main_grid:grid_get(i, 1) -- 199
		cell.word_cell = utf8.sub(text, i, i) -- 200
	end -- 200
end -- 194
generate_arena = function(added_score) -- 204
	if added_score == nil then -- 204
		added_score = 0 -- 204
	end -- 204
	main:timer_every(0.4, (function() -- 205
		local i = main:timer_get_every_index('set_top_text') -- 206
		if i % 4 == 1 then -- 207
			return set_top_text("GENERATING        +" .. tostring(added_score)) -- 208
		elseif i % 4 == 2 then -- 209
			return set_top_text("GENERATING.       +" .. tostring(added_score)) -- 210
		elseif i % 4 == 3 then -- 211
			return set_top_text("GENERATING..      +" .. tostring(added_score)) -- 212
		elseif i % 4 == 0 then -- 213
			return set_top_text("GENERATING...     +" .. tostring(added_score)) -- 214
		end -- 207
	end), nil, true, nil, 'set_top_text') -- 205
	spawning = true -- 217
	pointer_shape, pointer_shape_rotation = nil, 1 -- 218
	round_started = false -- 219
	return main:timer_every(0.1, (function() -- 220
		if main:random_bool(50) then -- 221
			return objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(8, 20))) -- 222
		else -- 224
			return objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(16, 40), main:random_float(16, 40))) -- 224
		end -- 221
	end), 40, true, (function() -- 225
		return main:timer_after(2, (function() -- 226
			objects:container_destroy() -- 227
			round_started = true -- 228
			pointer_shape = 'short_t' -- 229
			pointer_shape_rotation = 1 -- 230
			main:timer_cancel('set_top_text') -- 231
			return set_top_text("SCORE:" .. tostring(player_score)) -- 232
		end)) -- 233
	end)) -- 234
end -- 204
get_solid_cell_count = function() -- 236
	local count = 0 -- 237
	for x = 2, main_grid.w - 1 do -- 238
		for y = 2, main_grid.h - 1 do -- 239
			do -- 240
				local cell = main_grid:grid_get(x, y) -- 240
				if cell then -- 240
					if cell.solid_cell then -- 241
						count = count + 1 -- 242
					end -- 241
				end -- 240
			end -- 240
		end -- 242
	end -- 242
	return count -- 243
end -- 236
does_shape_fit = function(x, y, shape) -- 247
	for _index_0 = 1, #shape do -- 248
		local offset = shape[_index_0] -- 248
		do -- 249
			local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 249
			if cell then -- 249
				if cell.interactable_cell then -- 250
					if cell.solid_cell or not cell.arena_cell then -- 251
						return false -- 252
					end -- 251
				else -- 254
					return false -- 254
				end -- 250
			else -- 256
				return false -- 256
			end -- 249
		end -- 249
	end -- 256
	return true -- 257
end -- 247
does_shape_fit_arena = function(shape_rotations) -- 262
	for x = 2, main_grid.w - 1 do -- 263
		for y = 2, main_grid.h - 1 do -- 264
			do -- 265
				local cell = main_grid:grid_get(x, y) -- 265
				if cell then -- 265
					if cell.arena_cell then -- 266
						for _index_0 = 1, #shape_rotations do -- 267
							local rotated_shape = shape_rotations[_index_0] -- 267
							if does_shape_fit(x, y, rotated_shape) then -- 268
								return true -- 269
							end -- 268
						end -- 269
					end -- 266
				end -- 265
			end -- 265
		end -- 269
	end -- 269
end -- 262
cell = function(i, j) -- 272
	local self = anchor('cell') -- 273
	self:prs_init((i - 1) * cell_w + 0.5 * cell_w, (j - 1) * cell_h + 0.5 * cell_h) -- 274
	self:collider_init('cell', 'static', 'rectangle', cell_w, cell_h) -- 275
	self.i, self.j = i, j -- 276
	self.interactable_cell = self.i >= 2 and self.j >= 2 and self.i <= main_grid.w - 1 and self.j <= main_grid.h - 1 -- 277
	self.arena_cell = false -- 278
	self.pointer_cell_ok = false -- 279
	self.pointer_cell_not_ok = false -- 280
	self.solid_cell = false -- 281
	self.word_cell = false -- 282
	self.counter_cell = false -- 283
	self.update = function(self, dt) -- 285
		if self.trigger_active['generation_collider'] and self.interactable_cell then -- 286
			self.arena_cell = true -- 286
		end -- 286
		if self.counter_cell then -- 287
			local _exp_0 = self.counter_cell -- 288
			if 'normal' == _exp_0 then -- 289
				return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.yellow[0]) -- 290
			elseif 'warning' == _exp_0 then -- 291
				return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.orange[0]) -- 292
			elseif 'danger' == _exp_0 then -- 293
				return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.red[0]) -- 294
			end -- 294
		elseif self.word_cell then -- 295
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.bg[0]) -- 296
			if type(self.word_cell) == 'string' then -- 297
				return game:draw_text_centered(self.word_cell, font, self.x, self.y - 2, 0, 1, 1, 0, 0, colors.fg[0]) -- 297
			end -- 297
		elseif self.solid_cell then -- 298
			return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_solid_color) -- 299
		elseif self.pointer_cell_ok then -- 300
			return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_pointer_ok_color) -- 301
		elseif self.pointer_cell_not_ok then -- 302
			return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_pointer_not_ok_color) -- 303
		elseif self.arena_cell then -- 304
			return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_marker_color) -- 305
		end -- 287
	end -- 285
	return self -- 306
end -- 272
reset_cell = function(self) -- 308
	self.collision_active['generation_collider'] = nil -- 309
	self.trigger_active['generation_collider'] = nil -- 310
	self.arena_cell = false -- 311
	self.pointer_cell_ok = false -- 312
	self.pointer_cell_not_ok = false -- 313
	self.solid_cell = false -- 314
	self.word_cell = false -- 315
end -- 308
generation_collider = function(x, y, w, h) -- 318
	local self = anchor('generation_collider') -- 319
	self:prs_init(x, y) -- 320
	if w and h then -- 321
		self:collider_init('generation_collider', 'dynamic', 'rectangle', w, h) -- 322
	else -- 324
		self:collider_init('generation_collider', 'dynamic', 'circle', w) -- 324
	end -- 321
	self.update = function(self, dt) -- 326
		self:collider_update_position_and_angle() -- 327
		if self.shape_type == 'circle' then -- 328
			return game:circle(self.x, self.y, self.rs, grid_marker_color, 2) -- 329
		else -- 331
			return game:polygon(self:collider_get_vertices(), grid_marker_color, 2) -- 331
		end -- 328
	end -- 326
	return self -- 332
end -- 318
