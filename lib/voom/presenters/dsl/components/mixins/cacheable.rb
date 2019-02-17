module Voom
  module Presenters
    module DSL
      module Components
        module Mixins
          module Cacheable
            attr_reader :cache_key

            def cache(key_or_collection)
              @cache_key = build_cache_key(key_or_collection)
            end

            private

            def build_cache_key(key)
              if key.respond_to?(:map)
                key.map { |k| build_cache_key(k) }.join('-')
              elsif key.respond_to?(:cache_key)
                key.cache_key
              else
                key.to_s
              end
            end
          end
        end
      end
    end
  end
end
