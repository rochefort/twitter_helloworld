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

  describe "GET 'list'" do
    context "偉大なるHelloWorldを検索し、検索結果が0件でない場合" do
      before do
        get_search_stub.and_return(dummy_search)
        get 'list'
      end
      it { response.should be_success }
      it { response.should render_template('list') }
      it { assigns[:statuses].should_not be_empty }
    end
  end
  
  private
  def post_tweet_stub
    controller.stub_chain(:current_user, :twitter, :post).with('/statuses/update.json', :status => "偉大なるHelloWorld")
  end

  def get_search_stub
    controller.stub_chain(:current_user, :twitter, :get).with("http://search.twitter.com/search.json?q=#{CGI.escape '偉大なるHelloWorld'}")
  end

end
