![Logo Clever Cloud](./assets/clever-cloud-logo.png)

# Deploy a Gleam (Wisp) application on Clever Cloud
[![Clever Cloud - PaaS](https://img.shields.io/badge/Clever%20Cloud-PaaS-orange)](https://clever-cloud.com)

This is an example of how to deploy a [Gleam](https://gleam.run/) web application,
built with the [Wisp](https://gleam-wisp.github.io/wisp/) web framework, on Clever Cloud.

This example uses the [`linux` runtime](https://www.clever.cloud/developers/doc/applications/linux/).
The base image already ships Erlang 27, so [Mise](https://mise.jdx.dev/) only
installs Gleam (as a precompiled binary, from the Mise registry) and rebar3,
which Gleam needs to build Erlang dependencies (the base image only ships rebar2).

The application is a "Hello world" HTTP server that listens on `0.0.0.0:8080`,
as required by the Linux runtime.

## How it works

The Linux runtime looks for a `build` and a `run` task. Both are provided by
`mise.toml`:

- **`[tools]`** installs `gleam` and `rebar` (rebar3). Erlang is already in the
  base image.
- **`build`** runs `gleam deps download && gleam build` to fetch dependencies
  from Hex and compile the project.
- **`run`** runs `gleam run`, which starts the Mist web server.

## Project structure

```
.
├── gleam.toml              # Project metadata and dependencies
├── mise.toml               # Mise tools (gleam, rebar3) + build/run tasks
├── src/
│   ├── hello_world.gleam   # Entry point: starts Mist/Wisp on 0.0.0.0:8080
│   └── app/
│       ├── router.gleam    # The request handler
│       └── web.gleam       # The Wisp middleware stack
└── test/
    └── hello_world_test.gleam
```

## Deployment steps

To deploy this application, you need [Clever Tools](https://github.com/CleverCloud/clever-tools), the Clever Cloud CLI.

```bash
# Step 1: Create the application
clever create --type linux gleam-example

# Step 2: Add your domain (optional but recommended)
clever domain add <YOUR_DOMAIN_NAME>

# Step 3: Deploy
clever deploy
```

And you're done! Your application is deploying and will be available on the `<YOUR_DOMAIN_NAME>` domain.


## Running locally

If you want to run the example on your machine, install
[Gleam](https://gleam.run/getting-started/installing/) and Erlang, then:

```bash
gleam test   # run the tests
gleam run    # start the server on http://localhost:8080
```

## Troubleshooting

If you encounter issues:

1. Check the application logs: `clever logs`
2. Verify all environment variables are correctly set: `clever env`
3. Make sure the application listens on `0.0.0.0:8080`.

## Contributing

Contributions to improve this deployment example are welcome! Please feel free to submit pull requests or open issues for any enhancements or bug fixes.

## License

This example is provided under the terms of the MIT license.
