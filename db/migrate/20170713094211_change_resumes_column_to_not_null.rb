class ChangeResumesColumnToNotNull < ActiveRecord::Migration
  def change
    change_column_null :resumes, :resume_file, false
  end
end
