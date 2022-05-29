ThinkingSphinx::Index.define :product, :with => :active_record do
  indexes :name, :sortable => true
end
