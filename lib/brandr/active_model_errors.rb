module ActiveModel
  class Errors
    def normalize_message(attribute, message, options)
      "#{@base.class.name.downcase}.#{attribute}.errors.#{message}"
    end
  end
end
