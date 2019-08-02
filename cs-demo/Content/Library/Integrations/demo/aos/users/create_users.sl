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
  results: []
