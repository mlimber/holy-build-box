# Security hardening binaries

Holy Build Box makes it easy to compile your application with special security hardening features. This is done through the `exe_gc_light_hardened` `exe_gc_hardened` library variants.

| Security feature                                      | exe_gc_light_hardened | exe_gc_hardened |
|-------------------------------------------------------|-----------------------|-----------------|
| Protection against stack overflows and stack smashing | Yes                   |                 |
| Extra bounds checking in common functions             | Yes                   |                 |
| Load time address randomization                       | Yes                   | Yes             |
| Read-only global offset table                         | Yes                   | Yes             |

See [tutorial 5](TUTORIAL-5-LIBRARY-VARIANTS) for more information about library variants. When one of these variants is activated, Holy Build Box will set the necessary security hardening flags in `$CLFAGS`, `$CXXFLAGS` and `$LDFLAGS`.

## WARNING: -O3 not supported in `exe_gc_hardened`

The `exe_gc_hardened` variant is not compatible with `-O3`. Ensure that your code is compiled with `-O2` or lower, or use `exe_gc_light_hardened`.

## The `hardening-check` tool

Holy Build Box also includes the `hardening-check` tool. Originally from Debian, this tool checks whether a binary is compiled with all the recommended security hardening flags.

Inside a Holy Build Box container, use it as `hardening-check -b <FILENAME>`.

If you want to use it outside a Holy Build Box container, use it as follows:

    docker run -t -i --rm \
      -v /path-to-your-binary:/exe:ro \
      phusion/holy-build-box-64:latest \
      /hbb_exe_gc_hardened/activate-exec \
      hardening-check -b /exe

Replace `/path-to-your-binary` with the actual path.

See also [the hardening-check man page](http://manpages.ubuntu.com/manpages/trusty/man1/hardening-check.1.html).

We recommend that you call `hardening-check` from your compilation script after compilation is finished.

## Why `-b`?

We recommend passing `-b` (also known as `--nobindnow`) to `hardening-check`. By default, `hardening-check` checks whether the binary is compiled with immediate binding (`BIND_NOW`). However, we have chosen not to include this flag in our environment because it makes application startup slow for not much security gain. [The Debian hardening guide](https://wiki.debian.org/HardeningWalkthrough) also recommends disabling it by default.
