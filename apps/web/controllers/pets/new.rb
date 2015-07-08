module Web::Controllers::Pets
  class New
    include Web::Action

    before :authenticate!

    expose :pet

    def call(params)
      @pet = Pet.new
    end
  end
end
