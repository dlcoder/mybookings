module Pundit
  def self.included base
    super

    base.class_eval do
      alias_method :original_authorize, :authorize

      def authorize record, query='manage?'
        original_authorize(record, query)
      end
    end
  end
end
