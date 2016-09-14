class AddColumnToQuestionVotes < ActiveRecord::Migration
	def change
		add_column :question_votes, :status, :integer
	end
end
