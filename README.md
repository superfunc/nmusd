WIP

### Building

There are two primary ways to build

1. [build\_all.sh] nmusd builds a local version of USD Core, including the two required deps (boost and tbb).
2. [build\_without\_deps.sh] nmusd builds a local version of USD Core, but does _not_ build the required deps.
3. [build\_just\_nmusd.sh] nmusd builds just the nim library, with the users supplied USD.

Each of these should detect and not rebuild USD again after the first run.
