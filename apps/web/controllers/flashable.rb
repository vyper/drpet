module Web::Controllers
  module Flashable
    def self.included(action)
      action.class_eval do
        expose :flash
      end
    end
  end
end
