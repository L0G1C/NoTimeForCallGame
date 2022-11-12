class_name PrincipalSequence
extends Resource

export(int) var sequence_id : int = 3
export(String) var color : String
export(Texture) var icon : Texture
export(Array) var Events : Array = [
	{
	"EventId": 0,
	"CallerName": "Principal Jones",
	"CallerVoice": "voice2",
	"Text": "Hello there, I'm your daughter's school principal. Will you be attending the assembly this Friday?",
	"CorrectAnswerText": "Of course!",
	"CorrectAnswerResults": [-1, 2, 1],
	"WrongAnswerText": "What Assembly?",
	"WrongAnswerResults": [2, -3, -2]
	},
	{
	"EventId": 1,
	"CallerName": "Principal Jones",
	"CallerVoice": "voice2",
	"Text": "You left your daughter at school.",
	"CorrectAnswerText": "I'll pick her up.",
	"CorrectAnswerResults": [-3, 2, 0],
	"WrongAnswerText": "You keep her.",
	"WrongAnswerResults": [4, -4, -2]
	},
	{
	"EventId": 2,
	"CallerName": "Principal Jones",
	"CallerVoice": "voice2",
	"Text": "It's that time of year again! Can we count on you for the fall fund drive?",
	"CorrectAnswerText": "Ugh...",
	"CorrectAnswerResults": [4, -2, 3],
	"WrongAnswerText": "Totally!",
	"WrongAnswerResults": [-4, 4, -2]
	},
	{
	"EventId": 3,
	"CallerName": "Principal Jones",
	"CallerVoice": "voice2",
	"Text": "Hello it's Principal Jones again, did you want to enroll your son in our upcoming field trip?",
	"CorrectAnswerText": "That's right.",
	"CorrectAnswerResults": [-3, 3, -2],
	"WrongAnswerText": "Can't afford it.",
	"WrongAnswerResults": [3, -3, 2]
	},
	
]	
	
