class User < ActiveRecord::Base
  has_secure_password
  #has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'
  #has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  #has_and_belongs_to_many :friends, class_name: 'User', foreign_key: 'user_id', association_foreign_key: 'friend_id', join_table: 'friendships'

  has_many :friendships
  has_many :friends, class_name: 'User', through: :friendships
  after_initialize :default_values

  def received_messages
    # NOTE: the messages from blocked friends is hidden from messages/index.html.erb
    Message.where(recipient: self).order('created_at DESC')
  end

  # For the page archive messages
  def received_read_messages
    Message.where(recipient: self, is_read: true).order('created_at DESC')
  end

  # For the page sent messages
  def sent_messages
    Message.where(sender: self).order('created_at DESC')
  end

  # Get the list of users who are not in the friend list
  # NOTE: Also exclude this user from this list
  def users_not_in_friend_list
    User.where.not(id: self.friends.ids << self.id)
  end

  # Check the friend of this user if he is blocked or not.
  def is_friend_blocked(friend_id)
    find_friendship(friend_id)
    unless @friendship.nil?
      @friendship.is_blocked
    end
  end

  def set_block_friend(friend_id, blocked_value)
    find_friendship(friend_id)
    unless @friendship.nil?
      @friendship.update(is_blocked: blocked_value)
    end
  end

  def add_friendship(friend_id)
    find_friendship(friend_id)
    if @friendship.nil?
      self.friendships.create(friend_id: friend_id)
    end
  end

  def remove_friendship(friend_id)
    find_friendship(friend_id)
    unless @friendship.nil?
      @friendship.destroy
    end
  end

  def find_friendship(friend_id)
    @friendship = self.friendships.find_by_friend_id(friend_id)
  end

  ## Filter out the blocked friends so the user will NOT able to send message
  def unblocked_friends
    self.friends.where("friendships.is_blocked=false")
  end

  private
  def default_values
    self.image_url ||= 'smile'
  end
end
