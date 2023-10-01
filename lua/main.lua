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
	sfx = sound_tag({ -- 10
		volume = 1 -- 10
	}) -- 10
	death = sound('assets/death.ogg', { -- 11
		tag = sfx -- 11
	}) -- 11
	deep_wobble = sound('assets/deep_wobble.ogg', { -- 12
		tag = sfx -- 12
	}) -- 12
	failed_placement = sound('assets/failed_placement.ogg', { -- 13
		tag = sfx -- 13
	}) -- 13
	failed_placement_2 = sound('assets/failed_placement_2.ogg', { -- 14
		tag = sfx -- 14
	}) -- 14
	generation_over = sound('assets/generation_over.ogg', { -- 15
		tag = sfx -- 15
	}) -- 15
	generation_shape_spawn = sound('assets/generation_shape_spawn.ogg', { -- 16
		tag = sfx -- 16
	}) -- 16
	rotate = sound('assets/rotate.ogg', { -- 17
		tag = sfx -- 17
	}) -- 17
	round_end = sound('assets/round_end.ogg', { -- 18
		tag = sfx -- 18
	}) -- 18
	score_count_tile = sound('assets/score_count_tile.ogg', { -- 19
		tag = sfx -- 19
	}) -- 19
	successful_placement = sound('assets/successful_placement.ogg', { -- 20
		tag = sfx -- 20
	}) -- 20
	successful_placement_2 = sound('assets/successful_placement_2.ogg', { -- 21
		tag = sfx -- 21
	}) -- 21
	warning = sound('assets/warning.ogg', { -- 22
		tag = sfx -- 22
	}) -- 22
	grid_marker_color = colors.bg[0]:color_clone() -- 24
	grid_marker_color.a = 0.08 -- 25
	bottom_counter_color = colors.bg[0]:color_clone() -- 26
	bottom_counter_color.a = 0.20 -- 27
	grid_pointer_ok_color = colors.green[0]:color_clone() -- 28
	grid_pointer_ok_color.a = 0.32 -- 29
	grid_pointer_ok_outline_color = colors.green[0]:color_clone() -- 30
	grid_pointer_ok_outline_color.a = 0.64 -- 31
	grid_pointer_not_ok_color = colors.red[0]:color_clone() -- 32
	grid_pointer_not_ok_color.a = 0.32 -- 33
	grid_pointer_not_ok_outline_color = colors.red[0]:color_clone() -- 34
	grid_pointer_not_ok_outline_color.a = 0.64 -- 35
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
					-1, -- 54
					0 -- 54
				}, -- 54
				{ -- 54
					1, -- 54
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
					-1 -- 55
				}, -- 55
				{ -- 55
					0, -- 55
					1 -- 55
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
					1, -- 56
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
					1 -- 57
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
					-1, -- 60
					0 -- 60
				}, -- 60
				{ -- 60
					1, -- 60
					0 -- 60
				}, -- 60
				{ -- 60
					2, -- 60
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
					-1 -- 61
				}, -- 61
				{ -- 61
					0, -- 61
					1 -- 61
				}, -- 61
				{ -- 61
					0, -- 61
					2 -- 61
				} -- 61
			}, -- 61
			{ -- 62
				{ -- 62
					0, -- 62
					0 -- 62
				}, -- 62
				{ -- 62
					1, -- 62
					0 -- 62
				}, -- 62
				{ -- 62
					-1, -- 62
					0 -- 62
				}, -- 62
				{ -- 62
					-2, -- 62
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
					1 -- 63
				}, -- 63
				{ -- 63
					0, -- 63
					-1 -- 63
				}, -- 63
				{ -- 63
					0, -- 63
					-2 -- 63
				} -- 63
			} -- 63
		}, -- 59
		short_j = { -- 66
			{ -- 66
				{ -- 66
					0, -- 66
					0 -- 66
				}, -- 66
				{ -- 66
					-1, -- 66
					0 -- 66
				}, -- 66
				{ -- 66
					-1, -- 66
					-1 -- 66
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
					0, -- 67
					1 -- 67
				}, -- 67
				{ -- 67
					0, -- 67
					-1 -- 67
				}, -- 67
				{ -- 67
					1, -- 67
					-1 -- 67
				} -- 67
			}, -- 67
			{ -- 68
				{ -- 68
					0, -- 68
					0 -- 68
				}, -- 68
				{ -- 68
					-1, -- 68
					0 -- 68
				}, -- 68
				{ -- 68
					1, -- 68
					0 -- 68
				}, -- 68
				{ -- 68
					1, -- 68
					1 -- 68
				} -- 68
			}, -- 68
			{ -- 69
				{ -- 69
					0, -- 69
					0 -- 69
				}, -- 69
				{ -- 69
					0, -- 69
					-1 -- 69
				}, -- 69
				{ -- 69
					0, -- 69
					1 -- 69
				}, -- 69
				{ -- 69
					-1, -- 69
					1 -- 69
				} -- 69
			} -- 69
		}, -- 65
		long_j = { -- 72
			{ -- 72
				{ -- 72
					0, -- 72
					0 -- 72
				}, -- 72
				{ -- 72
					-1, -- 72
					0 -- 72
				}, -- 72
				{ -- 72
					-1, -- 72
					-1 -- 72
				}, -- 72
				{ -- 72
					1, -- 72
					0 -- 72
				}, -- 72
				{ -- 72
					2, -- 72
					0 -- 72
				} -- 72
			}, -- 72
			{ -- 73
				{ -- 73
					0, -- 73
					0 -- 73
				}, -- 73
				{ -- 73
					0, -- 73
					1 -- 73
				}, -- 73
				{ -- 73
					0, -- 73
					2 -- 73
				}, -- 73
				{ -- 73
					0, -- 73
					-1 -- 73
				}, -- 73
				{ -- 73
					1, -- 73
					-1 -- 73
				} -- 73
			}, -- 73
			{ -- 74
				{ -- 74
					0, -- 74
					0 -- 74
				}, -- 74
				{ -- 74
					-1, -- 74
					0 -- 74
				}, -- 74
				{ -- 74
					-2, -- 74
					0 -- 74
				}, -- 74
				{ -- 74
					1, -- 74
					0 -- 74
				}, -- 74
				{ -- 74
					1, -- 74
					1 -- 74
				} -- 74
			}, -- 74
			{ -- 75
				{ -- 75
					0, -- 75
					0 -- 75
				}, -- 75
				{ -- 75
					0, -- 75
					-1 -- 75
				}, -- 75
				{ -- 75
					0, -- 75
					-2 -- 75
				}, -- 75
				{ -- 75
					0, -- 75
					1 -- 75
				}, -- 75
				{ -- 75
					-1, -- 75
					1 -- 75
				} -- 75
			} -- 75
		}, -- 71
		short_l = { -- 78
			{ -- 78
				{ -- 78
					0, -- 78
					0 -- 78
				}, -- 78
				{ -- 78
					-1, -- 78
					0 -- 78
				}, -- 78
				{ -- 78
					1, -- 78
					0 -- 78
				}, -- 78
				{ -- 78
					1, -- 78
					-1 -- 78
				} -- 78
			}, -- 78
			{ -- 79
				{ -- 79
					0, -- 79
					0 -- 79
				}, -- 79
				{ -- 79
					0, -- 79
					-1 -- 79
				}, -- 79
				{ -- 79
					0, -- 79
					1 -- 79
				}, -- 79
				{ -- 79
					1, -- 79
					1 -- 79
				} -- 79
			}, -- 79
			{ -- 80
				{ -- 80
					0, -- 80
					0 -- 80
				}, -- 80
				{ -- 80
					1, -- 80
					0 -- 80
				}, -- 80
				{ -- 80
					-1, -- 80
					0 -- 80
				}, -- 80
				{ -- 80
					-1, -- 80
					1 -- 80
				} -- 80
			}, -- 80
			{ -- 81
				{ -- 81
					0, -- 81
					0 -- 81
				}, -- 81
				{ -- 81
					0, -- 81
					1 -- 81
				}, -- 81
				{ -- 81
					0, -- 81
					-1 -- 81
				}, -- 81
				{ -- 81
					-1, -- 81
					-1 -- 81
				} -- 81
			} -- 81
		}, -- 77
		long_l = { -- 84
			{ -- 84
				{ -- 84
					0, -- 84
					0 -- 84
				}, -- 84
				{ -- 84
					-1, -- 84
					0 -- 84
				}, -- 84
				{ -- 84
					-2, -- 84
					0 -- 84
				}, -- 84
				{ -- 84
					1, -- 84
					0 -- 84
				}, -- 84
				{ -- 84
					1, -- 84
					-1 -- 84
				} -- 84
			}, -- 84
			{ -- 85
				{ -- 85
					0, -- 85
					0 -- 85
				}, -- 85
				{ -- 85
					0, -- 85
					-1 -- 85
				}, -- 85
				{ -- 85
					0, -- 85
					-2 -- 85
				}, -- 85
				{ -- 85
					0, -- 85
					1 -- 85
				}, -- 85
				{ -- 85
					1, -- 85
					1 -- 85
				} -- 85
			}, -- 85
			{ -- 86
				{ -- 86
					0, -- 86
					0 -- 86
				}, -- 86
				{ -- 86
					1, -- 86
					0 -- 86
				}, -- 86
				{ -- 86
					2, -- 86
					0 -- 86
				}, -- 86
				{ -- 86
					-1, -- 86
					0 -- 86
				}, -- 86
				{ -- 86
					-1, -- 86
					1 -- 86
				} -- 86
			}, -- 86
			{ -- 87
				{ -- 87
					0, -- 87
					0 -- 87
				}, -- 87
				{ -- 87
					0, -- 87
					1 -- 87
				}, -- 87
				{ -- 87
					0, -- 87
					2 -- 87
				}, -- 87
				{ -- 87
					0, -- 87
					-1 -- 87
				}, -- 87
				{ -- 87
					-1, -- 87
					-1 -- 87
				} -- 87
			} -- 87
		}, -- 83
		short_s = { -- 90
			{ -- 90
				{ -- 90
					0, -- 90
					0 -- 90
				}, -- 90
				{ -- 90
					-1, -- 90
					0 -- 90
				}, -- 90
				{ -- 90
					0, -- 90
					-1 -- 90
				}, -- 90
				{ -- 90
					1, -- 90
					-1 -- 90
				} -- 90
			}, -- 90
			{ -- 91
				{ -- 91
					0, -- 91
					0 -- 91
				}, -- 91
				{ -- 91
					0, -- 91
					-1 -- 91
				}, -- 91
				{ -- 91
					1, -- 91
					0 -- 91
				}, -- 91
				{ -- 91
					1, -- 91
					1 -- 91
				} -- 91
			}, -- 91
			{ -- 92
				{ -- 92
					0, -- 92
					0 -- 92
				}, -- 92
				{ -- 92
					1, -- 92
					0 -- 92
				}, -- 92
				{ -- 92
					0, -- 92
					1 -- 92
				}, -- 92
				{ -- 92
					-1, -- 92
					1 -- 92
				} -- 92
			}, -- 92
			{ -- 93
				{ -- 93
					0, -- 93
					0 -- 93
				}, -- 93
				{ -- 93
					0, -- 93
					1 -- 93
				}, -- 93
				{ -- 93
					-1, -- 93
					0 -- 93
				}, -- 93
				{ -- 93
					-1, -- 93
					-1 -- 93
				} -- 93
			} -- 93
		}, -- 89
		long_s = { -- 96
			{ -- 96
				{ -- 96
					0, -- 96
					0 -- 96
				}, -- 96
				{ -- 96
					-1, -- 96
					0 -- 96
				}, -- 96
				{ -- 96
					-2, -- 96
					0 -- 96
				}, -- 96
				{ -- 96
					0, -- 96
					-1 -- 96
				}, -- 96
				{ -- 96
					1, -- 96
					-1 -- 96
				} -- 96
			}, -- 96
			{ -- 97
				{ -- 97
					0, -- 97
					0 -- 97
				}, -- 97
				{ -- 97
					0, -- 97
					-1 -- 97
				}, -- 97
				{ -- 97
					0, -- 97
					-2 -- 97
				}, -- 97
				{ -- 97
					1, -- 97
					0 -- 97
				}, -- 97
				{ -- 97
					1, -- 97
					1 -- 97
				} -- 97
			}, -- 97
			{ -- 98
				{ -- 98
					0, -- 98
					0 -- 98
				}, -- 98
				{ -- 98
					1, -- 98
					0 -- 98
				}, -- 98
				{ -- 98
					2, -- 98
					0 -- 98
				}, -- 98
				{ -- 98
					0, -- 98
					1 -- 98
				}, -- 98
				{ -- 98
					-1, -- 98
					1 -- 98
				} -- 98
			}, -- 98
			{ -- 99
				{ -- 99
					0, -- 99
					0 -- 99
				}, -- 99
				{ -- 99
					0, -- 99
					1 -- 99
				}, -- 99
				{ -- 99
					0, -- 99
					2 -- 99
				}, -- 99
				{ -- 99
					-1, -- 99
					0 -- 99
				}, -- 99
				{ -- 99
					-1, -- 99
					-1 -- 99
				} -- 99
			} -- 99
		}, -- 95
		short_z = { -- 102
			{ -- 102
				{ -- 102
					0, -- 102
					0 -- 102
				}, -- 102
				{ -- 102
					1, -- 102
					0 -- 102
				}, -- 102
				{ -- 102
					0, -- 102
					-1 -- 102
				}, -- 102
				{ -- 102
					-1, -- 102
					-1 -- 102
				} -- 102
			}, -- 102
			{ -- 103
				{ -- 103
					0, -- 103
					0 -- 103
				}, -- 103
				{ -- 103
					0, -- 103
					1 -- 103
				}, -- 103
				{ -- 103
					1, -- 103
					0 -- 103
				}, -- 103
				{ -- 103
					1, -- 103
					-1 -- 103
				} -- 103
			}, -- 103
			{ -- 104
				{ -- 104
					0, -- 104
					0 -- 104
				}, -- 104
				{ -- 104
					-1, -- 104
					0 -- 104
				}, -- 104
				{ -- 104
					0, -- 104
					1 -- 104
				}, -- 104
				{ -- 104
					1, -- 104
					1 -- 104
				} -- 104
			}, -- 104
			{ -- 105
				{ -- 105
					0, -- 105
					0 -- 105
				}, -- 105
				{ -- 105
					0, -- 105
					-1 -- 105
				}, -- 105
				{ -- 105
					-1, -- 105
					0 -- 105
				}, -- 105
				{ -- 105
					-1, -- 105
					1 -- 105
				} -- 105
			} -- 105
		}, -- 101
		long_z = { -- 108
			{ -- 108
				{ -- 108
					0, -- 108
					0 -- 108
				}, -- 108
				{ -- 108
					1, -- 108
					0 -- 108
				}, -- 108
				{ -- 108
					2, -- 108
					0 -- 108
				}, -- 108
				{ -- 108
					0, -- 108
					-1 -- 108
				}, -- 108
				{ -- 108
					-1, -- 108
					-1 -- 108
				} -- 108
			}, -- 108
			{ -- 109
				{ -- 109
					0, -- 109
					0 -- 109
				}, -- 109
				{ -- 109
					0, -- 109
					1 -- 109
				}, -- 109
				{ -- 109
					0, -- 109
					2 -- 109
				}, -- 109
				{ -- 109
					1, -- 109
					0 -- 109
				}, -- 109
				{ -- 109
					1, -- 109
					-1 -- 109
				} -- 109
			}, -- 109
			{ -- 110
				{ -- 110
					0, -- 110
					0 -- 110
				}, -- 110
				{ -- 110
					-1, -- 110
					0 -- 110
				}, -- 110
				{ -- 110
					-2, -- 110
					0 -- 110
				}, -- 110
				{ -- 110
					0, -- 110
					1 -- 110
				}, -- 110
				{ -- 110
					1, -- 110
					1 -- 110
				} -- 110
			}, -- 110
			{ -- 111
				{ -- 111
					0, -- 111
					0 -- 111
				}, -- 111
				{ -- 111
					0, -- 111
					-1 -- 111
				}, -- 111
				{ -- 111
					0, -- 111
					-2 -- 111
				}, -- 111
				{ -- 111
					-1, -- 111
					0 -- 111
				}, -- 111
				{ -- 111
					-1, -- 111
					1 -- 111
				} -- 111
			} -- 111
		}, -- 107
		short_v = { -- 114
			{ -- 114
				{ -- 114
					0, -- 114
					0 -- 114
				}, -- 114
				{ -- 114
					1, -- 114
					0 -- 114
				}, -- 114
				{ -- 114
					0, -- 114
					-1 -- 114
				} -- 114
			}, -- 114
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
					1 -- 115
				} -- 115
			}, -- 115
			{ -- 116
				{ -- 116
					0, -- 116
					0 -- 116
				}, -- 116
				{ -- 116
					-1, -- 116
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
					0, -- 117
					-1 -- 117
				}, -- 117
				{ -- 117
					-1, -- 117
					0 -- 117
				} -- 117
			} -- 117
		}, -- 113
		long_v = { -- 120
			{ -- 120
				{ -- 120
					0, -- 120
					0 -- 120
				}, -- 120
				{ -- 120
					1, -- 120
					0 -- 120
				}, -- 120
				{ -- 120
					2, -- 120
					0 -- 120
				}, -- 120
				{ -- 120
					0, -- 120
					-1 -- 120
				}, -- 120
				{ -- 120
					0, -- 120
					-2 -- 120
				} -- 120
			}, -- 120
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
					1 -- 121
				}, -- 121
				{ -- 121
					0, -- 121
					2 -- 121
				} -- 121
			}, -- 121
			{ -- 122
				{ -- 122
					0, -- 122
					0 -- 122
				}, -- 122
				{ -- 122
					-1, -- 122
					0 -- 122
				}, -- 122
				{ -- 122
					-2, -- 122
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
					0, -- 123
					-1 -- 123
				}, -- 123
				{ -- 123
					0, -- 123
					-2 -- 123
				}, -- 123
				{ -- 123
					-1, -- 123
					0 -- 123
				}, -- 123
				{ -- 123
					-2, -- 123
					0 -- 123
				} -- 123
			} -- 123
		}, -- 119
		o = { -- 126
			{ -- 126
				{ -- 126
					0, -- 126
					0 -- 126
				}, -- 126
				{ -- 126
					1, -- 126
					0 -- 126
				}, -- 126
				{ -- 126
					1, -- 126
					1 -- 126
				}, -- 126
				{ -- 126
					0, -- 126
					1 -- 126
				} -- 126
			}, -- 126
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
			} -- 129
		}, -- 125
		x = { -- 132
			{ -- 132
				{ -- 132
					0, -- 132
					0 -- 132
				}, -- 132
				{ -- 132
					1, -- 132
					0 -- 132
				}, -- 132
				{ -- 132
					-1, -- 132
					0 -- 132
				}, -- 132
				{ -- 132
					0, -- 132
					1 -- 132
				}, -- 132
				{ -- 132
					0, -- 132
					-1 -- 132
				} -- 132
			}, -- 132
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
			} -- 135
		}, -- 131
		f = { -- 138
			{ -- 138
				{ -- 138
					0, -- 138
					0 -- 138
				}, -- 138
				{ -- 138
					0, -- 138
					1 -- 138
				}, -- 138
				{ -- 138
					0, -- 138
					-1 -- 138
				}, -- 138
				{ -- 138
					1, -- 138
					-1 -- 138
				}, -- 138
				{ -- 138
					-1, -- 138
					0 -- 138
				} -- 138
			}, -- 138
			{ -- 139
				{ -- 139
					0, -- 139
					0 -- 139
				}, -- 139
				{ -- 139
					-1, -- 139
					0 -- 139
				}, -- 139
				{ -- 139
					1, -- 139
					0 -- 139
				}, -- 139
				{ -- 139
					1, -- 139
					1 -- 139
				}, -- 139
				{ -- 139
					0, -- 139
					-1 -- 139
				} -- 139
			}, -- 139
			{ -- 140
				{ -- 140
					0, -- 140
					0 -- 140
				}, -- 140
				{ -- 140
					0, -- 140
					-1 -- 140
				}, -- 140
				{ -- 140
					0, -- 140
					1 -- 140
				}, -- 140
				{ -- 140
					-1, -- 140
					1 -- 140
				}, -- 140
				{ -- 140
					1, -- 140
					0 -- 140
				} -- 140
			}, -- 140
			{ -- 141
				{ -- 141
					0, -- 141
					0 -- 141
				}, -- 141
				{ -- 141
					-1, -- 141
					0 -- 141
				}, -- 141
				{ -- 141
					-1, -- 141
					-1 -- 141
				}, -- 141
				{ -- 141
					1, -- 141
					0 -- 141
				}, -- 141
				{ -- 141
					0, -- 141
					1 -- 141
				} -- 141
			} -- 141
		}, -- 137
		p = { -- 144
			{ -- 144
				{ -- 144
					0, -- 144
					0 -- 144
				}, -- 144
				{ -- 144
					0, -- 144
					-1 -- 144
				}, -- 144
				{ -- 144
					0, -- 144
					1 -- 144
				}, -- 144
				{ -- 144
					1, -- 144
					-1 -- 144
				}, -- 144
				{ -- 144
					1, -- 144
					0 -- 144
				} -- 144
			}, -- 144
			{ -- 145
				{ -- 145
					0, -- 145
					0 -- 145
				}, -- 145
				{ -- 145
					-1, -- 145
					0 -- 145
				}, -- 145
				{ -- 145
					1, -- 145
					0 -- 145
				}, -- 145
				{ -- 145
					0, -- 145
					1 -- 145
				}, -- 145
				{ -- 145
					1, -- 145
					1 -- 145
				} -- 145
			}, -- 145
			{ -- 146
				{ -- 146
					0, -- 146
					0 -- 146
				}, -- 146
				{ -- 146
					0, -- 146
					-1 -- 146
				}, -- 146
				{ -- 146
					0, -- 146
					1 -- 146
				}, -- 146
				{ -- 146
					-1, -- 146
					0 -- 146
				}, -- 146
				{ -- 146
					-1, -- 146
					1 -- 146
				} -- 146
			}, -- 146
			{ -- 147
				{ -- 147
					0, -- 147
					0 -- 147
				}, -- 147
				{ -- 147
					1, -- 147
					0 -- 147
				}, -- 147
				{ -- 147
					-1, -- 147
					0 -- 147
				}, -- 147
				{ -- 147
					-1, -- 147
					-1 -- 147
				}, -- 147
				{ -- 147
					0, -- 147
					-1 -- 147
				} -- 147
			} -- 147
		}, -- 143
		u = { -- 150
			{ -- 150
				{ -- 150
					0, -- 150
					0 -- 150
				}, -- 150
				{ -- 150
					0, -- 150
					1 -- 150
				}, -- 150
				{ -- 150
					0, -- 150
					-1 -- 150
				}, -- 150
				{ -- 150
					1, -- 150
					1 -- 150
				}, -- 150
				{ -- 150
					1, -- 150
					-1 -- 150
				} -- 150
			}, -- 150
			{ -- 151
				{ -- 151
					0, -- 151
					0 -- 151
				}, -- 151
				{ -- 151
					-1, -- 151
					0 -- 151
				}, -- 151
				{ -- 151
					1, -- 151
					0 -- 151
				}, -- 151
				{ -- 151
					1, -- 151
					1 -- 151
				}, -- 151
				{ -- 151
					-1, -- 151
					1 -- 151
				} -- 151
			}, -- 151
			{ -- 152
				{ -- 152
					0, -- 152
					0 -- 152
				}, -- 152
				{ -- 152
					0, -- 152
					-1 -- 152
				}, -- 152
				{ -- 152
					0, -- 152
					1 -- 152
				}, -- 152
				{ -- 152
					-1, -- 152
					1 -- 152
				}, -- 152
				{ -- 152
					-1, -- 152
					-1 -- 152
				} -- 152
			}, -- 152
			{ -- 153
				{ -- 153
					0, -- 153
					0 -- 153
				}, -- 153
				{ -- 153
					-1, -- 153
					0 -- 153
				}, -- 153
				{ -- 153
					-1, -- 153
					-1 -- 153
				}, -- 153
				{ -- 153
					1, -- 153
					0 -- 153
				}, -- 153
				{ -- 153
					1, -- 153
					-1 -- 153
				} -- 153
			} -- 153
		}, -- 149
		y = { -- 156
			{ -- 156
				{ -- 156
					0, -- 156
					0 -- 156
				}, -- 156
				{ -- 156
					-1, -- 156
					0 -- 156
				}, -- 156
				{ -- 156
					1, -- 156
					0 -- 156
				}, -- 156
				{ -- 156
					2, -- 156
					0 -- 156
				}, -- 156
				{ -- 156
					0, -- 156
					-1 -- 156
				} -- 156
			}, -- 156
			{ -- 157
				{ -- 157
					0, -- 157
					0 -- 157
				}, -- 157
				{ -- 157
					0, -- 157
					-1 -- 157
				}, -- 157
				{ -- 157
					0, -- 157
					1 -- 157
				}, -- 157
				{ -- 157
					0, -- 157
					2 -- 157
				}, -- 157
				{ -- 157
					1, -- 157
					0 -- 157
				} -- 157
			}, -- 157
			{ -- 158
				{ -- 158
					0, -- 158
					0 -- 158
				}, -- 158
				{ -- 158
					1, -- 158
					0 -- 158
				}, -- 158
				{ -- 158
					-1, -- 158
					0 -- 158
				}, -- 158
				{ -- 158
					-2, -- 158
					0 -- 158
				}, -- 158
				{ -- 158
					0, -- 158
					1 -- 158
				} -- 158
			}, -- 158
			{ -- 159
				{ -- 159
					0, -- 159
					0 -- 159
				}, -- 159
				{ -- 159
					0, -- 159
					1 -- 159
				}, -- 159
				{ -- 159
					0, -- 159
					-1 -- 159
				}, -- 159
				{ -- 159
					0, -- 159
					-2 -- 159
				}, -- 159
				{ -- 159
					-1, -- 159
					0 -- 159
				} -- 159
			} -- 159
		}, -- 155
		z = { -- 162
			{ -- 162
				{ -- 162
					0, -- 162
					0 -- 162
				}, -- 162
				{ -- 162
					0, -- 162
					-1 -- 162
				}, -- 162
				{ -- 162
					0, -- 162
					1 -- 162
				}, -- 162
				{ -- 162
					1, -- 162
					1 -- 162
				}, -- 162
				{ -- 162
					-1, -- 162
					-1 -- 162
				} -- 162
			}, -- 162
			{ -- 163
				{ -- 163
					0, -- 163
					0 -- 163
				}, -- 163
				{ -- 163
					1, -- 163
					0 -- 163
				}, -- 163
				{ -- 163
					-1, -- 163
					0 -- 163
				}, -- 163
				{ -- 163
					-1, -- 163
					1 -- 163
				}, -- 163
				{ -- 163
					1, -- 163
					-1 -- 163
				} -- 163
			}, -- 163
			{ -- 164
				{ -- 164
					0, -- 164
					0 -- 164
				}, -- 164
				{ -- 164
					0, -- 164
					1 -- 164
				}, -- 164
				{ -- 164
					0, -- 164
					-1 -- 164
				}, -- 164
				{ -- 164
					-1, -- 164
					-1 -- 164
				}, -- 164
				{ -- 164
					1, -- 164
					1 -- 164
				} -- 164
			}, -- 164
			{ -- 165
				{ -- 165
					0, -- 165
					0 -- 165
				}, -- 165
				{ -- 165
					-1, -- 165
					0 -- 165
				}, -- 165
				{ -- 165
					1, -- 165
					0 -- 165
				}, -- 165
				{ -- 165
					1, -- 165
					-1 -- 165
				}, -- 165
				{ -- 165
					-1, -- 165
					1 -- 165
				} -- 165
			} -- 165
		} -- 161
	} -- 40
	objects = container() -- 170
	main:physics_world_set_collision_tags({ -- 171
		'cell', -- 171
		'generation_collider' -- 171
	}) -- 171
	main:physics_world_disable_collision_between('cell', { -- 172
		'cell', -- 172
		'generation_collider' -- 172
	}) -- 172
	main:physics_world_enable_trigger_between('cell', { -- 173
		'generation_collider' -- 173
	}) -- 173
	player_score = 0 -- 175
	player_counter = 0 -- 176
	round_started = false -- 177
	bottom_counter_grayed = false -- 178
	bottom_counter_hidden = false -- 179
	main.bottom_counter_state = nil -- 180
	main:observer_condition((function() -- 183
		return player_counter >= 25 -- 183
	end), (function() -- 183
		reset_grid() -- 184
		death:sound_play(0.75, main:random_float(0.95, 1.05)) -- 186
		main:timer_cancel('warning') -- 187
		game_over = true -- 188
		round_started = false -- 189
		bottom_counter_hidden = false -- 190
		bottom_counter_grayed = true -- 191
		main.bottom_counter_state = nil -- 192
		set_text(8, 9, 'GAME OVER') -- 193
		t = "SCORE: " .. tostring(player_score) -- 194
		set_text(math.ceil((24 - utf8.len(t)) / 2), 10, "SCORE: " .. tostring(player_score)) -- 195
		return set_text(2, 11, 'left click to restart') -- 196
	end)) -- 183
	main:observer_condition((function() -- 200
		return player_counter >= 16 -- 200
	end), (function() -- 200
		main.bottom_counter_state = 'warning' -- 200
	end)) -- 200
	main:observer_condition((function() -- 201
		return player_counter >= 20 -- 201
	end), (function() -- 201
		main.bottom_counter_state = 'danger' -- 201
	end)) -- 201
	main:observer_value('bottom_counter_state', 'normal', (function() -- 203
		return main:timer_cancel('warning') -- 203
	end)) -- 203
	main:observer_value('bottom_counter_state', 'warning', (function() -- 204
		return main:timer_every(0.8, (function() -- 205
			bottom_counter_hidden = not bottom_counter_hidden -- 206
			return warning:sound_play(0.75) -- 207
		end), nil, nil, nil, 'warning') -- 208
	end)) -- 204
	main_grid = grid(24, 24, 0) -- 212
	cell_w, cell_h = main.w / main_grid.w, main.h / main_grid.h -- 213
	for i = 1, main_grid.w do -- 214
		for j = 1, main_grid.h do -- 215
			main_grid:grid_set(i, j, cell(i, j)) -- 216
		end -- 216
	end -- 216
	starting_game = true -- 219
	set_text(6, 4, 'M8B1674-00D4') -- 220
	set_text(6, 11, 'fill the area') -- 221
	set_text(5, 12, 'until the next') -- 222
	set_text(5, 13, 'shape wont fit') -- 223
	set_text(4, 20, 'left click: place') -- 224
	return set_text(3, 21, 'right click: rotate') -- 225
end -- 4
update = function(dt) -- 228
	if (main:input_is_pressed('1') or main:input_is_pressed('2')) and starting_game then -- 232
		starting_game = false -- 233
		reset_grid() -- 234
		generate_arena() -- 235
	end -- 232
	if main:input_is_pressed('2') then -- 238
		rotate:sound_play(0.75, main:random_float(0.95, 1.05)) -- 239
		pointer_shape_rotation = pointer_shape_rotation + 1 -- 240
		if pointer_shape_rotation == 5 then -- 241
			pointer_shape_rotation = 1 -- 241
		end -- 241
	end -- 238
	if round_started then -- 244
		player_counter = player_counter + 0.75 * dt -- 245
	end -- 244
	set_bottom_counter(player_counter) -- 246
	if main.bottom_counter_state == 'warning' or main.bottom_counter_state == 'danger' then -- 248
		local warning_speed = math.remap(25 - player_counter, 9, 0, 1, 0.1) -- 249
		print(warning_speed) -- 250
		main:timer_set_multiplier('warning', warning_speed) -- 251
	end -- 248
	for i = 2, main_grid.w - 1 do -- 254
		for j = 2, main_grid.h - 1 do -- 255
			local cell = main_grid:grid_get(i, j) -- 256
			cell.pointer_cell_ok = false -- 257
			cell.pointer_cell_not_ok = false -- 258
		end -- 258
	end -- 258
	local x, y = math.ceil(main.pointer.x / cell_w), math.ceil(main.pointer.y / cell_h) -- 261
	local any_cell_not_ok = false -- 262
	local current_cells = { } -- 263
	if pointer_shape and round_started then -- 264
		local shape = shapes[pointer_shape][pointer_shape_rotation] -- 265
		if does_shape_fit(x, y, shape) then -- 266
			for _index_0 = 1, #shape do -- 267
				local offset = shape[_index_0] -- 267
				do -- 268
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 268
					if cell then -- 268
						if cell.interactable_cell then -- 269
							current_cells[#current_cells + 1] = cell -- 270
							cell.pointer_cell_ok = true -- 271
						end -- 269
					end -- 268
				end -- 268
			end -- 271
		else -- 273
			any_cell_not_ok = true -- 273
			for _index_0 = 1, #shape do -- 274
				local offset = shape[_index_0] -- 274
				do -- 275
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 275
					if cell then -- 275
						if cell.interactable_cell then -- 276
							current_cells[#current_cells + 1] = cell -- 277
							cell.pointer_cell_not_ok = true -- 278
						end -- 276
					end -- 275
				end -- 275
			end -- 278
		end -- 266
	end -- 264
	if main:input_is_pressed('1') and any_cell_not_ok and round_started then -- 280
		failed_placement:sound_play(0.375, main:random_float(0.95, 1.05)) -- 281
		failed_placement_2:sound_play(0.75, main:random_float(0.95, 1.05)) -- 282
		for _index_0 = 1, #current_cells do -- 283
			local cell = current_cells[_index_0] -- 283
			if cell.interactable_cell and cell.arena_cell then -- 284
				cell:shake_shake(4, 0.2) -- 285
			end -- 284
		end -- 285
	end -- 280
	if main:input_is_pressed('1') and not any_cell_not_ok and round_started then -- 288
		successful_placement:sound_play(0.375, main:random_float(0.95, 1.05)) -- 289
		successful_placement_2:sound_play(0.75) -- 290
		for _index_0 = 1, #current_cells do -- 291
			local cell = current_cells[_index_0] -- 291
			if cell.interactable_cell and cell.arena_cell then -- 292
				cell.pointer_cell_ok = false -- 293
				cell.pointer_cell_not_ok = false -- 294
				cell.solid_cell = true -- 295
				hitfx_cell(cell, 0.2, 0.15) -- 296
			end -- 292
		end -- 296
		pointer_shape = nil -- 299
		main:timer_after(0.3, (function() -- 300
			pointer_shape = get_next_pointer_shape() -- 301
			if not does_shape_fit_arena(shapes[pointer_shape]) then -- 303
				pointer_shape = nil -- 304
				local added_score = get_solid_cell_score() -- 305
				print(added_score) -- 306
				round_started = false -- 307
				player_score = player_score -- 308
				player_counter = player_counter -- 309
				main:timer_tween(0.64, _G, { -- 310
					player_counter = player_counter - added_score / 10 -- 310
				}, math.cubic_in_out, (function() -- 310
					if player_counter < 0 then -- 311
						player_counter = 0 -- 311
					end -- 311
					if player_counter < 16 then -- 312
						main.bottom_counter_state = 'normal' -- 312
					end -- 312
					if player_counter >= 16 and player_counter < 20 then -- 313
						main.bottom_counter_state = 'warning' -- 313
					end -- 313
					bottom_counter_grayed = true -- 314
				end), 'player_counter') -- 310
				local solid_cells = { } -- 316
				for x = 2, main_grid.w do -- 317
					for y = 2, main_grid.h do -- 318
						do -- 319
							local cell = main_grid:grid_get(x, y) -- 319
							if cell then -- 319
								if cell.solid_cell then -- 320
									solid_cells[#solid_cells + 1] = cell -- 321
								else -- 323
									reset_cell(cell) -- 323
								end -- 320
							end -- 319
						end -- 319
					end -- 323
				end -- 323
				table.shuffle(solid_cells) -- 324
				main:timer_after(0.5, (function() -- 325
					round_end:sound_play(0.75, main:random_float(0.95, 1.05)) -- 326
					deep_wobble:sound_play(0.75, main:random_float(0.95, 1.05)) -- 327
					for i, solid_cell in ipairs(solid_cells) do -- 328
						hitfx_cell(solid_cell, 0.0, nil, nil, 0.15) -- 329
						main:timer_after(0.1, (function() -- 330
							local score = get_solid_neighbor_count(solid_cell.i, solid_cell.j) -- 331
							solid_cell.solid_word_cell = tostring(score) -- 332
						end)) -- 330
					end -- 333
				end)) -- 325
				local pitch = 0.75 -- 335
				main:timer_after(3, (function() -- 336
					for i, solid_cell in ipairs(solid_cells) do -- 337
						main:timer_after((i - 1) * 0.05, (function() -- 338
							local score = get_solid_neighbor_count(solid_cell.i, solid_cell.j) -- 339
							pitch = pitch + (i * (score / 200)) -- 340
							score_count_tile:sound_play(0.8, pitch) -- 341
							solid_cell.solid_word_cell = '0' -- 342
							player_score = player_score + score -- 343
							return set_top_text("SCORE: " .. tostring(player_score)) -- 344
						end)) -- 338
					end -- 345
				end)) -- 336
				return main:timer_after(4 + 0.05 * #solid_cells, (function() -- 347
					reset_grid() -- 348
					return generate_arena() -- 349
				end)) -- 350
			end -- 303
		end), 'new_shape') -- 300
	end -- 288
	if main:input_is_pressed('1') and game_over then -- 354
		reset_grid() -- 355
		player_score = 0 -- 357
		player_counter = 0 -- 358
		round_started = false -- 359
		game_over = false -- 360
		main.bottom_counter_state = nil -- 361
		bottom_counter_grayed = false -- 362
		generate_arena() -- 363
	end -- 354
	bg:rectangle(0.5 * main.w, 0.5 * main.h, main.w, main.h, 0, 0, colors.fg[0]) -- 366
	bg2:set_blend_mode('replace') -- 367
	for i = 2, main_grid.w do -- 368
		for j = 2, main_grid.h do -- 369
			x, y = (i - 1) * cell_w, (j - 1) * cell_h -- 370
			local w, h = 5, 5 -- 371
			bg2:line(x - w / 2, y, x + w / 2, y, grid_marker_color, 1) -- 372
			bg2:line(x, y - h / 2, x, y + h / 2, grid_marker_color, 1) -- 373
		end -- 373
	end -- 373
	bg2:set_blend_mode() -- 374
	main_grid:grid_for_each((function(v, i, j) -- 377
		return v:update(dt) -- 377
	end)) -- 377
	objects:container_update(dt) -- 378
	return objects:container_remove_dead() -- 379
end -- 228
get_next_pointer_shape = function() -- 382
	pointer_shape_rotation = 1 -- 383
	return main:random_table({ -- 384
		'short_t', -- 384
		'long_t', -- 384
		'short_i', -- 384
		'long_i', -- 384
		'short_j', -- 384
		'long_j', -- 384
		'short_l', -- 384
		'long_l', -- 384
		'short_s', -- 384
		'long_s', -- 384
		'short_z', -- 384
		'long_z', -- 384
		'short_v', -- 384
		'long_v', -- 384
		'o', -- 384
		'x', -- 384
		'f', -- 384
		'p', -- 384
		'u', -- 384
		'y', -- 384
		'z' -- 384
	}) -- 384
end -- 382
set_text = function(x, y, text) -- 388
	for i = 1, utf8.len(text) do -- 389
		do -- 390
			local cell = main_grid:grid_get(x + i, y) -- 390
			if cell then -- 390
				cell.word_cell = utf8.sub(text, i, i) -- 391
			end -- 390
		end -- 390
	end -- 391
end -- 388
reset_grid = function() -- 394
	for x = 2, main_grid.w do -- 395
		for y = 2, main_grid.h do -- 396
			do -- 397
				local cell = main_grid:grid_get(x, y) -- 397
				if cell then -- 397
					reset_cell(cell) -- 398
				end -- 397
			end -- 397
		end -- 398
	end -- 398
end -- 394
set_bottom_counter = function(value) -- 402
	for i = 1, main_grid.w do -- 403
		local cell = main_grid:grid_get(i, main_grid.h) -- 404
		cell.counter_cell = nil -- 405
	end -- 405
	for i = 1, math.floor(value) do -- 406
		do -- 407
			local cell = main_grid:grid_get(i, main_grid.h) -- 407
			if cell then -- 407
				if i <= 16 then -- 408
					cell.counter_cell = 'normal' -- 409
				elseif i > 16 and i <= 20 then -- 410
					cell.counter_cell = 'warning' -- 411
				elseif i > 20 and i <= 25 then -- 412
					cell.counter_cell = 'danger' -- 413
				end -- 408
			end -- 407
		end -- 407
	end -- 413
end -- 402
set_top_text = function(text) -- 416
	for i = 1, main_grid.w do -- 417
		local cell = main_grid:grid_get(i, 1) -- 418
		cell.word_cell = '' -- 419
	end -- 419
	for i = 1, utf8.len(text) do -- 420
		local cell = main_grid:grid_get(i, 1) -- 421
		cell.word_cell = utf8.sub(text, i, i) -- 422
	end -- 422
end -- 416
generate_arena = function() -- 426
	main:timer_every(0.4, (function() -- 427
		local i = main:timer_get_every_index('set_top_text') -- 428
		if i % 4 == 1 then -- 429
			return set_top_text('GENERATING') -- 430
		elseif i % 4 == 2 then -- 431
			return set_top_text('GENERATING.') -- 432
		elseif i % 4 == 3 then -- 433
			return set_top_text('GENERATING..') -- 434
		elseif i % 4 == 0 then -- 435
			return set_top_text('GENERATING...') -- 436
		end -- 429
	end), nil, true, nil, 'set_top_text') -- 427
	spawning = true -- 439
	pointer_shape, pointer_shape_rotation = nil, 1 -- 440
	round_started = false -- 441
	local spawn_count = 10 -- 442
	return main:timer_every(0.1, (function() -- 443
		if main:random_bool(50) then -- 444
			objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(8, 20))) -- 445
		else -- 447
			objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(16, 40), main:random_float(16, 40))) -- 447
		end -- 444
		generation_shape_spawn:sound_play(0.75, main:random_float(0.7, 1.3)) -- 448
		return rotate:sound_play(0.75, main:random_float(0.7, 1.3)) -- 449
	end), spawn_count, true, (function() -- 450
		return main:timer_after(spawn_count / 15, (function() -- 451
			objects:container_destroy() -- 452
			bottom_counter_grayed = false -- 453
			main.bottom_counter_state = 'normal' -- 454
			round_started = true -- 455
			pointer_shape = get_next_pointer_shape() -- 456
			pointer_shape_rotation = 1 -- 457
			main:timer_cancel('set_top_text') -- 458
			set_top_text("SCORE: " .. tostring(player_score)) -- 459
			return generation_over:sound_play(0.75, main:random_float(0.95, 1.05)) -- 460
		end)) -- 461
	end)) -- 462
end -- 426
get_solid_cell_count = function() -- 465
	local count = 0 -- 466
	for x = 2, main_grid.w - 1 do -- 467
		for y = 2, main_grid.h - 1 do -- 468
			do -- 469
				local cell = main_grid:grid_get(x, y) -- 469
				if cell then -- 469
					if cell.solid_cell then -- 470
						count = count + 1 -- 471
					end -- 470
				end -- 469
			end -- 469
		end -- 471
	end -- 471
	return count -- 472
end -- 465
get_solid_cell_score = function() -- 475
	local count = 0 -- 476
	for x = 2, main_grid.w - 1 do -- 477
		for y = 2, main_grid.h - 1 do -- 478
			do -- 479
				local cell = main_grid:grid_get(x, y) -- 479
				if cell then -- 479
					if cell.solid_cell then -- 480
						count = count + get_solid_neighbor_count(x, y) -- 481
					end -- 480
				end -- 479
			end -- 479
		end -- 481
	end -- 481
	return count -- 482
end -- 475
get_solid_neighbor_count = function(x, y) -- 485
	local count = 0 -- 486
	do -- 487
		local cell = main_grid:grid_get(x, y) -- 487
		if cell then -- 487
			local left, right, up, down = main_grid:grid_get(x - 1, y), main_grid:grid_get(x + 1, y), main_grid:grid_get(x, y - 1), main_grid:grid_get(x, y + 1) -- 488
			if (function() -- 489
				if left ~= nil then -- 489
					return left.solid_cell -- 489
				end -- 489
				return nil -- 489
			end)() then -- 489
				count = count + 1 -- 489
			end -- 489
			if (function() -- 490
				if right ~= nil then -- 490
					return right.solid_cell -- 490
				end -- 490
				return nil -- 490
			end)() then -- 490
				count = count + 1 -- 490
			end -- 490
			if (function() -- 491
				if up ~= nil then -- 491
					return up.solid_cell -- 491
				end -- 491
				return nil -- 491
			end)() then -- 491
				count = count + 1 -- 491
			end -- 491
			if (function() -- 492
				if down ~= nil then -- 492
					return down.solid_cell -- 492
				end -- 492
				return nil -- 492
			end)() then -- 492
				count = count + 1 -- 492
			end -- 492
			return count -- 493
		end -- 487
	end -- 487
	return 0 -- 494
end -- 485
does_shape_fit = function(x, y, shape) -- 498
	for _index_0 = 1, #shape do -- 499
		local offset = shape[_index_0] -- 499
		do -- 500
			local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 500
			if cell then -- 500
				if cell.interactable_cell then -- 501
					if cell.solid_cell or not cell.arena_cell then -- 502
						return false -- 503
					end -- 502
				else -- 505
					return false -- 505
				end -- 501
			else -- 507
				return false -- 507
			end -- 500
		end -- 500
	end -- 507
	return true -- 508
end -- 498
does_shape_fit_arena = function(shape_rotations) -- 513
	for x = 2, main_grid.w - 1 do -- 514
		for y = 2, main_grid.h - 1 do -- 515
			do -- 516
				local cell = main_grid:grid_get(x, y) -- 516
				if cell then -- 516
					if cell.arena_cell then -- 517
						for _index_0 = 1, #shape_rotations do -- 518
							local rotated_shape = shape_rotations[_index_0] -- 518
							if does_shape_fit(x, y, rotated_shape) then -- 519
								return true -- 520
							end -- 519
						end -- 520
					end -- 517
				end -- 516
			end -- 516
		end -- 520
	end -- 520
end -- 513
cell = function(i, j) -- 523
	local self = anchor('cell') -- 524
	self:prs_init((i - 1) * cell_w + 0.5 * cell_w, (j - 1) * cell_h + 0.5 * cell_h) -- 525
	self:collider_init('cell', 'static', 'rectangle', cell_w, cell_h) -- 526
	self:hitfx_init() -- 527
	self:shake_init() -- 528
	self.i, self.j = i, j -- 529
	self.interactable_cell = self.i >= 2 and self.j >= 2 and self.i <= main_grid.w - 1 and self.j <= main_grid.h - 1 -- 530
	self.arena_cell = false -- 531
	self.pointer_cell_ok = false -- 532
	self.pointer_cell_not_ok = false -- 533
	self.solid_cell = false -- 534
	self.word_cell = false -- 535
	self.counter_cell = false -- 536
	self.update = function(self, dt) -- 538
		if self.trigger_active['generation_collider'] and self.interactable_cell then -- 539
			self.arena_cell = true -- 539
		end -- 539
		game:push(self.x, self.y, 0, self.springs.main.x, self.springs.main.x) -- 540
		if self.counter_cell then -- 541
			if not bottom_counter_hidden then -- 542
				do -- 543
					local _exp_0 = self.counter_cell -- 543
					if 'normal' == _exp_0 then -- 544
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.yellow[0]) -- 545
					elseif 'warning' == _exp_0 then -- 546
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.orange[0]) -- 547
					elseif 'danger' == _exp_0 then -- 548
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.red[0]) -- 549
					end -- 549
				end -- 549
			end -- 542
		elseif self.word_cell then -- 550
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.bg[2]) -- 551
			if type(self.word_cell) == 'string' then -- 552
				game:draw_text_centered(self.word_cell, font, self.x, self.y, 0, 1, 1, 0, 0, colors.fg[0]) -- 552
			end -- 552
		elseif self.solid_word_cell then -- 553
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.bg[2]) -- 554
			if type(self.solid_word_cell) == 'string' then -- 555
				game:draw_text_centered(self.solid_word_cell, font, self.x, self.y, 0, 1, 1, 0, 0, colors.fg[0]) -- 555
			end -- 555
		elseif self.solid_cell then -- 556
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, self.flashes.main.x and colors.fg[5] or colors.bg[2]) -- 557
			if self.pointer_cell_not_ok and not self.flashes.main.x then -- 558
				game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 0, 0, grid_pointer_not_ok_color) -- 559
				game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 4, 4, grid_pointer_not_ok_outline_color, 2) -- 560
			end -- 558
		elseif self.pointer_cell_ok then -- 561
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_pointer_ok_color) -- 562
			game:rectangle(self.x, self.y, self.w, self.h, 4, 4, grid_pointer_ok_outline_color, 2) -- 563
		elseif self.pointer_cell_not_ok then -- 564
			game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 0, 0, grid_pointer_not_ok_color) -- 565
			game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 4, 4, grid_pointer_not_ok_outline_color, 2) -- 566
		elseif self.arena_cell then -- 567
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_marker_color) -- 568
		end -- 541
		return game:pop() -- 569
	end -- 538
	return self -- 570
end -- 523
reset_cell = function(self) -- 572
	self.collision_active['generation_collider'] = nil -- 573
	self.trigger_active['generation_collider'] = nil -- 574
	self.arena_cell = false -- 575
	self.pointer_cell_ok = false -- 576
	self.pointer_cell_not_ok = false -- 577
	self.solid_cell = false -- 578
	self.word_cell = false -- 579
	self.solid_word_cell = false -- 580
end -- 572
score_cell = function(self) -- 582
	objects:container_add(hit_circle(self.x, self.y, { -- 583
		colors = { -- 583
			colors.bg[5] -- 583
		}, -- 583
		duration = 0.4, -- 583
		rs = 14 -- 583
	})) -- 583
	for i = 1, main:random_int(3, 4) do -- 584
		objects:container_add(hit_particle(self.x, self.y, { -- 584
			angular_v = main:random_float(-math.pi, math.pi), -- 584
			colors = { -- 584
				main:random_bool(50) and colors.bg[5] or colors.fg[5] -- 584
			}, -- 584
			duration = main:random_float(0.4, 1), -- 584
			v = main:random_float(100, 300) -- 584
		})) -- 584
	end -- 584
end -- 582
hitfx_cell = function(self, s, f) -- 586
	return self:hitfx_use('main', s or 0.25, nil, nil, f or 0.15) -- 587
end -- 586
generation_collider = function(x, y, w, h) -- 590
	local self = anchor('generation_collider') -- 591
	self:prs_init(x, y) -- 592
	if w and h then -- 593
		self:collider_init('generation_collider', 'dynamic', 'rectangle', w, h) -- 594
	else -- 596
		self:collider_init('generation_collider', 'dynamic', 'circle', w) -- 596
	end -- 593
	self.update = function(self, dt) -- 598
		self:collider_update_position_and_angle() -- 599
		if self.shape_type == 'circle' then -- 600
			return game:circle(self.x, self.y, self.rs, grid_marker_color, 2) -- 601
		else -- 603
			return game:polygon(self:collider_get_vertices(), grid_marker_color, 2) -- 603
		end -- 600
	end -- 598
	return self -- 604
end -- 590
