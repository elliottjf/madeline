class Division < ActiveRecord::Base
  # include ::Translatable

  #create_table :divisions do |t|
  #  t.string :name
  #  t.text :description
  #
  #  t.timestamps

  has_many :loans, dependent: :destroy

  validates :name, presence: true, length: {minimum: 2}


  def loans_count
    loans.size
  end

end
