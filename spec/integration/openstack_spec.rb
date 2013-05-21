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

def get_config()
  YAML.load(File.read(File.expand_path("../config/environment.yml", __FILE__)))
end

describe 'knife', knife: true, pending: !open_source? do
  include Pedant::RSpec::KnifeUtil
  include Pedant::RSpec::KnifeUtil::Node
  context 'integration test' do
    context 'for create server' do
      let(:command) { "knife openstack server create -N 'os-node-1' -s 'http://localhost:8983' --openstack-api-endpoint 'http://172.31.4.28:5000/v2.0/tokens' --openstack-password 'password' --openstack-tenant 'tenant' --openstack-username 'username' -I 'imageid' --template-file '../templates/chef-full-chef-zero.erb'" }
      after(:each)  { knife "openstack server delete #{node_name} --yes" }
      let(:requestor) { knife_admin }
      it 'should succeed' do
        should have_outcome :status => 0, :stdout => /Created server- \[#{node_name}\]/      
      end
    end
  end
end