class User < ActiveRecord::Base
  has_secure_password
  #has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'
  #has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'

  has_and_belongs_to_many :friends, class_name: 'User', foreign_key: 'user_id', association_foreign_key: 'friend_id', join_table: 'friendships'
  #has_many :friends, class_name: 'User', through: 'Friendships'

  def received_messages
    # TODO: filter out the message from blocked friend
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

  # Check the friend of this user if he is blocked or not.
  def is_friend_blocked(friend_id)
    @friendship = Friendship.where(user_id: self.id, friend_id: friend_id).first
    @friendship.is_blocked
  end

  # Get the list of users who are not in the friend list
  # NOTE: Also exclude this user from this list
  def users_not_in_friend_list
    User.where.not(id: self.friends.ids << self.id)
  end

end
