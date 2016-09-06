require 'byebug'

get '/' do
  if logged_in?
  	erb :"static/homepage"
  else
  	erb :"static/index"
  end
end

get '/login' do
	if logged_in?
		redirect '/homepage'
	else
		erb :"static/login"
	end
end

get '/homepage' do
	erb :"static/homepage"
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
		# puts "INVALID"
		redirect '/'
	end
end

post '/login' do
	if @user = User.authenticate(params[:user][:email], params[:user][:password])
		session[:id] = @user.id
		redirect '/homepage'
	else
		redirect '/login'
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


post '/logout' do 
	session[:id] = nil
    redirect'/login'
end

get '/users/:id' do
end