# 1. Point the Windows Minion to your Domain Controller (192.168.0.231)
set_domain_dns:
  cmd.run:
    - name: Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.0.231"
    - shell: powershell
    - unless: (Get-DnsClientServerAddress -InterfaceAlias "Ethernet").ServerAddresses -contains "192.168.0.231"

# 2. Join the Active Directory Domain
join_ad_domain:
  system.join_domain:
    - name: 'yourdomain.local'  # Replace with your actual AD domain name
    - username: 'DomainAdmin'   # Replace with your domain join account
    - password: 'YourSecurePassword' # Note: In production, move this to your encrypted Salt Vault!
    - restart: True
    - require:
      - cmd: set_domain_dns
# 1. Query and install critical security patches silently
install_security_updates:
  wua.uptodate:
    - categories:
      - 'Critical Updates'
      - 'Security Updates'

# 2. ONLY reboot the server if the step above actually installed updates
smart_reboot:
  system.reboot:
    - timeout: 1
    - in_seconds: True
    - onchanges:
      - wua: install_security_updates

# 3. Mount the OS Deployment Share persistently
map_deployment_share:
  cmd.run:
    - name: New-SmbMapping -LocalPath 'Z:' -RemotePath '\\192.168.0.221\DeploymentShare$' -Persistent $true
    - shell: powershell
    - unless: Test-Path 'Z:\'
