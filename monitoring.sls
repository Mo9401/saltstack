install_windows_exporter:
  chocolatey.installed:
    - name: windows_exporter

start_exporter_service:
  service.running:
    - name: windows_exporter
    - enable: True
