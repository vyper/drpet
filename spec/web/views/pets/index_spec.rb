require 'spec_helper'
require_relative '../../../../apps/web/views/pets/index'

describe Web::Views::Pets::Index do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Lotus::View::Template.new('apps/web/templates/pets/index.html.erb') }
  let(:view)      { Web::Views::Pets::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it "exposes #foo" do
    expect(view.foo).to eq exposures.fetch(:foo)
  end
end
