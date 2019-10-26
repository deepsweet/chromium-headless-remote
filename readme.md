[![version](https://img.shields.io/badge/chromium-77-green.svg?style=flat-square)](https://packages.ubuntu.com/bionic/chromium-browser) [![hub](https://flat.badgen.net/docker/pulls/deepsweet/chromium-headless-remote)](https://hub.docker.com/r/deepsweet/chromium-headless-remote/) [![size](https://img.shields.io/microbadger/image-size/deepsweet/chromium-headless-remote.svg?label=size&style=flat-square)](https://microbadger.com/images/deepsweet/chromium-headless-remote)

Dockerized Chromium in [headless](https://chromium.googlesource.com/chromium/src/+/lkgr/headless/README.md) [remote debugging mode](https://chromedevtools.github.io/devtools-protocol/).

## Usage

```sh
docker pull deepsweet/chromium-headless-remote:77
docker run -it --rm -p 9222:9222 deepsweet/chromium-headless-remote:77
```

Example using [Puppeteer](https://github.com/GoogleChrome/puppeteer):

Ensure to match version of `puppeteer-core` to the version of Chromium you are using:

```sh
npm install puppeteer-core@chrome-77
```

```js
import puppeteer from 'puppeteer-core'
import request from 'request-promise-native'

(async () => {
  try {
    const { body: { webSocketDebuggerUrl } } = await request({
      uri: 'http://localhost:9222/json/version',
      json: true,
      resolveWithFullResponse: true
    })
    const browser = await puppeteer.connect({
      browserWSEndpoint: webSocketDebuggerUrl
    })
    const page = await browser.newPage()

    await page.goto('https://example.com')
    await page.screenshot({ path: 'example.png' })
    await browser.close()
  } catch (err) {
    console.error(err)
  }
})()
```

## Fonts

It's possible to mount a folder with custom fonts to be used later by Chromium: add `-v $(pwd)/path/to/fonts:/home/chromium/.fonts` to `docker run` arguments.

## Related

* [ungoogled-chromium-headless-remote](https://github.com/deepsweet/ungoogled-chromium-headless-remote)
* [firefox-headless-remote](https://github.com/deepsweet/firefox-headless-remote)
