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
       post_tweet_stub.and_return(true)
        post 'create'
      end
      it { flash[:success].should eql "おめでとう！偉大なるHelloWorldは成功した。" }
      it { response.should redirect_to root_path }
    end

    context "tweetに失敗した場合" do
      before  do
        post_tweet_stub.and_return(false)
        post 'create'
      end
      it { flash[:error].should eql "残念だが、偉大なるHelloWorldは失敗に終わった。" }
      it { response.should render_template('index') }
      it { response.should be_success }
    end
    
    context "tweet時にduplicateエラーによる例外が発生した場合" do
      before do
        post_tweet_stub.once.and_raise(TwitterAuth::Dispatcher::Error)
        post 'create'
      end
      it { flash[:error].should eql "連投エラーです。" }
      it { response.should render_template('index') }
      it { response.code.should == '500' }
    end

    context "tweet時に予期せぬエラーによる例外が発生した場合" do
      before do
        post_tweet_stub.once.and_raise(Exception)
        post 'create'
      end
      it { flash[:error].should eql "予期せぬエラーが発生しました。" }
      it { should render_template('index') }
      it { response.code.should == '500' }
    end
  end
  
  def post_tweet_stub
    controller.stub_chain(:current_user, :twitter, :post).with('/statuses/update.json', :status => "偉大なるHelloWorld")
  end

end
