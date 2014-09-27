class Author::PersistenceForm < Reform::Form

  include Reform::NestedFormParent
  include Reform::Deletable

  # bleh, nested_form gem made me do it
  def self.reflect_on_association(assoc)
    Author.reflect_on_association(assoc)
  end

  deletable_collection :emails

  property :name

  collection :emails, populate_if_empty: lambda { |fragment, args| 
    model.emails.build
  }, form: Email::PersistenceForm

  validates :name, presence: true

end