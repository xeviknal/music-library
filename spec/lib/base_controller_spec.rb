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
    let(:options) { {} }

    context 'when status is present in options' do
      let(:object)  { ['Name has already been taken'] }
      let(:options) { { status: 500 } }

      it { expect(subject.status_code).to eq 500 }
      it { expect(subject.body).to eq object.to_json }
    end

    context 'when object to render is nil' do
      let(:object) { nil }

      it { expect(subject.status_code).to eq Response.empty.status_code }
      it { expect(subject.body).to eq Response.empty.body }
      it { expect(subject.header).to eq Response.empty.header }
    end

    context 'when object to render is an array' do
      let(:object) { [1,2,3] }

      it 'returns a response object' do
        is_expected.to be_instance_of(Response)
      end

      it 'returns a response object with status code to 200' do
        expect(subject.status_code).to eq 200
      end

      it 'returns a response object with header with JSON MIME content-type' do
        expect(subject.header).to eq({ 'Content-Type' => 'application/json' })
      end

      it 'returns a response object with the json representation of the input object' do
        expect(subject.body).to eq '[1,2,3]'
      end
    end

    context 'when object to render is a hash' do
      let(:object) { { title: 'title', artist: 'artist' } }

      it 'returns a response object' do
        is_expected.to be_instance_of(Response)
      end

      it 'returns a response object with status code to 200' do
        expect(subject.status_code).to eq 200
      end

      it 'returns a response object with header with JSON MIME content-type' do
        expect(subject.header).to eq({ 'Content-Type' => 'application/json' })
      end

      it 'returns a response object with the json representation of the input object' do
        expect(subject.body).to eq '{"title":"title","artist":"artist"}'
      end
    end

    context 'when object to render a single object' do
      let(:object)      { OpenStruct.new(name: 'Elliot', last_name: 'Alderson') }

      it 'returns a response object' do
        is_expected.to be_instance_of(Response)
      end

      it 'returns a response object with status code to 200' do
        expect(subject.status_code).to eq 200
      end

      it 'returns a response object with header with JSON MIME content-type' do
        expect(subject.header).to eq({ 'Content-Type' => 'application/json' })
      end

      it 'returns a response object with the json' do
        expect(subject.body).to eq '{"table":{"name":"Elliot","last_name":"Alderson"}}'
      end
    end

    context 'when object to render is a enumerable' do
      let(:object) do
        5.times.map { OpenStruct.new(name: 'Elliot', last_name: 'Alderson') }
      end

      it 'returns a response object' do
        is_expected.to be_instance_of(Response)
      end

      it 'returns a response object with status code to 200' do
        expect(subject.status_code).to eq 200
      end

      it 'returns a response object with header with JSON MIME content-type' do
        expect(subject.header).to eq({ 'Content-Type' => 'application/json' })
      end

      it 'returns a response object with the json' do
        object_json = (['{"table":{"name":"Elliot","last_name":"Alderson"}}'] * 5).join ','
        expect(subject.body).to eq "[#{object_json}]"
      end
    end
  end

  describe '.render_success' do
    subject { controller.send(:render_success) }

    before { allow(Response).to receive(:success) }

    it 'returns a response' do
      subject
      expect(Response).to have_received(:success)
    end
  end

  describe '.render_failure' do
    subject { controller.send(:render_failure) }

    before { allow(Response).to receive(:failure) }

    it 'returns a response' do
      subject
      expect(Response).to have_received(:failure)
    end
  end
end
