# Sensu::Extensions::Deregistration

**NOTE: This extension is considered experimental and needs testing!**

For each event recieved, this handler extension deletes the corresponding client via the /clients API

## Installation

1. Install this gem using sensu-install

    ``` bash
    $ sensu-install -e sensu-extensions-deregistration
    ```

2. Configure Sensu to load the extension, as [documented here][0].

    ``` json
    {
      "extensions": {
        "deregistration": {
          "gem": "sensu-extensions-deregistration"
        }
      }
    }
    ```

## Configuration

With the extension loaded, the "deregistration" handler is now available for use with [client deregistration attributes][1]:

```
{
  "client": {
    "name": "1-424242",
    "...": "...",
    "deregister": true,
    "deregistration": {
      "handler": "deregistration"
    }
  }
}

```

With this configuration in place, clients will be automatically deregistered when sensu-client process recieves a SIGTERM.

[1]: https://sensuapp.org/docs/latest/reference/clients.html#deregistration-attributes
[0]: https://sensuapp.org/docs/latest/reference/extensions.html
