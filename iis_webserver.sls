# 1. Install the IIS Windows Feature
install_iis_role:
  win_servermanager.installed:
    - name: Web-Server
    - recurse: True

# 2. Ensure the IIS Service is active and starts on boot
ensure_iis_running:
  service.running:
    - name: W3SVC
    - enable: True
    - require:
      - win_servermanager: install_iis_role

# 3. Deploy a custom homepage to prove it works
deploy_custom_homepage:
  file.managed:
    - name: 'C:\inetpub\wwwroot\index.html'
    - contents: |
        <!DOCTYPE html>
        <html>
        <body style="text-align: center; font-family: Arial, sans-serif; margin-top: 50px;">
            <h1 style="color: #0078D4;">Welcome to the Dell-730 Web Server!</h1>
            <h2>This IIS server was provisioned automatically via SaltStack and GitOps.</h2>
        </body>
        </html>
    - require:
      - win_servermanager: install_iis_role
