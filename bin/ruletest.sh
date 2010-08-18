#!/bin/sh

HOMEDIR=/home/ddp/src/projects/hg/wip-ossec-rules
RULES="arpwatch avahi bsd_kernel bsd clamav cvsyncd dbus ddclient dropbear flowd hp identd irqbalance isakmpd linux_kernel mountd named ntpd pam pulseaudio python samba sensorsd smartd smtpd snmpd sshd su syslog"
MAINOUT=`mktemp /tmp/wip-ossec-rules.XXXXXX` || ( echo "Cannot create tempfile!" ; exit 1 )

cd ${HOMEDIR}/ossec || ( echo "Cannot chdir to ${HOMEDIR}/ossec!" ; exit 1 )

for i in ${RULES}; do
  cat ${HOMEDIR}/logs/${i} | sudo /var/ossec/bin/ossec-logtest -D ${HOMEDIR}/ossec -c ${HOMEDIR}/ossec/etc/ossec.conf 2>&1 | \
    grep -v 'ossec-testrule: INFO:' > ${HOMEDIR}/results/${i}.results
done

cd ${HOMEDIR} || ( echo "Cannot chdir to ${HOMEDIR}!" ; exit 1 )
hg status | grep '^M ' > /dev/null && ( echo "Status:" >> ${MAINOUT} && hg status | grep -v '^? ' >> ${MAINOUT} \
  && echo "" >> ${MAINOUT} && echo "Diff:" >> ${MAINOUT} && hg diff >> ${MAINOUT} )

[ -s ${MAINOUT} ] && mail -s 'wip-ossec-rules test' ddp < ${MAINOUT} #&& rm ${MAINOUT}

rm ${MAINOUT}
