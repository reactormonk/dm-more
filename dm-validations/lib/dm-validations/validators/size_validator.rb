# -*- coding: utf-8 -*-
module DataMapper
  module Validate
    class SizeValidator < GenericValidator
      def call(target)
        value = target.validation_property_value(field_name)
        return true if valid?(value)

        # Stolen from within_validator
        size = @options[:size]
        msg = @options[:message]
        error_message = msg ||
          if size.is_a?(Range)
            if size.last == n
              ValidationErrors.default_error_message(:greater_than_or_equal_to, field_name, size)
            elsif size.first == 0
              ValidationErrors.default_error_message(:less_than_or_equal_to, field_name, size.last)
            else
              ValidationErrors.default_error_message(:value_between, field_name, size.first, size.last)
            end
          else
            ValidationErrors.default_error_message(:equal_to, field_name, size)
          end

        add_error(target, error_message, field_name)
        false
      end

      private
      def valid?(value)
        return true if optional?(value)
        @options[:size] === value.size
      end

      def n
        1/0.0
      end
    end

    module ValidatesSize
      ##
      # Validates that the size of the specified association (or attribute)
      # is within the range.
      #
      # @example [Usage]
      #
      #   class WikiPage
      #     include DataMapper::Resource
      #
      #     # proposed API
      #     has (5..n), :citations
      #
      #     # current API
      #     has n, :citations
      #     validates_size :citations, :size => (5..n)
      #
      #   end
      #
      def validates_size(*fields)
        opts = opts_from_validator_args(fields)
        add_validator_to_context(opts, fields, DataMapper::Validate::SizeValidator)
      end
    end
  end
end
