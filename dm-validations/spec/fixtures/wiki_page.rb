module DataMapper
  module Validate
    module Fixtures
      class WikiPage
        include DataMapper::Resource
        property :id, Serial
        has n, :citations
      end
      class Citation
        include DataMapper::Resource
        property :id, Serial
        belongs_to :wiki_page
      end
    end
  end
end
