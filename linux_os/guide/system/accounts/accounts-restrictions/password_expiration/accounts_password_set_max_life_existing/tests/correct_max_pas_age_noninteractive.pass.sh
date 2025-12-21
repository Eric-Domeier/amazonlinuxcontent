#!/bin/bash
# platform = Red Hat Virtualization 4,multi_platform_fedora,multi_platform_ol,multi_platform_rhel,multi_platform_sle,multi_platform_slmicro,multi_platform_ubuntu,multi_platform_almalinux,multi_platform_debian,multi_platform_al,multi_platform_al
# variables = var_accounts_minimum_age_login_defs=1,var_accounts_maximum_age_login_defs=60
# make existing entries pass
for acct in $(awk -F: '(/^[^:]+:[^!*]/ && ($5 > var || $5 == "")) {print $1}' /etc/shadow ); do
    chage -M 60 -d $(date +%Y-%m-%d) $acct
done
# Add  test entries
# Noninteractive users are a pass
echo "max-test-user:x:540:540:Test User for Password Expiration:/:/sbin/nologin" >> /etc/passwd
echo "max-test-user:!!:18648:1::::" >> /etc/shadow
