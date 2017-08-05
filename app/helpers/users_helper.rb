module UsersHelper
  private

    def user_required_params
      params.require(:user).permit(:email, :password)
    end

    def user_optional_params
      params.require(:user).permit(:first_name, :last_name, :student_id)
    end
end
