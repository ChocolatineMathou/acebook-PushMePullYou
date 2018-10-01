require_relative '../support/sign_up'

RSpec.configure do |config|
  config.include SignUpHelper
end

RSpec.feature 'Single view', type: :feature do
  scenario 'User can see a single post' do
    sign_up
    expect(sign_up).to be(:available)

  end
end
