require 'spec_helper'

describe "/messages/list" do
  before do
    assigns[:statuses] = dummy_search
    render 'messages/list'
  end

  it "「偉大なるHelloWorld」のつぶやき一覧を表示すること" do
    response.should have_tag('#tweet1', /username1/)
    response.should have_tag('#tweet2', /username2/)
    response.should have_tag('#tweet3', /username3/)
  end
end
