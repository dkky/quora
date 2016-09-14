class CreateQuestionVotes < ActiveRecord::Migration
	def change
		create_table :question_votes do |t|
	      t.references :user
	      t.references :question
	      t.boolean :vote 
	      t.timestamps
	    end
	end
end
