# CircleCI Artifacts Orb

A collection of useful tools for artifacts on CircleCI projects.


## Summarize

The summarize job prints a simple html index of any nested files (by regexp pattern.)

```
version: 2.1
orbs:
  artifacts: eddiewebb/artifacts@volatile

jobs:
  build:
    docker:
      - image: circleci/node:10
    working_directory: ~/repo
    steps:
      - run: |
          mkdir -p reports/junit/reportA
          mkdir -p reports/junit/reportB
          mkdir -p reports/junit/reportC
          echo "file1" >> reports/junit/reportA/index.html
          echo "file2" >> reports/junit/reportB/index.html
          echo "file3" >> reports/junit/reportC/index.html
      - artifacts/summarize:
      	  parent_folder: reports
      	  file_pattern: "*.html"
      - store_artifacts:
          path: reports
          destination: reports


```