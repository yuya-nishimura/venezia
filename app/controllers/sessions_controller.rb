class SessionsController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"].except("extra"))

    # ユーザーが保存済みならばそのユーザーでログイン
    if @user.persisted?
      sign_in_and_redirect @user

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
