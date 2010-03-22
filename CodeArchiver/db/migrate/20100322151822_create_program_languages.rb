class CreateProgramLanguages < ActiveRecord::Migration
  def self.up
    create_table :program_languages do |t|
      t.string :language_name
      t.text :reservered_words

      t.timestamps
    end
  end

  def self.down
    drop_table :program_languages
  end
end
