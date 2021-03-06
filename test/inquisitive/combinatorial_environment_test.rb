require 'test_helper'

class InquisitiveCombinatorialEnvironmentTest < EnvironmentTest

  def setup
    super
    ENV['NIL_OBJECT'] = @raw_nil_object
    ENV['STRING'] = @raw_string
    ENV['ARRAY'] = @raw_array.join(',')
    ENV['HASH__NOTHING'] = @raw_hash[:nothing]
    ENV['HASH__AUTHENTICATION'] = @raw_hash[:authentication].to_s
    ENV['HASH__IN'] = @raw_hash[:in]
    ENV['HASH__DATABASES'] = @raw_hash[:databases].join(',')
    ENV['HASH__NESTED__KEY'] = @raw_hash[:nested][:key]
    ENV['HASH__NESTED__ARRAY'] = @raw_hash[:nested][:array].join(',')
  end
  def teardown
    super
    ENV.delete 'NIL_OBJECT'
    ENV.delete 'STRING'
    ENV.delete 'ARRAY'
    ENV.delete 'HASH__NOTHING'
    ENV.delete 'HASH__AUTHENTICATION'
    ENV.delete 'HASH__IN'
    ENV.delete 'HASH__DATABASES'
    ENV.delete 'HASH__NESTED__KEY'
    ENV.delete 'HASH__NESTED__ARRAY'
    ENV.delete 'HASH__SOMETHING_NEW'
  end

  def change_nil_object_variable
    ENV['NIL_OBJECT'] = 'something_new'
  end
  def change_string_variable
    ENV['STRING'] = 'something_new'
  end
  def change_array_variable
    ENV['ARRAY'] = [ ENV['ARRAY'], 'something_new' ].join ','
  end
  def change_hash_variable
    ENV['HASH__SOMETHING_NEW'] = 'true'
  end

end

%w[nil_object string array hash].each do |type|

  Inquisitive.const_set(
    :"Inquisitive#{type.split('_').map(&:capitalize).join}EnvironmentTest",
    Class.new(InquisitiveCombinatorialEnvironmentTest) do

      class << self
        attr_accessor :type
      end

      def setup
        super
        @type = Inquisitive[self.class.type]
        App.inquires_about @type.upcase
      end

      def nil_object
        App.nil_object
      end
      def string
        App.string
      end
      def array
        App.array
      end
      def hash
        App.hash
      end

      include CombinatorialEnvironmentTests

    end
  ).tap do |klass|
    klass.type = type
  end.send :include, Object.const_get(:"#{type.split('_').map(&:capitalize).join}Tests")

end
