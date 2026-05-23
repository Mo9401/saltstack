# Query and install critical security patches silently
install_security_updates:
  wua.uptodate:
    - categories:
      - 'Critical Updates'
      - 'Security Updates'
