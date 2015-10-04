module Web::Views::Pets
  class Edit
    include Web::View

    # TODO Duplicated... );
    UrlAws = "https://s3-sa-east-1.amazonaws.com/#{ENV['AWS_BUCKET']}/store/pets/".freeze

    # TODO I don't like this ):
    def pet_image_tag
      return '' if pet.image_id.to_s.empty?

      html.div class: 'pet' do
        h2 'Actual image'
        img src: "#{UrlAws}#{pet.image_id}"
      end
    end
  end
end
