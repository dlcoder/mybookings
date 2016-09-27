class AddFeedbackToEvents < ActiveRecord::Migration
  def change
    add_column :events, :feedback, :text
  end
end
