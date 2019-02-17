require 'spec_helper'

describe 'dsl' do
  describe 'cache' do
    before do
      load_presenters('presenters', spec_dir)
    end

    after do
      reset_presenters!
    end

    it 'is capable of caching' do
      pom = Voom::Presenters::App[:simple_cache_key].call.expand(router: nil)
      expect(pom.cache_key).to eq 'remember_me'
    end

    it 'can cache child component with complex cache keys' do
      pom = Voom::Presenters::App[:complex_child_cache_key].call.expand(router: nil)
      expect(pom.components.first.cache_key).to eq 'table-wild-abc-123'
    end
  end
end
