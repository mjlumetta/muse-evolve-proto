require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  def setup
    @base_title = "Muse Evolution"
  end 

  test "should get collection" do
    get :collection
    assert_response :success
    assert_select "title", "Collection | #{@base_title}"
  end

  test "should get project" do
    get :project
    assert_response :success
    assert_select "title", "Project | #{@base_title}"
  end

end
