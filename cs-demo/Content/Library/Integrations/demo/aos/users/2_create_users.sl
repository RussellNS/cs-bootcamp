namespace: Integrations.demo.aos.users
flow:
  name: create_users
  inputs:
    - file_host: itom1.hcm.demo.local
    - file_user: root
    - file_password:
        default: S0lutions2016
        sensitive: true
    - file_path: /tmp/users.txt
    - db_host: 10.0.46.43
    - db_user: postgres
    - db_password:
        default: admin
        sensitive: true
    - mm_url: 'https://mattermost.hcm.demo.local'
    - mm_user: admin
    - mm_password:
        default: Cloud_123
        sensitive: true
    - mm_chanel_id: eeujbpz9ufbc8rxcyj9qhcgq3a
  workflow:
    - read_users:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${file_host}'
            - command: "${'cat '+file_path}"
            - username: '${file_user}'
            - password:
                value: '${file_password}'
                sensitive: true
        publish:
          - file_content: '${return_result}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    results:
      SUCCESS:
        5e8b1377-b27b-ab9d-f6b0-f0dcb3416c04:
          x: 161
          'y': 138
