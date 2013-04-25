ActiveAdmin.register Feed do
	before_filter do
    Feed.class_eval do
      def to_param
        id.to_s
      end
    end
  end
end
