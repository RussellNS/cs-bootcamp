namespace: Integrations.demo.aos.users
flow:
  name: create_user
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
    - parse_credentials:
        do:
          Integrations.demo.aos.users.parse_credentials:
            - credentials: '${credentials}'
        publish:
          - created_name: '${name}'
          - created_password: '${password}'
        navigate:
          - SUCCESS: calculate_sha1
    - calculate_sha1:
        do:
          Integrations.demo.aos.users.calculate_sha1:
            - host: '${file_host}'
            - user: '${file_user}'
            - password:
                value: '${file_password}'
                sensitive: true
            - text: '${created_password}'
        publish: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: calculate_sha1_1
    - calculate_sha1_1:
        do:
          Integrations.demo.aos.users.calculate_sha1:
            - host: '${file_host}'
            - user: '${file_user}'
            - password:
                value: '${file_password}'
                sensitive: true
            - text: '${created_name[::-1]+password_sha1}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: random_number_generator
    - random_number_generator:
        do:
          io.cloudslang.base.math.random_number_generator:
            - min: '100000000'
            - max: '1000000000'
        publish:
          - user_id: '${random_number}'
        navigate:
          - SUCCESS: sql_command
          - FAILURE: on_failure
    - sql_command:
        do:
          io.cloudslang.base.database.sql_command:
            - db_server_name: '${db_host}'
            - db_type: PostgreSQL
            - username: '${db_user}'
            - password:
                value: '${db_password}'
                sensitive: true
            - database_name: adv_account
            - command: "${\"INSERT INTO account (user_id, user_type, active, agree_to_receive_offers, defaultpaymentmethodid, email, internallastsuccesssullogin, internalunsuccessfulloginattempts, internaluserblockedfromloginuntil, login_name, password, country_id) VALUES (\"+user_id+\", 20, 'Y', true, 0, 'someone@microfocus.com', 0, 0, 0, '\"+created_name+\"', '\"+username_password_sha1+\"', 210);\"}"
            - trust_all_roots: 'true'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      parse_credentials:
        x: 321
        'y': 110
      calculate_sha1:
        x: 529
        'y': 109
      calculate_sha1_1:
        x: 704
        'y': 110
      random_number_generator:
        x: 703
        'y': 352
      sql_command:
        x: 517
        'y': 364
        navigate:
          2bea5d9b-72bb-bf73-cf4e-1c69d67e3478:
            targetId: 4d037aba-219c-1752-b566-8acccdde13eb
            port: SUCCESS
    results:
      SUCCESS:
        4d037aba-219c-1752-b566-8acccdde13eb:
          x: 331
          'y': 360
