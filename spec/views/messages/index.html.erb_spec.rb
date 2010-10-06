require 'spec_helper'

describe "/messages/index" do
  context "ログインしている場合" do  
    before do
      template.stub(:logged_in?).and_return(true)
      render 'messages/index'
    end

    it "「偉大なるHelloWorldをツイートする」ボタンを表示すること" do
      response.should have_tag('input', :type => 'submit', :value => '偉大なるHelloWorldをツイートする')
    end
  end

  context "ログインしていない場合" do
    before do
      template.stub(:logged_in?).and_return(false)
      render 'messages/index'
    end

    it "ログインリンクを表示すること" do
      response.should have_tag('a', :href => '/login')
    end
  end
end
