class Operation < ActiveRecord::Base
  belongs_to :user
  belongs_to :bank_account
  belongs_to :operation_type

  def self.all_my_distinct(user_id)
    where(user_id: user_id).group(:details_recipient)
  end

  def categories(user_id)
    Categories.where("user_id = ? AND ? like concat('%',keyword,'%')", user_id, self.details_recipient)
  end

  def self.get_for_filters(filters, user_id)
    filters = CGI.parse(filters)
    categories = [0]
    print(filters)
    filters['categorie[]'].each do |value|
      categories << connection.quote(value)
    end
    categories_id = categories.join ", "
    sql = "select distinct o.id,  sum(o.`value`) val, GROUP_CONCAT(c.name) categories, o.accounting_date from operations o
      join categories c on o.details_recipient like concat('%',c.keyword,'%')
      where c.name in (select distinct name from categories where id in ("+categories_id+")) and o.user_id = "+connection.quote(user_id)+"
      and o.accounting_date >= "+connection.quote(filters['date_from'][0])+" and o.accounting_date <= "+connection.quote(filters['date_to'][0])+"
      group by o.accounting_date, o.id"
    return ActiveRecord::Base.connection.execute(sql)
  end
end
