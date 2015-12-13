class Friendship < ActiveRecord::Base
  #belongs_to :user, class_name: 'User'
  #belongs_to :friend, class_name: 'User'

  after_initialize :default_values

  private
  def default_values
    self.is_blocked ||= false
  end
end
