create_test_directory:
  file.directory:
    - name: 'C:\Salt_GitOps_Test'
    - makedirs: True

create_test_file:
  file.managed:
    - name: 'C:\Salt_GitOps_Test\hello_world.txt'
    - contents: 'This file was deployed automatically via GitHub and SaltStack GitFS!'
    - require:
      - file: create_test_directory
