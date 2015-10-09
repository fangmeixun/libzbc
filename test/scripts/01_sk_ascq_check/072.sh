#!/bin/bash
#
# This file is part of libzbc.
#
# Copyright (C) 2009-2014, HGST, Inc.  All rights reserved.
#
# This software is distributed under the terms of the BSD 2-clause license,
# "as is," without technical support, and WITHOUT ANY WARRANTY, without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE. You should have received a copy of the BSD 2-clause license along
# with libzbc. If not, see  <http://opensource.org/licenses/BSD-2-Clause>.
#

. ../zbc_test_lib.sh

zbc_test_init $0 $*

# Set expected error code
expected_sk="Aborted-command"
expected_asc="Insufficient-zone-resources"

zbc_test_info "WRITE insufficient zone resources..."

# Get drive information
zbc_test_get_drive_info

# Get zone information
zbc_test_get_zone_info

# Open zones
zbc_test_open_nr_zones ${max_open}

# Get zone information
zbc_test_get_zone_info

# Search target LBA
zbc_test_search_vals_from_zone_type_and_cond "0x2" "0x1"
target_lba=${target_slba}

# Start testing
zbc_test_run ${bin_path}/zbc_test_write_zone -v ${device} ${target_lba} 8

# Check result
zbc_test_get_sk_ascq
zbc_test_check_sk_ascq

# Post process
zbc_test_run ${bin_path}/zbc_test_reset_write_ptr ${device} -1

rm -f ${zone_info_file}
