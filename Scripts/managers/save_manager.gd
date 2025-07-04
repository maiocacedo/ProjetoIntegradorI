extends Node

var progress := {}             
const savePath := "user://progress.json" # Caminho do JSON de salvamento

# Estrelas em função do tempo, para cada level
@export var recompensaLevels := {
	"fase_1": { "3": 25.0, "2": 40.0 },
	"fase_2": { "3": 25.0, "2": 40.0 },
	"fase_3": { "3": 25.0, "2": 40.0 },
	"fase_4": { "3": 25.0, "2": 40.0 },
	"fase_5": { "3": 25.0, "2": 40.0 },
	"fase_6": { "3": 25.0, "2": 40.0 },
	"fase_7": { "3": 25.0, "2": 40.0 },
	"fase_8": { "3": 25.0, "2": 40.0 },
	"fase_9": { "3": 25.0, "2": 40.0 },
	"fase_10": { "3": 25.0, "2": 40.0 }
}

func _ready() -> void:
	load_progress()
	ensure_progress_structure()

	# Soma estrelas dos níveis
	for levelName in SaveManager.recompensaLevels.keys():
		var estrelas = SaveManager.progress.get("fases", {}).get(levelName, {}).get("estrelas", 0)
		PlayerData.stats["estrelas"] += estrelas

	# Carrega upgrades
	PlayerData.hasSpeedUpgrade    = SaveManager.progress.get("itens", {}).get("shoes", {}).get("has", false)
	PlayerData.hasDamageUpgrade   = SaveManager.progress.get("itens", {}).get("cape", {}).get("has", false)
	PlayerData.hasJumpUpgrade     = SaveManager.progress.get("itens", {}).get("refri", {}).get("has", false)
	PlayerData.hasPergaminho      = SaveManager.progress.get("itens", {}).get("pergaminho", {}).get("has", false)


# Garante que a estrutura básica do dicionário exista
func ensure_progress_structure() -> void:
	if "fases" not in progress:
		progress["fases"] = {}

	if "itens" not in progress:
		progress["itens"] = {
			"cape":        {"has": false, "purchased": false},
			"pergaminho":  {"has": false, "purchased": false},
			"refri":       {"has": false, "purchased": false},
			"shoes":       {"has": false, "purchased": false}
		}


# Carrega progresso a partir do JSON
func load_progress() -> void:
	if not FileAccess.file_exists(savePath):
		progress = {}  # Será completado em ensure_progress_structure()
		return

	var f := FileAccess.open(savePath, FileAccess.READ)
	if not f:
		push_error("Não conseguiu abrir %s" % savePath)
		progress = {}
		return

	var text := f.get_as_text()
	f.close()

	var j := JSON.new()
	var parse := j.parse(text)

	if parse != OK:
		push_error("Erro ao parsear JSON: %s" % j.get_error_message())
		progress = {}
	else:
		progress = j.data


# Salva progresso atual no arquivo JSON
func save_progress() -> void:
	var f := FileAccess.open(savePath, FileAccess.WRITE)
	if not f:
		push_error("Não foi possível salvar progresso em %s" % savePath)
		return

	var j := JSON.new()
	var json_text := j.stringify(progress)
	f.store_string(json_text)
	f.close()


# Atualiza progresso de uma fase
func update_level_progress(nomeLevel: String, tempoDecorrido: float) -> void:
	ensure_progress_structure()
	var rn = recompensaLevels.get(nomeLevel, {})
	var estrelas = 1

	if tempoDecorrido <= rn.get("3", 0.0):
		estrelas = 3
	elif tempoDecorrido <= rn.get("2", 0.0):
		estrelas = 2

	if not progress["fases"].has(nomeLevel) or tempoDecorrido < progress["fases"][nomeLevel].get("tempo", INF):
		progress["fases"][nomeLevel] = {
			"tempo": tempoDecorrido,
			"estrelas": estrelas
		}
		save_progress()


# Atualiza progresso de um upgrade (ex: shoes, cape)
func update_upgrade_progress(nomeUpgrade: String, has: bool, purchased: bool) -> void:
	ensure_progress_structure()
	progress["itens"][nomeUpgrade] = {
		"has": has,
		"purchased": purchased
	}
	save_progress()
