module Web::Views::Pets
  class Index
    include Web::View

    # TODO DRY
    def logged_user?
      current_user
    end
  end
end
