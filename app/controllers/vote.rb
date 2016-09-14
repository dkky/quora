post '/vote/:id' do 
	ques= Question.find(params[:id])
	QuestionVote.status(current_user.id, params[:id],params[:value])
	erb :"questions/vote_btn", layout: false, locals: { ques: ques }
end 
