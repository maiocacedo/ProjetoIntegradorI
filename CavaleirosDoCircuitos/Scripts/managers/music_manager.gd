extends Node

var musica: AudioStreamPlayer 
var lastScene: Node = null

func _ready():
	# Faz este nó rodar mesmo quando a árvore for pausada
	process_mode = Node.PROCESS_MODE_ALWAYS
	musica = AudioStreamPlayer.new() # Instancia um AudioStreamPlayer
	add_child(musica) 
	musica.bus = "music" # define canal onde a música deve tocar
	lastScene = get_tree().current_scene # Recebe cena atual
	# se a cena existir, inicia a música da cena
	if lastScene:
		_on_scene_changed(lastScene) 


func _process(delta):
	# recebe cena atual
	var currentScene = get_tree().current_scene
	# se a cena atual for diferente da ultima cena e diferente da tela_de_morte,
	# ultima cena vira atual e a música troca
	if currentScene != lastScene:
		lastScene = currentScene
		if currentScene:
			_on_scene_changed(currentScene)


# Função que toca nova musica se a cena mudar, ou mantém a mesma
func _on_scene_changed(newScene: Node) -> void:
	print("Cena mudou para:", newScene.name)
	# Toca música de acordo com a cena
	match newScene.name:
		"fase_1", "fase_2","fase_3","fase_4","fase_5":
			_play_music("res://Assets/music/tema_level_1.wav")
		"fase_6", "fase_7","fase_8","fase_9","fase_10":
			_play_music("res://Assets/music/tema_level_2.wav")
		"menu_principal", "seletor_nivel", "opcoes", "creditos":
			_play_music("res://Assets/music/tema_menu.wav")
		"Store","SkinsStore":
			_play_music("res://Assets/music/loja.wav")
		_:
			_stop_music()


# Função para tocar música de acordo com path
func _play_music(path: String) -> void:
	if !musica.stream or musica.stream.resource_path != path:
		
		musica.stream = load(path)
		musica.play()

func retomar_musica():
	musica.play()

# Função para parar música
func _stop_music() -> void:
	musica.stop()
