class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_attributes(auth_object = nil)

    if Ransack::SUPPORTS_ATTRIBUTE_ALIAS
      column_names + _ransackers.keys + _ransack_aliases.keys + attribute_aliases.keys
    else
      column_names + _ransackers.keys + _ransack_aliases.keys
    end.uniq
  end
 
  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map { |a| a.name.to_s }
  end
end
