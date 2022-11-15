class_name TelemarketersSequence
extends Resource

export(int) var sequence_id : int = 4
export(String) var color : String
export(Texture) var icon : Texture
export(Array) var Events : Array = [
	{
	"EventId": 0,
	"CallerName": "Telemarketers",
	"CallerVoice": "voice3",
	"Text": "Hello we've been trying to reach you about your cars extended warranty.",
	"CorrectAnswerText": "STAHP!",
	"CorrectAnswerResults": [3, 1, -2],
	"WrongAnswerText": "Take My Money!",
	"WrongAnswerResults": [-3, -3, -1],
	},
	{
	"EventId": 1,
	"CallerName": "Telemarketers",
	"CallerVoice": "voice1",
	"Text": "I'm a Nigerian prince and I want to give you $50,000.",
	"CorrectAnswerText": "Seems sus.",
	"CorrectAnswerResults": [3, 1, 1],
	"WrongAnswerText": "Give bank info.",
	"WrongAnswerResults": [-5, -2, -1],
	},
	{
	"EventId": 3,
	"CallerName": "Telemarketers",
	"CallerVoice": "voice2",
	"Text": "I'm the REAL Nigerian prince, here's your last chance for free money!",
	"CorrectAnswerText": "No Thank you!",
	"CorrectAnswerResults": [3, 2, 2],
	"WrongAnswerText": "Take My Money!",
	"WrongAnswerResults": [-5, --2, -1],
	},
]	
	
