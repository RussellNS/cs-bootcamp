namespace: Integrations.demo.aos.users
flow:
  name: 2_create_user
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
    results:
      SUCCESS:
        020f0249-ac69-3e88-bff9-004ddd3c8073:
          x: 258
          'y': 178
