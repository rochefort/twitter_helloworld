class MessagesController < ApplicationController
  def index
  end

  def create
    begin
      res = current_user.twitter.post('/statuses/update.json', :status => "偉大なるHelloWorld")
    rescue TwitterAuth::Dispatcher::Error => e
      flash[:error] = "連投エラーです。"
      return render(:action  => 'index', :status  => '500')
    rescue Exception => e
      flash[:error] = "予期せぬエラーが発生しました。"
      return render(:action  => 'index', :status  => '500')
    end
  
    if res
      flash[:success] = "おめでとう！偉大なるHelloWorldは成功した。"
      redirect_to root_path
    else
      flash[:error] = "残念だが、偉大なるHelloWorldは失敗に終わった。"
      render :action  => 'index'
    end
  end
end
