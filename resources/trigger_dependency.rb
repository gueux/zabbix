actions :create
default_action :create

attribute :trigger_name, :kind_of => String, :name_attribute => true
attribute :dependency_name, :kind_of => String, :required => true
