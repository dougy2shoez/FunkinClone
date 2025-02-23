extends Node2D


const VU_COUNT = 7.0
const FREQ_MAX = 4000.0

const WIDTH = 800
const HEIGHT = 250
const HEIGHT_SCALE = 8
const MIN_DB = 60
const ANIMATION_SPEED = 0

var spectrum
var min_values = []
var max_values = []


@onready var data = []
func _process(_delta):
	data = []
	var prev_hz = 0

	for i in range(1, VU_COUNT + 1):
		var hz = float(i) * FREQ_MAX / VU_COUNT
		var magnitude = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clampf((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		var height = energy * HEIGHT * HEIGHT_SCALE
		data.append(height)
		prev_hz = hz

	for i in range(VU_COUNT):
		if data[i] > max_values[i]:
			max_values[i] = data[i]
		else:
			max_values[i] = lerp(max_values[i], data[i], ANIMATION_SPEED)

		if data[i] <= 0.0:
			min_values[i] = lerp(min_values[i], 0.0, ANIMATION_SPEED)


func _ready():
	spectrum = AudioServer.get_bus_effect_instance(1, 0)
	print(spectrum)
	min_values.resize(int(VU_COUNT))
	max_values.resize(int(VU_COUNT))
	min_values.fill(0.0)
	max_values.fill(0.0)
