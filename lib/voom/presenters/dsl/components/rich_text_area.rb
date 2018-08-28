require_relative 'text_field'

module Voom
  module Presenters
    module DSL
      module Components
        class RichTextArea < TextField
          attr_reader :placeholder

          def initialize(**attribs_, &block)
            super(type: :rich_text_area, **attribs_, &block)
            @rows = attribs.delete(:rows) || default(:rows)
            @placeholder = attribs.delete(:placeholder)
            expand!
          end

          def height
            return @height if locked?
            @height = "#{@rows * 12}px"
          end

        end
      end
    end
  end
end