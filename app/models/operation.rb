class Operation < ActiveRecord::Base
  belongs_to :user
  belongs_to :bank_account
  belongs_to :operation_type

  def self.all_my_distinct(user_id)
    where(user_id: user_id).group(:details_recipient)
  end

  def categories(user_id)
    Categories.select(:name).where("user_id = ? AND ? like concat('%',keyword,'%')", user_id, self.details_recipient)
  end
end
