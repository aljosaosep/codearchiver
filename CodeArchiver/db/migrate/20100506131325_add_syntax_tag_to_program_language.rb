class AddSyntaxTagToProgramLanguage < ActiveRecord::Migration
  def self.up
    add_column :program_languages, :syntax_tag, :string
  end

  def self.down
    remove_column :program_languages, :syntax_tag
  end
end
