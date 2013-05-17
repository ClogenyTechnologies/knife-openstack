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

require 'pedant/rspec/knife_util'
require 'securerandom'

describe 'knife-openstack', knife: true, pending: !open_source? do
  context 'integration' do
    context 'create server' do
      include Pedant::RSpec::KnifeUtil
      include Pedant::RSpec::KnifeUtil::Node

      #FIXME Putting up basic place holder to think over
      let(:command) { knife "openstack server create #{node_name} -c #{knife_config} --disable-editing" }
      after(:each)  { knife "openstack server delete #{node_name} -c #{knife_config} --yes" }

      context '- Linux VM' do
        context '- Bootstrap' do
          let(:requestor) { knife_admin }

          it 'should succeed' do
            should have_outcome :status => 0, :stdout => /Created server- \[#{node_name}\]/
          end
        end
      end

    end
  end
end