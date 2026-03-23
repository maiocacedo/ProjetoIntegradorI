extends CanvasLayer

@onready var tempo_counter = $fundo_solido2/tempo_counter  # timer
@onready var estrela_1 = $fundo_solido2/estrelas_1/estrela_1 # estrela 1
@onready var estrela_2 = $fundo_solido2/estrelas_1/estrela_2 # estrela 2 
@onready var estrela_3 = $fundo_solido2/estrelas_1/estrela_3 # estrela 3

var estrelaPath = "res://Assets/sprites/estrela.png" # caminho da estrela "acesa"
var estrelaText : Texture2D = load(estrelaPath) # carregando estrela como textura

# Path da proxima fase
var proximaFase: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false # inicia invisivel 
	process_mode = Node.PROCESS_MODE_ALWAYS # Permite rodar com as cenas pausadas
	var scene_name = get_tree().current_scene.name
	match scene_name:
		"fase_1":
			$fundo_solido4/texto_conclusao.text = "Tutorial Iniciado: Cavaleiro dos Circuitos"
			$fundo_solido4/texto_fase.text = "Bem-vindo, Cavaleiro!"
			$fundo_solido4/texto_descritivo.text = "
			Você está prestes a explorar o mundo mágico da Lógica Digital!
			Neste reino, os sinais viajam como feitiços: ligados (1) ou desligados (0).\n
			Prepare sua mente... e que a lógica esteja com você!"
		"fase_2":
			$fundo_solido4/texto_conclusao.text = "Fase Concluída: Porta PUSH (Buffer)"
			$fundo_solido4/texto_fase.text = "Parabéns, você dominou a Porta PUSH!"
			$fundo_solido4/texto_descritivo.text = "
			Você descobriu o poder de manter as coisas como estão!
			A Porta PUSH é como um espelho: o que entra por um lado, sai igualzinho do outro.
			Se você manda um sinal ligado, ele sai ligado. Se manda um sinal desligado, ele sai desligado.\n
			Você aprendeu a passar a informação para frente sem nenhuma alteração!"
		"fase_3":
			$fundo_solido4/texto_conclusao.text = "Fase Concluída: Porta NOT (Inversora)"
			$fundo_solido4/texto_fase.text = "Incrível! Você venceu a Porta NOT!"
			$fundo_solido4/texto_descritivo.text = "
			Você é um mestre da inversão!
			A Porta NOT é a porta do 'contrário'. Tudo o que entra nela, sai diferente. 
			Se um sinal entra ligado, ela o transforma em desligado. E se entra desligado, ela o deixa ligado!\n
			Você agora sabe como virar a lógica de cabeça para baixo!"
		"fase_4":
			$fundo_solido4/texto_conclusao.text = "Fase Concluída: Porta AND (E)"
			$fundo_solido4/texto_fase.text = "Excelente! Você desvendou o segredo da Porta AND!"
			$fundo_solido4/texto_descritivo.text = "
			Para passar por esta porta, você precisou que todas as entradas estivessem ligadas ao mesmo tempo. 
			A Porta AND é exigente e só diz 'sim' (saída ligada) quando a entrada 1 E a entrada 2 estão ligadas. 
			Se qualquer uma delas estiver desligada, a saída também ficará desligada.\n
			Você aprendeu a importância do trabalho em equipe para que tudo funcione!"
		"fase_5":
			$fundo_solido4/texto_conclusao.text = "Fase Concluída: Porta OR (OU)"
			$fundo_solido4/texto_fase.text = "Fantástico! A Porta OR não foi páreo para você!"
			$fundo_solido4/texto_descritivo.text = "
			Com a Porta OR, você descobriu o poder das opções! 
			Para ela, basta que pelo menos uma das entradas esteja ligada para que a saída também fique ligada. 
			A entrada 1 OU a entrada 2 precisam estar ativadas. 
			É claro que se as duas estiverem ligadas, melhor ainda!\n
			Você entendeu que, às vezes, um único sim é o suficiente!"
		"fase_6":
			$fundo_solido4/texto_conclusao.text = "Fase Concluída: Porta NAND (NÃO E)"
			$fundo_solido4/texto_fase.text = "Impressionante! Você passou pela Porta NAND!"
			$fundo_solido4/texto_descritivo.text = "
			A Porta NAND é a versão 'rebelde' da Porta AND. Pense na Porta AND e depois inverta o resultado! 
			A saída da NAND está quase sempre ligada, e só desliga na única situação em que a porta AND ligaria: quando a entrada 1 E a entrada 2 estão ligadas.\n
			Você aprendeu que negar o 'tudo ou nada' pode abrir muitas possibilidades!"
		"fase_7":
			$fundo_solido4/texto_conclusao.text = "Fase Concluída: Porta NOR (NÃO OU)"
			$fundo_solido4/texto_fase.text = "Maravilhoso! A Porta NOR foi vencida!"
			$fundo_solido4/texto_descritivo.text = "
			A Porta NOR é a 'negação total'. Ela é o contrário da Porta OR. Para a saída dela ficar ligada, todas as entradas precisam estar desligadas. 
			Se a entrada 1 OU a entrada 2 (ou as duas) estiverem ligadas, a saída será desligada.\n
			Você descobriu que, às vezes, a única maneira de conseguir um 'sim' é quando não há nenhum outro sinal!"
		"fase_8":
			$fundo_solido4/texto_conclusao.text = "Fase Concluída: Porta XOR (OU Exclusivo)"
			$fundo_solido4/texto_fase.text = "Genial! Você completou o desafio da Porta XOR!"
			$fundo_solido4/texto_descritivo.text = "
			A Porta XOR é a porta do 'um ou outro, mas não ambos'. 
			Ela só liga a saída quando as entradas são diferentes uma da outra. Se uma entrada está ligada e a outra desligada, a saída fica ligada. 
			Mas se as duas estiverem iguais (ambas ligadas ou ambas desligadas), a saída permanece desligada.\n
			Você se tornou um especialista em encontrar as diferenças!"
		"fase_9":
			$fundo_solido4/texto_conclusao.text = "Fase Concluída: Porta XNOR (NÃO OU Exclusivo)"
			$fundo_solido4/texto_fase.text = "Espetacular! Você conquistou a Porta XNOR!"
			$fundo_solido4/texto_descritivo.text = "
			A Porta XNOR é a 'porta dos iguais'. 
			Ela é o oposto da XOR! A saída dela só fica ligada quando as duas entradas são exatamente iguais: ou as duas estão ligadas ou as duas estão desligadas. 
			Se as entradas forem diferentes, a saída ficará desligada.\n
			Você provou que sabe reconhecer quando as coisas combinam perfeitamente!"
		"fase_10":
			$fundo_solido2/VBoxContainer/proxima_fase.text = "Continuar"
			$fundo_solido4/texto_conclusao.text = "Fase Desafio"
			$fundo_solido4/texto_fase.text = "Parabéns, Você concluiu a jornada dos circuitos!"
			$fundo_solido4/texto_descritivo.text = "
			Muito obrigado por jogar! Sua dedicação, coragem e persistência levaram você até o fim dessa aventura.
			Esperamos que tenha se divertido tanto quanto nós ao criar esse mundo para você explorar."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_proxima_fase_pressed() -> void:
	visible = false # Torna invisivel novamente
	get_tree().paused = false # Despausa cena
	get_tree().change_scene_to_file(proximaFase) 

func _on_loja_pressed() -> void:
	visible = false # Torna invisivel novamente
	get_tree().paused = false # Despausa cena
	var total_estrelas := 0
	
	for levelName in SaveManager.recompensaLevels.keys():
		var levelNum   = levelName.get_slice("_", 1).to_int()
		var estrelas   = SaveManager.progress.get("fases").get(levelName, {}).get("estrelas", 0)
		total_estrelas += estrelas
			
	PlayerData.stats["estrelas"] = total_estrelas
	
	get_tree().change_scene_to_file("res://Cenas/hud e menus/Store.tscn") # mudar para loja

func _on_voltar_ao_menu_pressed() -> void:
	visible = false # Torna invisivel novamente
	get_tree().paused = false # Despausa cena
	get_tree().change_scene_to_file("res://Cenas/hud e menus/seletor_nivel.tscn") # retorna a menu
	
# Função que exibe resultados
func resultados(tempoDecorrido:float, estrelas: int, proxFase: String):
	# Passa a path da proxima fase
	proximaFase = proxFase
	# condicional para "acender" as estrelas de acordo com o desempenho
	if estrelas == 1:
		estrela_1.texture = estrelaText
	elif (estrelas == 2):
		estrela_1.texture = estrelaText
		estrela_2.texture = estrelaText
	else: 
		estrela_1.texture = estrelaText
		estrela_2.texture = estrelaText
		estrela_3.texture = estrelaText
	
	# convertendo tempo para minutos e segundos
	var levelMinutes = int(tempoDecorrido) / 60
	var levelSeconds = int(tempoDecorrido) % 60
	
	# Alterando texto do tempo
	tempo_counter.text = str("%02d" % levelMinutes) + ":" +  str("%02d" % levelSeconds)
	SaveManager.update_level_progress(get_tree().current_scene.name, tempoDecorrido)
	get_tree().paused = true # pausa as cenas
	
		


func _on_continuar_pressed() -> void:
	$fundo_solido4.visible = false
