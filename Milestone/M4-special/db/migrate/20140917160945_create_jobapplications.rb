class CreateJobapplications < ActiveRecord::Migration
  def change
    create_table :jobapplications do |t|
      t.string :name
      t.string :email
      t.string :job_name
      t.string :phone
      t.string :status
      t.integer :user_id
      t.integer :job_id
      t.text :coverletter
      t.string :major

      t.timestamps
    end
  end
end
