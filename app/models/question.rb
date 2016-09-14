class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers, dependent: :destroy
	has_many :question_votes, dependent: :destroy

	def upvote_count
		question_votes.where(status: 1).count
	end

	def downvote_count
		question_votes.where(status: -1).count
	end
end
