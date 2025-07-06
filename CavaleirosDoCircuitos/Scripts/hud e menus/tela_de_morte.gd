extends CanvasLayer

@onready var voce_perdeu_label = $menu_morte/voce_perdeu_label
@onready var voce_perdeu_label2 = $menu_morte/voce_perdeu_label2
var morte_labels = [
	"Até os maiores heróis tropeçam. A poeira em seus ombros é a prova de que você está tentando. 
	Levante-se, aventureiro, a masmorra ainda espera por seus feitos!",
	"Cada queda nos ensina a levantar mais fortes. Você descobriu um dos segredos da masmorra.
	Agora, com mais sabedoria, tente novamente e mostre a ela quem manda!",
	"A escuridão desta masmorra é traiçoeira, mas sua coragem brilha mais forte.
	Não deixe uma armadilha apagar seu fogo. Respire fundo, a próxima tentativa será a vitoriosa!",
	"Isso não é o fim, é apenas um passo na jornada. As lendas são escritas com tentativas e erros. 
	A sua história de glória ainda está sendo contada. Vamos lá, mais uma vez!",
	"As paredes desta masmorra viram muitos caírem, mas poucas vezes viram alguém com a sua determinação. 
	O tesouro final pertence aos persistentes. Você está pronto para tentar de novo?",
	"Um arranhão não para um verdadeiro explorador! Você aprendeu algo valioso com essa derrota. 
	Use esse conhecimento para desviar do perigo na próxima vez. A aventura chama!",
	"Não tema a queda, tema ficar no chão. A masmorra testou sua habilidade e agora testa sua coragem. 
	Mostre a ela que você tem de sobra!",
	"As riquezas e segredos estão guardados por desafios. Este foi apenas um deles. 
	A cada tentativa, você fica mais perto da vitória. Não desista agora!",
	"O eco da sua bravura ainda ressoa nestes corredores. A masmorra pode ter vencido esta rodada, 
	mas a aventura não acabou. Levante-se e continue sua lenda!",
	"A sorte favorece os bravos, e a vitória favorece os que não desistem. Você é ambos! 
	Sacuda a poeira e mostre a essa masmorra do que um verdadeiro herói é feito!"
]

func _ready() -> void:
	mostrar_morte()

# mostra a tela e atualiza texto
func mostrar_morte():
	visible = true
	voce_perdeu_label.text = GameManager.last_death_cause
	var morte_label = randi_range(0, 9)   # inteiro em [1,10]
	voce_perdeu_label2.text = morte_labels[morte_label]


func _process(delta: float) -> void:
	pass

# Recarrega fase
func _on_tentar_novamente_pressed() -> void:
	# se o path estiver correto, recarrega cena anterior
	if GameManager.last_scene_path != "":
		get_tree().change_scene_to_file(GameManager.last_scene_path)
		MusicManager.retomar_musica()
	else: 
		push_error("lastScenePath não existe")
	

# Volta para o menu
func _on_voltar_menu_principal_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Cenas/hud e menus/seletor_nivel.tscn")
