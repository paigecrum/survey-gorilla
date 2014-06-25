require 'pp'

get '/' do
  erb :index
end

post '/login' do
  if User.authenticate(params[:email], params[:password])
   #if User.find_by_email(params[:email]) && params[:password] == User.find_by_email(params[:email])#.password_hash
    @user = User.find_by_email(params[:email])
    #session[:user_id] = User.find_by_email(params[:email]).id
    session[:user_id] = @user.id
    session[:message] = nil
    redirect '/menu'
  else
    session[:message] = "Your email address or password do not match"
    redirect back
  end
end

get '/logout' do
  session.clear
  redirect to "/"
end

post '/signup' do
  if params[:password] == params[:confirm_password]
    @new_user = User.create(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], password: params[:password])
    session[:user_id] = @new_user.id
    redirect '/menu'
  else
    session[:message] = "Your password validation did not match"
    redirect back
  end
end


get '/profile' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    erb :profile
  else
    redirect back
  end
end

get '/create' do
  if session[:user_id]
    erb :create
  else
    redirect '/'
  end
end

get '/menu' do
  if session[:user_id]
    erb :menu
  else 
    redirect '/'
  end
end

post '/take' do
  if Survey.find_by_id(params[:survey_id])
    session[:message] = nil
    redirect "/take/#{params[:survey_id]}"
  else
    session[:message] = "Survey Number doesn't exist"
    redirect back
  end
end

post '/results' do
  if Survey.find_by_id(params[:survey_id])
    session[:message] = nil
    redirect "/results/#{params[:survey_id]}"
  else
    session[:message] = "Survey Number doesn't exist"
    redirect back
  end
end

get '/take/:survey_id' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions
    @survey_hash = {}
    @questions.each do |question|
      @survey_hash[question] = question.responses
    end
    if @user.taken_surveys.find_by_id(params[:survey_id])
      session[:message] = "Sorry.  You can only take each survey once."
      redirect back
    else
      session[:message] = nil
      erb :take_survey
    end
  else
    redirect '/'
  end
end

post '/take/:survey_id' do
  @user = User.find(session[:user_id])
  @survey = Survey.find(params[:survey_id])
  @user.taken_surveys << @survey

  @survey.questions.each do |ques|
    var = "qq_" + ques.id.to_s
    puts var
    p Response.find(params[var]).choice_text
    @user.responses << Response.find(params[var])
  end
  redirect 'menu'
end

get '/results/:survey_id' do
  if session[:user_id]
    @survey = Survey.find(params[:survey_id])
    @questions = @survey.questions
    @survey_hash = {}
    @questions.each do |question|
      @survey_hash[question] = question.responses
    end
      erb :results_survey
  else 
    redirect '/'
  end
end

delete '/delete_survey/:survey_id' do
  @survey = Survey.find(params[:survey_id])
  @survey.destroy
  redirect back
end

put '/edit/:user_id' do
  @user = User.find(params[:user_id])
  @user.update_attributes(first_name: params[:first_name], last_name: params[:last_name])
  redirect back
end

post '/new_survey' do
  if request.xhr?
    @new_survey = Survey.create(title: params[:survey_title], creator_id: session[:user_id])
    session[:working_survey_id] = @new_survey.id
    erb :_survey_questions, layout: false
  end
end

post '/new_question' do
  if request.xhr?
    @new_question = Question.create(question_text: params[:question], survey_id: session[:working_survey_id])
    session[:working_question_id] = @new_question.id
    erb :_created_questions, layout: false
  end
end

post '/new_response' do
  if request.xhr?
    @new_response = Response.create(choice_text: params[:question_response], question_id: session[:working_question_id])
    erb :_created_questions, layout: false
  end
end
