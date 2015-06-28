require 'spec_helper'

RSpec.describe Pet do
  include MyMatchers

  #
  # validations
  #
  it { is_expected.to validate_presence_of(:name) }
end
