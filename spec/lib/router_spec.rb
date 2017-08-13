require 'spec_helper'

describe Router do
  let(:router) { Router.new }
  subject { router }

  %w{get post delete}.each do |method|
    describe ".#{method}" do
      subject { router.send(method, path, options) }
      let(:path)    { '/albums/:id' }
      let(:options) { { to: 'albums#show' } }

      context 'when path not present' do
        let(:path) { nil }

        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context 'when both path and options are present' do
        it 'register new get route' do
          subject
          expect(router.routes[method.to_sym].first).to eq [path, options]
        end
      end
    end
  end
end
