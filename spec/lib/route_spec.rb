require 'spec_helper'

describe Route do
  let(:route) { Route.new('/path', { to: 'album#index' }) }
  subject { route }

  it { is_expected.to respond_to(:path) }
  it { is_expected.to respond_to(:options) }
end
