# 1. Query and install critical security patches
install_security_updates:
  wua.uptodate:
    - categories:
      - 'Critical Updates'
      - 'Security Updates'

# 2. ONLY reboot the server if updates were installed
smart_reboot:
  system.reboot:
    - timeout: 1
    - in_seconds: True
    - onchanges:
      - wua: install_security_updates
