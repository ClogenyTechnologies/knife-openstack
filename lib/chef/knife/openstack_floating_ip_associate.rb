#
# Author:: Vasundhara Jagdale (<vasundhara.jagdale@clogeny.com>)
# Copyright:: Copyright 2015-2018 Chef Software, Inc.
# License:: Apache License, Version 2.0
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
#

require "chef/knife/openstack_helpers"
require "chef/knife/cloud/openstack_service_options"
require "chef/knife/cloud/openstack_service"
require "chef/knife/cloud/command"

class Chef
  class Knife
    class Cloud
      class OpenstackFloatingIpAssociate < Command
        include OpenstackHelpers
        include OpenstackServiceOptions

        banner "knife openstack floating_ip associate IP (options)"

        option :instance_id,
               long: "--instance-id ID",
               description: "Instance id to associate it with.",
               proc: proc { |key| Chef::Config[:knife][:instance_id] = key },
               required: true

        def execute_command
          if @name_args[0]
            floating_ip = @name_args[0]
          else
            ui.error "Please provide Floating IP to associate with."
            exit 1
          end

          response = @service.associate_address(locate_config_value(:instance_id), floating_ip)
          if response && response.status == 202
            ui.info "Floating IP #{floating_ip} associated with Instance #{locate_config_value(:instance_id)}"
          end
        end
      end
    end
  end
end
