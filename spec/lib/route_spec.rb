require 'spec_helper'

describe Route do
  let(:route) { Route.new('/path', { to: 'albums#index' }) }
  subject { route }

  it { is_expected.to respond_to(:path) }
  it { is_expected.to respond_to(:options) }

  describe :controller do
    subject { route.controller }

    context 'when controller exists' do
      it { is_expected.to eq(AlbumsController) }
    end

    context 'when controller doesn\'t exists' do
      let(:route) { Route.new('/path', { to: 'unknown#index' }) }
      it { expect { subject }.to raise_error(LoadError) }
    end
  end

  describe :action do
    subject { route.action }

    it { is_expected.to eq :index }
  end
end
