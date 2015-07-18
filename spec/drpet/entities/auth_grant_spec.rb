require 'spec_helper'

RSpec.describe AuthGrant do
  #
  # validations
  #
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to coerce_attribute(:code).to(String) }
  it { is_expected.to validate_presence_of(:access_token) }
  it { is_expected.to coerce_attribute(:access_token).to(String) }
  it { is_expected.to validate_presence_of(:refresh_token) }
  it { is_expected.to coerce_attribute(:refresh_token).to(String) }
  it { is_expected.to validate_presence_of(:permissions) }
  it { is_expected.to coerce_attribute(:permissions).to(String) }
  it { is_expected.to validate_presence_of(:client_app_id) }
  it { is_expected.to coerce_attribute(:client_app_id).to(Integer) }
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to coerce_attribute(:user_id).to(Integer) }
end
