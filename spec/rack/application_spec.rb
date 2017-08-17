require 'spec_helper'

describe MusicLibrary::Application do
  let(:application) { MusicLibrary::Application.new }
  subject { application }

  it { is_expected.to respond_to(:call).with(1).argument }

  describe :new do
    it { expect(application.router).to be_instance_of(Router) }
    it { expect(application.environment).to eq 'test' }
  end

  describe :call do
    subject { application.call({}) }

    let(:request)     { double(ActiveRequest) }
    let(:response)    { double(Response) }
    let(:router)      { double(Router) }
    let(:controller)  { double(BaseController) }

    before { allow(ActiveRequest).to receive(:new).and_return(request) }
    before { allow_any_instance_of(Router).to receive(:route_for).and_return(route) }
    before { allow(response).to receive(:to_rack).and_return([]) }

    context 'when route does exist' do
      let(:route)       { double(Route) }

      before { allow(route).to receive(:controller).and_return(BaseController) }
      before { allow(route).to receive(:action).and_return(:index) }
      before { allow(BaseController).to receive(:new).and_return(controller) }
      before { allow(controller).to receive(:send).and_return(response) }

      it 'returns a controller rack response' do
        subject
        expect(controller).to have_received(:send)
        expect(response).to have_received(:to_rack)
      end
    end

    context 'when route does not exist' do
      let(:route)       { nil }

      before { allow(Response).to receive(:not_found).and_return(response) }
      before { allow(request).to receive(:preflight?).and_return(false) }

      it 'returns a not found rack response' do
        subject
        expect(Response).to have_received(:not_found)
        expect(response).to have_received(:to_rack)
      end
    end

    context 'when incoming request is a preflight' do
      let(:route) { nil }

      before { allow(Response).to receive(:preflight).and_return(response) }
      before { allow(request).to receive(:preflight?).and_return(true) }

      it 'returns a not found rack response' do
        subject
        expect(Response).to have_received(:preflight)
        expect(response).to have_received(:to_rack)
      end
    end
  end

end
