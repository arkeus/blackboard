class AddSharedToDocuments < ActiveRecord::Migration
  def change
  	add_column :documents, :shared, :boolean, default: false
  end
end
