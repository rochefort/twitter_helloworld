require 'spec_helper'

describe "/messages/index" do
  before(:each) do
    render 'messages/index'
  end

  it "should have submit_button" do
    response.should have_tag('input', :type => 'submit', :value => '偉大なるHelloWorldをツイートする')
  end
end
