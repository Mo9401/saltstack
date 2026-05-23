# First, install the Chocolatey package manager itself
install_chocolatey:
  chocolatey.installed:
    - name: chocolatey
    - force: False

# Next, use Chocolatey to install some useful server tools
install_server_tools:
  chocolatey.installed:
    - names:
      - notepadplusplus
      - googlechrome
      - 7zip
    - require:
      - chocolatey: install_chocolatey
