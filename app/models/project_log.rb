class ProjectLog < ActiveRecord::Base
  include ::Translatable

  # create_table :project_logs do |t|
  #   t.references :project_step, index: true
  #   t.references :person, index: true
  #   t.integer :progress_metric_option_id
  #   t.date :date
  #   t.timestamps

  belongs_to :project_step
  belongs_to :person


  # define accessor like convenience methods for the fields stored in the Translations table
  attr_translatable :summary, :details, :additional_notes, :private_notes


  validates :project_step_id, presence: true


  def name
    # logger.debug "this: #{self.inspect}"
    "#{project_step.try(:name)} log"
  end


  def progress_metric
    PROGRESS_METRIC_OPTIONS.label_for(progress_metric_option_id)
  end



  PROGRESS_METRIC_OPTIONS = OptionSet.new(
      [ [2,'ahead'],
        [1,'on time'],
        [-1,'behind'],
        [-2,'in need of changing some events'],
        [-3,'in need of changing its whole plan'],
      ])

end
