module Web::Views::Pets
  class Index
    include Web::View

    def logged_user?
      !session[:logged_user_id].nil?
    end
  end
end
