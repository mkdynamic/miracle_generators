require 'test_helper'

class <%= class_name %>sControllerTest < ActionController::TestCase
  context "routing" do
    # index and create
    should_route :get, "/<%= plural_name %>", :controller => :<%= plural_name %>, :action => :index
    should_route :post, "/<%= plural_name %>", :controller => :<%= plural_name %>, :action => :create    

    # new
    should_route :get, "/<%= plural_name %>/new", :controller => :<%= plural_name %>, :action => :new

    # edit
    should_route :get, "/<%= plural_name %>/1/edit", :controller => :<%= plural_name %>, :action => :edit, :id => 1

    # show, update, and delete
    should_route :get, "/<%= plural_name %>/1", :controller => :<%= plural_name %>, :action => :show, :id => 1
    should_route :put, "/<%= plural_name %>/1", :controller => :<%= plural_name %>, :action => :update, :id => 1
    should_route :delete, "/<%= plural_name %>/1", :controller => :<%= plural_name %>, :action => :destroy, :id => 1
  end
  
  context "listing" do    
    should "be successful" do
      get :index
      assert_response :success
    end
    should "assign <%= plural_name %>" do
      get :index
      assert_not_nil assigns(:<%= plural_name %>)
    end
  end
  
  context "adding" do
    should "be successful" do
      get :new
      assert_response :success
    end
    should "assign <%= singular_name %>" do
      get :new
      assert_not_nil assigns(:<%= singular_name %>)
    end
    should "create new <%= singular_name.titleize.downcase %>" do
      get :new
      assert assigns(:<%= singular_name %>).new_record?
    end
  end
  
  context "creating" do
    should "assign <%= singular_name %>" do
      post :create
      assert_not_nil assigns(:<%= singular_name %>)
    end
    context "when valid" do
      setup do
        stub.instance_of(<%= class_name %>).valid? { true }
      end
      should "set the flash to success" do
        post :create
        assert_match /success/i, flash[:notice]
      end
      should "redirect to <%= plural_name.titleize.downcase %> list" do
        post :create
        assert_redirected_to <%= plural_name %>_path
      end
    end
    context "when invalid" do
      setup do
        stub.instance_of(<%= class_name %>).valid? { false }
      end
      should "render new template" do
        post :create
        assert_template "new"
      end
    end
  end
  
  context "showing" do
    setup do
      stub(<%= class_name %>).find { Factory(:<%= singular_name %>) }
    end
    should "be successful" do      
      get :show, :id => 1
      assert_response :success
    end
    should "assign <%= singular_name %>" do
      get :show, :id => 1
      assert_not_nil assigns(:<%= singular_name %>)
    end
  end
  
  context "editing" do
    setup do
      stub(<%= class_name %>).find { Factory(:<%= singular_name %>) }
    end
    should "be successful" do      
      get :edit, :id => 1
      assert_response :success
    end
    should "assign <%= singular_name %>" do
      get :edit, :id => 1
      assert_not_nil assigns(:<%= singular_name %>)
    end    
  end
  
  context "updating" do
    setup do
      @<%= singular_name %> = Factory(:<%= singular_name %>)
      stub(<%= class_name %>).find { @<%= singular_name %> }
    end
    should "assign <%= singular_name %>" do
      put :update, :id => 1
      assert_not_nil assigns(:<%= singular_name %>)
    end
    should "update <%= singular_name.titleize.downcase %>" do
      mock.proxy(@<%= singular_name %>).update_attributes(anything)
      put :update, :id => 1
    end
    context "when valid" do
      setup do
        stub(@<%= singular_name %>).valid? { true }
      end
      should "set the flash to success" do
        put :update, :id => 1
        assert_match /success/i, flash[:notice]
      end
      should "redirect to <%= plural_name.titleize.downcase %> list" do
        put :update, :id => 1
        assert_redirected_to <%= plural_name %>_path
      end
    end
    context "when invalid" do
      setup do
        stub(@<%= singular_name %>).valid? { false }
      end
      should "render new template" do
        put :update, :id => 1
        assert_template "edit"
      end
    end
  end
  
  context "deleting" do
    setup do
      @<%= singular_name %> = Factory(:<%= singular_name %>)
      stub(<%= class_name %>).find { @<%= singular_name %> }
    end
    should "destroy <%= singular_name.titleize.downcase %>" do
      mock.proxy(@<%= singular_name %>).destroy
      delete :destroy, :id => 1
    end
    should "set flash to success" do
      delete :destroy, :id => 1
      assert_match /success/i, flash[:notice]
    end
    should "redirect to <%= plural_name.titleize.downcase %> list" do
      delete :destroy, :id => 1
      assert_redirected_to <%= plural_name %>_path
    end
  end
  
end
