module Autotable
  module Rails
    class Engine < ::Rails::Engine
      initializer "autotable.helpers" do
        ActionView::Base.send :include, Autotable::Helper
      end
    end
  end
end