require 'spec_helper'

describe 'DataMapper::Validate::Fixtures::WikiPage' do
  describe "with (3..n)" do
    before :all do
      @wiki_class = Class.new(DataMapper::Validate::Fixtures::WikiPage)
      @citation_class = DataMapper::Validate::Fixtures::Citation
      @wiki_class.class_eval { validates_size :citations, :size => (3..n) }
    end

    describe "with 3 citations" do
      before :all do
        @wiki_class.auto_migrate!
        @model = @wiki_class.new
        3.times {@model.citations << @citation_class.new}
      end
      it_should_behave_like "valid model"
    end
    describe "with 2 citations" do
      before :all do
        # Don't ask, rspec sucks.
        @wiki_class.auto_migrate!
        @model = @wiki_class.new
        2.times {@model.citations << @citation_class.new}
      end
      it_should_behave_like "invalid model"
    end
  end
  describe "with (0..4)" do
    before :all do
      @wiki_class = Class.new(DataMapper::Validate::Fixtures::WikiPage)
      @citation_class = DataMapper::Validate::Fixtures::Citation
      @wiki_class.class_eval { validates_size :citations, :size => (0..4) }
    end

    describe "without citations" do
      before :all do
        @wiki_class.auto_migrate!
        @model = @wiki_class.new
      end
      it_should_behave_like "valid model"
    end
    describe "with 5 citations" do
      before :all do
        # Don't ask, rspec sucks.
        @wiki_class.auto_migrate!
        @model = @wiki_class.new
        5.times {@model.citations << @citation_class.new}
      end
      it_should_behave_like "invalid model"
    end
  end
  describe "with 2" do
    before :all do
      @wiki_class = Class.new(DataMapper::Validate::Fixtures::WikiPage)
      @citation_class = DataMapper::Validate::Fixtures::Citation
      @wiki_class.class_eval { validates_size :citations, :size => 2 }
    end

    describe "with 2 citations" do
      before :all do
        @wiki_class.auto_migrate!
        @model = @wiki_class.new
        2.times {@model.citations << @citation_class.new}
      end
      it_should_behave_like "valid model"
    end
    describe "with 3 citations" do
      before :all do
        # Don't ask, rspec sucks.
        @wiki_class.auto_migrate!
        @model = @wiki_class.new
        3.times {@model.citations << @citation_class.new}
      end
      it_should_behave_like "invalid model"
    end
    describe "without citations" do
      before :all do
        # Don't ask, rspec sucks.
        @wiki_class.auto_migrate!
        @model = @wiki_class.new
      end
      it_should_behave_like "invalid model"
    end
  end
end
