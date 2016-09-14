
get '/' do
  if logged_in?
  	redirect "/homepage"
  else
  	redirect "/home"
  end
end

get '/signup' do
	erb :"static/signup"
end

get '/home' do
	erb :"static/index"
end

get '/login' do
	if logged_in?
		redirect '/homepage'
	else
		erb :"static/index"
	end
end

# .all.order(created_at: :desc)

get '/homepage' do
	@q_all = Question.paginate(:page => params[:page], :per_page => 10).order(id: :desc)
	@ques = Question.new(params[:question])
	if logged_in?
		erb :"static/homepage"
	else
		redirect "/login"
	end
end

# get '/homepage/:name' do
# 	user = User.find_by_name(params[:name])
# end

post '/signup' do 

	# name=email
	# params = { email: 'dasdsad'}

	# name=user[email] and name=user[password]
	# params = { user: { email: 'dasdsad', password: 'dasdad'} }
	@user = User.new(params[:user])
	if @user.save
		# go to database
		#redirect to homepage/dashboard
		redirect '/login' 
	else
		flash.now[:error] = @user.errors.full_messages.join("\n")
		erb :"static/signup"
	end
end

# .messages[:email][0]

post '/login' do
	if @user = User.authenticate(params[:user][:email], params[:user][:password])
		session[:id] = @user.id
		redirect '/homepage'
	else
		erb :"static/index"
	end

	#with has_secure_password
    # @user = User.find_by_email(params[:user][:email])
    # # If the user exists AND the password entered is correct.
    # if @user && @user.authenticate(params[:user][:password])
    #   # Save the user id inside the browser cookie. This is how we keep the user 
    #   # logged in when they navigate around our website.
    #   session[:id] = @user.id
    #   redirect '/homepage'
    # else
    # # If user's login doesn't work, send them back to the login form.
    #   redirect '/login'
    # end
end


get '/logout' do 
	session[:id] = nil
    redirect'/login'
end

get '/users/:id' do
	@view_user = User.find(params[:id])
	if current_user.id == params[:id]
		erb :"users/current-user-profile"
	else
		erb :"users/user-profile"
	end
end

get '/profile' do
	erb :"users/current-user-profile"
end


get '/my_answer' do 
	@my_answer = current_user.answers 
	erb :"static/my_answer"
end 

# get '/answers/:id/edit' do
# 	byebug
# 	@edit_answer = current_user.answers.find(params[:id])
# end

post '/my_answer/:id' do 
	@edit_answer = current_user.answers.find(params[:id])
	erb :'/answers/edit'
end

post '/answer/:id/edit' do 
	@edit_answer = Answer.find(params[:id])
	# byebug
	@edit_answer.update(params[:answer])
	# byebug
	redirect '/my_answer'
end 

post '/my_answer/:id/delete' do
	@delete_answer = Answer.find(params[:id])
	@delete_answer.destroy
	redirect '/my_answer'
end 


post '/user/:id/question/:question_id/answer' do
	@question = Question.find(params[:question_id])
	@answer = @question.answers.new(user_id:params[:id],answer:params[:answer])
	@answer.save
	@q_all = Question.all.order(created_at: :desc)
	# @answer = Answer.new(params[:answer])
	# @answer.user_id = params[:id]
	# @answer.question_id = params[:question_id]
	# @answer.save
	redirect "/homepage"
end

before do
	#pass means permission granted
	pass if logged_in? || request.path_info == '/signup' || request.path_info == '/login'
	#otherwise do the below
	redirect "/signup"
end

get '/fish' do
	erb :'random/fish'
end

get '/the-story' do
	erb :'random/the-story'
end

# before do 
#     regex = %r{\A(\/|\/users(\/signup|\/login|\/questions\/\d+)?\/?)\z}
#     pass if logged_in? || !(request.path_info =~ regex).nil?
#     redirect '/'
# end