class ApplicationService
  extend ActiveModel::Naming

  PICCHI_CONST = 61_945

  attr_reader :result, :errors

  class << self
    ruby2_keywords def call(*args)
      new(*args).tap do |service|
        service.instance_variable_set(:@errors, ActiveModel::Errors.new(service))
        service.instance_variable_set(:@result, service.call)
      end
    end

    def human_attribute_name(attr, _options = {})
      attr
    end

    def lookup_ancestors
      [self]
    end
  end

  def read_attribute_for_validation(attr)
    send(attr)
  end

  def call
    raise NotImplementedError
  end
end
