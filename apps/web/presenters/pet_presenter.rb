class PetPresenter
  include Lotus::Presenter

  UrlDefault = 'http://placehold.it/80x80'.freeze
  # TODO Duplicated... );
  UrlAws     = "https://s3-sa-east-1.amazonaws.com/#{ENV['AWS_BUCKET']}/store/pets/".freeze

  def image_url
    # TODO Choice better way... d:
    _raw image_id.to_s.empty? ? UrlDefault : "#{UrlAws}#{image_id}"
  end
end
