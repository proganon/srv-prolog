# Docker Image for Prolog Service

The image runs SWI-Prolog on Alpine Linux ready for running container services at launch time. The container sets up the Alpine environment as follows.

1. Makes Prolog's current working directory at `/srv` at launch time.
2. Loads all Prolog sources within `/srv` automatically, everything with `pl` extension in undefined order. Derived containers do not need to override the entry point.
3. Sets up any SWI-Prolog configuration at `/root/.config/swi-prolog`.

The `srv` folder off the root of the file system should contain multiple Prolog sources. Those sources do *not* need to be modules; they load into the `user` module by default. Better to place module sources within sub-directories.

Prolog initialisation file `init.pl` lives in `/root/.config/swi-prolog`. The image copies a default source.

## Example

Pull and run an interactive SWI-Prolog on Alpine using Docker:
```bash
docker run --rm -it ghcr.io/proganon/srvpl:v1.0.0 -g check_installation
```
The `-g` argument adds a program start-up goal to run the built-in [installation checker](https://www.swi-prolog.org/pldoc/doc/_SWI_/library/check_installation.pl). Results appear on the console before Prolog launches its top-level [interactive goal](https://www.swi-prolog.org/pldoc/doc_for?object=prolog/0).

## Deriving an Image

Copy service-oriented sources to the current directory, or `srv` by default. Also copy `init.pl` to root's configuration directory, as follows.

```Dockerfile
COPY srv/*.pl .
COPY swi-prolog/*.pl /root/.config/swi-prolog
```

## Ordering the Sources

Order undefined by default. Replace the entry point to expand and sort before loading.

```Dockerfile
ENTRYPOINT [ "swipl", "-g", "expand_file_name('*.pl', A), sort(A, B), load_files(B)" ]
```
