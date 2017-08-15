require 'spec_helper'
require 'ostruct'

describe BaseController do
  subject { controller }
  let(:controller)  { BaseController.new(request) }
  let(:request)     { ActiveRequest.new({}) }

  it { is_expected.to respond_to(:request) }
  it { is_expected.to respond_to(:params) }

  describe :render do
    subject { controller.send(:render, object, options) }

    context 'when object to render is nil' do
      let(:object) { nil }
      let(:options) { { serializer: TestSerializer } }

      it { is_expected.to be_nil }
    end

    context 'when no serializer is provided' do
      let(:object) { [1,2,3] }
      let(:options) { { } }

      it 'return the json representation of the input object' do
        is_expected.to eq '[1,2,3]'
      end
    end

    context 'when options[:serializer] is a SerializerClass' do
      let(:serializer)  { double(TestSerializer) }
      let(:object)      { OpenStruct.new(name: 'Elliot', last_name: 'Alderson') }
      let(:options)     { { serializer: TestSerializer } }

      before { allow(TestSerializer).to receive(:new).and_return(serializer) }
      before { allow(serializer).to receive(:to_json) }

      it 'returns the json representation of serializer class' do
        subject

        expect(TestSerializer).to have_received(:new)
        expect(serializer).to have_received(:to_json)
      end
    end

    context 'when options[:each_serializer] is a serializer class' do
      let(:serializer)  { double(TestSerializer) }
      let(:options)     { { each_serializer: TestSerializer } }
      let(:object) do
        5.times.map { OpenStruct.new(name: 'Elliot', last_name: 'Alderson') }
      end

      before { allow(TestSerializer).to receive(:new).and_return(serializer) }
      before { allow(serializer).to receive(:to_json) }

      it 'returns the json representation of SerializerClass' do
        subject

        expect(TestSerializer).to have_received(:new).exactly(5).times
        expect(serializer).to have_received(:to_json).exactly(5).times
      end
    end
  end
end
