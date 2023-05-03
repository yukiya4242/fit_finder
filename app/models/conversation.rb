class Conversation < ApplicationRecord

  has_many   :messages,   dependent: :destroy
  belongs_to :sender,     class_name: 'User'
  belongs_to :receiver,   class_name: 'User'


  validates :sender_id, uniqueness: { scope: :receiver_id }

  def opponent_of(user)
    user == sender ? receiver : sender
  end

end
