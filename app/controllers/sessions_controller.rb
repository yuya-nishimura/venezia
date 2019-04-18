class SessionsController < Devise::OmniauthCallbacksController
  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"].except("extra"))

    # ユーザーが保存済みならばそのユーザーでログイン
    if @user.persisted?
      sign_in_and_redirect @user

    # 新規ユーザーならセッションに値を保存してルートにリダイレクト
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to root_url
    end
  end
end
