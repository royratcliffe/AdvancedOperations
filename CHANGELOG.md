# Change Log

## [0.1.10](https://github.com/royratcliffe/AdvancedOperations/tree/0.1.10) (2016-05-26)

- Merge branch 'feature/delay_operation' into develop
- Merge branch 'feature/operation_log_observer' into develop
- Line-length warnings at 200 columns
- Operation log observer
- Operation change observer relays dependencies and queue-priority changes
- Will- and did-produce operation needs empty implementation for overriding
- NSOperation extensions: addDependencies and addCompletionBlock
- Added delay operation and test to project
- DelayOperation class, including test

[Full Change Log](https://github.com/royratcliffe/AdvancedOperations/compare/0.1.9...0.1.10)

## [0.1.9](https://github.com/royratcliffe/AdvancedOperations/tree/0.1.9) (2016-05-17)

- Use "underlying" queue rather than group queue
- Include extract for producing dependent with block

[Full Change Log](https://github.com/royratcliffe/AdvancedOperations/compare/0.1.8...0.1.9)

## [0.1.8](https://github.com/royratcliffe/AdvancedOperations/tree/0.1.8) (2016-05-16)

- Add test for NSOperation.produceDependentWithBlock
- Merge branch 'feature/group_queue' into develop
- NSOperation extensions: produce dependency, dependent ops and with blocks
- New GroupOperation methods: for group QoS and for cancelling all sub-operations
- GroupOperation.groupQueue now accessible
- Master branch build status
- Merge branch 'feature/travis_ci' into develop
- Compile using Swift 2.2
- Use the correct scheme

[Full Change Log](https://github.com/royratcliffe/AdvancedOperations/compare/0.1.7...0.1.8)

## [0.1.7](https://github.com/royratcliffe/AdvancedOperations/tree/0.1.7) (2016-05-02)

- Disable some SwiftLint rules
- Fix C header name
- More commentary for group-operation methods
- Group operation tests added

[Full Change Log](https://github.com/royratcliffe/AdvancedOperations/compare/0.1.6...0.1.7)

## [0.1.6](https://github.com/royratcliffe/AdvancedOperations/tree/0.1.6) (2016-04-28)

Group operation enhancements: suspend the queue, and wait for operations to
finish. Operations can ask for cancelled dependencies.

- Filter operation dependencies for cancelled ops
- Group operation can suspend and wait

[Full Change Log](https://github.com/royratcliffe/AdvancedOperations/compare/0.1.5...0.1.6)

## [0.1.5](https://github.com/royratcliffe/AdvancedOperations/tree/0.1.5) (2016-04-27)

Adds operation producer behaviour with basic tests. Also uses SwiftLint;
linting automatically at the end of the build.

- Merge branch 'feature/operation_producer' into develop
- Test utilises public IsFinishedObserver class
- Producer tests and is-finished observer added to project
- Some operation producer tests
- IsFinishedObserver class
- Operations can produce other operations
- Change log, initial commit
- Merge branch 'feature/swift_lint' into develop
- Describe parameters for KV observers add object
- Exclude q and op variable names; warn after 150 columns
- Internal operation-observer key uses lowercase
- SwiftLint wants `else` on the same line
- Run SwiftLint in a shell-script build phase

[Full Change Log](https://github.com/royratcliffe/AdvancedOperations/compare/0.1.4...0.1.5)

## [0.1.4](https://github.com/royratcliffe/AdvancedOperations/tree/0.1.4) (2016-04-25)

Series of patches pushed on the same day designed to rename project from
Operations to AdvancedOperations because pod name already taken.

[Full Change Log](https://github.com/royratcliffe/AdvancedOperations/compare/0.1.0...0.1.4)

## [0.1.0](https://github.com/royratcliffe/AdvancedOperations/tree/0.1.0) (2016-04-25)

Initial commit.
