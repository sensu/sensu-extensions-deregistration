# Sensu::Extensions::Deregistration

For each event recieved, this handler extension deletes the corresponding client via the /clients API

## Installation

*NOTE: This extension is built-in to official Sensu packages from 1.7 onward. These installation steps are unnecessary if you are using these packages.*

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

### Extension configuration

By default this extension will attempt to communicate with the Sensu API running on 127.0.0.1 port 4567. These settings can be overridden by providing deregistration configuration attributes on the Sensu server.

```
$ cat /etc/sensu/conf.d/deregistration_settings.json
{
  "deregistration": {
    "host": "10.0.0.1",
    "port": 14567
   }
 }
 ```


|attribute|type|default|description|
|----|----|----|---|
|host|string|127.0.0.1|Sensu API host|
|port|integer|4567|Sensu API port|

### Client configuration

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
