class Post < ApplicationRecord
  belongs_to :customer
  has_many :likes

  attr_accessor :first_name, :last_name

  def json_format
    customer = Customer.find(customer_id)
    super.merge(test: customer.first_name)
    # first_name = customer.first_name
    # last_name = customer.last_name
    # p first_name
    # p last_name
    # p self
  end
end
