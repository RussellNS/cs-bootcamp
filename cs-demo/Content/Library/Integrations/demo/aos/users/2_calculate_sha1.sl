namespace: Integrations.demo.aos.users
flow:
  name: 2_calculate_sha1
  inputs:
    - host: itom1.hcm.demo.local
    - user: root
    - password:
        default: ********
        sensitive: true
    - text: cloud
  workflow:
    - ssh_command:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${\"echo -n '\"+text+\"' | sha1sum | awk '{print $1}'\"}"
            - username: '${user}'
            - password:
                value: '${password}'
                sensitive: true
        publish:
          - sha1: '${return_result.strip()}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - sha1: '${sha1}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    results:
      SUCCESS:
        8330a099-fdfe-eda5-6b1f-43d962455cc9:
          x: 251
          'y': 114
