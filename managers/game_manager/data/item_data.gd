extends Resource

class_name ItemSpawn

const ITEM_1 := "ToySheep"
const ITEM_2 := "ToyShark"
const ITEM_3 := "ToyPigueon_03"
const ITEM_4 := "ToyPigueon_02"
const ITEM_5 := "ToyPigueon_01"
const ITEM_6 := "ToyManta"


enum EnumItemName {
	ITEM_1,
	ITEM_2,
	ITEM_3,
	ITEM_4,
	ITEM_5,
	ITEM_6,
}

var ItemDataSpawn: Dictionary = {
	EnumItemName.ITEM_1: {
		"scene": preload("res://game_objects/item/items_main/item_sheep.tscn"),
		"position": [
			{ "x": 0, "y": 0.30, "z": 0 },
			{ "x": 0, "y": 0.30, "z": 0 },
			{ "x": 0, "y": 0.30, "z": 0 },
		]
	},
	EnumItemName.ITEM_2: {
		"scene": preload("res://game_objects/item/items_main/item_shark.tscn"),
		"position": [
			{ "x": 0.0, "y": 0.0, "z": 19.113 },
			{ "x": 26.523, "y": 0.0, "z": 19.113 },
			{ "x": 18.343, "y": 0.0, "z": 6.492 },
		]
	},
	EnumItemName.ITEM_3: {
		"scene": preload("res://game_objects/item/items_main/item_pigueon_03.tscn"),
		"position": [
			{ "x": 10.56, "y": 0.0, "z": -7.414 },
			{ "x": 23.833, "y": 0.0, "z": -13.911 },
			{ "x": 12.867, "y": 0.0, "z": -17.602 },
		]
	},
	EnumItemName.ITEM_4: {
		"scene": preload("res://game_objects/item/items_main/item_pigueon_02.tscn"),
		"position": [
			{ "x": 3.884, "y": 0.0, "z": -17.602 },
			{ "x": -15.315, "y": 0.0, "z": -8.724 },
			{ "x": -28.459, "y": 0.0, "z": 0.451 },
		]
	},
	EnumItemName.ITEM_5: {
		"scene": preload("res://game_objects/item/items_main/item_pigueon_01.tscn"),
		"position": [
			{ "x": -19.206, "y": 0.0, "z": -18.233 },
			{ "x": -28.255, "y": 0.0, "z": -16.689 },
			{ "x": -28.255, "y": 0.0, "z": 10.335 },
		]
	},
	EnumItemName.ITEM_6: {
		"scene": preload("res://game_objects/item/items_main/item_manta.tscn"),
		"position": [
			{ "x": -12.752, "y": 0.0, "z": 21.174 },
			{ "x": 15.51, "y": 0.0, "z": 7.679 },
			{ "x": -15.267, "y": 0.0, "z": 1.886 },
		]
	},
}
