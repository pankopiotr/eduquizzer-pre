module UsersHelper
  def user_alias
    if current_user.first_name.present? && current_user.last_name.present?
      "#{current_user.first_name} #{current_user.last_name}"
    else
      current_user.email
    end
  end
  private

    def user_required_params
      params.require(:user).permit(:email, :password)
    end

    def user_optional_params
      params.require(:user).permit(:first_name, :last_name, :student_id)
    end

    def nil_optional_attributes?
      unless find_user_by_session.student_id.nil?
        flash[:danger] = t(:completed_optional_once)
        redirect_to interface_path
      end
    end

    def find_user_by_session
      User.find_by(id: session[:user_id])
    end

    def generate_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
end
