namespace: Integrations.demo.aos.users
flow:
  name: calculate_sha1
  inputs:
    - host
    - user
    - password:
        sensitive: true
    - text
  workflow:
    - ssh_command:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${\"echo -n '\"+text+\"' | sha1sum | awk '{print $1}'\"}"
            - username: '${user}'
        publish:
          - sha1: '${return_result}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      ssh_command:
        x: 116
        'y': 143
        navigate:
          338760e8-c096-5739-ba71-16d50b92f955:
            targetId: 384ac78b-f4e8-1863-0953-71301c5220e7
            port: SUCCESS
    results:
      SUCCESS:
        384ac78b-f4e8-1863-0953-71301c5220e7:
          x: 409
          'y': 143
