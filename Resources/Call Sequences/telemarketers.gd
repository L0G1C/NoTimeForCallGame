class_name ManagerSequence
extends Resource

export(int) var sequence_id : int = 1
export(String) var color : String
export(Texture) var icon : Texture
export(Array) var Events : Array = [
	{
	"EventId": 0,
	"CallerName": "Telemarketers",
	"CallerVoice": "3",
	"Text": "Hello we've been trying to reach you about your cars extended warranty.",
	"CorrectAnswerText": "STAHP!",
	"CorrectAnswerResults": [3, 1, -2],
	"WrongAnswerText": "Take My Money!",
	"WrongAnswerResults": [-3, -3, -1],
	},
]	
	
