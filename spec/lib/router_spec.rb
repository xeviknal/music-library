require 'spec_helper'

describe Router do
  let(:router) { Router.new }
  subject { router }

  describe '.get' do
    subject { router.get(path, options) }
    let(:path)    { '/albums/:id' }
    let(:options) { { to: 'albums#show' } }

    context 'when path not present' do
      let(:path) { nil }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when both path and options are present' do
      it 'register new get route' do
        expect(router.routes).to be_empty
        subject
        expect(router.routes[:get].first).to eq [path, options]
      end
    end
  end
end
