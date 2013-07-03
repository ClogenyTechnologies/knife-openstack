#
# Author:: Mukta Aphale (<mukta.aphale@clogeny.com>)
# Copyright:: Copyright (c) 2013 Opscode, Inc.

require File.expand_path('../../spec_helper', __FILE__)
require 'chef/knife/openstack_server_create'

describe Chef::Knife::OpenstackServerCreate do
  before do
    @app = OpenstackServerCreate.new
    @service = Chef::Knife::Cloud::OpenstackService.new

  end

  describe "run" do

  end

  describe "when configuring the bootstrap process" do
  end

end
