# 1. Point the Windows Minion to your Domain Controller
set_domain_dns:
  cmd.run:
    - name: Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses "192.168.0.231"
    - shell: powershell
    - unless: (Get-DnsClientServerAddress -InterfaceAlias "Ethernet").ServerAddresses -contains "192.168.0.231"

# 2. Join the Domain
join_ad_domain:
  system.join_domain:
    - name: 'indirectory.com'
    - username: 'Administrator'
    - password: 'D0m@in3c370'
    - restart: True
    - require:
      - cmd: set_domain_dns

# 3. Mount the Deployment Share
map_deployment_share:
  cmd.run:
    - name: New-SmbMapping -LocalPath 'Z:' -RemotePath '\\192.168.0.221\DeploymentShare$' -Persistent $true
    - shell: powershell
    - unless: Test-Path 'Z:\'
