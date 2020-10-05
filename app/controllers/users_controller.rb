class UsersController < ApplicationController
  def edit
  end

  def update
    if current_user.update(user_params)
      # current_userメソッドはユーザー情報が格納されている
      redirect_to root_path
      # アップデートに成功したらトップページにリダイレクト
    else
      render :edit
      # 失敗したらeditに戻る。（editのビューが表示）
    end
  end

  private 
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
end