# frozen_string_literal: true

# Copyright 2016-2017 New Context Services, Inc.
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

require 'terraform/groups_coercer'
require 'terraform/simple_config'

module Terraform
  # Behaviour for the [:groups] config option
  module GroupsConfig
    include ::Terraform::SimpleConfig

    def self.extended(configurable_class)
      configurable_class
        .configure_required attr: :groups,
                            coercer_class: ::Terraform::GroupsCoercer,
                            default_value: []
    end
  end
end
