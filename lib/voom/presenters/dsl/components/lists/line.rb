

module Voom 
module Presenters 
module DSL 
module Components 
class Line < Base 
include Mixins::Event
          attr_accessor :separator, :actions

          def initialize(context:, **attribs_, &block)
            super(type: :line, context: context, **attribs_, &block)
            @separator = attribs.delete(:separator)
            @actions = []
            expand!
          end
          
          def text(text = nil, **attribs, &block)
            return @text if locked?
            @text = Components::Typography.new(parent: self, type: :text, text: text, context: context, **attribs, &block)
          end

          def subtitle(subtitle = nil, **attribs, &block)
            return @subtitle if locked?
            @subtitle = Components::Typography.new(parent: self, type: :subtitle, text: subtitle, context: context, **attribs, &block)
          end

          def info(info=nil, **attribs, &block)
            return @info if locked?
            @info = Components::Typography.new(parent: self, type: :info, text: info, context: context, **attribs, &block)
          end

          def body(body = nil, **attribs, &block)
            return @body if locked?
            @body = Components::Typography.new(parent: self, type: :body, text: body, context: context, **attribs, &block)
          end

          def avatar(avatar = nil, **attribs, &block)
            return @avatar if locked?
            @avatar = Avatar.new(parent: self, avatar: avatar,
                                 context: context,
                                 **attribs, &block)
          end

          def icon(icon=nil, **attribs, &block)
            return @icon if locked?
            @icon = Icon.new(parent: self, icon: icon,
                             context: context,
                             **attribs, &block)
          end


          def action(**attribs, &block)
            @actions << ListAction.new(parent: self,
                                       **attribs, &block)
          end
end
end
end
end
end