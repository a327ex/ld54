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
	for i = 13, 100 do -- 190
		print(level_to_player_counter_speed[i]) -- 191
	end -- 191
	main:observer_condition((function() -- 194
		return player_counter >= 25 -- 194
	end), (function() -- 194
		reset_grid() -- 195
		death:sound_play(0.75, main:random_float(0.95, 1.05)) -- 197
		main:timer_cancel('warning') -- 198
		game_over = true -- 199
		just_game_over = true -- 200
		main:timer_after(1, (function() -- 201
			just_game_over = false -- 201
		end), 'just_game_over') -- 201
		level = 1 -- 202
		round_started = false -- 203
		bottom_counter_hidden = false -- 204
		bottom_counter_grayed = true -- 205
		main.bottom_counter_state = nil -- 206
		set_text(8, 9, 'GAME OVER') -- 207
		t = "SCORE: " .. tostring(player_score) -- 208
		set_text(math.ceil((24 - utf8.len(t)) / 2), 10, "SCORE: " .. tostring(player_score)) -- 209
		return set_text(2, 11, 'left click to restart') -- 210
	end)) -- 194
	main:observer_condition((function() -- 214
		return player_counter >= 16 -- 214
	end), (function() -- 214
		main.bottom_counter_state = 'warning' -- 214
	end)) -- 214
	main:observer_condition((function() -- 215
		return player_counter >= 20 -- 215
	end), (function() -- 215
		main.bottom_counter_state = 'danger' -- 215
	end)) -- 215
	main:observer_value('bottom_counter_state', 'normal', (function() -- 217
		main:timer_cancel('warning') -- 218
		bottom_counter_hidden = false -- 219
	end)) -- 217
	main:observer_value('bottom_counter_state', 'warning', (function() -- 221
		return main:timer_every(0.8, (function() -- 222
			bottom_counter_hidden = not bottom_counter_hidden -- 223
			return warning:sound_play(0.75) -- 224
		end), nil, nil, nil, 'warning') -- 225
	end)) -- 221
	main_grid = grid(24, 24, 0) -- 229
	cell_w, cell_h = main.w / main_grid.w, main.h / main_grid.h -- 230
	for i = 1, main_grid.w do -- 231
		for j = 1, main_grid.h do -- 232
			main_grid:grid_set(i, j, cell(i, j)) -- 233
		end -- 233
	end -- 233
	starting_game = true -- 236
	set_text(6, 4, 'M8B1674-00D4') -- 237
	set_text(6, 11, 'fill the area') -- 238
	set_text(5, 12, 'until the next') -- 239
	set_text(5, 13, 'shape wont fit') -- 240
	set_text(4, 20, 'left click: place') -- 241
	return set_text(3, 21, 'right click: rotate') -- 242
end -- 4
update = function(dt) -- 245
	if (main:input_is_pressed('1') or main:input_is_pressed('2')) and starting_game then -- 249
		starting_game = false -- 250
		reset_grid() -- 251
		generate_arena() -- 252
	end -- 249
	if main:input_is_pressed('2') then -- 255
		rotate:sound_play(0.75, main:random_float(0.95, 1.05)) -- 256
		pointer_shape_rotation = pointer_shape_rotation + 1 -- 257
		if pointer_shape_rotation == 5 then -- 258
			pointer_shape_rotation = 1 -- 258
		end -- 258
	end -- 255
	if round_started then -- 261
		player_counter = player_counter + level_to_player_counter_speed[level] * dt -- 262
	end -- 261
	set_bottom_counter(player_counter) -- 263
	if main.bottom_counter_state == 'warning' or main.bottom_counter_state == 'danger' then -- 265
		local warning_speed = math.remap(25 - player_counter, 9, 0, 1, 0.1) -- 266
		main:timer_set_multiplier('warning', warning_speed) -- 267
	end -- 265
	for i = 2, main_grid.w - 1 do -- 270
		for j = 2, main_grid.h - 1 do -- 271
			local cell = main_grid:grid_get(i, j) -- 272
			cell.pointer_cell_ok = false -- 273
			cell.pointer_cell_not_ok = false -- 274
		end -- 274
	end -- 274
	local x, y = math.ceil(main.pointer.x / cell_w), math.ceil(main.pointer.y / cell_h) -- 277
	local any_cell_not_ok = false -- 278
	local current_cells = { } -- 279
	if pointer_shape and round_started then -- 280
		local shape = shapes[pointer_shape][pointer_shape_rotation] -- 281
		if does_shape_fit(x, y, shape) then -- 282
			for _index_0 = 1, #shape do -- 283
				local offset = shape[_index_0] -- 283
				do -- 284
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 284
					if cell then -- 284
						if cell.interactable_cell then -- 285
							current_cells[#current_cells + 1] = cell -- 286
							cell.pointer_cell_ok = true -- 287
						end -- 285
					end -- 284
				end -- 284
			end -- 287
		else -- 289
			any_cell_not_ok = true -- 289
			for _index_0 = 1, #shape do -- 290
				local offset = shape[_index_0] -- 290
				do -- 291
					local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 291
					if cell then -- 291
						if cell.interactable_cell then -- 292
							current_cells[#current_cells + 1] = cell -- 293
							cell.pointer_cell_not_ok = true -- 294
						end -- 292
					end -- 291
				end -- 291
			end -- 294
		end -- 282
	end -- 280
	if main:input_is_pressed('1') and any_cell_not_ok and round_started then -- 296
		failed_placement:sound_play(0.375, main:random_float(0.95, 1.05)) -- 297
		failed_placement_2:sound_play(0.75, main:random_float(0.95, 1.05)) -- 298
		for _index_0 = 1, #current_cells do -- 299
			local cell = current_cells[_index_0] -- 299
			if cell.interactable_cell and cell.arena_cell then -- 300
				cell:shake_shake(4, 0.2) -- 301
			end -- 300
		end -- 301
	end -- 296
	if main:input_is_pressed('1') and not any_cell_not_ok and round_started then -- 304
		successful_placement:sound_play(0.375, main:random_float(0.95, 1.05)) -- 305
		successful_placement_2:sound_play(0.75) -- 306
		for _index_0 = 1, #current_cells do -- 307
			local cell = current_cells[_index_0] -- 307
			if cell.interactable_cell and cell.arena_cell then -- 308
				cell.pointer_cell_ok = false -- 309
				cell.pointer_cell_not_ok = false -- 310
				cell.solid_cell = true -- 311
				hitfx_cell(cell, 0.2, 0.15) -- 312
			end -- 308
		end -- 312
		pointer_shape = nil -- 315
		main:timer_after(0.3, (function() -- 316
			pointer_shape = get_next_pointer_shape() -- 317
			if not does_shape_fit_arena(shapes[pointer_shape]) then -- 319
				pointer_shape = nil -- 320
				local added_score = get_solid_cell_score() -- 321
				round_started = false -- 322
				player_score = player_score -- 323
				player_counter = player_counter -- 324
				main:timer_tween(0.64, _G, { -- 325
					player_counter = player_counter - added_score / 12 -- 325
				}, math.cubic_in_out, (function() -- 325
					if player_counter < 0 then -- 326
						player_counter = 0 -- 326
					end -- 326
					if player_counter < 16 then -- 327
						main.bottom_counter_state = 'normal' -- 327
					end -- 327
					if player_counter >= 16 and player_counter < 20 then -- 328
						main.bottom_counter_state = 'warning' -- 328
					end -- 328
					bottom_counter_grayed = true -- 329
				end), 'player_counter') -- 325
				local solid_cells = { } -- 331
				for x = 2, main_grid.w do -- 332
					for y = 2, main_grid.h do -- 333
						do -- 334
							local cell = main_grid:grid_get(x, y) -- 334
							if cell then -- 334
								if cell.solid_cell then -- 335
									solid_cells[#solid_cells + 1] = cell -- 336
								else -- 338
									reset_cell(cell) -- 338
								end -- 335
							end -- 334
						end -- 334
					end -- 338
				end -- 338
				set_text(18, 4, "+" .. tostring(tostring(added_score))) -- 339
				table.shuffle(solid_cells) -- 340
				main:timer_after(0.5, (function() -- 341
					round_end:sound_play(0.75, main:random_float(0.95, 1.05)) -- 342
					deep_wobble:sound_play(0.75, main:random_float(0.95, 1.05)) -- 343
					for i, solid_cell in ipairs(solid_cells) do -- 344
						hitfx_cell(solid_cell, 0.0, nil, nil, 0.15) -- 345
						main:timer_after(0.1, (function() -- 346
							local score = get_solid_neighbor_count(solid_cell.i, solid_cell.j) -- 347
							solid_cell.solid_word_cell = tostring(score) -- 348
						end)) -- 346
					end -- 349
				end)) -- 341
				local pitch = 0.75 -- 351
				main:timer_after(3, (function() -- 352
					for i, solid_cell in ipairs(solid_cells) do -- 353
						main:timer_after((i - 1) * 0.05, (function() -- 354
							local score = get_solid_neighbor_count(solid_cell.i, solid_cell.j) -- 355
							pitch = pitch + (i * (score / 200)) -- 356
							score_count_tile:sound_play(0.8, pitch) -- 357
							solid_cell.solid_word_cell = '0' -- 358
							player_score = player_score + score -- 359
							return set_top_text("SCORE: " .. tostring(player_score)) -- 360
						end)) -- 354
					end -- 361
				end)) -- 352
				return main:timer_after(4 + 0.05 * #solid_cells, (function() -- 363
					level = level + 1 -- 364
					reset_grid() -- 365
					return generate_arena() -- 366
				end)) -- 367
			end -- 319
		end), 'new_shape') -- 316
	end -- 304
	if main:input_is_pressed('1') and game_over and not just_game_over then -- 371
		reset_grid() -- 372
		player_score = 0 -- 374
		player_counter = 0 -- 375
		level = 1 -- 376
		round_started = false -- 377
		game_over = false -- 378
		main.bottom_counter_state = nil -- 379
		bottom_counter_grayed = false -- 380
		generate_arena() -- 381
	end -- 371
	bg:rectangle(0.5 * main.w, 0.5 * main.h, main.w, main.h, 0, 0, colors.fg[0]) -- 384
	bg2:set_blend_mode('replace') -- 385
	for i = 2, main_grid.w do -- 386
		for j = 2, main_grid.h do -- 387
			x, y = (i - 1) * cell_w, (j - 1) * cell_h -- 388
			local w, h = 5, 5 -- 389
			bg2:line(x - w / 2, y, x + w / 2, y, grid_marker_color, 1) -- 390
			bg2:line(x, y - h / 2, x, y + h / 2, grid_marker_color, 1) -- 391
		end -- 391
	end -- 391
	bg2:set_blend_mode() -- 392
	main_grid:grid_for_each((function(v, i, j) -- 395
		return v:update(dt) -- 395
	end)) -- 395
	objects:container_update(dt) -- 396
	return objects:container_remove_dead() -- 397
end -- 245
get_next_pointer_shape = function() -- 400
	pointer_shape_rotation = 1 -- 401
	return main:random_table({ -- 402
		'short_t', -- 402
		'long_t', -- 402
		'short_i', -- 402
		'long_i', -- 402
		'short_j', -- 402
		'long_j', -- 402
		'short_l', -- 402
		'long_l', -- 402
		'short_s', -- 402
		'long_s', -- 402
		'short_z', -- 402
		'long_z', -- 402
		'short_v', -- 402
		'long_v', -- 402
		'o', -- 402
		'x', -- 402
		'f', -- 402
		'p', -- 402
		'u', -- 402
		'y', -- 402
		'z' -- 402
	}) -- 402
end -- 400
set_text = function(x, y, text) -- 406
	for i = 1, utf8.len(text) do -- 407
		do -- 408
			local cell = main_grid:grid_get(x + i, y) -- 408
			if cell then -- 408
				cell.word_cell = utf8.sub(text, i, i) -- 409
			end -- 408
		end -- 408
	end -- 409
end -- 406
reset_grid = function() -- 412
	for x = 2, main_grid.w do -- 413
		for y = 2, main_grid.h do -- 414
			do -- 415
				local cell = main_grid:grid_get(x, y) -- 415
				if cell then -- 415
					reset_cell(cell) -- 416
				end -- 415
			end -- 415
		end -- 416
	end -- 416
end -- 412
reset_line = function(x, y) -- 419
	for i = x, main_grid.w do -- 420
		do -- 421
			local cell = main_grid:grid_get(i, y) -- 421
			if cell then -- 421
				reset_cell(cell) -- 422
			end -- 421
		end -- 421
	end -- 422
end -- 419
set_bottom_counter = function(value) -- 426
	for i = 1, main_grid.w do -- 427
		local cell = main_grid:grid_get(i, main_grid.h) -- 428
		cell.counter_cell = nil -- 429
	end -- 429
	for i = 1, math.floor(value) do -- 430
		do -- 431
			local cell = main_grid:grid_get(i, main_grid.h) -- 431
			if cell then -- 431
				if i <= 16 then -- 432
					cell.counter_cell = 'normal' -- 433
				elseif i > 16 and i <= 20 then -- 434
					cell.counter_cell = 'warning' -- 435
				elseif i > 20 and i <= 25 then -- 436
					cell.counter_cell = 'danger' -- 437
				end -- 432
			end -- 431
		end -- 431
	end -- 437
end -- 426
set_top_text = function(text) -- 440
	for i = 1, main_grid.w do -- 441
		local cell = main_grid:grid_get(i, 1) -- 442
		cell.word_cell = '' -- 443
	end -- 443
	for i = 1, utf8.len(text) do -- 444
		local cell = main_grid:grid_get(i, 1) -- 445
		cell.word_cell = utf8.sub(text, i, i) -- 446
	end -- 446
end -- 440
generate_arena = function() -- 450
	set_text(2, 4, "Lv." .. tostring(tostring(level))) -- 451
	main:timer_every(0.4, (function() -- 453
		local i = main:timer_get_every_index('set_top_text') -- 454
		if i % 4 == 1 then -- 455
			return set_top_text('GENERATING') -- 456
		elseif i % 4 == 2 then -- 457
			return set_top_text('GENERATING.') -- 458
		elseif i % 4 == 3 then -- 459
			return set_top_text('GENERATING..') -- 460
		elseif i % 4 == 0 then -- 461
			return set_top_text('GENERATING...') -- 462
		end -- 455
	end), nil, true, nil, 'set_top_text') -- 453
	spawning = true -- 465
	pointer_shape, pointer_shape_rotation = nil, 1 -- 466
	round_started = false -- 467
	local spawn_count = level_to_generation_colliders_spawned[level] -- 468
	return main:timer_every(0.1, (function() -- 469
		if main:random_bool(50) then -- 470
			objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(8, 20))) -- 471
		else -- 473
			objects:container_add(generation_collider(main.w / 2 + main:random_float(-8, 8), main.h / 2 + main:random_float(-8, 8), main:random_float(16, 40), main:random_float(16, 40))) -- 473
		end -- 470
		generation_shape_spawn:sound_play(0.75, main:random_float(0.7, 1.3)) -- 474
		return rotate:sound_play(0.75, main:random_float(0.7, 1.3)) -- 475
	end), spawn_count, true, (function() -- 476
		return main:timer_after(spawn_count / 15, (function() -- 477
			objects:container_destroy() -- 478
			bottom_counter_grayed = false -- 479
			main.bottom_counter_state = 'normal' -- 480
			round_started = true -- 481
			pointer_shape = get_next_pointer_shape() -- 482
			pointer_shape_rotation = 1 -- 483
			main:timer_cancel('set_top_text') -- 484
			set_top_text("SCORE: " .. tostring(player_score)) -- 485
			return generation_over:sound_play(0.75, main:random_float(0.95, 1.05)) -- 486
		end)) -- 487
	end)) -- 488
end -- 450
get_solid_cell_count = function() -- 491
	local count = 0 -- 492
	for x = 2, main_grid.w - 1 do -- 493
		for y = 2, main_grid.h - 1 do -- 494
			do -- 495
				local cell = main_grid:grid_get(x, y) -- 495
				if cell then -- 495
					if cell.solid_cell then -- 496
						count = count + 1 -- 497
					end -- 496
				end -- 495
			end -- 495
		end -- 497
	end -- 497
	return count -- 498
end -- 491
get_solid_cell_score = function() -- 501
	local count = 0 -- 502
	for x = 2, main_grid.w - 1 do -- 503
		for y = 2, main_grid.h - 1 do -- 504
			do -- 505
				local cell = main_grid:grid_get(x, y) -- 505
				if cell then -- 505
					if cell.solid_cell then -- 506
						count = count + get_solid_neighbor_count(x, y) -- 507
					end -- 506
				end -- 505
			end -- 505
		end -- 507
	end -- 507
	return count -- 508
end -- 501
get_solid_neighbor_count = function(x, y) -- 511
	local count = 0 -- 512
	do -- 513
		local cell = main_grid:grid_get(x, y) -- 513
		if cell then -- 513
			local left, right, up, down = main_grid:grid_get(x - 1, y), main_grid:grid_get(x + 1, y), main_grid:grid_get(x, y - 1), main_grid:grid_get(x, y + 1) -- 514
			if (function() -- 515
				if left ~= nil then -- 515
					return left.solid_cell -- 515
				end -- 515
				return nil -- 515
			end)() then -- 515
				count = count + 1 -- 515
			end -- 515
			if (function() -- 516
				if right ~= nil then -- 516
					return right.solid_cell -- 516
				end -- 516
				return nil -- 516
			end)() then -- 516
				count = count + 1 -- 516
			end -- 516
			if (function() -- 517
				if up ~= nil then -- 517
					return up.solid_cell -- 517
				end -- 517
				return nil -- 517
			end)() then -- 517
				count = count + 1 -- 517
			end -- 517
			if (function() -- 518
				if down ~= nil then -- 518
					return down.solid_cell -- 518
				end -- 518
				return nil -- 518
			end)() then -- 518
				count = count + 1 -- 518
			end -- 518
			return count -- 519
		end -- 513
	end -- 513
	return 0 -- 520
end -- 511
does_shape_fit = function(x, y, shape) -- 524
	for _index_0 = 1, #shape do -- 525
		local offset = shape[_index_0] -- 525
		do -- 526
			local cell = main_grid:grid_get(x + offset[1], y + offset[2]) -- 526
			if cell then -- 526
				if cell.interactable_cell then -- 527
					if cell.solid_cell or not cell.arena_cell then -- 528
						return false -- 529
					end -- 528
				else -- 531
					return false -- 531
				end -- 527
			else -- 533
				return false -- 533
			end -- 526
		end -- 526
	end -- 533
	return true -- 534
end -- 524
does_shape_fit_arena = function(shape_rotations) -- 539
	for x = 2, main_grid.w - 1 do -- 540
		for y = 2, main_grid.h - 1 do -- 541
			do -- 542
				local cell = main_grid:grid_get(x, y) -- 542
				if cell then -- 542
					if cell.arena_cell then -- 543
						for _index_0 = 1, #shape_rotations do -- 544
							local rotated_shape = shape_rotations[_index_0] -- 544
							if does_shape_fit(x, y, rotated_shape) then -- 545
								return true -- 546
							end -- 545
						end -- 546
					end -- 543
				end -- 542
			end -- 542
		end -- 546
	end -- 546
end -- 539
cell = function(i, j) -- 549
	local self = anchor('cell') -- 550
	self:prs_init((i - 1) * cell_w + 0.5 * cell_w, (j - 1) * cell_h + 0.5 * cell_h) -- 551
	self:collider_init('cell', 'static', 'rectangle', cell_w, cell_h) -- 552
	self:hitfx_init() -- 553
	self:shake_init() -- 554
	self.i, self.j = i, j -- 555
	self.interactable_cell = self.i >= 2 and self.j >= 2 and self.i <= main_grid.w - 1 and self.j <= main_grid.h - 1 -- 556
	self.arena_cell = false -- 557
	self.pointer_cell_ok = false -- 558
	self.pointer_cell_not_ok = false -- 559
	self.solid_cell = false -- 560
	self.word_cell = false -- 561
	self.counter_cell = false -- 562
	self.update = function(self, dt) -- 564
		if self.trigger_active['generation_collider'] and self.interactable_cell then -- 565
			self.arena_cell = true -- 565
		end -- 565
		game:push(self.x, self.y, 0, self.springs.main.x, self.springs.main.x) -- 566
		if self.counter_cell then -- 567
			if not bottom_counter_hidden then -- 568
				do -- 569
					local _exp_0 = self.counter_cell -- 569
					if 'normal' == _exp_0 then -- 570
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.yellow[0]) -- 571
					elseif 'warning' == _exp_0 then -- 572
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.orange[0]) -- 573
					elseif 'danger' == _exp_0 then -- 574
						game:rectangle(self.x, self.y, self.w, self.h, 0, 0, bottom_counter_grayed and bottom_counter_color or colors.red[0]) -- 575
					end -- 575
				end -- 575
			end -- 568
		elseif self.word_cell then -- 576
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.bg[2]) -- 577
			if type(self.word_cell) == 'string' then -- 578
				game:draw_text_centered(self.word_cell, font, self.x, self.y, 0, 1, 1, 0, 0, colors.fg[0]) -- 578
			end -- 578
		elseif self.solid_word_cell then -- 579
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, colors.bg[2]) -- 580
			if type(self.solid_word_cell) == 'string' then -- 581
				game:draw_text_centered(self.solid_word_cell, font, self.x, self.y, 0, 1, 1, 0, 0, colors.fg[0]) -- 581
			end -- 581
		elseif self.solid_cell then -- 582
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, self.flashes.main.x and colors.fg[5] or colors.bg[2]) -- 583
			if self.pointer_cell_not_ok and not self.flashes.main.x then -- 584
				game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 0, 0, grid_pointer_not_ok_color) -- 585
				game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 4, 4, grid_pointer_not_ok_outline_color, 2) -- 586
			end -- 584
		elseif self.pointer_cell_ok then -- 587
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_pointer_ok_color) -- 588
			game:rectangle(self.x, self.y, self.w, self.h, 4, 4, grid_pointer_ok_outline_color, 2) -- 589
		elseif self.pointer_cell_not_ok then -- 590
			game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 0, 0, grid_pointer_not_ok_color) -- 591
			game:rectangle(self.x + self.shake_amount.x, self.y + self.shake_amount.y, self.w, self.h, 4, 4, grid_pointer_not_ok_outline_color, 2) -- 592
		elseif self.arena_cell then -- 593
			game:rectangle(self.x, self.y, self.w, self.h, 0, 0, grid_marker_color) -- 594
		end -- 567
		return game:pop() -- 595
	end -- 564
	return self -- 596
end -- 549
reset_cell = function(self) -- 598
	self.collision_active['generation_collider'] = nil -- 599
	self.trigger_active['generation_collider'] = nil -- 600
	self.arena_cell = false -- 601
	self.pointer_cell_ok = false -- 602
	self.pointer_cell_not_ok = false -- 603
	self.solid_cell = false -- 604
	self.word_cell = false -- 605
	self.solid_word_cell = false -- 606
end -- 598
score_cell = function(self) -- 608
	objects:container_add(hit_circle(self.x, self.y, { -- 609
		colors = { -- 609
			colors.bg[5] -- 609
		}, -- 609
		duration = 0.4, -- 609
		rs = 14 -- 609
	})) -- 609
	for i = 1, main:random_int(3, 4) do -- 610
		objects:container_add(hit_particle(self.x, self.y, { -- 610
			angular_v = main:random_float(-math.pi, math.pi), -- 610
			colors = { -- 610
				main:random_bool(50) and colors.bg[5] or colors.fg[5] -- 610
			}, -- 610
			duration = main:random_float(0.4, 1), -- 610
			v = main:random_float(100, 300) -- 610
		})) -- 610
	end -- 610
end -- 608
hitfx_cell = function(self, s, f) -- 612
	return self:hitfx_use('main', s or 0.25, nil, nil, f or 0.15) -- 613
end -- 612
generation_collider = function(x, y, w, h) -- 616
	local self = anchor('generation_collider') -- 617
	self:prs_init(x, y) -- 618
	if w and h then -- 619
		self:collider_init('generation_collider', 'dynamic', 'rectangle', w, h) -- 620
	else -- 622
		self:collider_init('generation_collider', 'dynamic', 'circle', w) -- 622
	end -- 619
	self.update = function(self, dt) -- 624
		self:collider_update_position_and_angle() -- 625
		if self.shape_type == 'circle' then -- 626
			return game:circle(self.x, self.y, self.rs, grid_marker_color, 2) -- 627
		else -- 629
			return game:polygon(self:collider_get_vertices(), grid_marker_color, 2) -- 629
		end -- 626
	end -- 624
	return self -- 630
end -- 616
