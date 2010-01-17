class MiracleScaffoldGenerator < Rails::Generator::Base
  
  attr_accessor :name, :attributes
  
  def initialize(runtime_args, runtime_options = {})
    super
    usage if @args.empty?
    
    @name = @args.first
    
    @attributes = []    
    @args[1..-1].each do |arg|
      @attributes << Rails::Generator::GeneratedAttribute.new(*arg.split(":"))
    end
    @attributes.uniq!
    
    options[:skip_model] = true if @attributes.empty?
  end
  
  def manifest
    record do |m|
      # Model
      unless options[:skip_model]
        m.directory "app/models"
        m.template "model.rb", "app/models/#{singular_name}.rb"
        m.migration_template "migration.rb", "db/migrate", :migration_file_name => "create_#{plural_name}"
        unless options[:skip_tests]
          m.directory "test/unit" 
          m.template "test/model.rb", "test/unit/#{singular_name}_test.rb"
        end
      end
 
      # Controller
      m.directory "app/controllers"
      m.template "controller.rb", "app/controllers/#{plural_name}_controller.rb"
      unless options[:skip_tests]
        m.directory "test/functional" 
        m.template "test/controller.rb", "test/functional/#{plural_name}_controller_test.rb"
      end
      
      # Helper
      m.directory "app/helpers"
      m.template "helper.rb", "app/helpers/#{plural_name}_helper.rb"
      
      # Views
      m.directory "app/views/#{plural_name}"
      m.template "views/index.html.erb", "app/views/#{plural_name}/index.html.erb"
      m.template "views/show.html.erb", "app/views/#{plural_name}/show.html.erb"
      m.template "views/new.html.erb", "app/views/#{plural_name}/new.html.erb"
      m.template "views/edit.html.erb", "app/views/#{plural_name}/edit.html.erb"
      m.template "views/_form.html.erb", "app/views/#{plural_name}/_form.html.erb"
      
      # Route
      m.route_resources plural_name
      
      # Copy migrate to clipboard
      system "echo 'rake db:migrate && rake db:test:prepare' | pbcopy"
    end
  end
  
  def singular_name
    name.underscore
  end
  
  def plural_name
    name.underscore.pluralize
  end
  
  def class_name
    name.camelize
  end
  
  def plural_class_name
    plural_name.camelize
  end
 
end