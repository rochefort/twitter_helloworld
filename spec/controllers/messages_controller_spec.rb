require 'spec_helper'

describe MessagesController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    context "tweetに成功した場合" do
      before  do
        controller.stub_chain(:current_user, :twitter, :post).with('/statuses/update.json', :status => "偉大なるHelloWorld").and_return(true)
        post 'create'
      end
      it { flash[:success].should eql "おめでとう！偉大なるHelloWorldは成功した。" }
      it { response.should redirect_to root_path }
    end

    context "tweetに失敗した場合" do
      before  do
        controller.stub_chain(:current_user, :twitter, :post).with('/statuses/update.json', :status => "偉大なるHelloWorld").and_return(false)
        post 'create'
      end
      it { flash[:error].should eql "残念だが、偉大なるHelloWorldは失敗に終わった。" }
      it { response.should render_template('index') }
      it { response.should be_success }
    end
  end

end
