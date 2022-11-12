class_name ManagerSequence
extends Resource

export(int) var sequence_id : int = 1
export(String) var color : String
export(Texture) var icon : Texture
export(Array) var Events : Array = [
	{
	"EventId": 0,
	"CallerName": "Boss",
	"CallerVoice": "voice2",
	"Text": "Hey there. We're going to need you to come in on Saturday.",
	"CorrectAnswerText": "Sure, boss.",
	"CorrectAnswerResults": [3, -2, -3],
	"WrongAnswerText": "Uh..no can do.",
	"WrongAnswerResults": [-3, 1, 2],
	},
	{
	"EventId": 1,
	"CallerName": "Boss",
	"CallerVoice": "voice2",
	"Text": "Did you turn in your TPS report!?",
	"CorrectAnswerText": "I didn't get the memo.",
	"CorrectAnswerResults": [-3, 1, 3],
	"WrongAnswerText": "Always.",
	"WrongAnswerResults": [1, -1, -3]
	}
	,
	{
	"EventId": 2,
	"CallerName": "Boss",
	"CallerVoice": "voice2",
	"Text": "We need to talk about your performance...",
	"CorrectAnswerText": "Roger that.",
	"CorrectAnswerResults": [1, 1, -3],
	"WrongAnswerText": "Come at me bro!",
	"WrongAnswerResults": [-4, -1, 3],
	}
]	
	
