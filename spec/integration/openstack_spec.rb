# Copyright: Copyright (c) 2012 Opscode, Inc.
# License: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Author:: Ameya Varade (<ameya.varade@clogeny.com>)

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

def append_openstack_creds(is_list_cmd = false)
  openstack_config = YAML.load(File.read(File.expand_path("../config/environment.yml", __FILE__)))
  openstack_creds_cmd = " --openstack-username #{openstack_config['development']['openstack_username']} --openstack-password #{openstack_config['development']['openstack_password']} --openstack-api-endpoint #{openstack_config['development']['openstack_auth_url']} "
  if(!is_list_cmd)
    openstack_creds_cmd = openstack_creds_cmd + " --openstack-tenant #{openstack_config['development']['openstack_tenant']} "
  end
  # puts File.read(File.expand_path("../templates/chef-full-chef-zero.erb", __FILE__))
  openstack_creds_cmd
end

def create_template_file
  linux_file = File.read(File.expand_path("../templates/chef-full-chef-zero.erb", __FILE__))
  File.open("#{temp_repository}/chef-full-chef-zero.erb", 'w') {|f| f.write(linux_file)}
end

def linux_template_file_path
  "#{temp_repository}/chef-full-chef-zero.erb"
end

def delete_instance_cmd(instace_name, stdout)
  "knife openstack server delete " + find_id(instance_name, '#{stdout}') +
  "-c #{knife_config}" +
  append_openstack_creds() + "--yes"
end


describe 'knife', knife: true, pending: !open_source? do
  include Pedant::RSpec::KnifeUtil
  include Pedant::RSpec::KnifeUtil::Node
  context 'integration test' do
    context 'for create server' do\
      before(:each) { create_template_file }
      let(:command) { "knife openstack server create -N #{node_name} "+
      "-I '9d155c01-1652-43bf-95f3-30893c40d423' -f '2' "+
      "--template-file " + linux_template_file_path +
      " -c #{knife_config}" +
      append_openstack_creds() }
      after(:each)  { delete_instance_cmd('#{node_name}', '#{stdout}') }
      let(:requestor) { knife_admin }
      it 'should succeed' do
        should have_outcome :status => 0, :stdout => /Created node\[#{node_name}\]/
      end
    end

    context 'for flavor list' do
      let(:command) { "knife openstack flavor list -c #{knife_config}" + append_openstack_creds(is_list_cmd = true) }
      let(:requestor) { knife_admin }
      it 'should succeed' do
        should have_outcome :status => 0
      end
    end

  end
end