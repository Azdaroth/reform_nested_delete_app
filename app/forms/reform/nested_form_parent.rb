module Reform::NestedFormParent

  extend ActiveSupport::Concern

  NestedCollectionOptionsAggregate = Struct.new(:name)

  included do

    def self.deletable_collections
      @deletable_collections ||= []
    end

    def self.deletable_collection(name, options={})
      deletable_collections << NestedCollectionOptionsAggregate.new(name)
    end

  end

  def update!(params)
    super
    self.class.deletable_collections.each do |deletable_collection|
      filtered_collection = send(deletable_collection.name).reject do |element|
        element.marked_for_destruction? && element.not_persisted?
      end
      self.send("#{deletable_collection.name}=", filtered_collection) 
    end
  end

  def save!
    super
    # damn ugly, requires eliminating respond_to? calls and should be recursive
    if self.class.respond_to?(:deletable_collections)
      self.class.deletable_collections.each do |deletable_collection|
        send(deletable_collection.name).reject(&:marked_for_destruction?)
        .select { |el| el.class.respond_to?(:deletable_collections) }.each do |element|
          element.class.deletable_collections.each do |childs_deletable_collection|
            element.send(childs_deletable_collection.name).select(&:marked_for_destruction?).each(&:destroy)
          end
        end
        send(deletable_collection.name).select(&:marked_for_destruction?).each(&:destroy)
      end
    end
  end

end
