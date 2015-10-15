# 
# Copyright 2011-2015 Jeff Bush
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

#
# When the processor comes out of reset, it starts execution here. This sets
# up the stack and calls main, which runs the serial loader. After main returns,
# this jumps to address 0, where it should have loaded the new program. When
# the loaded program later starts other threads, they will also begin 
# execution here. But they will skip running the serial loader and jump directly 
# to address 0.
#

					.text
					.align 4

					.globl _start
					.type _start,@function
_start:				getcr s0, 0
					btrue s0, jump_to_zero

					# Set up stack
					load_32 sp, temp_stack
					call main

jump_to_zero: 		move pc, 0

temp_stack:			.long 0x400000
