
class QuestionVote < ActiveRecord::Base
	belongs_to :user
	belongs_to :question

	def self.status(user_id,question_id, status)
		question_vote = self.find_by(user_id: user_id, question_id: question_id)
		if question_vote.nil?
			new_question_vote = self.create(user_id: user_id, question_id: question_id, status: status)
		else
			current_status =  question_vote.status
			case current_status
			when 0 #neutral
				if status.to_i == 1
					question_vote.update(status: 1)
				elsif status.to_i == -1
					question_vote.update(status: -1)
				end
			when 1 #upvote
				if status.to_i == -1
					question_vote.update(status: -1)
				elsif status.to_i== 1
					question_vote.update(status: 0)
				end
			when -1 #downvote
				if status.to_i == -1
					question_vote.update(status: 0)
				elsif status.to_i == 1
					question_vote.update(status: 1)
				end
			end
		end
	end 
end
