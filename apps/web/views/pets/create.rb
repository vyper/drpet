module Web::Views::Pets
  class Create
    include Web::View

    template 'pets/new'

    # TODO DRY
    def logged_user?
      current_user
    end
  end
end
