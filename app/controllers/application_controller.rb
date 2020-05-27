class ApplicationController < ActionController::Base

  before_action :authenticate_user!, except: [:home, :about]
  #before_actionメソッドはこのコントローラが動作する前に実行される
  #authenticate_userメソッドは、devise側が用意しているメソッドで:authenticate_user!とすることによって
  #「ログイン認証されていなければ、ログイン画面へリダイレクトする」機能を実装できます。

  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
  	 #ユーザ登録(sign_up)の際にデータ操作を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:name])


    # ログイン登録（sign_in）の際に、データ操作を許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :profile_image])
  end

   # ログイン後にマイページに遷移する
  def after_sign_in_path_for(resource)
  		user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

end
