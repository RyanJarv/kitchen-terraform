# frozen_string_literal: true

# Copyright 2016 New Context Services, Inc.
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

require "kitchen/provisioner/terraform"
require "support/terraform/configurable_context"
require "support/terraform/configurable_examples"

::RSpec.describe ::Kitchen::Provisioner::Terraform do
  include_context "instance"

  let(:described_instance) { provisioner }

  it_behaves_like ::Terraform::Configurable

  describe "#call(_state = nil)" do
    include_context "client"

    context "when all commands do not fail" do
      after { described_instance.call }

      subject { client }

      it "applies constructively" do
        is_expected.to receive(:apply_constructively).with no_args
      end
    end

    context "when a command does fail" do
      before do
        allow(client).to receive(:apply_constructively)
          .with(no_args).and_raise ::SystemCallError, "system call"
      end

      subject { proc { described_instance.call } }

      it "raises an action failed error" do
        is_expected.to raise_error ::Kitchen::ActionFailed, /system call/
      end
    end
  end
end
