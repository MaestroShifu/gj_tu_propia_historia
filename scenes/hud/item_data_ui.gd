extends PanelContainer
class_name ItemDataUI

@onready var item_texture: TextureButton = $ItemTexture

var item : ItemSpawn.EnumItemName

func init(normal_texture : Texture2D, disable_texture : Texture2D, in_item : ItemSpawn.EnumItemName):
	item_texture.texture_normal = normal_texture
	item_texture.texture_disabled = disable_texture
	item = in_item
	item_texture.disabled = true

func set_active_item():
	item_texture.disabled = false

