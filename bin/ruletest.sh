#!/bin/sh

HOME=/home/ddp/src/projects/hg/wip-ossec-rules
RULES="arpwatch avahi bsd_kernel cvsyncd dbus ddclient dropbear flowd identd irqbalance isakmpd linux_kernel named pam python smartd smtpd smtpd sshd"

MAINOUT=`mktemp /tmp/wip-ossec-rules.XXXXXX` || ( echo "Cannot create tempfile!" ; exit 1 )

cd ${HOME}/ossec || ( echo "Cannot chdir to ${HOME}/ossec!" ; exit 1 )

for i in ${RULES}; do
  cat ${HOME}/logs/${i} | sudo /var/ossec/bin/ossec-logtest -D ${HOME}/ossec -c ${HOME}/ossec/etc/ossec.conf 2>&1 | \
    grep -v 'ossec-testrule: INFO: Started' > ${HOME}/results/${i}.results
done

cd ${HOME} || ( echo "Cannot chdir to ${HOME}!" ; exit 1 )
hg status | grep '^M ' > /dev/null && ( echo "Status:" >> ${MAINOUT} && hg status | grep -v '^? ' >> ${MAINOUT} \
  && echo "" >> ${MAINOUT} && echo "Diff:" >> ${MAINOUT} && hg diff >> ${MAINOUT} )

[ -s ${MAINOUT} ] && mail -s 'wip-ossec-rules test' ddp < ${MAINOUT} && rm ${MAINOUT}
