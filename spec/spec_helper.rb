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


$:.unshift File.expand_path('../../lib', __FILE__)
require 'chef/knife/bootstrap'
require 'chef/knife/winrm_base'
require 'chef/knife/openstack_server_create'
require 'bundler/setup' # so we don't need to type 'bundle exec' to run it
require 'rspec/core'
require 'pedant'
require 'pedant/opensource'
require 'pedant/rspec/knife_util'
require 'pedant/rspec/validations'
require 'securerandom'
require 'pathname'
require 'tmpdir'

def find_id(instance_name, line)
  if line.include?("#{instance_name}")    
      puts "#{line}"
      return "#{line}".split(' ').first
  end
end

Pedant.config.platform_class = Pedant::OpenSourcePlatform
Pedant.config.suite = "spec"
Pedant.setup(ARGV)
puts Pedant::UI.new.info_banner
exit RSpec::Core::Runner.run(Pedant.config.rspec_args)