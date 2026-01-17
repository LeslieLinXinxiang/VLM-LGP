#!/bin/bash

BIN=../../../bin

$BIN/skeletonSolver \
    -confFile '"/home/leslie/Projects/VLM_LGP/rai/test/newLGP/problems/rai-robotModels/scenarios/workshopTable.g"' \
    -sktFile stackingBlocks.skt \
    -mode sequence \
    -collisions true
