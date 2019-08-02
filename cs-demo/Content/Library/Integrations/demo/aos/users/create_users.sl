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
    - mm_chanel_id: eeujbpz9ufbc8rxcyj9qhcgq3a
    - mm_password:
        default: Cloud_123
        sensitive: true
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
    steps:
      read_users:
        x: 94
        'y': 127
        navigate:
          c4c083f1-9cb4-fd31-f53a-97a0815c77f4:
            targetId: 31387d6d-a382-000d-71cb-da9df67526ca
            port: SUCCESS
    results:
      SUCCESS:
        31387d6d-a382-000d-71cb-da9df67526ca:
          x: 318
          'y': 132
