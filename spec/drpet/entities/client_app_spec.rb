require 'spec_helper'

RSpec.describe ClientApp do
  #
  # validations
  #
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to coerce_attribute(:name).to(String) }
  it { is_expected.to validate_presence_of(:app_id) }
  it { is_expected.to coerce_attribute(:app_id).to(String) }
  it { is_expected.to validate_presence_of(:app_secret) }
  it { is_expected.to coerce_attribute(:app_secret).to(String) }
  it { is_expected.to validate_presence_of(:permissions) }
  it { is_expected.to coerce_attribute(:permissions).to(String) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to coerce_attribute(:user_id).to(Integer) }
end
