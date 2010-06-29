#!/bin/sh

HOME=/home/ddp/src/projects/hg/wip-ossec-rules
RULES="arpwatch avahi bsd_kernel cvsyncd dbus ddclient dropbear flowd identd irqbalance isakmpd linux_kernel named pam python smartd smtpd smtpd sshd"

cd ${HOME}/ossec || ( echo "Cannot chdir to ${HOME}!" ; exit 1 )

for i in ${RULES}; do
  cat ${HOME}/logs/${i} | sudo /var/ossec/bin/ossec-logtest -D ${HOME}/ossec -c ${HOME}/ossec/etc/ossec.conf 2>&1 | \
    grep -v 'ossec-testrule: INFO: Started' > ${HOME}/results/${i}.results
done

echo "Tests complete. Try running 'hg status' to see the files that have changed."
