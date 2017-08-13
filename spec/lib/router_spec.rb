require 'spec_helper'

describe Router do
  let(:router) { Router.new }
  subject { router }

  describe '.route_for' do
    subject { router.route_for(request) }
    let(:request) { double(ActiveRequest) }
    let(:path)    { '/an/example/path' }
    let(:method)  { :get }

    before { allow(request).to receive(:method).and_return(method) }
    before { allow(request).to receive(:path).and_return(path) }

    context 'when there is no url for request\'s method' do
      before do
        allow(router).to receive(:routes).
          and_return( { get: [], post: [], delete: [] })
      end

      it { is_expected.to be_nil }
    end

    context 'when there url doesn\'t match with existent url for request\'s method' do
      before do
        allow(router).to receive(:routes).
          and_return( { get: [], post: [], delete: [] })

        router.routes[:post] << [path, { to: 'album#index' }]
      end

      it { is_expected.to be_nil }
    end

    context 'when request\'s method match with url' do
      before do
        allow(router).to receive(:routes).
          and_return( { method => [[path, { to: 'album#index' }]] })
      end

      it { is_expected.to be_instance_of(Route) }
      it { expect(subject.path).to eq path }
    end
  end

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
