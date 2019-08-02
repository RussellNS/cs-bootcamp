namespace: Integrations.demo.aos.users
flow:
  name: create_users
  inputs:
    - file_host: itom1.hcm.demo.local
    - file_user: root
    - file_password:
        default: ********
        sensitive: true
    - file_path: /tmp/users.txt
    - db_host: 10.0.46.34
    - db_user: postgres
    - db_password:
        default: ********
        sensitive: true
    - mm_url: 'https://mattermost.hcm.demo.local'
    - mm_user: admin
    - mm_password:
        default: ********
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
    steps:
      read_users:
        x: 100
        'y': 150
        navigate:
          3f7d6499-a524-f052-92e6-4bdc96f6a389:
            targetId: ce0804a5-6992-09bb-5259-0e8172bcf29a
            port: SUCCESS
    results:
      SUCCESS:
        ce0804a5-6992-09bb-5259-0e8172bcf29a:
          x: 537
          'y': 159
