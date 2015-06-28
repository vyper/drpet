module Web::Controllers::UserSessions
  class New
    include Web::Action

    expose :flash

    def call(params)
    end

    private

    # TODO: Improve this!
    def authenticate!
    end
  end
end
