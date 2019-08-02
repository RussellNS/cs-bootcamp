namespace: Integrations.demo.aos.users
flow:
  name: create_users
  inputs:
    - file_host: itom1.hcm.demo.local
    - file_user: root
    - file_path: /tmp/users.txt
    - db_host: 10.0.46.43
    - db_user: postgres
    - mm_url: 'https://mattermost.hcm.demo.local'
    - mm_user: admin
    - mm_chanel_id: eeujbpz9ufbc8rxcyj9qhcgq3a
    - file_password:
        default: S0lutions2016
        sensitive: true
    - db_password:
        default: admin
        sensitive: true
    - mm_password:
        default: Cloud_123
        sensitive: true
  results: []
