require 'spec_helper'

describe Route do
  let(:route) { Route.new('/path', { to: 'albums#index' }) }
  subject { route }

  it { is_expected.to respond_to(:path) }
  it { is_expected.to respond_to(:options) }

  describe :controller do
    subject { route.controller }

    it { is_expected.to eq(AlbumsController) }
  end
end
