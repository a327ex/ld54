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
		just_game_over = true -- 198
		main:timer_after(1, (function() -- 199
			just_game_over = false -- 199
		end), 'just_game_over') -- 199
		level = 1 -- 200
		round_started = false -- 201
		bottom_counter_hidden = false -- 202
		bottom_counter_grayed = true -- 203
		main.bottom_counter_state = nil -- 204
		set_text(8, 9, 'GAME OVER') -- 205
		t = "SCORE: " .. tostring(player_score) -- 206
		set_text(math.ceil((24 - utf8.len(t)) / 2), 10, "SCORE: " .. tostring(player_score)) -- 207
		return set_text(2, 11, 'left click to restart') -- 208
	end)) -- 192
	main:observer_condition((function() -- 212
		return player_counter >= 16 -- 212
	end), (function() -- 212
		main.bottom_counter_state = 'warning' -- 212
	end)) -- 212
	main:observer_condition((function() -- 213
		return player_counter >= 20 -- 213
	end), (function() -- 213
		main.bottom_counter_state = 'danger' -- 213
	end)) -- 213
	main:observer_value('bottom_counter_state', 'normal', (function() -- 215
		main:timer_cancel('warning') -- 216
		bottom_counter_hidden = false -- 217
	end)) -- 215
	main:observer_value('bottom_counter_state', 'warning', (function() -- 219
		return main:timer_every(0.8, (function() -- 220
			bottom_counter_hidden = not bottom_counter_hidden -- 221
			return warning:sound_play(0.75) -- 222
		end), nil, nil, nil, 'warning') -- 223
	end)) -- 219
	main_grid = grid(24, 24, 0) -- 227
	cell_w, cell_h = main.w / main_grid.w, main.h / main_grid.h -- 228
	for i = 1, main_grid.w do -- 229
		for j = 1, main_grid.h do -- 230
			main_grid:grid_set(i, j, cell(i, j)) -- 231
		end -- 231
	end -- 231
	starting_game = true -- 234
	set_text(6, 4, 'M8B1674-00D4') -- 235
	set_text(6, 11, 'fill the area') -- 236
	set_text(5, 12, 'until the next') -- 237
	set_text(5, 13, 'shape wont fit') -- 238
	set_text(4, 20, 'left click: place') -- 239
	return set_text(3, 21, 'right click: rotate') -- 240
end -- 4
update = function(dt) -- 243
	if (main:input_is_pressed('1') or main:input_is_pressed('2')) and starting_game then -- 247
		starting_game = false -- 248
		reset_grid() -- 249
		generate_arena() -- 250
	end -- 247
	if main:input_is_pressed('2') then -- 253
		rotate:sound_play(0.75, main:random_float(0.95, 1.05)) -- 254
		pointer_shape_rotation = pointer_shape_rotation + 1 -- 255
		if pointer_shape_rotation == 5 then -- 256
			pointer_shape_rotation = 1 -- 256
		end -- 256
	end -- 253
	if round_started then -- 259
		player_counter = player_counter + level_to_player_counter_speed[level] * dt -- 260
	end -- 259
	set_bottom_counter(player_counter) -- 261
	if main.bottom_counter_state == 'warning' or main.bottom_counter_state == 'danger' then -- 263
		local warning_speed = math.remap(25 - player_counter, 9, 0, 1, 0.1) -- 264
		main:timer_set_multiplier('warning', warning_speed) -- 265
	end -- 263
	for i = 2, main_grid.w - 1 do -- 268
		for j = 2, main_grid.h - 1 do -- 269
			local cell = main_grid:grid_get(i, j) -- 270
			cell.pointer_cell_ok = false -- 271
			cell.pointer_cell_not_ok = false -- 272
		end -- 272
	end -- 272
	local x, y = math.ceil(main.pointer.x / cell_w), math.ceil(main.pointer.y / cell_h) -- 275
	local any_cell_not_ok = false -- 276
	local current_cells = { } -- 277
	if pointer_shape and round_started then -- 278
		local shape = shapes[pointer_shape][pointer_shape_rotation] -- 279
		if does_shape_fit(x, y, shape) then -- 280
			for _index_0 = 1, #shape do -- 281
				local offset = shape[_index_0] -- 281
				do -- 282
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 282
					if cell then -- 282
						if cell.interactable_cell then -- 283
							current_cells[#current_cells + 1] = cell -- 284
							cell.pointer_cell_ok = true -- 285
						end -- 283
					end -- 282
				end -- 282
			end -- 285
		else -- 287
			any_cell_not_ok = true -- 287
			for _index_0 = 1, #shape do -- 288
				local offset = shape[_index_0] -- 288
				do -- 289
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 289
					if cell then -- 289
						if cell.interactable_cell then -- 290
							current_cells[#current_cells + 1] = cell -- 291
							cell.pointer_cell_not_ok = true -- 292
						end -- 290
					end -- 289
				end -- 289
			end -- 292
		end -- 280
	end -- 278
	if main:input_is_pressed('1') and any_cell_not_ok and round_started then -- 294
		failed_placement:sound_play(0.375, main:random_float(0.95, 1.05)) -- 295
		failed_placement_2:sound_play(0.75, main:random_float(0.95, 1.05)) -- 296
		for _index_0 = 1, #current_cells do -- 297
			local cell = current_cells[_index_0] -- 297
			if cell.interactable_cell and cell.arena_cell then -- 298
				cell:shake_shake(4, 0.2) -- 299
			end -- 298
		end -- 299
	end -- 294
	if main:input_is_pressed('1') and not any_cell_not_ok and round_started then -- 302
		successful_placement:sound_play(0.375, main:random_float(0.95, 1.05)) -- 303
		successful_placement_2:sound_play(0.75) -- 304
		for _index_0 = 1, #current_cells do -- 305
			local cell = current_cells[_index_0] -- 305
			if cell.interactable_cell and cell.arena_cell then -- 306
				cell.pointer_cell_ok = false -- 307
				cell.pointer_cell_not_ok = false -- 308
				cell.solid_cell = true -- 309
				hitfx_cell(cell, 0.2, 0.15) -- 310
			end -- 306
		end -- 310
		pointer_shape = nil -- 313
		main:timer_after(0.3, (function() -- 314
			pointer_shape = get_next_pointer_shape() -- 315
			if not does_shape_fit_arena(shapes[pointer_shape]) then -- 317
				pointer_shape = nil -- 318
				local added_score = get_solid_cell_score() -- 319
				round_started = false -- 320
				player_score = player_score -- 321
				player_counter = player_counter -- 322
				main:timer_tween(0.64, _G, { -- 323
					player_counter = player_counter - added_score / 12 -- 323
				}, math.cubic_in_out, (function() -- 323
					if player_counter < 0 then -- 324
						player_counter = 0 -- 324
					end -- 324
					if player_counter < 16 then -- 325
						main.bottom_counter_state = 'normal' -- 325
					end -- 325
					if player_counter >= 16 and player_counter < 20 then -- 326
						main.bottom_counter_state = 'warning' -- 326
					end -- 326
					bottom_counter_grayed = true -- 327
				end), 'player_counter') -- 323
				local solid_cells = { } -- 329
				for x = 2, main_grid.w do -- 330
					for y = 2, main_grid.h do -- 331
						do -- 332
							local cell = main_grid:grid_get(x, y) -- 332
							if cell then -- 332
								if cell.solid_cell then -- 333
									solid_cells[#solid_cells + 1] = cell -- 334
								else -- 336
									reset_cell(cell) -- 336
								end -- 333
							end -- 332
						end -- 332
					end -- 336
				end -- 336
				set_text(18, 4, "+" .. tostring(tostring(added_score))) -- 337
				table.shuffle(solid_cells) -- 338
				main:timer_after(0.5, (function() -- 339
					round_end:sound_play(0.75, main:random_float(0.95, 1.05)) -- 340
					deep_wobble:sound_play(0.75, main:random_float(0.95, 1.05)) -- 341
					for i, solid_cell in ipairs(solid_cells) do -- 342
						hitfx_cell(solid_cell, 0.0, nil, nil, 0.15) -- 343
						main:timer_after(0.1, (function() -- 344
							local score = get_solid_neighbor_count(solid_cell.i, solid_cell.j) -- 345
							solid_cell.solid_word_cell = tostring(score) -- 346
						end)) -- 344
					end -- 347
				end)) -- 339
				local pitch = 0.75 -- 349
				main:timer_after(3, (function() -- 350
					for i, solid_cell in ipairs(solid_cells) do -- 351
						main:timer_after((i - 1) * 0.05, (function() -- 352
							local score = get_solid_neighbor_count(solid_cell.i, solid_cell.j) -- 353
							pitch = pitch + (i * (score / 200)) -- 354
							score_count_tile:sound_play(0.8, pitch) -- 355
							solid_cell.solid_word_cell = '0' -- 356
							player_score = player_score + score -- 357
							return set_top_text("SCORE: " .. tostring(player_score)) -- 358
						end)) -- 352
					end -- 359
				end)) -- 350
				return main:timer_after(4 + 0.05 * #solid_cells, (function() -- 361
					level = level + 1 -- 362
					reset_grid() -- 363
					return generate_arena() -- 364
				end)) -- 365
			end -- 317
		end), 'new_shape') -- 314
	end -- 302
	if main:input_is_pressed('1') and game_over and not just_game_over then -- 369
		reset_grid() -- 370
		player_score = 0 -- 372
		player_counter = 0 -- 373
		level = 1 -- 374
		round_started = false -- 375
		game_over = false -- 376
		main.bottom_counter_state = nil -- 377
		bottom_counter_grayed = false -- 378
		generate_arena() -- 379
	end -- 369
	bg:rectangle(0.5 * main.w, 0.5 * main.h, main.w, main.h, 0, 0, colors.fg[0]) -- 382
	bg2:set_blend_mode('replace') -- 383
	for i = 2, main_grid.w do -- 384
		for j = 2, main_grid.h do -- 385
			x, y = (i - 1) * cell_w, (j - 1) * cell_h -- 386
			local w, h = 5, 5 -- 387
			bg2:line(x - w / 2, y, x + w / 2, y, grid_marker_color, 1) -- 388
			bg2:line(x, y - h / 2, x, y + h / 2, grid_marker_color, 1) -- 389
		end -- 389
	end -- 389
	bg2:set_blend_mode() -- 390
	main_grid:grid_for_each((function(v, i, j) -- 393
		return v:update(dt) -- 393
	end)) -- 393
	objects:container_update(dt) -- 394
	return objects:container_remove_dead() -- 395
end -- 243
get_next_pointer_shape = function() -- 398
	pointer_shape_rotation = 1 -- 399
	return main:random_table({ -- 400
		'short_t', -- 400
		'long_t', -- 400
		'short_i', -- 400
		'long_i', -- 400
		'short_j', -- 400
		'long_j', -- 400
		'short_l', -- 400
		'long_l', -- 400
		'short_s', -- 400
		'long_s', -- 400
		'short_z', -- 400
		'long_z', -- 400
		'short_v', -- 400
		'long_v', -- 400
		'o', -- 400
		'x', -- 400
		'f', -- 400
		'p', -- 400
		'u', -- 400
		'y', -- 400
		'z' -- 400
	}) -- 400
end -- 398
set_text = function(x, y, text) -- 404
	for i = 1, utf8.len(text) do -- 405
		do -- 406
			local cell = main_grid:grid_get(x + i, y) -- 406
			if cell then -- 406
				cell.word_cell = utf8.sub(text, i, i) -- 407
			end -- 406
		end -- 406
	end -- 407
end -- 404
reset_grid = function() -- 410
	for x = 2, main_grid.w do -- 411
		for y = 2, main_grid.h do -- 412
			do -- 413
				local cell = main_grid:grid_get(x, y) -- 413
				if cell then -- 413
					reset_cell(cell) -- 414
				end -- 413
			end -- 413
		end -- 414
	end -- 414
end -- 410
reset_line = function(x, y) -- 417
	for i = x, main_grid.w do -- 418
		do -- 419
			local cell = main_grid:grid_get(i, y) -- 419
			if cell then -- 419
				reset_cell(cell) -- 420
			end -- 419
		end -- 419
	end -- 420
end -- 417
set_bottom_counter = function(value) -- 424
	for i = 1, main_grid.w do -- 425
		local cell = main_grid:grid_get(i, main_grid.h) -- 426
		cell.counter_cell = nil -- 427
	end -- 427
	for i = 1, math.floor(value) do -- 428
		do -- 429
			local cell = main_grid:grid_get(i, main_grid.h) -- 429
			if cell then -- 429
				if i <= 16 then -- 430
					cell.counter_cell = 'normal' -- 431
				elseif i > 16 and i <= 20 then -- 432
					cell.counter_cell = 'warning' -- 433
				elseif i > 20 and i <= 25 then -- 434
					cell.counter_cell = 'danger' -- 435
				end -- 430
			end -- 429
		end -- 429
	end -- 435
end -- 424
set_top_text = function(text) -- 438
	for i = 1, main_grid.w do -- 439
		local cell = main_grid:grid_get(i, 1) -- 440
		cell.word_cell = '' -- 441
	end -- 441
	for i = 1, utf8.len(text) do -- 442
		local cell = main_grid:grid_get(i, 1) -- 443
		cell.word_cell = utf8.sub(text, i, i) -- 444
	end -- 444
end -- 438
generate_arena = function() -- 448
	set_text(2, 4, "Lv." .. tostring(tostring(level))) -- 449
	main:timer_every(0.4, (function() -- 451
		local i = main:timer_get_every_index('set_top_text') -- 452
		if i % 4 == 1 then -- 453
			return set_top_text('GENERATING') -- 454
		elseif i % 4 == 2 then -- 455
			return set_top_text('GENERATING.') -- 456
		elseif i % 4 == 3 then -- 457
			return set_top_text('GENERATING..') -- 458
		elseif i % 4 == 0 then -- 459
			return set_top_text('GENERATING...') -- 460
		end -- 453
	end), nil, true, nil, 'set_top_text') -- 451
	spawning = true -- 463
	pointer_shape, pointer_shape_rotation = nil, 1 -- 464
	round_started = false -- 465
	local spawn_count = level_to_generation_colliders_spawned[level] -- 466
	return main:timer_every(0.1, (function() -- 467
		if main:random_bool(50) then -- 468
			objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(8, 20))) -- 469
		else -- 471
			objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(16, 40), main:random_float(16, 40))) -- 471
		end -- 468
		generation_shape_spawn:sound_play(0.75, main:random_float(0.7, 1.3)) -- 472
		return rotate:sound_play(0.75, main:random_float(0.7, 1.3)) -- 473
	end), spawn_count, true, (function() -- 474
		return main:timer_after(spawn_count / 15, (function() -- 475
			objects:container_destroy() -- 476
			bottom_counter_grayed = false -- 477
			main.bottom_counter_state = 'normal' -- 478
			round_started = true -- 479
			pointer_shape = get_next_pointer_shape() -- 480
			pointer_shape_rotation = 1 -- 481
			main:timer_cancel('set_top_text') -- 482
			set_top_text("SCORE: " .. tostring(player_score)) -- 483
			return generation_over:sound_play(0.75, main:random_float(0.95, 1.05)) -- 484
		end)) -- 485
	end)) -- 486
end -- 448
get_solid_cell_count = function() -- 489
	local count = 0 -- 490
	for x = 2, main_grid.w - 1 do -- 491
		for y = 2, main_grid.h - 1 do -- 492
			do -- 493
				local cell = main_grid:grid_get(x, y) -- 493
				if cell then -- 493
					if cell.solid_cell then -- 494
						count = count + 1 -- 495
					end -- 494
				end -- 493
			end -- 493
		end -- 495
	end -- 495
	return count -- 496
end -- 489
get_solid_cell_score = function() -- 499
	local count = 0 -- 500
	for x = 2, main_grid.w - 1 do -- 501
		for y = 2, main_grid.h - 1 do -- 502
			do -- 503
				local cell = main_grid:grid_get(x, y) -- 503
				if cell then -- 503
					if cell.solid_cell then -- 504
						count = count + get_solid_neighbor_count(x, y) -- 505
					end -- 504
				end -- 503
			end -- 503
		end -- 505
	end -- 505
	return count -- 506
end -- 499
get_solid_neighbor_count = function(x, y) -- 509
	local count = 0 -- 510
	do -- 511
		local cell = main_grid:grid_get(x, y) -- 511
		if cell then -- 511
			local left, right, up, down = main_grid:grid_get(x - 1, y), main_grid:grid_get(x + 1, y), main_grid:grid_get(x, y - 1), main_grid:grid_get(x, y + 1) -- 512
			if (function() -- 513
				if left ~= nil then -- 513
					return left.solid_cell -- 513
				end -- 513
				return nil -- 513
			end)() then -- 513
				count = count + 1 -- 513
			end -- 513
			if (function() -- 514
				if right ~= nil then -- 514
					return right.solid_cell -- 514
				end -- 514
				return nil -- 514
			end)() then -- 514
				count = count + 1 -- 514
			end -- 514
			if (function() -- 515
				if up ~= nil then -- 515
					return up.solid_cell -- 515
				end -- 515
				return nil -- 515
			end)() then -- 515
				count = count + 1 -- 515
			end -- 515
			if (function() -- 516
				if down ~= nil then -- 516
					return down.solid_cell -- 516
				end -- 516
				return nil -- 516
			end)() then -- 516
				count = count + 1 -- 516
			end -- 516
			return count -- 517
		end -- 511
	end -- 511
	return 0 -- 518
end -- 509
does_shape_fit = function(x, y, shape) -- 522
	for _index_0 = 1, #shape do -- 523
		local offset = shape[_index_0] -- 523
		do -- 524
			local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 524
			if cell then -- 524
				if cell.interactable_cell then -- 525
					if cell.solid_cell or not cell.arena_cell then -- 526
						return false -- 527
					end -- 526
				else -- 529
					return false -- 529
				end -- 525
			else -- 531
				return false -- 531
			end -- 524
		end -- 524
	end -- 531
	return true -- 532
end -- 522
does_shape_fit_arena = function(shape_rotations) -- 537
	for x = 2, main_grid.w - 1 do -- 538
		for y = 2, main_grid.h - 1 do -- 539
			do -- 540
				local cell = main_grid:grid_get(x, y) -- 540
				if cell then -- 540
					if cell.arena_cell then -- 541
						for _index_0 = 1, #shape_rotations do -- 542
							local rotated_shape = shape_rotations[_index_0] -- 542
							if does_shape_fit(x, y, rotated_shape) then -- 543
								return true -- 544
							end -- 543
						end -- 544
					end -- 541
				end -- 540
			end -- 540
		end -- 544
	end -- 544
end -- 537
cell = function(i, j) -- 547
	local self = anchor('cell') -- 548
	self:prs_init((i - 1) * cell_w + 0.5 * cell_w, (j - 1) * cell_h + 0.5 * cell_h) -- 549
	self:collider_init('cell', 'static', 'rectangle', cell_w, cell_h) -- 550
	self:hitfx_init() -- 551
	self:shake_init() -- 552
	self.i, self.j = i, j -- 553
	self.interactable_cell = self.i >= 2 and self.j >= 2 and self.i <= main_grid.w - 1 and self.j <= main_grid.h - 1 -- 554
	self.arena_cell = false -- 555
	self.pointer_cell_ok = false -- 556
	self.pointer_cell_not_ok = false -- 557
	self.solid_cell = false -- 558
	self.word_cell = false -- 559
	self.counter_cell = false -- 560
	self.update = function(self, dt) -- 562
		if self.trigger_active['generation_collider'] and self.interactable_cell then -- 563
			self.arena_cell = true -- 563
		end -- 563
		game:push(self.x, self.y, 0, self.springs.main.x, self.springs.main.x) -- 564
		if self.counter_cell then -- 565
			if not bottom_counter_hidden then -- 566
				do -- 567
					local _exp_0 = self.counter_cell -- 567
					if 'normal' == _exp_0 then -- 568
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.yellow[0]) -- 569
					elseif 'warning' == _exp_0 then -- 570
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.orange[0]) -- 571
					elseif 'danger' == _exp_0 then -- 572
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.red[0]) -- 573
					end -- 573
				end -- 573
			end -- 566
		elseif self.word_cell then -- 574
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.bg[2]) -- 575
			if type(self.word_cell) == 'string' then -- 576
				game:draw_text_centered(self.word_cell, font, self.x, self.y, 0, 1, 1, 0, 0, colors.fg[0]) -- 576
			end -- 576
		elseif self.solid_word_cell then -- 577
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.bg[2]) -- 578
			if type(self.solid_word_cell) == 'string' then -- 579
				game:draw_text_centered(self.solid_word_cell, font, self.x, self.y, 0, 1, 1, 0, 0, colors.fg[0]) -- 579
			end -- 579
		elseif self.solid_cell then -- 580
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, self.flashes.main.x and colors.fg[5] or colors.bg[2]) -- 581
			if self.pointer_cell_not_ok and not self.flashes.main.x then -- 582
				game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 0, 0, grid_pointer_not_ok_color) -- 583
				game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 4, 4, grid_pointer_not_ok_outline_color, 2) -- 584
			end -- 582
		elseif self.pointer_cell_ok then -- 585
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_pointer_ok_color) -- 586
			game:rectangle(self.x, self.y, self.w, self.h, 4, 4, grid_pointer_ok_outline_color, 2) -- 587
		elseif self.pointer_cell_not_ok then -- 588
			game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 0, 0, grid_pointer_not_ok_color) -- 589
			game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 4, 4, grid_pointer_not_ok_outline_color, 2) -- 590
		elseif self.arena_cell then -- 591
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_marker_color) -- 592
		end -- 565
		return game:pop() -- 593
	end -- 562
	return self -- 594
end -- 547
reset_cell = function(self) -- 596
	self.collision_active['generation_collider'] = nil -- 597
	self.trigger_active['generation_collider'] = nil -- 598
	self.arena_cell = false -- 599
	self.pointer_cell_ok = false -- 600
	self.pointer_cell_not_ok = false -- 601
	self.solid_cell = false -- 602
	self.word_cell = false -- 603
	self.solid_word_cell = false -- 604
end -- 596
score_cell = function(self) -- 606
	objects:container_add(hit_circle(self.x, self.y, { -- 607
		colors = { -- 607
			colors.bg[5] -- 607
		}, -- 607
		duration = 0.4, -- 607
		rs = 14 -- 607
	})) -- 607
	for i = 1, main:random_int(3, 4) do -- 608
		objects:container_add(hit_particle(self.x, self.y, { -- 608
			angular_v = main:random_float(-math.pi, math.pi), -- 608
			colors = { -- 608
				main:random_bool(50) and colors.bg[5] or colors.fg[5] -- 608
			}, -- 608
			duration = main:random_float(0.4, 1), -- 608
			v = main:random_float(100, 300) -- 608
		})) -- 608
	end -- 608
end -- 606
hitfx_cell = function(self, s, f) -- 610
	return self:hitfx_use('main', s or 0.25, nil, nil, f or 0.15) -- 611
end -- 610
generation_collider = function(x, y, w, h) -- 614
	local self = anchor('generation_collider') -- 615
	self:prs_init(x, y) -- 616
	if w and h then -- 617
		self:collider_init('generation_collider', 'dynamic', 'rectangle', w, h) -- 618
	else -- 620
		self:collider_init('generation_collider', 'dynamic', 'circle', w) -- 620
	end -- 617
	self.update = function(self, dt) -- 622
		self:collider_update_position_and_angle() -- 623
		if self.shape_type == 'circle' then -- 624
			return game:circle(self.x, self.y, self.rs, grid_marker_color, 2) -- 625
		else -- 627
			return game:polygon(self:collider_get_vertices(), grid_marker_color, 2) -- 627
		end -- 624
	end -- 622
	return self -- 628
end -- 614
