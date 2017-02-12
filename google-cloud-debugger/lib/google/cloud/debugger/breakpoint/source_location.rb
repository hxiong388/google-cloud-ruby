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


module Google
  module Cloud
    module Debugger
      class Breakpoint
        class SourceLocation
          attr_accessor :path

          attr_accessor :line

          def initialize
            @path = nil
            @line = nil
          end

          def to_grpc
            Google::Apis::ClouddebuggerV2::SourceLocation.new.tap do |sl|
              sl.path = @path
              sl.line = @line
            end
          end

          def self.from_grpc grpc
            SourceLocation.new.tap do |sl|
              sl.path = grpc.path
              sl.line = grpc.line.to_i
            end
          end
        end
      end
    end
  end
end