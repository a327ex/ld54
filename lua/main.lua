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
	level = 1 -- 181
	level_to_player_counter_speed = { -- 182
		0.5, -- 182
		0.55, -- 182
		0.7, -- 182
		0.6, -- 182
		0.66, -- 182
		0.84, -- 182
		0.5, -- 182
		0.7, -- 182
		1.00, -- 182
		0.12, -- 182
		0.58, -- 182
		1.20 -- 182
	} -- 182
	level_to_generation_colliders_spawned = { -- 183
		10, -- 183
		12, -- 183
		18, -- 183
		14, -- 183
		10, -- 183
		22, -- 183
		16, -- 183
		18, -- 183
		32, -- 183
		40, -- 183
		40, -- 183
		40 -- 183
	} -- 183
	for i = 13, 100, 3 do -- 184
		level_to_player_counter_speed[i] = level_to_player_counter_speed[i - 1] * 0.5 -- 185
		level_to_player_counter_speed[i + 1] = level_to_player_counter_speed[i - 1] * 0.7 -- 186
		level_to_player_counter_speed[i + 2] = level_to_player_counter_speed[i - 1] * 1.4 -- 187
	end -- 187
	for i = 13, 100 do -- 188
		level_to_generation_colliders_spawned[i] = main:random_int(16, 40) -- 189
	end -- 189
	main:observer_condition((function() -- 192
		return player_counter >= 25 -- 192
	end), (function() -- 192
		reset_grid() -- 193
		death:sound_play(0.75, main:random_float(0.95, 1.05)) -- 195
		main:timer_cancel('warning') -- 196
		game_over = true -- 197
		level = 1 -- 198
		round_started = false -- 199
		bottom_counter_hidden = false -- 200
		bottom_counter_grayed = true -- 201
		main.bottom_counter_state = nil -- 202
		set_text(8, 9, 'GAME OVER') -- 203
		t = "SCORE: " .. tostring(player_score) -- 204
		set_text(math.ceil((24 - utf8.len(t)) / 2), 10, "SCORE: " .. tostring(player_score)) -- 205
		return set_text(2, 11, 'left click to restart') -- 206
	end)) -- 192
	main:observer_condition((function() -- 210
		return player_counter >= 16 -- 210
	end), (function() -- 210
		main.bottom_counter_state = 'warning' -- 210
	end)) -- 210
	main:observer_condition((function() -- 211
		return player_counter >= 20 -- 211
	end), (function() -- 211
		main.bottom_counter_state = 'danger' -- 211
	end)) -- 211
	main:observer_value('bottom_counter_state', 'normal', (function() -- 213
		main:timer_cancel('warning') -- 214
		bottom_counter_hidden = false -- 215
	end)) -- 213
	main:observer_value('bottom_counter_state', 'warning', (function() -- 217
		return main:timer_every(0.8, (function() -- 218
			bottom_counter_hidden = not bottom_counter_hidden -- 219
			return warning:sound_play(0.75) -- 220
		end), nil, nil, nil, 'warning') -- 221
	end)) -- 217
	main_grid = grid(24, 24, 0) -- 225
	cell_w, cell_h = main.w / main_grid.w, main.h / main_grid.h -- 226
	for i = 1, main_grid.w do -- 227
		for j = 1, main_grid.h do -- 228
			main_grid:grid_set(i, j, cell(i, j)) -- 229
		end -- 229
	end -- 229
	starting_game = true -- 232
	set_text(6, 4, 'M8B1674-00D4') -- 233
	set_text(6, 11, 'fill the area') -- 234
	set_text(5, 12, 'until the next') -- 235
	set_text(5, 13, 'shape wont fit') -- 236
	set_text(4, 20, 'left click: place') -- 237
	return set_text(3, 21, 'right click: rotate') -- 238
end -- 4
update = function(dt) -- 241
	if (main:input_is_pressed('1') or main:input_is_pressed('2')) and starting_game then -- 245
		starting_game = false -- 246
		reset_grid() -- 247
		generate_arena() -- 248
	end -- 245
	if main:input_is_pressed('2') then -- 251
		rotate:sound_play(0.75, main:random_float(0.95, 1.05)) -- 252
		pointer_shape_rotation = pointer_shape_rotation + 1 -- 253
		if pointer_shape_rotation == 5 then -- 254
			pointer_shape_rotation = 1 -- 254
		end -- 254
	end -- 251
	if round_started then -- 257
		player_counter = player_counter + level_to_player_counter_speed[level] * dt -- 258
	end -- 257
	set_bottom_counter(player_counter) -- 259
	if main.bottom_counter_state == 'warning' or main.bottom_counter_state == 'danger' then -- 261
		local warning_speed = math.remap(25 - player_counter, 9, 0, 1, 0.1) -- 262
		main:timer_set_multiplier('warning', warning_speed) -- 263
	end -- 261
	for i = 2, main_grid.w - 1 do -- 266
		for j = 2, main_grid.h - 1 do -- 267
			local cell = main_grid:grid_get(i, j) -- 268
			cell.pointer_cell_ok = false -- 269
			cell.pointer_cell_not_ok = false -- 270
		end -- 270
	end -- 270
	local x, y = math.ceil(main.pointer.x / cell_w), math.ceil(main.pointer.y / cell_h) -- 273
	local any_cell_not_ok = false -- 274
	local current_cells = { } -- 275
	if pointer_shape and round_started then -- 276
		local shape = shapes[pointer_shape][pointer_shape_rotation] -- 277
		if does_shape_fit(x, y, shape) then -- 278
			for _index_0 = 1, #shape do -- 279
				local offset = shape[_index_0] -- 279
				do -- 280
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 280
					if cell then -- 280
						if cell.interactable_cell then -- 281
							current_cells[#current_cells + 1] = cell -- 282
							cell.pointer_cell_ok = true -- 283
						end -- 281
					end -- 280
				end -- 280
			end -- 283
		else -- 285
			any_cell_not_ok = true -- 285
			for _index_0 = 1, #shape do -- 286
				local offset = shape[_index_0] -- 286
				do -- 287
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 287
					if cell then -- 287
						if cell.interactable_cell then -- 288
							current_cells[#current_cells + 1] = cell -- 289
							cell.pointer_cell_not_ok = true -- 290
						end -- 288
					end -- 287
				end -- 287
			end -- 290
		end -- 278
	end -- 276
	if main:input_is_pressed('1') and any_cell_not_ok and round_started then -- 292
		failed_placement:sound_play(0.375, main:random_float(0.95, 1.05)) -- 293
		failed_placement_2:sound_play(0.75, main:random_float(0.95, 1.05)) -- 294
		for _index_0 = 1, #current_cells do -- 295
			local cell = current_cells[_index_0] -- 295
			if cell.interactable_cell and cell.arena_cell then -- 296
				cell:shake_shake(4, 0.2) -- 297
			end -- 296
		end -- 297
	end -- 292
	if main:input_is_pressed('1') and not any_cell_not_ok and round_started then -- 300
		successful_placement:sound_play(0.375, main:random_float(0.95, 1.05)) -- 301
		successful_placement_2:sound_play(0.75) -- 302
		for _index_0 = 1, #current_cells do -- 303
			local cell = current_cells[_index_0] -- 303
			if cell.interactable_cell and cell.arena_cell then -- 304
				cell.pointer_cell_ok = false -- 305
				cell.pointer_cell_not_ok = false -- 306
				cell.solid_cell = true -- 307
				hitfx_cell(cell, 0.2, 0.15) -- 308
			end -- 304
		end -- 308
		pointer_shape = nil -- 311
		main:timer_after(0.3, (function() -- 312
			pointer_shape = get_next_pointer_shape() -- 313
			if not does_shape_fit_arena(shapes[pointer_shape]) then -- 315
				pointer_shape = nil -- 316
				local added_score = get_solid_cell_score() -- 317
				round_started = false -- 318
				player_score = player_score -- 319
				player_counter = player_counter -- 320
				main:timer_tween(0.64, _G, { -- 321
					player_counter = player_counter - added_score / 12 -- 321
				}, math.cubic_in_out, (function() -- 321
					if player_counter < 0 then -- 322
						player_counter = 0 -- 322
					end -- 322
					if player_counter < 16 then -- 323
						main.bottom_counter_state = 'normal' -- 323
					end -- 323
					if player_counter >= 16 and player_counter < 20 then -- 324
						main.bottom_counter_state = 'warning' -- 324
					end -- 324
					bottom_counter_grayed = true -- 325
				end), 'player_counter') -- 321
				local solid_cells = { } -- 327
				for x = 2, main_grid.w do -- 328
					for y = 2, main_grid.h do -- 329
						do -- 330
							local cell = main_grid:grid_get(x, y) -- 330
							if cell then -- 330
								if cell.solid_cell then -- 331
									solid_cells[#solid_cells + 1] = cell -- 332
								else -- 334
									reset_cell(cell) -- 334
								end -- 331
							end -- 330
						end -- 330
					end -- 334
				end -- 334
				set_text(18, 4, "+" .. tostring(tostring(added_score))) -- 335
				table.shuffle(solid_cells) -- 336
				main:timer_after(0.5, (function() -- 337
					round_end:sound_play(0.75, main:random_float(0.95, 1.05)) -- 338
					deep_wobble:sound_play(0.75, main:random_float(0.95, 1.05)) -- 339
					for i, solid_cell in ipairs(solid_cells) do -- 340
						hitfx_cell(solid_cell, 0.0, nil, nil, 0.15) -- 341
						main:timer_after(0.1, (function() -- 342
							local score = get_solid_neighbor_count(solid_cell.i, solid_cell.j) -- 343
							solid_cell.solid_word_cell = tostring(score) -- 344
						end)) -- 342
					end -- 345
				end)) -- 337
				local pitch = 0.75 -- 347
				main:timer_after(3, (function() -- 348
					for i, solid_cell in ipairs(solid_cells) do -- 349
						main:timer_after((i - 1) * 0.05, (function() -- 350
							local score = get_solid_neighbor_count(solid_cell.i, solid_cell.j) -- 351
							pitch = pitch + (i * (score / 200)) -- 352
							score_count_tile:sound_play(0.8, pitch) -- 353
							solid_cell.solid_word_cell = '0' -- 354
							player_score = player_score + score -- 355
							return set_top_text("SCORE: " .. tostring(player_score)) -- 356
						end)) -- 350
					end -- 357
				end)) -- 348
				return main:timer_after(4 + 0.05 * #solid_cells, (function() -- 359
					level = level + 1 -- 360
					reset_grid() -- 361
					return generate_arena() -- 362
				end)) -- 363
			end -- 315
		end), 'new_shape') -- 312
	end -- 300
	if main:input_is_pressed('1') and game_over then -- 367
		reset_grid() -- 368
		player_score = 0 -- 370
		player_counter = 0 -- 371
		level = 1 -- 372
		round_started = false -- 373
		game_over = false -- 374
		main.bottom_counter_state = nil -- 375
		bottom_counter_grayed = false -- 376
		generate_arena() -- 377
	end -- 367
	bg:rectangle(0.5 * main.w, 0.5 * main.h, main.w, main.h, 0, 0, colors.fg[0]) -- 380
	bg2:set_blend_mode('replace') -- 381
	for i = 2, main_grid.w do -- 382
		for j = 2, main_grid.h do -- 383
			x, y = (i - 1) * cell_w, (j - 1) * cell_h -- 384
			local w, h = 5, 5 -- 385
			bg2:line(x - w / 2, y, x + w / 2, y, grid_marker_color, 1) -- 386
			bg2:line(x, y - h / 2, x, y + h / 2, grid_marker_color, 1) -- 387
		end -- 387
	end -- 387
	bg2:set_blend_mode() -- 388
	main_grid:grid_for_each((function(v, i, j) -- 391
		return v:update(dt) -- 391
	end)) -- 391
	objects:container_update(dt) -- 392
	return objects:container_remove_dead() -- 393
end -- 241
get_next_pointer_shape = function() -- 396
	pointer_shape_rotation = 1 -- 397
	return main:random_table({ -- 398
		'short_t', -- 398
		'long_t', -- 398
		'short_i', -- 398
		'long_i', -- 398
		'short_j', -- 398
		'long_j', -- 398
		'short_l', -- 398
		'long_l', -- 398
		'short_s', -- 398
		'long_s', -- 398
		'short_z', -- 398
		'long_z', -- 398
		'short_v', -- 398
		'long_v', -- 398
		'o', -- 398
		'x', -- 398
		'f', -- 398
		'p', -- 398
		'u', -- 398
		'y', -- 398
		'z' -- 398
	}) -- 398
end -- 396
set_text = function(x, y, text) -- 402
	for i = 1, utf8.len(text) do -- 403
		do -- 404
			local cell = main_grid:grid_get(x + i, y) -- 404
			if cell then -- 404
				cell.word_cell = utf8.sub(text, i, i) -- 405
			end -- 404
		end -- 404
	end -- 405
end -- 402
reset_grid = function() -- 408
	for x = 2, main_grid.w do -- 409
		for y = 2, main_grid.h do -- 410
			do -- 411
				local cell = main_grid:grid_get(x, y) -- 411
				if cell then -- 411
					reset_cell(cell) -- 412
				end -- 411
			end -- 411
		end -- 412
	end -- 412
end -- 408
reset_line = function(x, y) -- 415
	for i = x, main_grid.w do -- 416
		do -- 417
			local cell = main_grid:grid_get(i, y) -- 417
			if cell then -- 417
				reset_cell(cell) -- 418
			end -- 417
		end -- 417
	end -- 418
end -- 415
set_bottom_counter = function(value) -- 422
	for i = 1, main_grid.w do -- 423
		local cell = main_grid:grid_get(i, main_grid.h) -- 424
		cell.counter_cell = nil -- 425
	end -- 425
	for i = 1, math.floor(value) do -- 426
		do -- 427
			local cell = main_grid:grid_get(i, main_grid.h) -- 427
			if cell then -- 427
				if i <= 16 then -- 428
					cell.counter_cell = 'normal' -- 429
				elseif i > 16 and i <= 20 then -- 430
					cell.counter_cell = 'warning' -- 431
				elseif i > 20 and i <= 25 then -- 432
					cell.counter_cell = 'danger' -- 433
				end -- 428
			end -- 427
		end -- 427
	end -- 433
end -- 422
set_top_text = function(text) -- 436
	for i = 1, main_grid.w do -- 437
		local cell = main_grid:grid_get(i, 1) -- 438
		cell.word_cell = '' -- 439
	end -- 439
	for i = 1, utf8.len(text) do -- 440
		local cell = main_grid:grid_get(i, 1) -- 441
		cell.word_cell = utf8.sub(text, i, i) -- 442
	end -- 442
end -- 436
generate_arena = function() -- 446
	set_text(2, 4, "Lv." .. tostring(tostring(level))) -- 447
	main:timer_every(0.4, (function() -- 449
		local i = main:timer_get_every_index('set_top_text') -- 450
		if i % 4 == 1 then -- 451
			return set_top_text('GENERATING') -- 452
		elseif i % 4 == 2 then -- 453
			return set_top_text('GENERATING.') -- 454
		elseif i % 4 == 3 then -- 455
			return set_top_text('GENERATING..') -- 456
		elseif i % 4 == 0 then -- 457
			return set_top_text('GENERATING...') -- 458
		end -- 451
	end), nil, true, nil, 'set_top_text') -- 449
	spawning = true -- 461
	pointer_shape, pointer_shape_rotation = nil, 1 -- 462
	round_started = false -- 463
	local spawn_count = level_to_generation_colliders_spawned[level] -- 464
	return main:timer_every(0.1, (function() -- 465
		if main:random_bool(50) then -- 466
			objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(8, 20))) -- 467
		else -- 469
			objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(16, 40), main:random_float(16, 40))) -- 469
		end -- 466
		generation_shape_spawn:sound_play(0.75, main:random_float(0.7, 1.3)) -- 470
		return rotate:sound_play(0.75, main:random_float(0.7, 1.3)) -- 471
	end), spawn_count, true, (function() -- 472
		return main:timer_after(spawn_count / 15, (function() -- 473
			objects:container_destroy() -- 474
			bottom_counter_grayed = false -- 475
			main.bottom_counter_state = 'normal' -- 476
			round_started = true -- 477
			pointer_shape = get_next_pointer_shape() -- 478
			pointer_shape_rotation = 1 -- 479
			main:timer_cancel('set_top_text') -- 480
			set_top_text("SCORE: " .. tostring(player_score)) -- 481
			return generation_over:sound_play(0.75, main:random_float(0.95, 1.05)) -- 482
		end)) -- 483
	end)) -- 484
end -- 446
get_solid_cell_count = function() -- 487
	local count = 0 -- 488
	for x = 2, main_grid.w - 1 do -- 489
		for y = 2, main_grid.h - 1 do -- 490
			do -- 491
				local cell = main_grid:grid_get(x, y) -- 491
				if cell then -- 491
					if cell.solid_cell then -- 492
						count = count + 1 -- 493
					end -- 492
				end -- 491
			end -- 491
		end -- 493
	end -- 493
	return count -- 494
end -- 487
get_solid_cell_score = function() -- 497
	local count = 0 -- 498
	for x = 2, main_grid.w - 1 do -- 499
		for y = 2, main_grid.h - 1 do -- 500
			do -- 501
				local cell = main_grid:grid_get(x, y) -- 501
				if cell then -- 501
					if cell.solid_cell then -- 502
						count = count + get_solid_neighbor_count(x, y) -- 503
					end -- 502
				end -- 501
			end -- 501
		end -- 503
	end -- 503
	return count -- 504
end -- 497
get_solid_neighbor_count = function(x, y) -- 507
	local count = 0 -- 508
	do -- 509
		local cell = main_grid:grid_get(x, y) -- 509
		if cell then -- 509
			local left, right, up, down = main_grid:grid_get(x - 1, y), main_grid:grid_get(x + 1, y), main_grid:grid_get(x, y - 1), main_grid:grid_get(x, y + 1) -- 510
			if (function() -- 511
				if left ~= nil then -- 511
					return left.solid_cell -- 511
				end -- 511
				return nil -- 511
			end)() then -- 511
				count = count + 1 -- 511
			end -- 511
			if (function() -- 512
				if right ~= nil then -- 512
					return right.solid_cell -- 512
				end -- 512
				return nil -- 512
			end)() then -- 512
				count = count + 1 -- 512
			end -- 512
			if (function() -- 513
				if up ~= nil then -- 513
					return up.solid_cell -- 513
				end -- 513
				return nil -- 513
			end)() then -- 513
				count = count + 1 -- 513
			end -- 513
			if (function() -- 514
				if down ~= nil then -- 514
					return down.solid_cell -- 514
				end -- 514
				return nil -- 514
			end)() then -- 514
				count = count + 1 -- 514
			end -- 514
			return count -- 515
		end -- 509
	end -- 509
	return 0 -- 516
end -- 507
does_shape_fit = function(x, y, shape) -- 520
	for _index_0 = 1, #shape do -- 521
		local offset = shape[_index_0] -- 521
		do -- 522
			local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 522
			if cell then -- 522
				if cell.interactable_cell then -- 523
					if cell.solid_cell or not cell.arena_cell then -- 524
						return false -- 525
					end -- 524
				else -- 527
					return false -- 527
				end -- 523
			else -- 529
				return false -- 529
			end -- 522
		end -- 522
	end -- 529
	return true -- 530
end -- 520
does_shape_fit_arena = function(shape_rotations) -- 535
	for x = 2, main_grid.w - 1 do -- 536
		for y = 2, main_grid.h - 1 do -- 537
			do -- 538
				local cell = main_grid:grid_get(x, y) -- 538
				if cell then -- 538
					if cell.arena_cell then -- 539
						for _index_0 = 1, #shape_rotations do -- 540
							local rotated_shape = shape_rotations[_index_0] -- 540
							if does_shape_fit(x, y, rotated_shape) then -- 541
								return true -- 542
							end -- 541
						end -- 542
					end -- 539
				end -- 538
			end -- 538
		end -- 542
	end -- 542
end -- 535
cell = function(i, j) -- 545
	local self = anchor('cell') -- 546
	self:prs_init((i - 1) * cell_w + 0.5 * cell_w, (j - 1) * cell_h + 0.5 * cell_h) -- 547
	self:collider_init('cell', 'static', 'rectangle', cell_w, cell_h) -- 548
	self:hitfx_init() -- 549
	self:shake_init() -- 550
	self.i, self.j = i, j -- 551
	self.interactable_cell = self.i >= 2 and self.j >= 2 and self.i <= main_grid.w - 1 and self.j <= main_grid.h - 1 -- 552
	self.arena_cell = false -- 553
	self.pointer_cell_ok = false -- 554
	self.pointer_cell_not_ok = false -- 555
	self.solid_cell = false -- 556
	self.word_cell = false -- 557
	self.counter_cell = false -- 558
	self.update = function(self, dt) -- 560
		if self.trigger_active['generation_collider'] and self.interactable_cell then -- 561
			self.arena_cell = true -- 561
		end -- 561
		game:push(self.x, self.y, 0, self.springs.main.x, self.springs.main.x) -- 562
		if self.counter_cell then -- 563
			if not bottom_counter_hidden then -- 564
				do -- 565
					local _exp_0 = self.counter_cell -- 565
					if 'normal' == _exp_0 then -- 566
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.yellow[0]) -- 567
					elseif 'warning' == _exp_0 then -- 568
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.orange[0]) -- 569
					elseif 'danger' == _exp_0 then -- 570
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.red[0]) -- 571
					end -- 571
				end -- 571
			end -- 564
		elseif self.word_cell then -- 572
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.bg[2]) -- 573
			if type(self.word_cell) == 'string' then -- 574
				game:draw_text_centered(self.word_cell, font, self.x, self.y, 0, 1, 1, 0, 0, colors.fg[0]) -- 574
			end -- 574
		elseif self.solid_word_cell then -- 575
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.bg[2]) -- 576
			if type(self.solid_word_cell) == 'string' then -- 577
				game:draw_text_centered(self.solid_word_cell, font, self.x, self.y, 0, 1, 1, 0, 0, colors.fg[0]) -- 577
			end -- 577
		elseif self.solid_cell then -- 578
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, self.flashes.main.x and colors.fg[5] or colors.bg[2]) -- 579
			if self.pointer_cell_not_ok and not self.flashes.main.x then -- 580
				game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 0, 0, grid_pointer_not_ok_color) -- 581
				game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 4, 4, grid_pointer_not_ok_outline_color, 2) -- 582
			end -- 580
		elseif self.pointer_cell_ok then -- 583
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_pointer_ok_color) -- 584
			game:rectangle(self.x, self.y, self.w, self.h, 4, 4, grid_pointer_ok_outline_color, 2) -- 585
		elseif self.pointer_cell_not_ok then -- 586
			game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 0, 0, grid_pointer_not_ok_color) -- 587
			game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 4, 4, grid_pointer_not_ok_outline_color, 2) -- 588
		elseif self.arena_cell then -- 589
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_marker_color) -- 590
		end -- 563
		return game:pop() -- 591
	end -- 560
	return self -- 592
end -- 545
reset_cell = function(self) -- 594
	self.collision_active['generation_collider'] = nil -- 595
	self.trigger_active['generation_collider'] = nil -- 596
	self.arena_cell = false -- 597
	self.pointer_cell_ok = false -- 598
	self.pointer_cell_not_ok = false -- 599
	self.solid_cell = false -- 600
	self.word_cell = false -- 601
	self.solid_word_cell = false -- 602
end -- 594
score_cell = function(self) -- 604
	objects:container_add(hit_circle(self.x, self.y, { -- 605
		colors = { -- 605
			colors.bg[5] -- 605
		}, -- 605
		duration = 0.4, -- 605
		rs = 14 -- 605
	})) -- 605
	for i = 1, main:random_int(3, 4) do -- 606
		objects:container_add(hit_particle(self.x, self.y, { -- 606
			angular_v = main:random_float(-math.pi, math.pi), -- 606
			colors = { -- 606
				main:random_bool(50) and colors.bg[5] or colors.fg[5] -- 606
			}, -- 606
			duration = main:random_float(0.4, 1), -- 606
			v = main:random_float(100, 300) -- 606
		})) -- 606
	end -- 606
end -- 604
hitfx_cell = function(self, s, f) -- 608
	return self:hitfx_use('main', s or 0.25, nil, nil, f or 0.15) -- 609
end -- 608
generation_collider = function(x, y, w, h) -- 612
	local self = anchor('generation_collider') -- 613
	self:prs_init(x, y) -- 614
	if w and h then -- 615
		self:collider_init('generation_collider', 'dynamic', 'rectangle', w, h) -- 616
	else -- 618
		self:collider_init('generation_collider', 'dynamic', 'circle', w) -- 618
	end -- 615
	self.update = function(self, dt) -- 620
		self:collider_update_position_and_angle() -- 621
		if self.shape_type == 'circle' then -- 622
			return game:circle(self.x, self.y, self.rs, grid_marker_color, 2) -- 623
		else -- 625
			return game:polygon(self:collider_get_vertices(), grid_marker_color, 2) -- 625
		end -- 622
	end -- 620
	return self -- 626
end -- 612
