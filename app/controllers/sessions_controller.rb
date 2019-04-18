class SessionsController < Devise::OmniauthCallbacksController
  def twitter
    auth = request.env["omniauth.auth"]

    @user = User.from_omniauth(auth.except("extra"))
    @current_name = auth[:info][:name]
    @current_image = auth[:info][:image]

    # ユーザーが保存済みならばそのユーザーでログイン
    if @user.persisted?
      sign_in_and_redirect @user
      # 名前とアイコンをTwitterのものと同期させる
      @user.update_attributes(name: @current_name, image: @current_image)

    # ユーザーが保存出来ていなければルートにリダイレクト
    else
      redirect_to root_url
    end
  end

  # 認証失敗時にルートへリダイレクトする
  def after_omniauth_failure_path_for(scope)
    root_path
  end
end
