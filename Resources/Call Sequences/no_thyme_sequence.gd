class_name NoThymeSequence
extends Resource

export(int) var sequence_id : int = 0
export(String) var color : String
export(Texture) var icon : Texture
export(Array) var Events : Array = [
	{
	"EventId": 0,
	"CallerName": "Cal",
	"CallerVoice": "voice1",
	"Text": "Hey man, can I get take that Thyme off your hands?!",
	"CorrectAnswerText": "No way, man.",
	"CorrectAnswerResults": [1, 1, 1],
	"WrongAnswerText": "Sure!",
	"WrongAnswerResults": [-1, -1, -1]
	},
	{
	"EventId": 1,
	"CallerName": "Cal",
	"CallerVoice": "voice1",
	"Text": "Dude...I really need that thyme tho...",
	"CorrectAnswerText": "Fuck off, bro!",
	"CorrectAnswerResults": [1, 1, 1],
	"WrongAnswerText": "Ugh, fine.",
	"WrongAnswerResults": [-1, -1, -1]
	}
	,{
	"EventId": 2,
	"CallerName": "Cal",
	"CallerVoice": "voice1",
	"Text": "Bro gimme or I'mma stab you",
	"CorrectAnswerText": "Come at me bro!",
	"CorrectAnswerResults": [1, 1, 1],
	"WrongAnswerText": "Okay I surrender!",
	"WrongAnswerResults": [-1, -1, -1]
	}
]	
	
