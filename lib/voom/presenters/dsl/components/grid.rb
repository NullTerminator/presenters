require 'voom/presenters/dsl/components/mixins/common'
require 'voom/presenters/dsl/components/mixins/images'
require 'voom/presenters/dsl/components/mixins/icons'
require 'voom/presenters/dsl/components/mixins/event'
require 'voom/presenters/dsl/components/mixins/attaches'
require 'voom/presenters/dsl/components/mixins/dialogs'
require 'voom/presenters/dsl/components/mixins/chips'
require 'voom/presenters/dsl/components/mixins/snackbars'
require 'voom/presenters/dsl/components/mixins/selects'
require 'voom/presenters/dsl/components/mixins/text_fields'
require 'voom/presenters/dsl/components/mixins/date_time_fields'
require 'voom/presenters/dsl/components/mixins/steppers'
require 'voom/presenters/dsl/components/mixins/sliders'
require 'voom/presenters/dsl/components/mixins/file_inputs'
require 'voom/presenters/dsl/components/mixins/avatar'
require 'voom/presenters/dsl/components/mixins/padding'
require 'voom/presenters/dsl/components/mixins/progress'

module Voom
  module Presenters
    module DSL
      module Components
        class Grid < EventBase
          include Mixins::Attaches
          include Mixins::Dialogs
          include Mixins::Snackbars
          include Mixins::Progress

          attr_reader   :columns,
                        :color,
                        :padding,
                        :wide,
                        :gutter

          def initialize(color: nil, **attribs_, &block)
            super(type: :grid, **attribs_, &block)
            @columns = []
            @color = h(color)
            padding = attribs.delete(:padding) {nil}
            @padding = validate_padding(coerce_padding(padding)).uniq if padding != nil
            @wide = attribs.delete(:wide) {false}
            @gutter = coerce_gutter(attribs.delete(:gutter) {nil})
            expand!
          end

          def column(size, color: nil, **attribs, &block)
            attribs = size.respond_to?(:keys) ? attribs.merge(size) : attribs.merge(size: size)
            @columns << Column.new(parent: self, color: color,
                                   **attribs, &block)
          end

          private

          def coerce_gutter(gutter)
            case gutter
            when true, :full, :all
              true
            when false, :none
              false
            when nil
              nil
            else
              raise Errors::ParameterValidation, "Grid gutter was: #{gutter}. "\
                          'Allowed gutter values are true, false, :full, :all, :none! and nil'
            end
          end

          include Mixins::Padding
          class Column < EventBase
            include Mixins::Common
            include Mixins::Icons
            include Mixins::Attaches
            include Mixins::Dialogs
            include Mixins::Chips
            include Mixins::TextFields
            include Mixins::DateTimeFields
            include Mixins::Selects
            include Mixins::Toggles
            include Mixins::Snackbars
            include Mixins::Steppers
            include Mixins::Sliders
            include Mixins::FileInputs
            include Mixins::Avatar
            include Mixins::Progress

            attr_reader :size,
                        :desktop,
                        :tablet,
                        :phone,
                        :color,
                        :components,
                        :padding,
                        :align,
                        :overflow

            def initialize(**attribs_, &block)
              super(type: :column, **attribs_, &block)
              @size = attribs.delete(:size) || 1
              @desktop = attribs.delete(:desktop)
              @tablet = attribs.delete(:tablet)
              @phone = attribs.delete(:phone)
              @color = attribs.delete(:color)
              @align = validate_alignment(attribs.delete(:align) {:left})
              @overflow = attribs.delete(:overflow){true}
              @components = []
              padding = attribs.delete(:padding) {nil}
              @padding = validate_padding(coerce_padding(padding)).uniq if padding != nil
              expand!
            end

            private

            include Mixins::Padding

            def validate_alignment(align)
              valid_alignment = %i(right left)
              raise "Invalid value for column alignment: #{align}. "\
                      "Valid values are #{valid_alignment.join(' ,')}." unless valid_alignment.include?(align)
              align
            end
          end
        end
      end
    end
  end
end
