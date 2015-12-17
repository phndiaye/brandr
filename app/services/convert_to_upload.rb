class ConvertToUpload
  class << self
    def perform(image)
      return nil unless image
      image = split_base64(image[:data])
      filename = "#{SecureRandom.uuid}.#{image[:extension]}"

      tmp_image = Tempfile.new(filename)
      tmp_image.binmode
      tmp_image.write(Base64.decode64(image[:data]))
      tmp_image.close

      ActionDispatch::Http::UploadedFile.new(
        filename: filename,
        type: image['type'],
        tempfile: tmp_image
      )
    end

    private

    def split_base64(uri_str)
      if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
        {
          type: $1,
          encoder: $2,
          data: $3,
          extension: $1.split('/')[1]
        }
      end
    end
  end
end
