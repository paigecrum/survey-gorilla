User.create(email: "daniel@example.com", password: "123456", first_name: "Daniel", last_name: "Deutsch")
User.create(email: "milan@example.com", password: "123456", first_name: "Milan", last_name: "Grubnic")
User.create(email: "jaimin@example.com", password: "123456", first_name: "Jaimin", last_name: "Patel")

Survey.create(title: "foods", creator_id: 1) #survey 1
Survey.create(title: "colors", creator_id: 2) #survey 2
Survey.create(title: "animals", creator_id: 3) #survey 3
Survey.create(title: "shapes", creator_id: 2) #survey 4

Question.create(survey_id: 1, question_text: "What is your favorite food?") #question 1
Question.create(survey_id: 1, question_text: "What is your least favorite food?") #question 2
Question.create(survey_id: 2, question_text: "What is your favorite color?") #question 3
Question.create(survey_id: 2, question_text: "What is your least favorite color?") #question 4
Question.create(survey_id: 3, question_text: "What is your favorite animal?") #question 5
Question.create(survey_id: 4, question_text: "What is your favorite shape?") #question 6

Response.create(question_id: 1, choice_text: "fruit") #response 1
Response.create(question_id: 1, choice_text: "burgers") #response 2

Response.create(question_id: 2, choice_text: "haggis") #response 3
Response.create(question_id: 2, choice_text: "liver") #response 4

Response.create(question_id: 3, choice_text: "red") #response 5
Response.create(question_id: 3, choice_text: "blue") #response 6

Response.create(question_id: 4, choice_text: "brown") #response 7
Response.create(question_id: 4, choice_text: "green") #response 8

Response.create(question_id: 5, choice_text: "horse") #response 9
Response.create(question_id: 5, choice_text: "dog") #response 10

Response.create(question_id: 6, choice_text: "square") #response 11
Response.create(question_id: 6, choice_text: "circle") #response 12
