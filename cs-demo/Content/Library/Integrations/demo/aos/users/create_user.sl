namespace: Integrations.demo.aos.users
flow:
  name: create_user
  inputs:
    - file_host
    - file_user
    - file_password:
        sensitive: true
    - credentials
    - db_host
    - db_user
    - db_password:
        sensitive: true
    - mm_url
    - mm_user
    - mm_password:
        sensitive: true
    - mm_channel_id
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
        x: 120
        'y': 170
        navigate:
          01968009-e738-53dd-3a3d-c74b8b09b221:
            targetId: 4d037aba-219c-1752-b566-8acccdde13eb
            port: SUCCESS
    results:
      SUCCESS:
        4d037aba-219c-1752-b566-8acccdde13eb:
          x: 343
          'y': 173
