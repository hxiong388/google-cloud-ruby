# Copyright 2016 Google Inc. All rights reserved.
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


require "google-cloud-debugger"
require "google/cloud/debugger/project"

module Google
  module Cloud
    module Debugger
      def self.new project: nil, keyfile: nil, scope: nil, timeout: nil,
                   client_config: nil
        project ||= Google::Cloud::Debugger::Project.default_project
        project = project.to_s # Always cast to a string
        fail ArgumentError, "project is missing" if project.empty?

        credentials =
          Google::Cloud::Debugger::Credentials.credentials_with_scope keyfile,
                                                                      scope

        Google::Cloud::Debugger::Project.new(
          Google::Cloud::Debugger::Service.new(
            project, credentials, timeout: timeout,
                                  client_config: client_config))
      end
    end
  end
end