class RenameSubjectableToSubject < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :subjectable_type, :subject_type
    rename_column :activities, :subjectable_id, :subject_id
  end
end
