# frozen_string_literal: true

require "rails_helper"

RSpec.describe Customer, type: :model do
  let(:customer) { Customer.create(email: "testing@rspec.com", first_name: "rspec", last_name: "testing", password: "123456") }

  it "is a valid object" do
    expect(customer).to be_valid
  end

  it "is not a valid object if params not provided" do
    expect(subject).not_to be_valid
  end
end
