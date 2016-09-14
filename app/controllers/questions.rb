get '/my_question' do 
	@my_question = current_user.questions 
	erb :"static/my_question"
end

# create new question
post '/user/question' do 

	@ques = current_user.questions.new(params[:question])
	if @ques.save
		# tolat_votes = @ques.questoin_votes.where().conts
		# @ques.to_json(except: [:created_at,:updated_at])

		erb :"questions/homepage_show", layout: false, locals: { ques: @ques }
		# {toal: totlat_votes }.to_json
		# go to database
		#redirect to homepage/dashboard
		# redirect '/homepage' 
	else
		# puts "INVALID"
		# redirect '/homepage'
	end
end


# show particular question
get '/question/:id' do
	@ques_clicked = Question.find(params[:id])
	erb :"static/question"
end

# edit question page
post '/my_question/:id' do
	@edit_ques = current_user.questions.find(params[:id])
	erb :'questions/edit'
end

# update a question
post '/question/:id/edit' do 
	@edit_ques = Question.find(params[:id])
	# byebug
	@edit_ques.update(params[:question])
	# byebug
	redirect '/my_question'
end 

# delete a question
post '/my_question/:id/delete' do
	@delete_ques = Question.find(params[:id])
	@delete_ques.destroy
	redirect '/my_question'
end 
