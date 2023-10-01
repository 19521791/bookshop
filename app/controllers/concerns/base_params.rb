module BaseParams
  extend ActiveSupport::Concern

  def user_params
    params.permit(
      :firstname,
      :lastname,
      :email,
      :password,
      :role,
      :mobile
    )
  end

  def auth_params
    params.permit(
      :email,
      :password
    )
  end

  def book_params
    params.permit(
      :title,
      :author,
      :description,
      :thumbnail,
      :rating,
      :price,
      :stock,
      book_categories_attributes: [:id, :category_id, :_allow_destroy]
    )
  end  
end