# Query and install critical security patches silently
install_security_updates:
  wua.uptodate:
    - categories:
      - 'Critical Updates'
      - 'Security Updates'
# Query and install critical security patches silently
install_security_updates:
  wua.uptodate:
    - categories:
      - 'Critical Updates'
      - 'Security Updates'

# ONLY reboot the server if the step above actually installed updates
smart_reboot:
  system.reboot:
    - timeout: 1
    - in_seconds: True
    - onchanges:
      - wua: install_security_updates
