extends Node
var progress := {}             
const savePath := "user://progress.json" # caminho do json de dados de salvamento

# estrelas em função do tempo, para cada level
@export var recompensaLevels := {
	"fase_1": { "3": 25.0, "2": 45.0 },
	"fase_2": { "3": 25.0, "2": 40.0 },
	"fase_3": { "3": 25.0, "2": 40.0 },
	"fase_4": { "3": 25.0, "2": 40.0 },
	"fase_5": { "3": 25.0, "2": 40.0 },
	"fase_6": { "3": 25.0, "2": 40.0 },
	"fase_7": { "3": 25.0, "2": 40.0 },
	
}

func _ready() -> void:
	load_progress()
	for levelName in SaveManager.recompensaLevels.keys():
		var levelNum   = levelName.get_slice("_", 1).to_int()
		var estrelas   = SaveManager.progress.get(levelName, {}).get("estrelas", 0)
		PlayerData.stats["estrelas"] += estrelas

# carrega progresso
func load_progress() -> void:
	# se o arquivo não existir, ele não é carregado
	if not FileAccess.file_exists(savePath):
		progress = {}
		return
	
	# acesso .JSON para leitura
	var f:= FileAccess.open(savePath, FileAccess.READ)
	# verifica se foi possivel acessar
	if not f:
		push_error("Não conseguiu abrir %s" % savePath)
		progress = {}
		return
	
	# recebe arquivo como texto
	var text := f.get_as_text()
	f.close()
	
	# Instancia arquivo .JSON
	var j:= JSON.new()
	var parse := j.parse(text) # transforma texto de JSON em dicionário
	
	# Ver
	if parse != OK:
		push_error("Erro no parse %s" % j.get_error_message())
		progress = {}
	else:
		progress = j.data # Atualiza progresso 
	
	
# salva progresso
func save_progress() -> void:
	# acessa arquivo para escrita
	var f:= FileAccess.open(savePath, FileAccess.WRITE)
	# verifica se é possivel acessar o arquivo
	if not f:
		push_error("Não foi possível salvar progresso em %s" % savePath)
		return
	
	# instancia um JSON
	var j := JSON.new()
	# Recebe o dicionario como string JSON e armazena
	var json_text := j.stringify(progress) 
	f.store_string(json_text)
	f.close()
	

# Atualiza progresso do level
func update_level_progress(nomeLevel: String, tempoDecorrido: float) -> void:
	
	var rn = recompensaLevels.get(nomeLevel, {}) # recebe recompensas referentes ao level
	var estrelas = 1 # estrelas começa em 1
	# verifica o desempenho por tempo e atualiza estrelas
	if tempoDecorrido <= rn.get("3", 0.0):
		estrelas = 3
	elif tempoDecorrido <= rn.get("2", 0.0):
		estrelas = 2
	
	# Verifica se o tempo já escrito lá é maior que o atual e salva.
	if not progress.has(nomeLevel) or tempoDecorrido < progress[nomeLevel]["tempo"]:
		progress[nomeLevel] = { 
			"tempo": tempoDecorrido, 
			"estrelas": estrelas 
		}
		save_progress()
