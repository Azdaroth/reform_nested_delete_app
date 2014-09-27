class Article::PersistenceForm < Reform::Form

  include Reform::NestedFormParent

  # bleh, nested_form gem made me do it
  def self.reflect_on_association(assoc)
    Article.reflect_on_association(assoc)
  end

  deletable_collection :authors

  model :article

  property :name

  collection :authors, populate_if_empty: lambda { |fragment, args| 
    model.authors.build
  }, form: Article::Author::PersistenceForm

  validates :name, presence: true

end