Config = {}

Config.Prints = true -- Used for Debug Prints

Config.Keys = {
    ["G"] = 0x760A9C6F,
}

Config.JobNpc = {
	[1] = { ["Model"] = "A_M_M_ValFarmer_01", ["Pos"] = vector3(-859.2, -1279.73, 43.56), ["Heading"] = 350.34 }, -- farmer market valentine
}

Config.Locations = {
	["Blackwater"] = {
		["WoodLocations"] = { -- Pickup Wood Locations
			[1] = { coords = vector3(-828.85, -1269.16, 43.63) },
			[2] = { coords = vector3(-827.86, -1272.18, 43.59) },
			[3] = { coords = vector3(-875.03, -1312.66, 43.06) },
			[4] = { coords = vector3(-865.51, -1312.34, 43.01) },
			[5] = { coords = vector3(-858.0, -1313.39, 43.11) },
		},
		["DropLocations"] = { -- Drop Wood Locations
			[1] = { coords = vector3(-832.2, -1276.19, 43.66) }, -- Table Saw
			[2] = { coords = vector3(-826.0, -1280.79, 43.62) },
			[3] = { coords = vector3(-826.24, -1274.73, 43.58) },
			[4] = { coords = vector3(-831.8, -1273.06, 43.59) },
			[5] = { coords = vector3(-838.53, -1272.92, 43.53) },
			[6] = { coords = vector3(-840.82, -1280.35, 43.52) },
			[7] = { coords = vector3(-838.78, -1265.26, 43.66) },
			[8] = { coords = vector3(-833.01, -1262.18, 43.55) },
			[9] = { coords = vector3(-840.04, -1270.1, 43.48) },
			[10] = { coords = vector3(-833.64, -1271.08, 43.58) },
		},
	}
}