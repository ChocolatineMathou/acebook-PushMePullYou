class Post < ApplicationRecord
  belongs_to :customer
  has_many :likes

  attr_accessor :first_name, :last_name

  def json_format
    customer = Customer.find(customer_id)
    {
      id: id,
      message: message,
      created_at: created_at,
      updated_at: updated_at,
      customer_id: customer_id,
      first_name: customer.first_name,
      last_name: customer.last_name
    }
  end
end
