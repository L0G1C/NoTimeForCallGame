class_name SpouseSequence
extends Resource

export(int) var sequence_id : int = 2
export(String) var color : String
export(Texture) var icon : Texture
export(Array) var Events : Array = [
	{
	"EventId": 0,
	"CallerName": "Spouse",
	"CallerVoice": "voice3",
	"Text": "Hi honey, did you pick up Groceries yet?",
	"CorrectAnswerText": "Yup!",
	"CorrectAnswerResults": [-1, 2, 0],
	"WrongAnswerText": "Uh oh...",
	"WrongAnswerResults": [0, -2, -1]
	},
	{
	"EventId": 1,
	"CallerName": "Spouse",
	"CallerVoice": "voice3",
	"Text": "And what about that other errand you mentioned?",
	"CorrectAnswerText": "Nah, let's forget it.",
	"CorrectAnswerResults": [2, 1, -1],
	"WrongAnswerText": "Leave me alone!",
	"WrongAnswerResults": [1, -4, -2]
	}
	,{
	"EventId": 2,
	"CallerName": "Spouse",
	"CallerVoice": "voice3",
	"Text": "Well, if you hurry home, you can make dinner.",
	"CorrectAnswerText": "On it!",
	"CorrectAnswerResults": [1, 3, 0],
	"WrongAnswerText": "I ate on the road...",
	"WrongAnswerResults": [-3, -4, -1]	
	}
]	
	
