[![version](https://img.shields.io/badge/chromium-68-green.svg?style=flat-square)](https://pkgs.alpinelinux.org/package/edge/community/x86_64/chromium) [![build](https://img.shields.io/docker/build/deepsweet/chromium-headless-remote.svg?label=build&style=flat-square)](https://hub.docker.com/r/deepsweet/chromium-headless-remote/) [![size](https://img.shields.io/microbadger/image-size/deepsweet/chromium-headless-remote.svg?label=size&style=flat-square)](https://microbadger.com/images/deepsweet/chromium-headless-remote)

Dockerized Chromium in [headless](https://chromium.googlesource.com/chromium/src/+/lkgr/headless/README.md) [remote debugging mode](https://chromedevtools.github.io/devtools-protocol/).

## Usage

```sh
docker run -it --rm -p 9222:9222 deepsweet/chromium-headless-remote:68
```

Example using [Puppeteer](https://github.com/GoogleChrome/puppeteer):

```js
import puppeteer from 'puppeteer'
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
