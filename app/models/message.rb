class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  after_initialize :default_values

  def set_as_read
    self.update(is_read: true)
  end

  private
    def default_values
      self.is_read ||= false
    end
end
