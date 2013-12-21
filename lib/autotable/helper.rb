module Autotable
  module Helper
    def autotable(collection, options = {})
      builder = ::Autotable::Builder.new(collection, self, options)
      yield builder if block_given?
      builder.to_html
    end
  end
end