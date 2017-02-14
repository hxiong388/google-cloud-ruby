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


require "pathname"
require "set"

module Google
  module Cloud
    module Debugger
      class Debuggee
        module AppUniquifierGenerator

          MAX_DEPTH = 10

          def self.generate_app_uniquifier sha, app_path = nil
            app_path ||= defined?(::Rack::Directory) ?
              Rack::Directory.new("").root :
              Dir.getwd

            process_directory sha, app_path
          end

          private

          def self.process_directory sha, path, depth = 1
            return if depth > MAX_DEPTH

            pathname = Pathname.new path
            pathname.each_child do |entry|
              if entry.directory?
                process_directory sha, entry, depth + 1
              else
                next unless entry.extname == ".rb" ||
                            entry.basename.to_s == "Gemfile.lock"
                sha << "#{entry.expand_path}:#{entry.stat.size}"
              end
            end
          end
        end
      end
    end
  end
end
