namespace: demo.aos
flow:
  name: remote_copy
  inputs:
    - host: 10.0.46.20
    - username: root
    - password: admin@123
    - url: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/install_tomcat.sh'
  workflow:
    - extract_filename:
        do:
          io.cloudslang.demo.extract_filename:
            - url: '${url}'
        publish:
          - filename
        navigate:
          - SUCCESS: http_client_action
    - remote_secure_copy:
        do:
          io.cloudslang.base.remote_file_transfer.remote_secure_copy:
            - source_path: '${filename}'
            - destination_host: '${host}'
            - destination_path: "${get_sp('script_location')}"
            - destination_username: '${username}'
            - destination_password:
                value: '${password}'
                sensitive: true
            - known_hosts_policy: null
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
    - http_client_action:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: '${url}'
            - destination_file: '${filename}'
            - method: GET
        publish: []
        navigate:
          - SUCCESS: remote_secure_copy
          - FAILURE: on_failure
  outputs:
    - filename: '${filename}'
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      http_client_action:
        x: 118
        y: 267
      remote_secure_copy:
        x: 306
        y: 266
        navigate:
          94ad61f2-64c4-a3a5-1647-6eb06ac1b687:
            targetId: 1a4b4e41-715c-4454-4553-8668c9592a94
            port: SUCCESS
      extract_filename:
        x: 106
        y: 88
    results:
      SUCCESS:
        1a4b4e41-715c-4454-4553-8668c9592a94:
          x: 298
          y: 91
