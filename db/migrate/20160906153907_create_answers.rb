class CreateAnswers < ActiveRecord::Migration
	def change
		create_table :answers do |t|
	      t.string :answer
	      t.references :user
	      t.references :question
	      t.timestamps
	    end
	end
end
