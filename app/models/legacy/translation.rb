module Legacy

class Translation < ActiveRecord::Base

  establish_connection :legacy

  include LegacyModel #, TranslationModule

  # language column made accessible by Legacy module interferes with language method below
  # remove_method :language

  # belongs_to :language, :foreign_key => 'Language'
  # attr_accessible :RemoteColumnName, :RemoteID, :RemoteTable, :TranslatedContent
  # alias_attribute :content, :TranslatedContent


  def migration_data
    new_model_name = map_model_name(remote_table)
    new_attribute_name = map_attribute_name(new_model_name, remote_column_name)
    puts "Translation[#{self.id}]"
    data = {
        id: self.id,
        translatable_type: new_model_name,
        translatable_id: remote_id,
        translatable_attribute: new_attribute_name,
        language_id: language,
        text: translated_content
    }
    data
  end

  def migrate
    if [1,2].include?(language)
      data = migration_data
      puts "#{data[:id]}: #{data[:translatable_type]}[#{data[:translatable_id]}].#{data[:translatable_attribute]}"
      ::Translation.create(data)
    else
      # note, there is a lot of orphaned translation data in the current production db
      puts "Warning, ignoring Translation[#{id}] with invalid Language reference: #{language}"
    end
  end


  def map_model_name(old_table)
    old_table.singularize  ## will need to expand this logic as we flush out the migration
  end

  def map_attribute_name(new_model, old_column)
    ATTRIBUTE_MAP[new_model][old_column]
  end

  ATTRIBUTE_MAP = {
      'Loan' => {'ShortDescription' => 'summary', 'Description' => 'details'}
  }

end

end
