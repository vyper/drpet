require 'spec_helper'

RSpec.describe Pet do
  #
  # validations
  #
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to coerce_attribute(:name).to(String) }
  it { is_expected.to coerce_attribute(:created_at).to(DateTime) }
  it { is_expected.to coerce_attribute(:updated_at).to(DateTime) }
end
