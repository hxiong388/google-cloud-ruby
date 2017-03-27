# Copyright 2017 Google Inc. All rights reserved.
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
    ##
    # # Stackdriver Debugger
    #
    # The Stackdriver Debugger library lets you inspect the state of a running
    # application at any code location in real time, without stopping or
    # slowing down the application, and without modifying the code to add
    # logging statements. You can use Stackdriver Debugger with any deployment
    # of your application, including test, development, and production. The
    # Ruby debugger adds minimal request latency, typically less than 50ms, and
    # only when the application state is captured. In most cases, this is not
    # noticeable by users.
    #
    # ## Quick Start
    #
    # Setting up Stackdriver Debugger involves three steps:
    #
    # 1. Add the `google-cloud-debugger` library to your app.
    # 2. Register your app's source code.
    # 3. Deploy your app and set a breakpoint.
    #
    # ### Add the library
    #
    # Make sure the `google-cloud-debugger` library is in your Gemfile. For
    # example,
    #
    # ```ruby
    # gem "google-cloud-debugger"
    # ```
    #
    # If you are using Ruby on Rails, add the following to your initialization
    # code in `application.rb`:
    #
    # ```ruby
    # require "google/cloud/debugger/rails"
    # ```
    #
    # Otherwise, if you are using Sinatra or another Rack-based web framework,
    # install the middleware. (TODO)
    #
    # ### Register your app source
    #
    # (TODO)
    #
    # ### Deploy your app and set a breakpoint
    #
    # (TODO)
    #
    module Debugger
      def self.new project: nil, keyfile: nil, module_name: nil,
                   module_version: nil, scope: nil, timeout: nil,
                   client_config: nil
        project ||= Debugger::Project.default_project
        project = project.to_s # Always cast to a string
        module_name ||= Debugger::Project.default_module_name
        module_name = module_name.to_s
        module_version ||= Debugger::Project.default_module_version
        module_version = module_version.to_s

        fail ArgumentError, "project is missing" if project.empty?
        fail ArgumentError, "module_name is missing" if module_name.empty?
        fail ArgumentError, "module_version is missing" if module_version.nil?

        credentials = Credentials.credentials_with_scope keyfile, scope

        Google::Cloud::Debugger::Project.new(
          Google::Cloud::Debugger::Service.new(
            project, credentials, timeout: timeout,
                                  client_config: client_config),
          module_name: module_name,
          module_version: module_version
        )
      end
    end
  end
end
