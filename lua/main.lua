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
	font = font('assets/ThaleahFat.ttf', 16, 'mono') -- 8
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
		set_text(2, 5, "SCORE: " .. tostring(player_score)) -- 29
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
	shapes = { -- 42
		short_t = { -- 43
			{ -- 43
				{ -- 43
					0, -- 43
					0 -- 43
				}, -- 43
				{ -- 43
					0, -- 43
					-1 -- 43
				}, -- 43
				{ -- 43
					0, -- 43
					1 -- 43
				}, -- 43
				{ -- 43
					1, -- 43
					0 -- 43
				} -- 43
			}, -- 43
			{ -- 44
				{ -- 44
					0, -- 44
					0 -- 44
				}, -- 44
				{ -- 44
					-1, -- 44
					0 -- 44
				}, -- 44
				{ -- 44
					1, -- 44
					0 -- 44
				}, -- 44
				{ -- 44
					0, -- 44
					1 -- 44
				} -- 44
			}, -- 44
			{ -- 45
				{ -- 45
					0, -- 45
					0 -- 45
				}, -- 45
				{ -- 45
					0, -- 45
					-1 -- 45
				}, -- 45
				{ -- 45
					0, -- 45
					1 -- 45
				}, -- 45
				{ -- 45
					-1, -- 45
					0 -- 45
				} -- 45
			}, -- 45
			{ -- 46
				{ -- 46
					0, -- 46
					0 -- 46
				}, -- 46
				{ -- 46
					-1, -- 46
					0 -- 46
				}, -- 46
				{ -- 46
					1, -- 46
					0 -- 46
				}, -- 46
				{ -- 46
					0, -- 46
					-1 -- 46
				} -- 46
			} -- 46
		}, -- 42
		long_t = { -- 49
			{ -- 49
				{ -- 49
					0, -- 49
					0 -- 49
				}, -- 49
				{ -- 49
					0, -- 49
					-1 -- 49
				}, -- 49
				{ -- 49
					0, -- 49
					1 -- 49
				}, -- 49
				{ -- 49
					1, -- 49
					0 -- 49
				}, -- 49
				{ -- 49
					2, -- 49
					0 -- 49
				} -- 49
			}, -- 49
			{ -- 50
				{ -- 50
					0, -- 50
					0 -- 50
				}, -- 50
				{ -- 50
					-1, -- 50
					0 -- 50
				}, -- 50
				{ -- 50
					1, -- 50
					0 -- 50
				}, -- 50
				{ -- 50
					0, -- 50
					1 -- 50
				}, -- 50
				{ -- 50
					0, -- 50
					2 -- 50
				} -- 50
			}, -- 50
			{ -- 51
				{ -- 51
					0, -- 51
					0 -- 51
				}, -- 51
				{ -- 51
					0, -- 51
					-1 -- 51
				}, -- 51
				{ -- 51
					0, -- 51
					1 -- 51
				}, -- 51
				{ -- 51
					-1, -- 51
					0 -- 51
				}, -- 51
				{ -- 51
					-2, -- 51
					0 -- 51
				} -- 51
			}, -- 51
			{ -- 52
				{ -- 52
					0, -- 52
					0 -- 52
				}, -- 52
				{ -- 52
					-1, -- 52
					0 -- 52
				}, -- 52
				{ -- 52
					1, -- 52
					0 -- 52
				}, -- 52
				{ -- 52
					0, -- 52
					-1 -- 52
				}, -- 52
				{ -- 52
					0, -- 52
					-2 -- 52
				} -- 52
			} -- 52
		}, -- 48
		short_i = { -- 55
			{ -- 55
				{ -- 55
					0, -- 55
					0 -- 55
				}, -- 55
				{ -- 55
					-1, -- 55
					0 -- 55
				}, -- 55
				{ -- 55
					1, -- 55
					0 -- 55
				} -- 55
			}, -- 55
			{ -- 56
				{ -- 56
					0, -- 56
					0 -- 56
				}, -- 56
				{ -- 56
					0, -- 56
					-1 -- 56
				}, -- 56
				{ -- 56
					0, -- 56
					1 -- 56
				} -- 56
			}, -- 56
			{ -- 57
				{ -- 57
					0, -- 57
					0 -- 57
				}, -- 57
				{ -- 57
					-1, -- 57
					0 -- 57
				}, -- 57
				{ -- 57
					1, -- 57
					0 -- 57
				} -- 57
			}, -- 57
			{ -- 58
				{ -- 58
					0, -- 58
					0 -- 58
				}, -- 58
				{ -- 58
					0, -- 58
					-1 -- 58
				}, -- 58
				{ -- 58
					0, -- 58
					1 -- 58
				} -- 58
			} -- 58
		}, -- 54
		long_i = { -- 61
			{ -- 61
				{ -- 61
					0, -- 61
					0 -- 61
				}, -- 61
				{ -- 61
					-1, -- 61
					0 -- 61
				}, -- 61
				{ -- 61
					1, -- 61
					0 -- 61
				}, -- 61
				{ -- 61
					2, -- 61
					0 -- 61
				} -- 61
			}, -- 61
			{ -- 62
				{ -- 62
					0, -- 62
					0 -- 62
				}, -- 62
				{ -- 62
					0, -- 62
					-1 -- 62
				}, -- 62
				{ -- 62
					0, -- 62
					1 -- 62
				}, -- 62
				{ -- 62
					0, -- 62
					2 -- 62
				} -- 62
			}, -- 62
			{ -- 63
				{ -- 63
					0, -- 63
					0 -- 63
				}, -- 63
				{ -- 63
					1, -- 63
					0 -- 63
				}, -- 63
				{ -- 63
					-1, -- 63
					0 -- 63
				}, -- 63
				{ -- 63
					-2, -- 63
					0 -- 63
				} -- 63
			}, -- 63
			{ -- 64
				{ -- 64
					0, -- 64
					0 -- 64
				}, -- 64
				{ -- 64
					0, -- 64
					1 -- 64
				}, -- 64
				{ -- 64
					0, -- 64
					-1 -- 64
				}, -- 64
				{ -- 64
					0, -- 64
					-2 -- 64
				} -- 64
			} -- 64
		}, -- 60
		short_j = { -- 67
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
					-1, -- 67
					-1 -- 67
				}, -- 67
				{ -- 67
					1, -- 67
					0 -- 67
				} -- 67
			}, -- 67
			{ -- 68
				{ -- 68
					0, -- 68
					0 -- 68
				}, -- 68
				{ -- 68
					0, -- 68
					1 -- 68
				}, -- 68
				{ -- 68
					0, -- 68
					-1 -- 68
				}, -- 68
				{ -- 68
					1, -- 68
					-1 -- 68
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
					1, -- 69
					1 -- 69
				} -- 69
			}, -- 69
			{ -- 70
				{ -- 70
					0, -- 70
					0 -- 70
				}, -- 70
				{ -- 70
					0, -- 70
					-1 -- 70
				}, -- 70
				{ -- 70
					0, -- 70
					1 -- 70
				}, -- 70
				{ -- 70
					-1, -- 70
					1 -- 70
				} -- 70
			} -- 70
		}, -- 66
		long_j = { -- 73
			{ -- 73
				{ -- 73
					0, -- 73
					0 -- 73
				}, -- 73
				{ -- 73
					-1, -- 73
					0 -- 73
				}, -- 73
				{ -- 73
					-1, -- 73
					-1 -- 73
				}, -- 73
				{ -- 73
					1, -- 73
					0 -- 73
				}, -- 73
				{ -- 73
					2, -- 73
					0 -- 73
				} -- 73
			}, -- 73
			{ -- 74
				{ -- 74
					0, -- 74
					0 -- 74
				}, -- 74
				{ -- 74
					0, -- 74
					1 -- 74
				}, -- 74
				{ -- 74
					0, -- 74
					2 -- 74
				}, -- 74
				{ -- 74
					0, -- 74
					-1 -- 74
				}, -- 74
				{ -- 74
					1, -- 74
					-1 -- 74
				} -- 74
			}, -- 74
			{ -- 75
				{ -- 75
					0, -- 75
					0 -- 75
				}, -- 75
				{ -- 75
					-1, -- 75
					0 -- 75
				}, -- 75
				{ -- 75
					-2, -- 75
					0 -- 75
				}, -- 75
				{ -- 75
					1, -- 75
					0 -- 75
				}, -- 75
				{ -- 75
					1, -- 75
					1 -- 75
				} -- 75
			}, -- 75
			{ -- 76
				{ -- 76
					0, -- 76
					0 -- 76
				}, -- 76
				{ -- 76
					0, -- 76
					-1 -- 76
				}, -- 76
				{ -- 76
					0, -- 76
					-2 -- 76
				}, -- 76
				{ -- 76
					0, -- 76
					1 -- 76
				}, -- 76
				{ -- 76
					-1, -- 76
					1 -- 76
				} -- 76
			} -- 76
		}, -- 72
		short_l = { -- 79
			{ -- 79
				{ -- 79
					0, -- 79
					0 -- 79
				}, -- 79
				{ -- 79
					-1, -- 79
					0 -- 79
				}, -- 79
				{ -- 79
					1, -- 79
					0 -- 79
				}, -- 79
				{ -- 79
					1, -- 79
					-1 -- 79
				} -- 79
			}, -- 79
			{ -- 80
				{ -- 80
					0, -- 80
					0 -- 80
				}, -- 80
				{ -- 80
					0, -- 80
					-1 -- 80
				}, -- 80
				{ -- 80
					0, -- 80
					1 -- 80
				}, -- 80
				{ -- 80
					1, -- 80
					1 -- 80
				} -- 80
			}, -- 80
			{ -- 81
				{ -- 81
					0, -- 81
					0 -- 81
				}, -- 81
				{ -- 81
					1, -- 81
					0 -- 81
				}, -- 81
				{ -- 81
					-1, -- 81
					0 -- 81
				}, -- 81
				{ -- 81
					-1, -- 81
					1 -- 81
				} -- 81
			}, -- 81
			{ -- 82
				{ -- 82
					0, -- 82
					0 -- 82
				}, -- 82
				{ -- 82
					0, -- 82
					1 -- 82
				}, -- 82
				{ -- 82
					0, -- 82
					-1 -- 82
				}, -- 82
				{ -- 82
					-1, -- 82
					-1 -- 82
				} -- 82
			} -- 82
		}, -- 78
		long_l = { -- 85
			{ -- 85
				{ -- 85
					0, -- 85
					0 -- 85
				}, -- 85
				{ -- 85
					-1, -- 85
					0 -- 85
				}, -- 85
				{ -- 85
					-2, -- 85
					0 -- 85
				}, -- 85
				{ -- 85
					1, -- 85
					0 -- 85
				}, -- 85
				{ -- 85
					1, -- 85
					-1 -- 85
				} -- 85
			}, -- 85
			{ -- 86
				{ -- 86
					0, -- 86
					0 -- 86
				}, -- 86
				{ -- 86
					0, -- 86
					-1 -- 86
				}, -- 86
				{ -- 86
					0, -- 86
					-2 -- 86
				}, -- 86
				{ -- 86
					0, -- 86
					1 -- 86
				}, -- 86
				{ -- 86
					1, -- 86
					1 -- 86
				} -- 86
			}, -- 86
			{ -- 87
				{ -- 87
					0, -- 87
					0 -- 87
				}, -- 87
				{ -- 87
					1, -- 87
					0 -- 87
				}, -- 87
				{ -- 87
					2, -- 87
					0 -- 87
				}, -- 87
				{ -- 87
					-1, -- 87
					0 -- 87
				}, -- 87
				{ -- 87
					-1, -- 87
					1 -- 87
				} -- 87
			}, -- 87
			{ -- 88
				{ -- 88
					0, -- 88
					0 -- 88
				}, -- 88
				{ -- 88
					0, -- 88
					1 -- 88
				}, -- 88
				{ -- 88
					0, -- 88
					2 -- 88
				}, -- 88
				{ -- 88
					0, -- 88
					-1 -- 88
				}, -- 88
				{ -- 88
					-1, -- 88
					-1 -- 88
				} -- 88
			} -- 88
		}, -- 84
		short_s = { -- 91
			{ -- 91
				{ -- 91
					0, -- 91
					0 -- 91
				}, -- 91
				{ -- 91
					-1, -- 91
					0 -- 91
				}, -- 91
				{ -- 91
					0, -- 91
					-1 -- 91
				}, -- 91
				{ -- 91
					1, -- 91
					-1 -- 91
				} -- 91
			}, -- 91
			{ -- 92
				{ -- 92
					0, -- 92
					0 -- 92
				}, -- 92
				{ -- 92
					0, -- 92
					-1 -- 92
				}, -- 92
				{ -- 92
					1, -- 92
					0 -- 92
				}, -- 92
				{ -- 92
					1, -- 92
					1 -- 92
				} -- 92
			}, -- 92
			{ -- 93
				{ -- 93
					0, -- 93
					0 -- 93
				}, -- 93
				{ -- 93
					1, -- 93
					0 -- 93
				}, -- 93
				{ -- 93
					0, -- 93
					1 -- 93
				}, -- 93
				{ -- 93
					-1, -- 93
					1 -- 93
				} -- 93
			}, -- 93
			{ -- 94
				{ -- 94
					0, -- 94
					0 -- 94
				}, -- 94
				{ -- 94
					0, -- 94
					1 -- 94
				}, -- 94
				{ -- 94
					-1, -- 94
					0 -- 94
				}, -- 94
				{ -- 94
					-1, -- 94
					-1 -- 94
				} -- 94
			} -- 94
		}, -- 90
		long_s = { -- 97
			{ -- 97
				{ -- 97
					0, -- 97
					0 -- 97
				}, -- 97
				{ -- 97
					-1, -- 97
					0 -- 97
				}, -- 97
				{ -- 97
					-2, -- 97
					0 -- 97
				}, -- 97
				{ -- 97
					0, -- 97
					-1 -- 97
				}, -- 97
				{ -- 97
					1, -- 97
					-1 -- 97
				} -- 97
			}, -- 97
			{ -- 98
				{ -- 98
					0, -- 98
					0 -- 98
				}, -- 98
				{ -- 98
					0, -- 98
					-1 -- 98
				}, -- 98
				{ -- 98
					0, -- 98
					-2 -- 98
				}, -- 98
				{ -- 98
					1, -- 98
					0 -- 98
				}, -- 98
				{ -- 98
					1, -- 98
					1 -- 98
				} -- 98
			}, -- 98
			{ -- 99
				{ -- 99
					0, -- 99
					0 -- 99
				}, -- 99
				{ -- 99
					1, -- 99
					0 -- 99
				}, -- 99
				{ -- 99
					2, -- 99
					0 -- 99
				}, -- 99
				{ -- 99
					0, -- 99
					1 -- 99
				}, -- 99
				{ -- 99
					-1, -- 99
					1 -- 99
				} -- 99
			}, -- 99
			{ -- 100
				{ -- 100
					0, -- 100
					0 -- 100
				}, -- 100
				{ -- 100
					0, -- 100
					1 -- 100
				}, -- 100
				{ -- 100
					0, -- 100
					2 -- 100
				}, -- 100
				{ -- 100
					-1, -- 100
					0 -- 100
				}, -- 100
				{ -- 100
					-1, -- 100
					-1 -- 100
				} -- 100
			} -- 100
		}, -- 96
		short_z = { -- 103
			{ -- 103
				{ -- 103
					0, -- 103
					0 -- 103
				}, -- 103
				{ -- 103
					1, -- 103
					0 -- 103
				}, -- 103
				{ -- 103
					0, -- 103
					-1 -- 103
				}, -- 103
				{ -- 103
					-1, -- 103
					-1 -- 103
				} -- 103
			}, -- 103
			{ -- 104
				{ -- 104
					0, -- 104
					0 -- 104
				}, -- 104
				{ -- 104
					0, -- 104
					1 -- 104
				}, -- 104
				{ -- 104
					1, -- 104
					0 -- 104
				}, -- 104
				{ -- 104
					1, -- 104
					-1 -- 104
				} -- 104
			}, -- 104
			{ -- 105
				{ -- 105
					0, -- 105
					0 -- 105
				}, -- 105
				{ -- 105
					-1, -- 105
					0 -- 105
				}, -- 105
				{ -- 105
					0, -- 105
					1 -- 105
				}, -- 105
				{ -- 105
					1, -- 105
					1 -- 105
				} -- 105
			}, -- 105
			{ -- 106
				{ -- 106
					0, -- 106
					0 -- 106
				}, -- 106
				{ -- 106
					0, -- 106
					-1 -- 106
				}, -- 106
				{ -- 106
					-1, -- 106
					0 -- 106
				}, -- 106
				{ -- 106
					-1, -- 106
					1 -- 106
				} -- 106
			} -- 106
		}, -- 102
		long_z = { -- 109
			{ -- 109
				{ -- 109
					0, -- 109
					0 -- 109
				}, -- 109
				{ -- 109
					1, -- 109
					0 -- 109
				}, -- 109
				{ -- 109
					2, -- 109
					0 -- 109
				}, -- 109
				{ -- 109
					0, -- 109
					-1 -- 109
				}, -- 109
				{ -- 109
					-1, -- 109
					-1 -- 109
				} -- 109
			}, -- 109
			{ -- 110
				{ -- 110
					0, -- 110
					0 -- 110
				}, -- 110
				{ -- 110
					0, -- 110
					1 -- 110
				}, -- 110
				{ -- 110
					0, -- 110
					2 -- 110
				}, -- 110
				{ -- 110
					1, -- 110
					0 -- 110
				}, -- 110
				{ -- 110
					1, -- 110
					-1 -- 110
				} -- 110
			}, -- 110
			{ -- 111
				{ -- 111
					0, -- 111
					0 -- 111
				}, -- 111
				{ -- 111
					-1, -- 111
					0 -- 111
				}, -- 111
				{ -- 111
					-2, -- 111
					0 -- 111
				}, -- 111
				{ -- 111
					0, -- 111
					1 -- 111
				}, -- 111
				{ -- 111
					1, -- 111
					1 -- 111
				} -- 111
			}, -- 111
			{ -- 112
				{ -- 112
					0, -- 112
					0 -- 112
				}, -- 112
				{ -- 112
					0, -- 112
					-1 -- 112
				}, -- 112
				{ -- 112
					0, -- 112
					-2 -- 112
				}, -- 112
				{ -- 112
					-1, -- 112
					0 -- 112
				}, -- 112
				{ -- 112
					-1, -- 112
					1 -- 112
				} -- 112
			} -- 112
		}, -- 108
		short_v = { -- 115
			{ -- 115
				{ -- 115
					0, -- 115
					0 -- 115
				}, -- 115
				{ -- 115
					1, -- 115
					0 -- 115
				}, -- 115
				{ -- 115
					0, -- 115
					-1 -- 115
				} -- 115
			}, -- 115
			{ -- 116
				{ -- 116
					0, -- 116
					0 -- 116
				}, -- 116
				{ -- 116
					1, -- 116
					0 -- 116
				}, -- 116
				{ -- 116
					0, -- 116
					1 -- 116
				} -- 116
			}, -- 116
			{ -- 117
				{ -- 117
					0, -- 117
					0 -- 117
				}, -- 117
				{ -- 117
					-1, -- 117
					0 -- 117
				}, -- 117
				{ -- 117
					0, -- 117
					1 -- 117
				} -- 117
			}, -- 117
			{ -- 118
				{ -- 118
					0, -- 118
					0 -- 118
				}, -- 118
				{ -- 118
					0, -- 118
					-1 -- 118
				}, -- 118
				{ -- 118
					-1, -- 118
					0 -- 118
				} -- 118
			} -- 118
		}, -- 114
		long_v = { -- 121
			{ -- 121
				{ -- 121
					0, -- 121
					0 -- 121
				}, -- 121
				{ -- 121
					1, -- 121
					0 -- 121
				}, -- 121
				{ -- 121
					2, -- 121
					0 -- 121
				}, -- 121
				{ -- 121
					0, -- 121
					-1 -- 121
				}, -- 121
				{ -- 121
					0, -- 121
					-2 -- 121
				} -- 121
			}, -- 121
			{ -- 122
				{ -- 122
					0, -- 122
					0 -- 122
				}, -- 122
				{ -- 122
					1, -- 122
					0 -- 122
				}, -- 122
				{ -- 122
					2, -- 122
					0 -- 122
				}, -- 122
				{ -- 122
					0, -- 122
					1 -- 122
				}, -- 122
				{ -- 122
					0, -- 122
					2 -- 122
				} -- 122
			}, -- 122
			{ -- 123
				{ -- 123
					0, -- 123
					0 -- 123
				}, -- 123
				{ -- 123
					-1, -- 123
					0 -- 123
				}, -- 123
				{ -- 123
					-2, -- 123
					0 -- 123
				}, -- 123
				{ -- 123
					0, -- 123
					1 -- 123
				}, -- 123
				{ -- 123
					0, -- 123
					2 -- 123
				} -- 123
			}, -- 123
			{ -- 124
				{ -- 124
					0, -- 124
					0 -- 124
				}, -- 124
				{ -- 124
					0, -- 124
					-1 -- 124
				}, -- 124
				{ -- 124
					0, -- 124
					-2 -- 124
				}, -- 124
				{ -- 124
					-1, -- 124
					0 -- 124
				}, -- 124
				{ -- 124
					-2, -- 124
					0 -- 124
				} -- 124
			} -- 124
		}, -- 120
		o = { -- 127
			{ -- 127
				{ -- 127
					0, -- 127
					0 -- 127
				}, -- 127
				{ -- 127
					1, -- 127
					0 -- 127
				}, -- 127
				{ -- 127
					1, -- 127
					1 -- 127
				}, -- 127
				{ -- 127
					0, -- 127
					1 -- 127
				} -- 127
			}, -- 127
			{ -- 128
				{ -- 128
					0, -- 128
					0 -- 128
				}, -- 128
				{ -- 128
					1, -- 128
					0 -- 128
				}, -- 128
				{ -- 128
					1, -- 128
					1 -- 128
				}, -- 128
				{ -- 128
					0, -- 128
					1 -- 128
				} -- 128
			}, -- 128
			{ -- 129
				{ -- 129
					0, -- 129
					0 -- 129
				}, -- 129
				{ -- 129
					1, -- 129
					0 -- 129
				}, -- 129
				{ -- 129
					1, -- 129
					1 -- 129
				}, -- 129
				{ -- 129
					0, -- 129
					1 -- 129
				} -- 129
			}, -- 129
			{ -- 130
				{ -- 130
					0, -- 130
					0 -- 130
				}, -- 130
				{ -- 130
					1, -- 130
					0 -- 130
				}, -- 130
				{ -- 130
					1, -- 130
					1 -- 130
				}, -- 130
				{ -- 130
					0, -- 130
					1 -- 130
				} -- 130
			} -- 130
		}, -- 126
		x = { -- 133
			{ -- 133
				{ -- 133
					0, -- 133
					0 -- 133
				}, -- 133
				{ -- 133
					1, -- 133
					0 -- 133
				}, -- 133
				{ -- 133
					-1, -- 133
					0 -- 133
				}, -- 133
				{ -- 133
					0, -- 133
					1 -- 133
				}, -- 133
				{ -- 133
					0, -- 133
					-1 -- 133
				} -- 133
			}, -- 133
			{ -- 134
				{ -- 134
					0, -- 134
					0 -- 134
				}, -- 134
				{ -- 134
					1, -- 134
					0 -- 134
				}, -- 134
				{ -- 134
					-1, -- 134
					0 -- 134
				}, -- 134
				{ -- 134
					0, -- 134
					1 -- 134
				}, -- 134
				{ -- 134
					0, -- 134
					-1 -- 134
				} -- 134
			}, -- 134
			{ -- 135
				{ -- 135
					0, -- 135
					0 -- 135
				}, -- 135
				{ -- 135
					1, -- 135
					0 -- 135
				}, -- 135
				{ -- 135
					-1, -- 135
					0 -- 135
				}, -- 135
				{ -- 135
					0, -- 135
					1 -- 135
				}, -- 135
				{ -- 135
					0, -- 135
					-1 -- 135
				} -- 135
			}, -- 135
			{ -- 136
				{ -- 136
					0, -- 136
					0 -- 136
				}, -- 136
				{ -- 136
					1, -- 136
					0 -- 136
				}, -- 136
				{ -- 136
					-1, -- 136
					0 -- 136
				}, -- 136
				{ -- 136
					0, -- 136
					1 -- 136
				}, -- 136
				{ -- 136
					0, -- 136
					-1 -- 136
				} -- 136
			} -- 136
		}, -- 132
		f = { -- 139
			{ -- 139
				{ -- 139
					0, -- 139
					0 -- 139
				}, -- 139
				{ -- 139
					0, -- 139
					1 -- 139
				}, -- 139
				{ -- 139
					0, -- 139
					-1 -- 139
				}, -- 139
				{ -- 139
					1, -- 139
					-1 -- 139
				}, -- 139
				{ -- 139
					-1, -- 139
					0 -- 139
				} -- 139
			}, -- 139
			{ -- 140
				{ -- 140
					0, -- 140
					0 -- 140
				}, -- 140
				{ -- 140
					-1, -- 140
					0 -- 140
				}, -- 140
				{ -- 140
					1, -- 140
					0 -- 140
				}, -- 140
				{ -- 140
					1, -- 140
					1 -- 140
				}, -- 140
				{ -- 140
					0, -- 140
					-1 -- 140
				} -- 140
			}, -- 140
			{ -- 141
				{ -- 141
					0, -- 141
					0 -- 141
				}, -- 141
				{ -- 141
					0, -- 141
					-1 -- 141
				}, -- 141
				{ -- 141
					0, -- 141
					1 -- 141
				}, -- 141
				{ -- 141
					-1, -- 141
					1 -- 141
				}, -- 141
				{ -- 141
					1, -- 141
					0 -- 141
				} -- 141
			}, -- 141
			{ -- 142
				{ -- 142
					0, -- 142
					0 -- 142
				}, -- 142
				{ -- 142
					-1, -- 142
					0 -- 142
				}, -- 142
				{ -- 142
					-1, -- 142
					-1 -- 142
				}, -- 142
				{ -- 142
					1, -- 142
					0 -- 142
				}, -- 142
				{ -- 142
					0, -- 142
					1 -- 142
				} -- 142
			} -- 142
		}, -- 138
		p = { -- 145
			{ -- 145
				{ -- 145
					0, -- 145
					0 -- 145
				}, -- 145
				{ -- 145
					0, -- 145
					-1 -- 145
				}, -- 145
				{ -- 145
					0, -- 145
					1 -- 145
				}, -- 145
				{ -- 145
					1, -- 145
					-1 -- 145
				}, -- 145
				{ -- 145
					1, -- 145
					0 -- 145
				} -- 145
			}, -- 145
			{ -- 146
				{ -- 146
					0, -- 146
					0 -- 146
				}, -- 146
				{ -- 146
					-1, -- 146
					0 -- 146
				}, -- 146
				{ -- 146
					1, -- 146
					0 -- 146
				}, -- 146
				{ -- 146
					0, -- 146
					1 -- 146
				}, -- 146
				{ -- 146
					1, -- 146
					1 -- 146
				} -- 146
			}, -- 146
			{ -- 147
				{ -- 147
					0, -- 147
					0 -- 147
				}, -- 147
				{ -- 147
					0, -- 147
					-1 -- 147
				}, -- 147
				{ -- 147
					0, -- 147
					1 -- 147
				}, -- 147
				{ -- 147
					-1, -- 147
					0 -- 147
				}, -- 147
				{ -- 147
					-1, -- 147
					1 -- 147
				} -- 147
			}, -- 147
			{ -- 148
				{ -- 148
					0, -- 148
					0 -- 148
				}, -- 148
				{ -- 148
					1, -- 148
					0 -- 148
				}, -- 148
				{ -- 148
					-1, -- 148
					0 -- 148
				}, -- 148
				{ -- 148
					-1, -- 148
					-1 -- 148
				}, -- 148
				{ -- 148
					0, -- 148
					-1 -- 148
				} -- 148
			} -- 148
		}, -- 144
		u = { -- 151
			{ -- 151
				{ -- 151
					0, -- 151
					0 -- 151
				}, -- 151
				{ -- 151
					0, -- 151
					1 -- 151
				}, -- 151
				{ -- 151
					0, -- 151
					-1 -- 151
				}, -- 151
				{ -- 151
					1, -- 151
					1 -- 151
				}, -- 151
				{ -- 151
					1, -- 151
					-1 -- 151
				} -- 151
			}, -- 151
			{ -- 152
				{ -- 152
					0, -- 152
					0 -- 152
				}, -- 152
				{ -- 152
					-1, -- 152
					0 -- 152
				}, -- 152
				{ -- 152
					1, -- 152
					0 -- 152
				}, -- 152
				{ -- 152
					1, -- 152
					1 -- 152
				}, -- 152
				{ -- 152
					-1, -- 152
					1 -- 152
				} -- 152
			}, -- 152
			{ -- 153
				{ -- 153
					0, -- 153
					0 -- 153
				}, -- 153
				{ -- 153
					0, -- 153
					-1 -- 153
				}, -- 153
				{ -- 153
					0, -- 153
					1 -- 153
				}, -- 153
				{ -- 153
					-1, -- 153
					1 -- 153
				}, -- 153
				{ -- 153
					-1, -- 153
					-1 -- 153
				} -- 153
			}, -- 153
			{ -- 154
				{ -- 154
					0, -- 154
					0 -- 154
				}, -- 154
				{ -- 154
					-1, -- 154
					0 -- 154
				}, -- 154
				{ -- 154
					-1, -- 154
					-1 -- 154
				}, -- 154
				{ -- 154
					1, -- 154
					0 -- 154
				}, -- 154
				{ -- 154
					1, -- 154
					-1 -- 154
				} -- 154
			} -- 154
		}, -- 150
		y = { -- 157
			{ -- 157
				{ -- 157
					0, -- 157
					0 -- 157
				}, -- 157
				{ -- 157
					-1, -- 157
					0 -- 157
				}, -- 157
				{ -- 157
					1, -- 157
					0 -- 157
				}, -- 157
				{ -- 157
					2, -- 157
					0 -- 157
				}, -- 157
				{ -- 157
					0, -- 157
					-1 -- 157
				} -- 157
			}, -- 157
			{ -- 158
				{ -- 158
					0, -- 158
					0 -- 158
				}, -- 158
				{ -- 158
					0, -- 158
					-1 -- 158
				}, -- 158
				{ -- 158
					0, -- 158
					1 -- 158
				}, -- 158
				{ -- 158
					0, -- 158
					2 -- 158
				}, -- 158
				{ -- 158
					1, -- 158
					0 -- 158
				} -- 158
			}, -- 158
			{ -- 159
				{ -- 159
					0, -- 159
					0 -- 159
				}, -- 159
				{ -- 159
					1, -- 159
					0 -- 159
				}, -- 159
				{ -- 159
					-1, -- 159
					0 -- 159
				}, -- 159
				{ -- 159
					-2, -- 159
					0 -- 159
				}, -- 159
				{ -- 159
					0, -- 159
					1 -- 159
				} -- 159
			}, -- 159
			{ -- 160
				{ -- 160
					0, -- 160
					0 -- 160
				}, -- 160
				{ -- 160
					0, -- 160
					1 -- 160
				}, -- 160
				{ -- 160
					0, -- 160
					-1 -- 160
				}, -- 160
				{ -- 160
					0, -- 160
					-2 -- 160
				}, -- 160
				{ -- 160
					-1, -- 160
					0 -- 160
				} -- 160
			} -- 160
		}, -- 156
		z = { -- 163
			{ -- 163
				{ -- 163
					0, -- 163
					0 -- 163
				}, -- 163
				{ -- 163
					0, -- 163
					-1 -- 163
				}, -- 163
				{ -- 163
					0, -- 163
					1 -- 163
				}, -- 163
				{ -- 163
					1, -- 163
					1 -- 163
				}, -- 163
				{ -- 163
					-1, -- 163
					-1 -- 163
				} -- 163
			}, -- 163
			{ -- 164
				{ -- 164
					0, -- 164
					0 -- 164
				}, -- 164
				{ -- 164
					1, -- 164
					0 -- 164
				}, -- 164
				{ -- 164
					-1, -- 164
					0 -- 164
				}, -- 164
				{ -- 164
					-1, -- 164
					1 -- 164
				}, -- 164
				{ -- 164
					1, -- 164
					-1 -- 164
				} -- 164
			}, -- 164
			{ -- 165
				{ -- 165
					0, -- 165
					0 -- 165
				}, -- 165
				{ -- 165
					0, -- 165
					1 -- 165
				}, -- 165
				{ -- 165
					0, -- 165
					-1 -- 165
				}, -- 165
				{ -- 165
					-1, -- 165
					-1 -- 165
				}, -- 165
				{ -- 165
					1, -- 165
					1 -- 165
				} -- 165
			}, -- 165
			{ -- 166
				{ -- 166
					0, -- 166
					0 -- 166
				}, -- 166
				{ -- 166
					-1, -- 166
					0 -- 166
				}, -- 166
				{ -- 166
					1, -- 166
					0 -- 166
				}, -- 166
				{ -- 166
					1, -- 166
					-1 -- 166
				}, -- 166
				{ -- 166
					-1, -- 166
					1 -- 166
				} -- 166
			} -- 166
		} -- 162
	} -- 41
	main_grid = grid(24, 24, 0) -- 172
	cell_w, cell_h = main.w / main_grid.w, main.h / main_grid.h -- 173
	for i = 1, main_grid.w do -- 174
		for j = 1, main_grid.h do -- 175
			main_grid:grid_set(i, j, cell(i, j)) -- 176
		end -- 176
	end -- 176
	return generate_arena() -- 177
end -- 4
update = function(dt) -- 180
	if main:input_is_pressed('f11') then -- 181
		love.event.restart() -- 181
	end -- 181
	if round_started then -- 182
		player_counter = player_counter + 0.75 * dt -- 183
		set_bottom_counter(player_counter) -- 184
	end -- 182
	if main:input_is_pressed('2') then -- 185
		pointer_shape_rotation = pointer_shape_rotation + 1 -- 186
		if pointer_shape_rotation == 5 then -- 187
			pointer_shape_rotation = 1 -- 187
		end -- 187
	end -- 185
	for i = 2, main_grid.w - 1 do -- 190
		for j = 2, main_grid.h - 1 do -- 191
			local cell = main_grid:grid_get(i, j) -- 192
			cell.pointer_cell_ok = false -- 193
			cell.pointer_cell_not_ok = false -- 194
		end -- 194
	end -- 194
	local x, y = math.ceil(main.pointer.x / cell_w), math.ceil(main.pointer.y / cell_h) -- 197
	local any_cell_not_ok = false -- 198
	local current_cells = { } -- 199
	if pointer_shape and round_started then -- 200
		local shape = shapes[pointer_shape][pointer_shape_rotation] -- 201
		if does_shape_fit(x, y, shape) then -- 202
			for _index_0 = 1, #shape do -- 203
				local offset = shape[_index_0] -- 203
				do -- 204
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 204
					if cell then -- 204
						if cell.interactable_cell then -- 205
							current_cells[#current_cells + 1] = cell -- 206
							cell.pointer_cell_ok = true -- 207
						end -- 205
					end -- 204
				end -- 204
			end -- 207
		else -- 209
			any_cell_not_ok = true -- 209
			for _index_0 = 1, #shape do -- 210
				local offset = shape[_index_0] -- 210
				do -- 211
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 211
					if cell then -- 211
						if cell.interactable_cell then -- 212
							current_cells[#current_cells + 1] = cell -- 213
							cell.pointer_cell_not_ok = true -- 214
						end -- 212
					end -- 211
				end -- 211
			end -- 214
		end -- 202
	end -- 200
	if main:input_is_pressed('1') and not any_cell_not_ok and round_started then -- 218
		for _index_0 = 1, #current_cells do -- 219
			local cell = current_cells[_index_0] -- 219
			if cell.interactable_cell and cell.arena_cell then -- 220
				cell.pointer_cell_ok = false -- 221
				cell.pointer_cell_not_ok = false -- 222
				cell.solid_cell = true -- 223
			end -- 220
		end -- 223
		pointer_shape, pointer_visual_shape = get_next_pointer_shape() -- 225
		if not does_shape_fit_arena(shapes[pointer_shape]) then -- 226
			local added_score = get_solid_cell_count() -- 227
			player_score = player_score + added_score -- 228
			player_counter = 0 -- 229
			set_bottom_counter(player_counter) -- 230
			reset_grid() -- 231
			generate_arena(added_score) -- 232
		end -- 226
	end -- 218
	if main:input_is_pressed('1') and game_over then -- 234
		reset_grid() -- 235
		player_score = 0 -- 237
		player_counter = 0 -- 238
		round_started = false -- 239
		game_over = false -- 240
		generate_arena() -- 241
	end -- 234
	bg:rectangle(0.5 * main.w, 0.5 * main.h, main.w, main.h, 0, 0, colors.fg[0]) -- 244
	bg2:set_blend_mode('replace') -- 245
	for i = 2, main_grid.w do -- 246
		for j = 2, main_grid.h do -- 247
			x, y = (i - 1) * cell_w, (j - 1) * cell_h -- 248
			local w, h = 5, 5 -- 249
			bg2:line(x - w / 2, y, x + w / 2, y, grid_marker_color, 1) -- 250
			bg2:line(x, y - h / 2, x, y + h / 2, grid_marker_color, 1) -- 251
		end -- 251
	end -- 251
	bg2:set_blend_mode() -- 252
	main_grid:grid_for_each((function(v, i, j) -- 255
		return v:update(dt) -- 255
	end)) -- 255
	objects:container_update(dt) -- 256
	return objects:container_remove_dead() -- 257
end -- 180
get_next_pointer_shape = function() -- 259
	if pointer_visual_shape then -- 260
		pointer_visual_shape.dead = true -- 260
	end -- 260
	pointer_shape_rotation = 1 -- 261
	local shape = main:random_table({ -- 262
		'short_t', -- 262
		'long_t', -- 262
		'short_i', -- 262
		'long_i', -- 262
		'short_j', -- 262
		'long_j', -- 262
		'short_l', -- 262
		'long_l', -- 262
		'short_s', -- 262
		'long_s', -- 262
		'short_z', -- 262
		'long_z', -- 262
		'short_v', -- 262
		'long_v', -- 262
		'o', -- 262
		'x', -- 262
		'f', -- 262
		'p', -- 262
		'u', -- 262
		'y', -- 262
		'z' -- 262
	}) -- 262
	return shape, objects:container_add(visual_shape(shapes[shape][1])) -- 263
end -- 259
set_text = function(x, y, text) -- 266
	for i = 1, utf8.len(text) do -- 267
		do -- 268
			local cell = main_grid:grid_get(x + i, y) -- 268
			if cell then -- 268
				cell.word_cell = utf8.sub(text, i, i) -- 269
			end -- 268
		end -- 268
	end -- 269
end -- 266
reset_grid = function() -- 272
	for x = 2, main_grid.w do -- 273
		for y = 2, main_grid.h do -- 274
			do -- 275
				local cell = main_grid:grid_get(x, y) -- 275
				if cell then -- 275
					reset_cell(cell) -- 276
				end -- 275
			end -- 275
		end -- 276
	end -- 276
end -- 272
set_bottom_counter = function(value) -- 280
	for i = 1, main_grid.w do -- 281
		local cell = main_grid:grid_get(i, main_grid.h) -- 282
		cell.counter_cell = nil -- 283
	end -- 283
	for i = 1, math.floor(value) do -- 284
		local cell = main_grid:grid_get(i, main_grid.h) -- 285
		if value <= 16 then -- 286
			cell.counter_cell = 'normal' -- 287
		elseif value > 16 and value <= 20 then -- 288
			cell.counter_cell = 'warning' -- 289
		elseif value > 20 and value <= 25 then -- 290
			cell.counter_cell = 'danger' -- 291
		end -- 286
	end -- 291
end -- 280
set_top_text = function(text) -- 294
	for i = 1, main_grid.w do -- 295
		local cell = main_grid:grid_get(i, 1) -- 296
		cell.word_cell = '' -- 297
	end -- 297
	for i = 1, utf8.len(text) do -- 298
		local cell = main_grid:grid_get(i, 1) -- 299
		cell.word_cell = utf8.sub(text, i, i) -- 300
	end -- 300
end -- 294
generate_arena = function(added_score) -- 304
	if added_score == nil then -- 304
		added_score = 0 -- 304
	end -- 304
	main:timer_every(0.4, (function() -- 305
		local i = main:timer_get_every_index('set_top_text') -- 306
		if i % 4 == 1 then -- 307
			return set_top_text("GENERATING        +" .. tostring(added_score)) -- 308
		elseif i % 4 == 2 then -- 309
			return set_top_text("GENERATING.       +" .. tostring(added_score)) -- 310
		elseif i % 4 == 3 then -- 311
			return set_top_text("GENERATING..      +" .. tostring(added_score)) -- 312
		elseif i % 4 == 0 then -- 313
			return set_top_text("GENERATING...     +" .. tostring(added_score)) -- 314
		end -- 307
	end), nil, true, nil, 'set_top_text') -- 305
	spawning = true -- 317
	pointer_shape, pointer_visual_shape, pointer_shape_rotation = nil, nil, 1 -- 318
	round_started = false -- 319
	return main:timer_every(0.1, (function() -- 320
		if main:random_bool(50) then -- 321
			return objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(8, 20))) -- 322
		else -- 324
			return objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(16, 40), main:random_float(16, 40))) -- 324
		end -- 321
	end), 40, true, (function() -- 325
		return main:timer_after(2, (function() -- 326
			objects:container_destroy() -- 327
			round_started = true -- 328
			pointer_shape, pointer_visual_shape = get_next_pointer_shape() -- 329
			pointer_shape_rotation = 1 -- 330
			main:timer_cancel('set_top_text') -- 331
			return set_top_text("SCORE:" .. tostring(player_score)) -- 332
		end)) -- 333
	end)) -- 334
end -- 304
get_solid_cell_count = function() -- 336
	local count = 0 -- 337
	for x = 2, main_grid.w - 1 do -- 338
		for y = 2, main_grid.h - 1 do -- 339
			do -- 340
				local cell = main_grid:grid_get(x, y) -- 340
				if cell then -- 340
					if cell.solid_cell then -- 341
						count = count + 1 -- 342
					end -- 341
				end -- 340
			end -- 340
		end -- 342
	end -- 342
	return count -- 343
end -- 336
does_shape_fit = function(x, y, shape) -- 347
	for _index_0 = 1, #shape do -- 348
		local offset = shape[_index_0] -- 348
		do -- 349
			local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 349
			if cell then -- 349
				if cell.interactable_cell then -- 350
					if cell.solid_cell or not cell.arena_cell then -- 351
						return false -- 352
					end -- 351
				else -- 354
					return false -- 354
				end -- 350
			else -- 356
				return false -- 356
			end -- 349
		end -- 349
	end -- 356
	return true -- 357
end -- 347
does_shape_fit_arena = function(shape_rotations) -- 362
	for x = 2, main_grid.w - 1 do -- 363
		for y = 2, main_grid.h - 1 do -- 364
			do -- 365
				local cell = main_grid:grid_get(x, y) -- 365
				if cell then -- 365
					if cell.arena_cell then -- 366
						for _index_0 = 1, #shape_rotations do -- 367
							local rotated_shape = shape_rotations[_index_0] -- 367
							if does_shape_fit(x, y, rotated_shape) then -- 368
								return true -- 369
							end -- 368
						end -- 369
					end -- 366
				end -- 365
			end -- 365
		end -- 369
	end -- 369
end -- 362
visual_shape = function(shape) -- 372
	local self = anchor('visual_shape') -- 373
	self:prs_init(main.pointer.x, main.pointer.y) -- 374
	self.cells = { } -- 375
	for _index_0 = 1, #shape do -- 376
		local offset = shape[_index_0] -- 376
		do -- 377
			local _obj_0 = self.cells -- 377
			_obj_0[#_obj_0 + 1] = { -- 377
				x = offset[1] * cell_w, -- 377
				y = offset[2] * cell_h, -- 377
				w = cell_w, -- 377
				h = cell_h -- 377
			} -- 377
		end -- 377
	end -- 377
	self.update = function(self, dt) -- 378
		self.x, self.y = main.pointer.x, main.pointer.y -- 379
		local _list_0 = self.cells -- 380
		for _index_0 = 1, #_list_0 do -- 380
			local cell = _list_0[_index_0] -- 380
			fg:rectangle(self.x + cell.x, self.y + cell.y, cell.w, cell.h, 3, 3, colors.bg[0]) -- 381
		end -- 381
	end -- 378
	return self -- 382
end -- 372
cell = function(i, j) -- 385
	local self = anchor('cell') -- 386
	self:prs_init((i - 1) * cell_w + 0.5 * cell_w, (j - 1) * cell_h + 0.5 * cell_h) -- 387
	self:collider_init('cell', 'static', 'rectangle', cell_w, cell_h) -- 388
	self.i, self.j = i, j -- 389
	self.interactable_cell = self.i >= 2 and self.j >= 2 and self.i <= main_grid.w - 1 and self.j <= main_grid.h - 1 -- 390
	self.arena_cell = false -- 391
	self.pointer_cell_ok = false -- 392
	self.pointer_cell_not_ok = false -- 393
	self.solid_cell = false -- 394
	self.word_cell = false -- 395
	self.counter_cell = false -- 396
	self.update = function(self, dt) -- 398
		if self.trigger_active['generation_collider'] and self.interactable_cell then -- 399
			self.arena_cell = true -- 399
		end -- 399
		if self.counter_cell then -- 400
			local _exp_0 = self.counter_cell -- 401
			if 'normal' == _exp_0 then -- 402
				return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.yellow[0]) -- 403
			elseif 'warning' == _exp_0 then -- 404
				return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.orange[0]) -- 405
			elseif 'danger' == _exp_0 then -- 406
				return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.red[0]) -- 407
			end -- 407
		elseif self.word_cell then -- 408
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.bg[0]) -- 409
			if type(self.word_cell) == 'string' then -- 410
				return game:draw_text_centered(self.word_cell, font, self.x, self.y, 0, 1, 1, 0, 0, colors.fg[0]) -- 410
			end -- 410
		elseif self.solid_cell then -- 411
			return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_solid_color) -- 412
		elseif self.pointer_cell_ok then -- 413
			return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_pointer_ok_color) -- 414
		elseif self.pointer_cell_not_ok then -- 415
			return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_pointer_not_ok_color) -- 416
		elseif self.arena_cell then -- 417
			return game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_marker_color) -- 418
		end -- 400
	end -- 398
	return self -- 419
end -- 385
reset_cell = function(self) -- 421
	self.collision_active['generation_collider'] = nil -- 422
	self.trigger_active['generation_collider'] = nil -- 423
	self.arena_cell = false -- 424
	self.pointer_cell_ok = false -- 425
	self.pointer_cell_not_ok = false -- 426
	self.solid_cell = false -- 427
	self.word_cell = false -- 428
end -- 421
generation_collider = function(x, y, w, h) -- 431
	local self = anchor('generation_collider') -- 432
	self:prs_init(x, y) -- 433
	if w and h then -- 434
		self:collider_init('generation_collider', 'dynamic', 'rectangle', w, h) -- 435
	else -- 437
		self:collider_init('generation_collider', 'dynamic', 'circle', w) -- 437
	end -- 434
	self.update = function(self, dt) -- 439
		self:collider_update_position_and_angle() -- 440
		if self.shape_type == 'circle' then -- 441
			return game:circle(self.x, self.y, self.rs, grid_marker_color, 2) -- 442
		else -- 444
			return game:polygon(self:collider_get_vertices(), grid_marker_color, 2) -- 444
		end -- 441
	end -- 439
	return self -- 445
end -- 431
