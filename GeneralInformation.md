# Introduction #

This page details the directory structure, and Rule ID use for the rules.

# Details #

## Directory structure ##
  * newlogs - This file contains new logs that have not been sorted yet.
  * rules/ - This directory contains the release rules.
  * etc/ - This directory contains the release decoder.xml, and the list of rule files in rules.config.
  * wip-rules/local\_STUFF\_rules.xml - These files contain new rules that have not been submitted to the OSSEC project yet.
  * wip-etc/local\_decoder.xml - This file contains new decoders that have not been submitted to the OSSEC project yet.
  * logs/ - These files contain collected logs for various programs.
  * ossec/rules/ - These files (except local\_rules.xml) are from OSSEC snapshots, and are being used for testing.
  * ossec/rules/local\_rules.xml - This file contains the new rules for testing.
  * ossec/etc/ - These files (except local\_decoder.xml) are from the OSSEC snapshots, and are being used for testing.
  * ossec/etc/local\_decoder.xml - This file contains the new decoders for testing.