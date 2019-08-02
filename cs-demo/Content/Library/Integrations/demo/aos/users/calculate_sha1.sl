namespace: Integrations.demo.aos.users
flow:
  name: calculate_sha1
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
    steps:
      ssh_command:
        x: 100
        'y': 150
        navigate:
          d0e9120a-3b1c-2b64-0b56-9f3a24267a4a:
            targetId: 6e966c1c-40df-110a-15dd-2e9af2269a30
            port: SUCCESS
    results:
      SUCCESS:
        6e966c1c-40df-110a-15dd-2e9af2269a30:
          x: 336
          'y': 153
