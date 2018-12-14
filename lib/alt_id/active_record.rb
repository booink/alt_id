module AltId
  module ActiveRecord
    extend ActiveSupport::Concern

    module Finder
      def find(*args)
        puts "args: #{args.inspect}"
        ids = []
        args.flatten.each do |arg|
          begin
            ids << AltId.deobfuscate(arg, Rails.application.credentials.secret_key_base, table_name: table_name, application_name: Rails.application.class.parent_name)
          rescue ArgumentError
            ids << arg
          end
        end
        puts "ids: #{ids.inspect}"
        super(ids)
      end
    end

    module ClassMethods
      include Finder

      def alternate_id(as_param: true)
        if as_param
          define_method :to_param do
            alt_id
          end
        end

        define_method :alt_id do
          return if id.nil?
          AltId.obfuscate(id, Rails.application.credentials.secret_key_base, table_name: self.class.table_name, application_name: Rails.application.class.parent_name)
        end
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.send(:include, AltId::ActiveRecord)
  ActiveRecord::Relation.send(:prepend, AltId::ActiveRecord::Finder)
end