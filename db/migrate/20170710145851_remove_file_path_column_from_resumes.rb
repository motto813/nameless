class RemoveFilePathColumnFromResumes < ActiveRecord::Migration
  def change
    remove_column :resumes, :file_path
  end
end
