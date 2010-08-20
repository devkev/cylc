#!/bin/bash

#         __________________________
#         |____C_O_P_Y_R_I_G_H_T___|
#         |                        |
#         |  (c) NIWA, 2008-2010   |
#         | Contact: Hilary Oliver |
#         |  h.oliver@niwa.co.nz   |
#         |    +64-4-386 0461      |
#         |________________________|


# run time scaled by $REAL_TIME_ACCEL 

# trap errors so that we need not check the success of basic operations.
set -e; trap 'cylc task-failed "error trapped"' ERR

# START MESSAGE
cylc task-started || exit 1

# check environment
check-env.sh || exit 1

# no prerequisites to check

#if [[ -z $START_CYCLE_TIME ]]; then
#    cylc task-failed "No start cycle time specified"
#    cylc --failed
#    exit 1
#fi

CYCLE=$CYCLE_TIME

while true; do
    sleep 10
    if ! cylc suicide; then
        cylc task-failed 'STOPPING NOW; cylc request'
        cylc task-finished
        exit 0
    fi
    cylc task-message "external data ready for $CYCLE"
    cylc task-message "crap ready for ${CYCLE}, ass hole"
    CYCLE=$( cylc-time -a 6 $CYCLE )
done

# SUCCESS MESSAGE (NEVER REACHED!)
cylc task-finished