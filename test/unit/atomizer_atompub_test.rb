require 'test_helper'
require 'atomizer'

class AtomizerAtompubTest < Test::Unit::TestCase

  def test_service_document
    service = Atomizer::Service.new
    workspace = Atomizer::Workspace.new
    collection = Atomizer::Collection.new
    workspace.collections << collection
    service.workspaces << workspace
    assert service.to_atom.include?("<service")
    assert service.to_atom.include?("<workspace")
    assert service.to_atom.include?("<collection")
  end

end
