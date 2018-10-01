require_relative '../../app/helpers/sign_up'

RSpec.configure do |config|
  config.include SignUpHelper
end

RSpec.feature 'Single view', type: :feature do
  scenario 'User can see a single post' do
    sign_up

  end
end
