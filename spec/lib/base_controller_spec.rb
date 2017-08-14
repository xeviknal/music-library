require 'spec_helper'

describe BaseController do
  subject { controller }
  let(:controller)  { BaseController.new(request) }
  let(:request)     { ActiveRequest.new({}) }

  it { is_expected.to respond_to(:request) }
  it { is_expected.to respond_to(:params) }
end
