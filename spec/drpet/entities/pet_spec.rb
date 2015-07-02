require 'spec_helper'

RSpec.describe Pet do
  #
  # validations
  #
  it { is_expected.to validate_presence_of(:name) }
end
